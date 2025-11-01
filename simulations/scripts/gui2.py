import random
import pyglet
from pyglet.window import key
from pyglet.window import mouse
from pyglet.shapes import Circle, Rectangle, Line

WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

NETWORK_SHAPE = (64,32)
LAYER_SPACING = 400
X_MARGIN = 32
neurons = []
connections = {}

def run_gui(data):

    def center_image(image):
        image.anchor_x = image.width // 2
        image.anchor_y = image.height // 2

    window = pyglet.window.Window(WINDOW_WIDTH, WINDOW_HEIGHT, resizable=True)
    pyglet.resource.path = ['../data']
    pyglet.resource.reindex()
    image = pyglet.resource.image('doomguy.jpg')
    center_image(image)
    batch = pyglet.graphics.Batch()
    label = pyglet.text.Label('SPIKING NEURAL NETWORK SIMULATOR V1',
                              font_name='GeistMono NF Medium',
                              font_size=18,
                              x=window.width//2, y=window.height-18,
                              anchor_x='center', anchor_y='center')

    # height, width, depth = np_image.shape
    # np_image[:, :, [0, 1, 2, 3]] = np_image[:, :, [3, 0, 1, 2]]
    # np_image = np.flip(np_image, 0)
    # pg_image = pg.image.create(width, height)
    # pg_image.set_data("ARGB", width*4, np_image)

    def draw_neurons():
        circles = []
        height = NETWORK_SHAPE[0] * 16
        y_offset = (WINDOW_HEIGHT - height) // 2
        for i in range(NETWORK_SHAPE[0]):
            neuron_x = (i // 100) * 16 + X_MARGIN
            neuron_y = (i % 100) * 16 + y_offset
            new_circle = Circle(x=neuron_x, y=neuron_y, radius=3, color=(225, 225, 225),batch=batch)
            circles.append(new_circle)
        height = NETWORK_SHAPE[1] * 16
        y_offset = (WINDOW_HEIGHT - height) // 2
        for j in range(NETWORK_SHAPE[1]):
            neuron_x = (j // 100) * 16 + LAYER_SPACING + X_MARGIN
            neuron_y = (j % 100) * 16 + y_offset
            new_circle = Circle(x=neuron_x, y=neuron_y, radius=3, color=(225, 225, 225),batch=batch)
            circles.append(new_circle)
        return circles

    def draw_connections():
        lines = []
        height = NETWORK_SHAPE[0] * 16
        y_offset = (WINDOW_HEIGHT - height) // 2
        height_dest = NETWORK_SHAPE[1] * 16
        y_offset_dest = (WINDOW_HEIGHT - height_dest) // 2
        for i in range(NETWORK_SHAPE[0]):
            neuron_x = (i // 100) * 16 + X_MARGIN
            neuron_y = (i % 100) * 16 + y_offset
            for j in range(NETWORK_SHAPE[1]):
                neuron_x_dest = (j // 100) * 16 + LAYER_SPACING + X_MARGIN
                neuron_y_dest = (j % 100) * 16 + y_offset_dest
                new_line = Line(neuron_x, neuron_y, neuron_x_dest, neuron_y_dest,
                                thickness=2, color=(225, 225, 225, 0),batch=batch)
                lines.append(new_line)
        return lines

    c = draw_connections()
    n = draw_neurons()
    def reset():
        for neuron in n:
            neuron.color = (255,255,255)

    def random_spike():
        randomint = random.randint(0,len(n)-1)
        n[randomint].color = (50,255,50)

    def update(dt):
        random_spike()

    def update_slow(dt):
        reset()

    pyglet.clock.schedule_interval(update, 1/120.0)
    pyglet.clock.schedule_interval(update_slow, 1)

    @window.event
    def on_key_press(symbol, modifiers):
        if symbol == key.A:
            print('The "A" key was pressed.')
        elif symbol == key.LEFT:
            print('The left arrow key was pressed.')
        elif symbol == key.ENTER:
            print('The enter key was pressed.')

    @window.event
    def on_mouse_press(x, y, button, modifiers):
        if button == mouse.LEFT:
            print(f'The left mouse button was pressed. [{x}, {y}]')

    @window.event
    def on_draw():
        window.clear()
        image.blit(window.width - 200, window.height - 200)
        label.draw()
        batch.draw()

    pyglet.app.run()
