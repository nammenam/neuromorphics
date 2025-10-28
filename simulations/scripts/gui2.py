

from math import sin, exp, pi
import numpy as np
import random
import threading
import dearpygui.dearpygui as dpg
import time
import collections
import bisect

from theme import create_global_theme, create_line_series_theme, load_font, scatter_green, scatter_orange
from core import intensity_to_delay_encoding,create_conv_connections, get_postsynaptic_events
from data import scale_image, rgba_image

MAX_POINTS = 2000
TIME_STEP = 0.01
# INPUT_SHAPE = (28, 28)
# OUTPUT_SHAPE = (28, 28)
INPUT_SHAPE = (8, 8)
INPUT_NEURONS = INPUT_SHAPE[0] * INPUT_SHAPE[1]
OUTPUT_SHAPE = (6, 6)
OUTPUT_WIDTH = OUTPUT_SHAPE[1]
INPUT_WIDTH = INPUT_SHAPE[1]
NUM_NEURONS_PER_MAP = OUTPUT_SHAPE[0] * OUTPUT_SHAPE[1]
TOTAL_NEURONS = NUM_NEURONS_PER_MAP
V_REST = 0
V_TRESH = 4
TAU_M = 1
SCALE_FACTOR_1 = int(256 / INPUT_SHAPE[0])
SCALE_FACTOR_2 = int(256 / OUTPUT_SHAPE[0])

is_paused = False
step_event = threading.Event()
simulation_time = 0.0

start_time = -(MAX_POINTS - 1) * TIME_STEP
initial_time_data = np.linspace(start_time, 0.0, num=MAX_POINTS)
time_data = collections.deque(initial_time_data, maxlen=MAX_POINTS)
simulation_time = 0

# NETWORK STATE
connections = {} # key: neuron index, val: (neuron indices, weights)
input_neuron_pos = {} # Stores {neuron_idx: (x, y)}
output_neuron_pos = {} # Stores {neuron_idx: (x, y)}
potentials = np.full(TOTAL_NEURONS, V_REST, dtype=float)

# --- GUI Layout ---
VIEWPORT_WIDTH = 2300
VIEWPORT_HEIGHT = 1300

def reset_simulation():
    global simulation_time
    simulation_time = 0.0
    time_data.clear()
    time_data.extend(initial_time_data)
    print("Simulation Reset")

def key_press_handler(sender, app_data):
    global is_paused
    key = app_data
    if key == 524:
        is_paused = not is_paused
        if not is_paused:
            step_event.set()
        print(f"Simulation {'Paused' if is_paused else 'Playing'}")
    elif key == 559 and is_paused:
        step_event.set()

def update_text():
    global simulation_time
    while True:
        dpg.set_value("frame_text", f"Frame: {dpg.get_frame_count()}")
        dpg.set_value("time_text", f"Time: {simulation_time}")
        time.sleep(0.1)

def fill_event_queue(event_queue, arrival_times, target_indices):
    for t, target in zip(arrival_times, target_indices):
        event_queue.append((t, 'FF', {'target': target }))
    event_queue.sort(key=lambda x: x[0])

