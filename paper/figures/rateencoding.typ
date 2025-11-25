#import "@preview/cetz:0.4.2"  
#import "@preview/cetz-plot:0.1.3": plot, chart

#let data = (
  (0.0, -70), (0.5, -70.2), (1.0, -69.8), (1.5, -70),
  (1.8, -55),
  (1.9, -40), (2.0, -10), (2.1, 20), (2.2, 35), (2.25, 40),
  (2.3, 30), (2.4, 10), (2.5, -10), (2.6, -30), (2.7, -50), (2.8, -65),
  (3.0, -75), (3.5, -80), (4.0, -82), (4.5, -80), (5.0, -75),
  (6.0, -71), (7.0, -70.5), (8.0, -70)
)

#cetz.canvas(length:.6cm, {
  import cetz.draw: *
  content((0,0.5), [A - 9])
  content((0,0), [B - 3])
  content((0,-0.5), [C - 2])
  content((0,-1), [D - 2])

  plot.plot(
    size: (10, 8), 
    x-tick-step: 10, 
    y-tick-step: 50, 
    x-format: v => text(str(v)),
    y-format: v => text(str(v)),
    axis-style: "school-book", 
    name: "phase", 
    {    
    plot.add(
      data,
      style: (stroke: (paint: gray, thickness: 2pt)),
      label:
      "potential"
    )
  })
})
