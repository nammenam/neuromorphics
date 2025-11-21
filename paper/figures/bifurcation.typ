#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot, chart

#set text(font: "GeistMono NF", weight: "medium", size: 9pt)

// --- AdEx Parameters ---
#let C = 281.0
#let gL = 30.0
#let EL = -70.6
#let VT = -50.4
#let DeltaT = 2.0
#let a = 4.0
#let tau_w = 144.0
#let b = 80.5

// --- Simulation Logic ---
#let get-bounds(I_val) = {
  let v = -70.6
  let w = 0.0
  let dt = 0.1
  let steps = 4000 
  let transient = 2000

  let min_v = 100.0
  let max_v = -100.0

  for i in range(steps) {
    let exp_term = gL * DeltaT * calc.exp((v - VT) / DeltaT)
    let dv = (-gL * (v - EL) + exp_term - w + I_val) / C
    let dw = (a * (v - EL) - w) / tau_w
    
    v = v + dv * dt
    w = w + dw * dt
    
    if v >= -30 { // Spike
      v = -70.6
      w = w + b
    }
    
    if i > transient {
      if v < min_v { min_v = v }
      if v > max_v { max_v = v }
    }
  }
  
  (min_v, max_v)
}

// --- Generate Data ---
#let i_vals = range(400, 1000, step: 20)
#let data_min = ()
#let data_max = ()

#for i_val in i_vals {
  let (mn, mx) = get-bounds(i_val)
  
  // Push (x, y) tuples for Cetz
  data_min.push((i_val, mn))
  
  // If difference is small, it's a fixed point
  if (mx - mn) < 0.5 {
    data_max.push((i_val, mn)) 
  } else {
    data_max.push((i_val, mx))
  }
}

// --- Diagram ---
#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  
  plot.plot(size: (10, 6), x-tick-step: 100, y-tick-step: 10, axis-style: "school-book", name: "bifurcation", {
    
    // 1. Minimum Voltage Branch (Fixed Point)
    plot.add(
      data_min, 
      style: (stroke: (paint: gray, thickness: 1.5pt)),
      label: "Stable Fixed Point / Min Voltage"
    )

    // 2. Maximum Voltage Branch (Spiking Peak)
    plot.add(
      data_max, 
      style: (stroke: (paint: gray, thickness: 1.5pt)),
      label: "Spiking Peak"
    )
    
    // 3. Vertical Line for Bifurcation (Manual Add)
    plot.add(
       ((500, -75), (500, -40)),
       style: (stroke: (paint: gray, dash: "dotted")),
       label: none
    )
  })

  content("bifurcation.north", text(weight: "bold", "AdEx Bifurcation Diagram"), anchor: "south", padding: .5)
  
  // Annotate the Bifurcation Point
  // We use canvas coordinates relative to the plot anchor if needed, 
  // or just plot-relative if sticking inside plot.add, but manual annotation here looks nice.
  // Since we are outside the plot block, we'd need the plot anchor.
  // To keep it simple, I put the line inside plot.add above.
})