def update_series_data(data:np.ndarray):
    global simulation_time, neurons_viz, connections_viz, potentials, connections, input_neuron_pos, output_neuron_pos

    # --- Create Mock Connections ---
    # Since "growth" isn't implemented, we'll create some static connections to visualize.
    # The key is the INPUT neuron index, the value is a list of (OUTPUT_neuron_index, weight).
    connections = {}
    all_output_neurons = list(range(TOTAL_NEURONS))
    for i in range(INPUT_NEURONS):
        # Connect each input to 5 random output neurons
        num_conns = 5
        if num_conns > TOTAL_NEURONS:
             num_conns = TOTAL_NEURONS
        targets = random.sample(all_output_neurons, num_conns)
        connections[i] = [(target, random.uniform(0.8, 1.5)) for target in targets]

    drawn_connections = set() # Track drawn line tags (e.g., "conn_0_15")
    # --------------------------------

    for iteration in range(3): # Loop through the 3 images
        input_image = data[iteration]
        normalized_image = input_image.astype(np.float32) / 255.0
        
        # Display the static input image
        scaled_image = scale_image(normalized_image, SCALE_FACTOR_1)
        scaled_image_rgba = rgba_image(scaled_image).flatten()
        dpg.set_value("input_image", scaled_image_rgba)

        # --- Get Input Spikes ---
        spikes = intensity_to_delay_encoding(input_image)
        height, width = spikes.shape
        y_coords, x_coords = np.where(~np.isnan(spikes))
        times = spikes[y_coords, x_coords]
        neuron_indices = y_coords * width + x_coords
        sorted_indices = np.argsort(times)
        spikes = times[sorted_indices]
        indices = neuron_indices[sorted_indices]

        sorted_indices = np.argsort(spikes)
        spikes = spikes[sorted_indices] + simulation_time
        indices = indices[sorted_indices]

        event_queue = []
        fill_event_queue(event_queue,spikes,indices) 
        
        # --- Reset Simulation State for New Image ---
        potentials.fill(V_REST)
        last_update_times = np.zeros(TOTAL_NEURONS, dtype=float)
        output_spike_times = np.full(TOTAL_NEURONS, np.nan, dtype=float)
        out_img = np.zeros(OUTPUT_SHAPE + (4,), dtype=np.float32)
        in_img = np.zeros(INPUT_SHAPE + (4,), dtype=np.float32)

        # Clear old connection lines from GUI
        for conn_tag in drawn_connections:
            if dpg.does_item_exist(conn_tag):
                dpg.delete_item(conn_tag)
        drawn_connections.clear()
        
        # --- Main Simulation Loop for this Image ---
        while len(event_queue) > 0:
            if is_paused:
                step_event.wait()
                step_event.clear()

            # Get next event
            event_time, event_type, event_data = event_queue.pop(0)
            
            # Animate time passing until the next event
            while simulation_time < event_time:
                simulation_time += TIME_STEP
                # Fade images
                in_img[:,:,0:3] *= 0.99
                out_img[:,:,0:3] *= 0.99
                # Fade connection lines
                for conn_tag in drawn_connections:
                     if dpg.does_item_exist(conn_tag):
                         dpg.configure_item(conn_tag, color=(255, 255, 255, 30)) # Fade to faint white

                # Update textures
                dpg.set_value("neurons0", rgba_image(scale_image(in_img, SCALE_FACTOR_1)).flatten())
                dpg.set_value("neurons1", rgba_image(scale_image(out_img, SCALE_FACTOR_2)).flatten())
                time.sleep(0.001) # Slow down simulation

            # --- Process the Spike Event ---
            if event_type == 'FF':
                input_idx = event_data['target']
                
                # 1. Visualize Input Spike (on texture)
                y = input_idx // INPUT_WIDTH
                x = input_idx % INPUT_WIDTH
                in_img[y, x, 0:3] = 1.0 # Set to bright white
                in_img[y, x, 3] = 1.0
                
                # 2. Propagate Spike to Output Neurons
                targets_and_weights = connections.get(input_idx, [])
                
                for output_idx, weight in targets_and_weights:
                
                    # 3. Draw/Update Connection Line
                    conn_tag = f"conn_{input_idx}_{output_idx}"
                    if conn_tag not in drawn_connections:
                        pos1 = input_neuron_pos[input_idx]
                        pos2 = output_neuron_pos[output_idx]
                        # Draw new line
                        dpg.draw_line(pos1, pos2, 
                                      color=(255, 255, 0, 200), # Draw bright yellow
                                      thickness=max(0.2, weight/2.0), 
                                      parent="network_drawlist", 
                                      tag=conn_tag)
                        drawn_connections.add(conn_tag)
                    else:
                        # Flash existing line
                        dpg.configure_item(conn_tag, color=(255, 255, 0, 200), thickness=max(0.5, weight))
                
                    # 4. Update Output Neuron Potential (Your uncommented logic)
                    if not np.isnan(output_spike_times[output_idx]):
                        continue # Neuron already fired

                    time_delta = event_time - last_update_times[output_idx]
                    if time_delta > 0:
                        potentials[output_idx] *= exp(-time_delta / TAU_M)

                    potentials[output_idx] += weight
                    last_update_times[output_idx] = event_time

                    # 5. Check for Output Spike
                    if potentials[output_idx] >= V_TRESH:
                        output_spike_times[output_idx] = event_time
                        potentials[output_idx] = V_REST
                        
                        # 6. Visualize Output Spike (on texture)
                        out_y = output_idx // OUTPUT_WIDTH
                        out_x = output_idx % OUTPUT_WIDTH
                        out_img[out_y, out_x, 0:3] = 1.0 # Bright white
                        out_img[out_y, out_x, 3] = 1.0
                        
                        # --- THIS IS WHERE "GROWTH" (PLASTICITY) WOULD HAPPEN ---
                        # To make connections "grow", you would start with `connections = {}`.
                        # Then, when an output neuron fires, you'd check recent input
                        # spikes (STDP) and, if a rule is met, add a *new* entry to
                        # the `connections` dict and draw its line for the first time.
                        # For example:
                        # `new_conn_tag = f"conn_{pre_syn_idx}_{output_idx}"`
                        # `if new_conn_tag not in drawn_connections:`
                        # `   ... dpg.draw_line(...) ...`
                        # `   drawn_connections.add(new_conn_tag)`
        
        # --- End of event queue for this image ---
        # Let simulation run for a bit longer to see fades
        end_time = simulation_time + 2.0
        while simulation_time < end_time:
                if is_paused:
                    step_event.wait()
                    step_event.clear()
                
                simulation_time += TIME_STEP
                in_img[:,:,0:3] *= 0.99
                out_img[:,:,0:3] *= 0.99
                for conn_tag in drawn_connections:
                     if dpg.does_item_exist(conn_tag):
                         dpg.configure_item(conn_tag, color=(255, 255, 255, 30))

                dpg.set_value("neurons0", rgba_image(scale_image(in_img, SCALE_FACTOR_1)).flatten())
                dpg.set_value("neurons1", rgba_image(scale_image(out_img, SCALE_FACTOR_2)).flatten())
                time.sleep(0.001)

