#import "@preview/lilaq:0.5.0" as lq
#import "@preview/zero:0.4.0": set-num
#import "@preview/cetz:0.4.2"  
#set text(size: 9pt, font: "GeistMono NF", weight: "medium")
#set-num(math: false)

#set text(font: "GeistMono NF", weight: "medium", size: 9pt)
#let sans-text(body) = {
  set text(font: "Geist", size: 10pt, weight: "regular")
  body
}

#cetz.canvas({
  import cetz.draw: *
  content((0,0.5), [A - 9])
  content((0,0), [B - 3])
  content((0,-0.5), [C - 2])
  content((0,-1), [D - 2])
})
#lq.diagram(
  title: sans-text()[Rate encoding],
  xlabel: [t], 
  ylabel: [neuron index],
  yaxis: (
    ticks: range(2, 7).zip(([A], [B], [C], [D]))
  ),
  lq.scatter((0,1,2,3,4), (3, 5, 4, 2, 3)),
)