def run_gui(data:np.ndarray):
    global input_neuron_pos, output_neuron_pos # <-- Added globals
    
    dpg.create_context()

    load_font(dpg)

    with dpg.handler_registry():
        dpg.add_key_press_handler(callback=key_press_handler)

    with dpg.window(tag="primary_window",
                    pos=[0, 0],
                    width=VIEWPORT_WIDTH,
                    height=VIEWPORT_HEIGHT,
                    no_move=True,
                    no_resize=True,
                    no_close=True,
                    no_collapse=True,
                    no_title_bar=True):
        with dpg.group(horizontal=True):
            with dpg.group(horizontal=False):
                with dpg.child_window(width=VIEWPORT_WIDTH * 0.7, height=VIEWPORT_HEIGHT*0.21):
                
                    default_value1 = np.zeros(INPUT_SHAPE, dtype=np.float32)
                    default_value = np.zeros(OUTPUT_SHAPE, dtype=np.float32)
                    default_image1 = scale_image(default_value1, SCALE_FACTOR_1)
                    default_image = scale_image(default_value, SCALE_FACTOR_2)
                    default_image_rgba = rgba_image(default_image).flatten()
                    default_image1_rgba = rgba_image(default_image1).flatten()
                    with dpg.texture_registry(show=True):
                        dpg.add_dynamic_texture(
                            width=default_image1.shape[1],
                            height=default_image1.shape[0],
                            default_value=default_image1_rgba,
                            tag="neurons0"
                        )
                        dpg.add_dynamic_texture(
                            width=default_image.shape[1],
                            height=default_image.shape[0],
                            default_value = default_image_rgba,
                            tag="neurons1"
                        )

                    with dpg.group(horizontal=True):
                        dpg.add_image("neurons0")
                        dpg.add_image("neurons1")

                with dpg.child_window(width=VIEWPORT_WIDTH * 0.7, height=VIEWPORT_HEIGHT*0.77):
                    # --- MODIFIED DRAWLIST ---
                    # Added a tag to the drawlist
                    with dpg.drawlist(width=VIEWPORT_WIDTH * 0.7, height=1980, tag="network_drawlist"):
                        
                        # Store input neuron positions and tag circles
                        for i in range(INPUT_SHAPE[0] * INPUT_SHAPE[1]):
                            pos = (50, i*8 + 15) # Gave more X-space
                            input_neuron_pos[i] = pos
                            dpg.draw_circle(pos, 3, fill=(255,255,255, 100), tag=f"input_neuron_{i}")
                            
                        # Store output neuron positions and tag circles
                        for i in range(OUTPUT_SHAPE[0] * OUTPUT_SHAPE[1]):
                            pos = (250, i*8 + 115) # Gave more X-space
                            output_neuron_pos[i] = pos
                            dpg.draw_circle(pos, 3, fill=(255,255,255, 100), tag=f"output_neuron_{i}")
                    # --- END MODIFIED DRAWLIST ---

            with dpg.child_window(width=-1):
                dpg.add_button(label="Reset Simulation", callback=reset_simulation, width=-1, height=40)
                dpg.add_separator()

                normalized_image = data[0].astype(np.float32) / 255.0
                input_image = scale_image(normalized_image, SCALE_FACTOR_1)
                input_image_rgba = rgba_image(input_image).flatten()

                with dpg.texture_registry(show=True):
                    dpg.add_dynamic_texture(
                        width=input_image.shape[1],
                        height=input_image.shape[0],
                        default_value=input_image_rgba,
                        tag="input_image"
                    )
                with dpg.group(horizontal=True):
                    dpg.add_image("input_image")
                    with dpg.drawlist(width=30, height=100):
                        dpg.draw_line((0, 0), (0, 100), color=(255, 255, 0, 255), thickness=30)
                dpg.add_separator()
                dpg.add_text(f"Frame: {dpg.get_frame_count()}", tag="frame_text")
                dpg.add_text(f"Time:  {simulation_time}", tag="time_text")

    dpg.create_viewport(title='Neuron Simulation', width=VIEWPORT_WIDTH, height=VIEWPORT_HEIGHT)
    dpg.set_viewport_vsync(True)
    dpg.setup_dearpygui()
    update_thread = threading.Thread(target=update_series_data, args=(data,), daemon=True)
    frame_thread = threading.Thread(target=update_text, daemon=True)
    update_thread.start()
    frame_thread.start()
    dpg.show_viewport()
    dpg.start_dearpygui()
    dpg.destroy_context()
