#import "@preview/droplet:0.3.1": dropcap
#import "@preview/wordometer:0.1.5": word-count, total-words
#import "@preview/lovelace:0.3.0": pseudocode-list
#import "@preview/glossarium:0.5.9": make-glossary, register-glossary, print-glossary, gls, glspl
#import "uiomasterfp/frontpage.typ": cover
#import "uiomasterfp/frontpage.typ": colors
#import "glossary.typ": entry-list
#import "style.typ": style, serif-text, mono-text, box-text

#show: style
#show: make-glossary
#show: word-count

// FRONTPAGE
#cover()

// ABSTRACT, ACKNOWLEDGEMENTS AND OUTLINE
#counter(page).update(1)

#v(1.2cm)
#align(center)[
#block(width:90%, inset: 2em)[
#align(left)[
  #text(weight:"semibold",size:16pt,[ABSTRACT])

  #serif-text()[
    #lorem(200)
  ]]
]]

#v(3cm)
#align(center)[
#block(width:100%)[
  #align(left)[
  #text(weight:"semibold",size:16pt,[ACKNOWLEDGEMENTS])

  #serif-text()[
    #lorem(78)
  ]]
]]

#pagebreak()

#{
  set text(font: "Geist", weight: "medium", size: 10pt)
  outline(depth:3, indent: auto)
}

#v(.5em)
#text(size: 9pt, weight: "medium")[
Wordcount: #total-words
]

#pagebreak()

#heading(outlined: false, numbering: none, level: 1)[GLOSSARY]
#{
set text(font: "Geist", weight: "medium", size: 10pt)
register-glossary(entry-list)
print-glossary(
 entry-list
)
}

#pagebreak()

= Introduction <intro>

#serif-text()[ The quest to create intelligent machines is one of humanity's most profound ambitions. This idea spans the realms of philosophy, mathematics, and engineering, tracing its roots far back into antiquity. From the ancient Greek myth of Talos---a conscious mechanical man of bronze---to the automata of the Enlightenment, the dream of synthetic life has always captivated the human imagination. However, what was once the domain of storytellers and philosophers is no longer confined to speculation. We are currently at the heart of a technological revolution that places the nature of intelligence at the center of our scientific and economic lives. Answering how intelligence emerges from inert matter, and how we can reproduce it, promises not only to unlock a deeper understanding of our own minds but to yield transformative tools---from hyper-personalized medicine to automated scientific discovery. As has been famously suggested, true @ai may be the last invention humanity ever needs to make.

In recent years, the materialization of this dream has accelerated dramatically. Deep Learning, a paradigm that layers simple computational units into vast networks, has shattered performance barriers previously considered insurmountable. We have witnessed these systems achieve demonstrably superhuman proficiency in domains once thought to be the exclusive purview of human intuition. In the realm of science, models like AlphaFold have solved decades-old biological grand challenges; in strategy, reinforcement learning agents have conquered the combinatorial complexity of games like Go; and in communication, Large Language Models have demonstrated a fluency that blurs the line between statistical mimicry and genuine understanding. This wave of success has solidified @ai's status not merely as a tool, but as a general-purpose technology on track to reshape the fundamental infrastructure of society.

However, amidst this explosive growth, fundamental cracks have begun to form beneath the surface. The triumph of modern deep learning is built largely on a paradigm of brute force---scaling performance by simply pouring in more data and more compute. We are now rapidly approaching the physical and economic limits of this strategy. The training of a single state-of-the-art model can consume megawatts of power, emitting a carbon footprint comparable to the lifetime emissions of multiple automobiles @Placeholder. While specialized processing units offer marginal gains, they cannot fix the fact that the underlying architecture is fundamentally inefficient. This voracious hunger for power is matched by an insatiable appetite for data; models now demand planet-scale datasets which are becoming increasingly difficult to source, curate, and maintain. Worse still, new evidence suggests that this brute-force approach is yielding diminishing returns. Despite their superhuman acuity in narrow tasks, these models often prove to be brittle, statistical correlation engines. They exhibit a profound lack of common-sense reasoning, struggle with robust out-of-distribution generalization, and often fail in spectacularly simple, non-human ways.

These fundamental flaws become starkly apparent when we compare artificial systems to the biological intelligence they strive to mimic. The human brain serves as a humbling existence proof that high-level intelligence does not require megawatts of energy or ocean-sized datasets. Consider the energy disparity. The human brain operates on approximately 20 watts of power---roughly equivalent to a dim lightbulb @Placeholder. Yet, with this meager energy budget, it does not merely classify static images; it manages a complex biological organism, processes a continuous flood of high-bandwidth multi-sensory data, navigates a dynamic 3D world, and engages in abstract reasoning---all in real-time. In contrast, matching just a fraction of these capabilities with deep learning requires massive GPU clusters consuming energy at the scale of a small town. The brain outperforms our best silicon by orders of magnitude in energy efficiency. The disparity in learning efficiency is equally profound. Deep learning models are notoriously "sample inefficient," requiring thousands or millions of examples to converge on a robust representation of a concept. In contrast, biological systems excel at "one-shot" or "few-shot" learning. A human child can be shown a "giraffe" once or twice and effectively recognize it for a lifetime, under varying lighting and angles. Furthermore, biological learning is continuous and plastic; we can learn new information without overwriting the old (catastrophic forgetting), a feat that remains a significant open challenge for artificial neural networks. This vast gap suggests that the inefficiency of modern AI is not merely a matter of engineering optimization, but a symptom of a deeper paradigmatic mismatch. It implies that contemporary deep learning, and the hardware it runs on, is missing or disastrously oversimplifying the fundamental principles that make biological intelligence so scalable and robust.

The path forward must therefore be one of biological inspiration, not just in theory but in practice. To bridge the chasm between the efficiency of the brain and the brute force of modern AI, we must look toward a fundamentally different computational paradigm: Neuromorphic Computing. At its core, neuromorphic computing is the attempt to engineer the physical structure of a computer to mimic the biological structure of the nervous system. Unlike traditional AI, which is often a software abstraction running on unrelated hardware, neuromorphic engineering seeks to close the gap between the algorithm and the substrate. It envisions a move away from the rigid, clock-driven rhythm of standard processors toward systems that are asynchronous, parallel, and "event-driven." In this paradigm, information is not represented by continuous streams of numbers, but by discrete, sparse events---often called "spikes." Much like neurons in the brain, a neuromorphic processor remains largely dormant, consuming negligible energy until a specific event triggers activity. This "sparsity" allows the system to process information only when and where it is needed, mirroring the brain's ability to ignore the static background and focus solely on changes in the environment. This is no longer a fringe theoretical pursuit; it is a burgeoning scientific frontier. A global community of physicists, neuroscientists, and engineers is currently racing to build these "brain-chips." From large-scale industrial efforts like Intel’s Loihi and IBM’s TrueNorth to massive academic supercomputers like the SpiNNaker project in Europe, the hardware landscape is diversifying. These systems are not merely faster versions of what we have today; they represent a complete reimagining of what a computer can be---moving from a machine that strictly calculates to a machine that adapts, interacts, and learns in real-time.

In this thesis, we explore how this shift toward event-driven, biologically plausible computation can resolve the critical limitations of scalability, data efficiency, and energy consumption. We present novel approaches for the efficient coding of information and demonstrate how to compute with such encodings, alongside exploring learning algorithms inspired by the mechanisms of the brain. However, we must temper biological inspiration with engineering reality. While we wish to emulate the brain, we are limited by our inability to manufacture the brain's substrate—specifically, its immense 3D connectivity and density. We are bound to the planar constraints of standard CMOS manufacturing. Therefore, a pragmatic approach is required. We must make calculated abstractions to best utilize our current hardware capabilities. The central challenge, and the focus of this work, lies in identifying the functional essence of the brain—distinguishing the core principles of computation from the intricate biological details that may be evolutionary byproducts or physical constraints of wetware. Concretely, this thesis aims to:

#box-text()[
- Investigate Sparse Information Flow: Explore how information can be encoded and processed using sparse, asynchronous events (spikes) within a neural network.

- Develop Biologically Plausible Learning: Explore and evaluate learning algorithms that are suitable for such networks, adhering to the constraints of locality and efficiency.
]

The remainder of this thesis is organized as follows: The succeeding chapter lays the theoretical foundation, covering early neuroscience and the development of artificial neural networks based on simple models of the brain. Following this, we review relevant modern neuroscience literature, extracting key concepts that will inform the methodology. Finally, we detail the implementation of these principles in a neuromorphic context and evaluate their performance against standard benchmarks. ]

#pagebreak()

= Background <background>


#serif-text()[
The aim of this section is to shed light on the history and developments of @ai, we will also go trough key concepts in modern neuroscience that will be important to understand the motivation for the methods used in this thesis.

We will begin at that shared origin point, a time when @ai research and and neuroscience were one and the same. We will then follow a diverging path that leads to modern deep learning and understand why it has little in common with modern neurscience but also why it is so powerful but also so inefficient. Finally, we will explore the neuromorphic path, the modern neuroscience it is built upon. We will end this section with a review of similar frameworks and methods---showcasing their strenghs and weaknesses and how we can improve opon them.
]

#v(2em)
== Neuron Doctrine

#serif-text()[ For centuries, the dominant theory of what the brain was made of was the reticular theory, which stated that the brain was a single, continuous, fused network of tissue (a reticulum). This theory was challenged by the work of Spanish neuroscientist Santiago Ramón y Cajal. Using novel staining techniques, he established the neuron doctrine at the turn of the 20th century, proving that the brain was composed of discrete, individual cells---the neurons---which acted as the fundamental units of the nervous system @Placeholder. We now have irrefutable evidence that supports the neuron doctrine using modern electron microscopes.

This foundation---that the brain is made of discrete units called neurons---led to the development of the first models of neurons, describing their high-level function. In 1943, neurophysiologist Warren McCulloch and logician Walter Pitts published their seminal paper, _A Logical Calculus of the Ideas Immanent in Nervous Activity_. They proposed the McCulloch-Pitts (M-P) neuron @Placeholder, the first mathematical model of the neuron.

Their model was simple; it abstracted the neuron into a binary decision device with inputs and outputs:
]

#box-text()[
- The neuron receives multiple binary inputs.
- The inputs are weighted as either excitatory (positive) or inhibitory (negative).
- The neuron sums these weighted inputs.
- If the sum exceeds a fixed threshold, the neuron outputs a 1 (it fires).
- If the sum does not meet the threshold, it outputs a 0 (it remains silent)
]

#serif-text()[
By combining these simple units, McCulloch and Pitts demonstrated that they could construct any logical operation (AND, OR, NOT) @Placeholder. This invention marked the beginning of computational neuroscience. The brain's fundamental components could be modeled as simple logic gates, and these neurons could be relaized arificially using electronics. The M-P neuron was the common ancestor of both artificial intelligence and computational neuroscience.

Altough the M-P neuron was a large step forward it had some obvious drawbacks: its connections were fixed, limiting the learing, circuits created with the M-P neuron had to be handcrafted. Binary weights makes all connections eqaul importance. It cannot capture real inputs

In 1949, 6 years after McCulloch and Pitts published their paper, psychologist Donald Hebb provided the theoretical framework that could help solve the M-P neuron's learing problem. He proposed a mechanism for how learning could occur in the brain in his book _The Organization of Behavior_. This mechanism is now famously summarized as Hebb's Rule or Hebbian learning. The principle states:
]
#box-text()[
Let us assume that the persistence or repetition of a reverberatory activity (or "trace") tends to induce lasting cellular changes that add to its stability. ... When an axon of cell A is near enough to excite a cell B and repeatedly or persistently takes part in firing it, some growth process or metabolic change takes place in one or both cells such that A’s efficiency, as one of the cells firing B, is increased @Placeholder.
]

#serif-text()[
In simpler terms: "neurons that fire together, wire together" @Placeholder. This was a local and decentralized learning rule. A synapse didn't need a teacher or a global error signal, it only needed to know if it successfully contributed to its post-synaptic neuron's firing.

With this framework in place, and the pionering work by McCulloh and Pitts the stage was set for the invention that would become the backbone in modern @ai
]

#v(2em)
== The Perceptron

#box(width: 48%)[#serif-text()[
In 1957, psychologist Frank Rosenblatt took these theoretical ideas and created the first practical, engineered neural network: The Perceptron. It was a direct hardware implementation (the "Mark I Perceptron") of the McCulloch-Pitts neuron, but with one crucial addition: a trainable learning rule based on Hebb's ideas. Rosenblatt's key contribution was the perceptron learning rule, an algorithm that could automatically adjust the weights to learn. The machine was shown a pattern (e.g., a letter) and it would guess a classification. If the guess was wrong, the algorithm would slightly increase the weights of connections that should have fired and decrease the weights of those that fired incorrectly. The Perceptron was capable of classifying linearly #h(1fr) separable #h(1fr) patterns, #h(1fr) and #h(1fr) its #h(1fr) creation #h(1fr) sparked]]
#h(2%)
#box(width: 48%, height: 8cm)[
#figure(include("figures/perceptron.typ"),caption:[The perceptron---a simple model of how a neuron operates. Inputs $x_i$ get multiplied by weights $w_i$ and summed. If the sum $∑ w_i x_i$ surpasses a threshold (or "bias" $b$), the neuron fires.
])]
#serif-text()[
immense optimism. It was hailed as the first "thinking machine" @Placeholder. However, this excitement was brought to an abrupt halt. In 1969, @ai pioneers Marvin Minsky and Seymour Papert published their book Perceptrons, a rigorous mathematical analysis of the model's limitations. Their most famous critique was the "XOR problem." They proved that a single-layer perceptron could learn simple logic functions like AND or OR, but it was fundamentally incapable of learning the @xor function. The problem is that the true and false cases for XOR cannot be separated by a single straight line, and a single perceptron is only capable of drawing a single line. This critique was devastating. It demonstrated that this simple model was a dead end for solving more complex, real-world problems.
]

#figure(include("figures/gates.typ"),caption:[XOR linear separable #lorem(20).])

#serif-text()[
The book's impact led to a near-total collapse in neural network funding, an era now known as the First @ai Winter. Even though Minsky and Papert had exposed a devastating flaw in the perceptron algorithm they themselves noted that a @mlp, stacking multiple layers of these units---could theoretically solve the XOR problem by creating more complex decision boundaries. The challenge was that no one knew how to train it. Rosenblatt's rule only worked for a single layer. If the next generation of @ai researchers could figure out how to train a @mlp they should be able to make machines that can make descitions on data that are not linearly separable.
]

== The Deep Learning Path

#serif-text()[
The critique by Minsky and Papert froze funding, but it did not kill the theoretical ambition. It was generally understood that if a single perceptron could not solve the XOR problem, a network of them---a Multi-Layer Perceptron (@mlp)---could. By stacking neurons into layers, the network could theoretically warp the input space to create complex, non-linear decision boundaries. The hardware was not the issue; the problem was the learning algorithm.

In a single-layer perceptron, the error is obvious: if the output is wrong, the weights directly connected to that output are "to blame." But in a multi-layer network, how do you determine which neuron in the middle "hidden" layers contributed to an error at the end? This was the "Credit Assignment Problem," and it remained an insurmountable wall for over a decade.
]

#figure(include("figures/network.typ"),caption:[A Multi-Layer Perceptron (MLP). By adding "hidden layers" between input and output, the network can solve non-linear problems like XOR. The challenge was discovering how to train these middle layers.])

=== Backpropagation

#serif-text()[
The thaw of the AI Winter arrived not through a biological discovery, but a mathematical one. In the 1970s and 1980s, researchers (including Rumelhart, Hinton, and Williams) popularized the Backpropagation algorithm. It was a definitive solution to the Credit Assignment Problem.

Backpropagation treats the neural network not just as a model of the brain, but as a massive, differentiable mathematical function. It uses the chain rule of calculus to compute the gradient of the error function with respect to every single weight in the network. Conceptually, the algorithm calculates the error at the output and propagates it backward through the layers. It precisely assigns "blame" to every neuron in the chain, calculating exactly how much each connection contributed to the final error and adjusting the weights (Δw) to minimize it.

This unlocked the ability to train deep networks. Suddenly, MLPs were no longer theoretical curiosities; they were powerful function approximators capable of learning complex, non-linear mappings from data.
]

=== Achievements

#serif-text()[
With the training mechanism solved, the field exploded. The combination of Backpropagation, massive datasets, and GPU hardware led to a "Cambrian Explosion" of neural architectures, each solving domains previously thought impossible for computers.

The revolution began in earnest with computer vision. Convolutional Neural Networks (@cnn), such as AlexNet (2012) and later ResNet, introduced the idea of learning hierarchical features---detecting edges, then shapes, then objects---much like the human visual cortex. This allowed machines to classify images with superhuman accuracy.

Soon after, the focus shifted to sequence data. Recurrent Neural Networks (RNNs) and LSTMs gave machines a short-term memory, enabling breakthroughs in speech recognition and machine translation. However, the true paradigm shift occurred with the introduction of the Transformer architecture in 2017. By utilizing an "attention mechanism" to parallelize the processing of language, Transformers allowed for the training of massive Large Language Models (LLMs) like GPT.

These techniques have even transcended media generation. Deep Learning has solved fundamental scientific problems; notably, DeepMind's AlphaFold utilized these architectures to predict the 3D structure of proteins from their amino acid sequences, a 50-year-old grand challenge in biology.
]

=== Shortcomings

#serif-text()[ The "engineering path" was undeniably successful. By ignoring biological constraints, we created models that could master Go, fold proteins, and generate human-like text. However, this success was achieved through brute force. By effectively simulating neural networks on hardware that was never designed for them, we have run into a new set of fundamental walls. The very divergence that allowed Deep Learning to thrive---separating the software from the hardware---has now become its greatest liability.

1. The Von Neumann Bottleneck

The brain is a "compute-in-memory" architecture; synapses store memory and perform processing in the exact same physical location. Modern computers, however, are built on the Von Neumann architecture, which physically separates the Processing Unit (CPU/GPU) from the Memory (RAM). For Deep Learning, this is catastrophic. A neural network is essentially a massive collection of weights (memory) that must be multiplied by inputs (compute). To run a modern LLM, the hardware must constantly shuttle billions of weights back and forth between the memory chips and the processor cores for every single token generated.

2. The Energy Crisis

The bottleneck is not just about speed; it is about energy. In modern silicon, the act of moving data is far more expensive than processing it. Fetching a single byte of data from off-chip memory consumes roughly 1,000 times more energy than performing a floating-point operation on that data. This has led to the era of "Megawatt Models." While the human brain operates on ≈20 watts (roughly the power of a dim lightbulb), our artificial equivalents require entire power plants.

3. Data Inefficiency and Opacity

Finally, Backpropagation is incredibly sample-inefficient compared to biology. Deep Learning models often require millions of examples to learn concepts that a human child can grasp from a single observation ("one-shot learning"). Furthermore, the resulting models are opaque "Black Boxes." We know that they work, but due to the distributed nature of their representations, we often cannot explain how or why specific decisions are made.
]

=== Engineering vs. Biology: The Great Divergence

#serif-text()[ This brings us to the root cause of these shortcomings. While the Perceptron was born from a desire to mimic the brain, the success of Backpropagation drove the field toward mathematical pragmatism and away from biological realism. To solve the training problem, mainstream AI accepted mechanisms that are fundamentally impossible in biological tissue.

The two most significant violations are:

The Non-Locality of Data: In backpropagation, a synapse in the first layer changes its strength based on an error calculation that occurred at the very end of the network. In the brain, learning is widely believed to be local (Hebbian plasticity)---synapses change based only on the immediate activity of the two neurons they connect, not a global error signal.

The Weight Transport Problem: To calculate the error gradient backward, the algorithm requires the backward pass to use the exact same synaptic weights as the forward pass. In the brain, synapses are unidirectional chemical bridges; there is no known biological mechanism that allows a neuron to "read" the strength of a downstream synapse to calculate an error derivative.

This divergence created a paradox: we achieved Artificial Intelligence, but at the cost of efficiency and explainability. We built software that behaves somewhat like a brain, but forced it to run on hardware that functions nothing like one.

To break through the energy and efficiency walls, researchers are now asking a new question: What if we stop forcing neural networks into the Von Neumann architecture? What if, instead of ignoring the biological constraints that Minsky and Papert critiqued, we embraced them? This line of thinking points toward a return to the original inspiration: Neuromorphic Computing.
]

#v(2em)
== The Birth of Neuromorphic Computing

#serif-text()[ While the artificial intelligence community was struggling through the AI Winter, debating the merits of symbolic logic versus connectionism, a parallel revolution was brewing in the field of hardware physics. In the late 1980s at Caltech, physicist and engineer Carver Mead---already a legend for pioneering VLSI (Very Large Scale Integration) chip design---began to question the fundamental trajectory of digital computing.

Mead observed that while digital computers were becoming exponentially faster (following Moore's Law), they were also becoming exponentially less efficient in terms of energy per operation. He realized that the prevailing method of building computers---using transistors as rigid, high-power "on/off" switches to perform boolean logic---was incredibly wasteful compared to the biological brains they were trying to emulate.

In 1990, Mead published his seminal paper, Neuromorphic Electronic Systems, coining the term "neuromorphic" (combining neuro for nerve and morph for form). His thesis was radical: rather than writing software to simulate the equations of a neuron on a digital computer, we should build physical hardware that relies on the same laws of physics as the biological nervous system. ]

#v(1em)
=== The Subthreshold Insight

#serif-text()[
The core insight that launched the field was a physical analogy between silicon and biology. In standard digital electronics, transistors are operated in "strong inversion." They are driven with high voltages to act as binary switches---either fully open (1) or fully closed (0). This ignores the complex physics that happens in between those states.

Mead, however, looked at the transistor in the "subthreshold" (or weak inversion) region---the tiny trickle of current that flows when the transistor is technically "off." He discovered that in this low-power regime, the current flowing through a transistor $I_"ds"$ is an exponential function of the gate voltage $V_"gs"$
$ I_"ds" prop "e" kai V_"gs" / U T $​
Crucially, this is the exact same Boltzmann-distribution physics that governs the flow of ions through protein channels in a biological neuronal membrane.

This realization was profound. It meant that a single transistor, operating in its natural subthreshold state, could physically compute the same exponential, non-linear functions that biological neurons use, but at a distinct speed advantage and with microscopic power consumption. We did not need thousands of logic gates to simulate a synapse; a synapse could be implemented by a single transistor.
]

#v(1em)
=== The Silicon Retina

#serif-text()[ To prove this concept, Mead and his doctoral student Misha Mahowald developed the Silicon Retina in 1991. It was the first true neuromorphic system.

Unlike a standard camera, which takes a snapshot of the entire world frame-by-frame (creating a massive stream of redundant data), the Silicon Retina mimicked the human eye. It used analog circuits to compute spatial and temporal derivatives directly on the chip. It did not output "frames"; it output asynchronous "events" only when the light intensity changed at a specific pixel.

If the retina stared at a static wall, it transmitted zero data and consumed almost zero energy. This mimicked the efficiency of biology and solved the redundancy problem inherent in digital sampling. It demonstrated that by "listening to the silicon"---by letting the physics of the device perform the computation---machines could process sensory information with a fraction of the power of a digital computer. ]

=== The Three Pillars of Neuromorphic Engineering

#serif-text()[ From this foundation, the field of Neuromorphic Engineering was established on three core principles that directly oppose the Von Neumann architecture:

    Analog Computation: Using the continuous physics of the device (voltage and current) to represent information, rather than binary abstraction.

Asynchronous Communication: Removing the global clock. Parts of the chip only operate when there is data to process, eliminating the massive power drain of "clock distribution" seen in modern CPUs.

Co-location of Memory and Compute: Eliminating the separation between the processor and the RAM. In a neuromorphic chip, the "weight" of a neural connection is stored physically within the circuit that does the processing, effectively destroying the Von Neumann bottleneck. ]

#serif-text()[ Why did it not take off immediately?

Despite the brilliance of Mead's insight, neuromorphic computing remained a niche academic curiosity for decades. The reason was economic: Moore's Law. For thirty years, it was simply cheaper and easier to simulate neural networks on rapidly improving, general-purpose digital CPUs than it was to design difficult, noisy, custom analog hardware.

However, as discussed in the previous chapter, Moore's Law is now slowing, and the energy demands of Deep Learning are exploding. The "free lunch" of digital scaling is over. This has forced the AI community to look back at Mead's original vision. We are now seeing a renaissance of these ideas, evolving from purely analog circuits to modern Spiking Neural Networks (@snn) implemented on digital-neuromorphic hybrids like Intel's Loihi and IBM's TrueNorth. ]

#v(2em)
== Modern Neuroscience

#serif-text()[
A lot has happened in neuroscience since the birth of the perceptron and the divergence of pragmatic @ai that evolved into deep learning. New insights about the structure and mechanics of the brain can give rise to new neuromorphic architechtures that might perform similar to the brains astonishing performance. This section will briefly go trough modern mechanistic neuroscience to lay a foundation for neuromorphic engineering.
]

#v(1em)
=== Spiking Neurons
#serif-text()[
The basic building block of the brain used to form many types of neural circutry is the neuron. It is a specialized cell, that in addition to having a cell body with many of the elemnts you typically excpect from a cell like mitocondria and nucleas, it also has extruding structures called denrites, axons and synapses. These structures allow neurons to connect to other neurons and communicate using what is called an @ap. @ap:pl are voltage potentials across the cells membrane, When a post synaptic neuron ...  ]

#figure(
  include("figures/bioneuron.typ"),
  caption: [Proposed simplifed layout of a SNN. The neurons are connected with hirearcical busses
  that allow for the network to be configured as a _small world network_]
)

#serif-text()[ Action potentials are in general uniform and look the same for every neuron every time they spike,
Graded potentials are primarily generated by sensory input ]

#figure(include("figures/actionpotential.typ"),caption:[Neuron dynamics])

#serif-text()[ The artificial neurons used in most deep learning models (like ReLU or sigmoid units) are static. They compute a weighted sum of their inputs, apply an activation function, and output a single, continuous value (like 0.83 or 5.2). This value is assumed to represent the neuron's firing rate. Biological neurons don't work this way. They are spiking neurons, and their computation is: ]
#box-text()[
- Temporal: They integrate inputs over time. A neuron's internal state (its membrane potential) rises and falls based on when inputs arrive.
- Event-Driven: They do not communicate with continuous values. They communicate using discrete, all-or-nothing electrical pulses called action potentials, or "spikes." A neuron only fires a spike when its internal potential crosses a specific threshold. 
- Efficient: Because they are event-driven, they are sparse. A neuron spends most of its time silent, only consuming energy when it receives or sends a spike. ]
#serif-text()[ In this model, information is not just in how many spikes there are (a rate code), but when they occur (a temporal code). A spike arriving a few milliseconds earlier or later can completely change the computational outcome. ]

#v(1em)
=== Generalized Leaky Integrate And Fire

#figure(
kind: "eq",
supplement: [Equation],
caption: [Generalized leaky integrate and fire differential equation gouvering the dynamics of a neurons membrane potential],
[
$ tau_m (dif u)/(dif t) = -(u - u_"rest") + R(u) I(t) $
])
#serif-text()[
Considering all input currents to be uniform packets (spikes), the dirac delta function fits well into the mathematical framework
]
#figure(
kind: "eq",
supplement: [Equation],
caption: [Generalized leaky integrate and fire differential equation gouvering the dynamics of a neurons membrane potential],
[
$ tau_m (dif u)/(dif t) = -(u - u_"rest") + R(u) q delta(t) $
]
) <glif>
#serif-text()[
solving the equation
]
#figure(
kind: "eq",
supplement: [Equation],
caption: [Generalized leaky integrate and fire differential equation gouvering the dynamics of a neurons membrane potential],
[
$ u(t) = u_"rest" + sum_f (u_r - phi) exp(- (t-t(f))/tau_m) + R/tau_m limits(integral)_0^infinity exp(-s/tau_m) I(t-s) dif s $
]
) <glif>


#v(1em)
=== Neuron Dynamics

#box-text()[
Attractor network\
Point attractors – memory, pattern completion, categorizing, noise reduction\
Line attractors – neural integration: oculomotor control\
Ring attractors – neural integration: spatial orientation\
Plane attractors – neural integration: (higher dimension of oculomotor control)\
Cyclic attractors – central pattern generators\
Chaotic attractors – recognition of odors and chaos is often mistaken for random noise.\
]

#figure(include("figures/neurondynamics.typ"),caption:[Neuron dynamics])

#figure(include("figures/bifurcation.typ"),caption:[Neuron dynamics])

#serif-text()[
Write about dynamical models and hoph bifucations, write about modes of firing depending on bifurcations ...
]

#serif-text()[
The biological neuron is the fundamental building block of the brain. The biological neuron consists of a cell body also called the soma, which contains all of the core machinery that other cells have, like the nucleus and mitochondria. However, it also has distinct structures:
#box-text()[
- Dendrites: A branching "input" tree that receives signals from other neurons.
- Axon: A long "output" cable (which can be over a meter long in humans) that transmits the neuron's own signal.
- Synapses: The junctions where an axon's terminal meets another neuron's dendrite to pass the signal.
]

When pre-synaptic neurons fire, they release neurotransmitters (like glutamate or dopamine) across the synapse. These chemicals open ion channels on the post-synaptic neuron, causing its internal electrical potential (the "membrane potential") to increase. If this potential, which is integrated over time, reaches a critical threshold, the neuron itself fires an action potential (a spike) down its axon.

Although the perceptron captures the basic idea of "integrating inputs to make a decision," a lot is left on the table. A lot of progress and new ideas have surfaced since its invention. The neuron, once thought to be a simple switch, turns out to be a complex computational device.

This forces us to rethink everything:
- Information Encoding: How is information represented? Is it in the rate of spikes, the precise timing of the first spike, or in correlations between patterns of spikes? This is a key research topic not explored by older models.
- Learning Rules: How does the brain learn? It is entirely different from what deep learning uses. The brain's learning is local (like STDP) and continuous.
- Network Architecture: The brain isn't a simple feed-forward stack of layers. It is a deeply recurrent, complex, and fully asynchronous graph where signals propagate at their own speed.

A lot of work has been put into modeling the neuron. The most biologically realistic models, like the Hodgkin-Huxley model, are incredibly complex and computationally expensive, simulating the precise dynamics of multiple ion channels.

For most neuromorphic computing, a balance is struck with simpler, more efficient models. The most popular are the Leaky Integrate-and-Fire (LIF) models.
- Integrate: The model's potential rises as it receives input spikes (summing their weights).
- Leaky: The potential "leaks" away over time, modeling the neuron's tendency to return to its resting state.
- Fire: If the potential crosses the threshold, it fires a spike and its potential is reset.

The Generalized Leaky Integrate-and-Fire (GLIF) and other variants (like the Izhikevich model) are the best models we have today for large-scale, efficient simulation. They add more biological realism (like adaptation, where a neuron's firing rate slows over time) without the extreme computational cost of full biophysical models.
]

#v(1em)
=== Encoding Mystery

#serif-text()[
In digital representaton, a piece of information can be represented in various different ways, all using bits as the lowest information quanta. combining bits we get a richer representation. float is a popular choice of combining bits. For instance representing a luminance value of a pixel in an image is straight forward, each pixel gets its own float. Representing information using analog systems offers far more presicion, in electronic systems, values can be represented with currents or voltages which can be any value. The brain uses action potentials to communicate, action potentials are analog voltages so we might excpect that information gets packaged into the shape of the action potential, however as we have discussed the vast majority of neurons in the brain are spiking neurons, and their action potentials are uniform in size, looking more like individual bits in time. The information stored in brain signals are much more similar to the discrete digital representation than analog. The information must be encoded in the relative timing between spikes.

It is observed that neurons fire in short bursts called spikes. Experiments show that neurons fire repetably. A sequence of spikes is called a spike train, and exactly how information is encoded in a spike train is a topic of hot debate in neuroscience. A popular idea is that information is encoded in the average value of spikes per time called rate encoding. Temporal encoding the brain most likely uses a combination of all. The time to first spike encoding could be understood like this it is not about the absolute timing of the neurons rather a race of which spikes come first. the first connections would exite the post-synaptic neurons first and they should inhibit the others (lateral inhibition)
]


#figure(include("figures/rateencoding.typ"),caption:[The perceptron---a simple model of how a neuron operates. Inputs $x_i$ get multiplied by weights $w_i$ and summed. If the sum $∑ w_i x_i$ surpasses a threshold (or "bias" $b$), the neuron fires.]
)

#v(1em)
=== Biological Learning

#serif-text()[
This different model of computation requires a different model of learning. Deep learning's backpropagation is a "global" algorithm. To update a synapse in the first layer, you need an error signal calculated at the very last layer and propagated all the way back. This is highly effective but biologically implausible; there is no known mechanism for such a precise, "backward" error signal in the brain.

Instead, the brain appears to use local learning rules. The most famous is Hebb's rule: "Neurons that fire together, wire together."

A modern, measurable version of this principle is Spike-Timing-Dependent Plasticity (STDP). STDP is a learning rule that adjusts the strength (the "weight") of a synapse based purely on the relative timing of spikes between the pre-synaptic neuron (the sender) and the post-synaptic neuron (the receiver). 

The rule is simple and local:
- LTP (Long-Term Potentiation): If the pre-synaptic neuron fires just before the post-synaptic neuron (meaning it likely contributed to the firing), the connection between them is strengthened.
- LTD (Long-Term Depression): If the pre-synaptic neuron fires just after the post-synaptic neuron (meaning it fired too late and did not contribute), the connection is weakened.

This mechanism allows the network to learn correlations, causal relationships, and temporal patterns directly from the stream of incoming spikes, without any "supervisor" or global error signal. It is the biological alternative to backpropagation and a cornerstone of modern neuromorphic learning.
]

#serif-text()[
- no evidence that brain does not use global error signal like backpropagation uses
- each neuron weight gets updated by a local rule
- spikes are discrete and does not have a gradient
While spiking neural networks offer greater biological plausibility and potential advantages in processing temporal information and energy efficiency, their adoption faces significant challenges, primarily stemming from the nature of their core computational element: the discrete spike.

A cornerstone of the success of modern deep learning, particularly with Multi-Layer Perceptrons (MLPs) and related architectures, is the backpropagation algorithm. Backpropagation relies fundamentally on the network's components being differentiable; specifically, the activation functions mapping a neuron's weighted input sum to its output must have a well-defined gradient. This allows the chain rule of calculus to efficiently compute how small changes in network weights affect the final output error, enabling effective gradient-based optimization (like Stochastic Gradient Descent and its variants). These techniques have proven exceptionally powerful for training deep networks on large datasets.

However, when we transition from the continuous-valued, rate-coded signals typical of MLPs to the binary, event-based spikes used in SNNs, this differentiability is lost. The spiking mechanism itself---where a neuron fires an all-or-none spike only when its internal state (e.g., membrane potential) crosses a threshold---is inherently discontinuous. Mathematically, this firing decision is often represented by a step function (like the Heaviside step function), whose derivative is zero almost everywhere and undefined (or infinite) at the threshold.

Consequently, standard backpropagation cannot be directly applied to SNNs. Gradients calculated using the chain rule become zero or undefined at the spiking neurons, preventing error signals from flowing backward through the network to update the weights effectively. This incompatibility represents a substantial obstacle, as it seemingly precludes the use of the highly successful and well-understood gradient-based optimization toolkit that underpins much of modern @ai.

Surrogate Gradients: A popular approach involves using a "surrogate" function during the backward pass of training. While the forward pass uses the discontinuous spike generation, the backward pass replaces the step function's derivative with a smooth, differentiable approximation (e.g., a fast sigmoid or a clipped linear function). This allows backpropagation-like algorithms (often termed "spatio-temporal backpropagation" or similar) to estimate gradients and train deep SNNs, albeit with approximations.
]

#v(1em)
=== Neural Network

#serif-text()[
However, this abstraction, while powerful, significantly simplifies the underlying neurobiology. Decades of rigorous neuroscience research reveal that brain function emerges from complex electro-chemical and molecular dynamics far richer than the simple weighted sum and static activation. While it's crucial to discern which biological details are fundamental to computation versus those that are merely implementation specifics
moving beyond the standard MLP model is necessary to capture more sophisticated aspects of neural processing.

A primary departure lies in the nature of neural communication. Unlike the continuous-valued activations typically passed between layers in an MLP (often interpreted as representing average firing rates), biological neurons communicate primarily through discrete, stereotyped, all-or-none electrical events known as action potentials, or 'spikes'. Information in the brain is encoded not just in the rate of these spikes (rate coding), but critically also in their precise timing, relative delays, and synchronous firing across populations (temporal coding) (Gerstner et al., 2014). For instance, the relative timing of spikes arriving at a neuron can determine its response, allowing the brain to process temporal patterns with high fidelity – a capability less naturally captured by standard MLPs. Spikes can thus be seen as event-based signals carrying rich temporal information.

Furthermore, neural systems exhibit complex dynamics beyond simple feedforward processing. Evidence suggests that cortical networks may operate near a critical state, balanced at the 'edge of chaos,' a regime potentially optimal for information transmission, storage capacity, and computational power. Systems like the visual cortex demonstrate this complexity, where intricate patterns of spatio-temporal spiking activity underlie feature detection, object recognition, and dynamic processing. These biologically observed principles---event-based communication, temporal coding, and complex network dynamics---motivate the exploration of Spiking Neural Networks (SNNs), which explicitly model individual spike events and their timing, offering a potentially more powerful and biologically plausible framework for computation than traditional MLPs. This path (Neuromorphic) is the one that directly addresses the efficiency problem by using event-driven, spiking, and local learning rules, just like the brain.
]

#v(2em)
== Neuromorphic State Of The Art\ & Research Gaps

#serif-text()[
Disentangling core computational mechanisms from biological implementation details is a major ongoing challenge in neuroscience and neuromorphic engineering. Some complex molecular processes might be essential for learning or adaptation, while others might primarily serve metabolic or structural roles not directly involved in the instantaneous computation being modeled.
]

#serif-text()[
The principles of neuromorphic computing, born from Carver Mead's vision and informed by modern neuroscience, have matured from theoretical concepts into a vibrant field of applied research. This progress is best seen in two key areas: the development of specialized, brain-inspired hardware and the creation of sophisticated software frameworks for simulating and deploying spiking neural networks (SNNs).
#v(1em)
=== Neuromorphic Hardware
The primary goal of neuromorphic hardware is to escape the von Neumann bottleneck and emulate the power efficiency and massive parallelism of the brain. Two landmark systems define the state of the art:

IBM TrueNorth: A prominent early example, TrueNorth is a fully digital, real-time, event-driven chip. It consists of 4,096 "neurosynaptic cores," collectively housing one million digital neurons and 256 million synapses. Its architecture is explicitly non-von Neumann; processing and memory are tightly integrated within each core. TrueNorth's key achievement is its staggering power efficiency: it can perform complex SNN inference tasks (like real-time video object detection) while consuming only tens of milliwatts---orders of magnitude less than a CPU or GPU performing a similar task. However, its architecture is largely fixed, making it a powerful "inference engine" but less flexible for researching novel, on-chip learning rules.

Intel Loihi (and Loihi 2): Intel's line of neuromorphic research chips, starting with Loihi in 2017, represents a significant step towards flexible, on-chip learning. Like TrueNorth, Loihi is an asynchronous, event-driven digital chip, but with a key difference: it features programmable "learning engines" within each of its 128 neuromorphic cores. This allows researchers to implement and test dynamic learning rules, such as STDP and its variants, directly on the hardware in real-time. The second generation, Loihi 2, further refines this with greater scalability, improved performance, and more advanced, programmable neuron models, positioning it as a leading platform for cutting-edge neuromorphic algorithm research. 

#v(1em)
=== Simulation and Software Frameworks
Before algorithms can be deployed on specialized hardware, they must be designed, tested, and validated. This is the role of SNN simulators, which function as the "TensorFlow" or "PyTorch" of the neuromorphic world.

Brian: A highly flexible and popular SNN simulator used extensively in the computational neuroscience community. Its strength lies in its intuitive syntax, which allows researchers to define neuron models and network rules directly as a set of mathematical equations (e.g., the differential equations of a Leaky Integrate-and-Fire neuron). This makes it an ideal tool for exploring the detailed dynamics of biologically realistic models.

Nengo: A powerful, high-level framework that functions as a "neural compiler." Nengo is built on a strong theoretical foundation (the Neural Engineering Framework) that allows users to define complex computations and dynamical systems in high-level Python code. Nengo then "compiles" this functional description into an equivalent SNN. Its key advantage is its backend-agnostic nature; the same Nengo-defined network can be run on a standard CPU, a GPU, or deployed directly to neuromorphic hardware like Intel's Loihi.

#v(1em)
=== The Research Gap: The Learning Problem
Despite this immense progress in hardware and software, a fundamental challenge remains, creating a critical research gap: the training problem.

Mainstream deep learning has a powerful, universal tool: backpropagation. Neuromorphic computing does not yet have a clear equivalent. While these systems exist, they still struggle with finding an efficient, scalable, and powerful learning algorithm that is both biologically plausible and computationally effective.

This gap manifests in several ways:
1.  Limited Supervised Learning: "Local" rules like STDP are fundamentally unsupervised. They are excellent for finding patterns and correlations but struggle with complex, task-driven "supervised" problems (e.g., "classify this audio signal into one of ten specific words").
2.  The "Conversion" Compromise: A popular workaround is to first train a conventional, non-spiking ANN using backpropagation, and then "convert" its weights to an SNN for efficient inference. This method, while practical, is a compromise. It discards the rich temporal dynamics SNNs are capable of and does not represent true "neuromorphic learning."
3.  The "Surrogate Gradient" Challenge: The "firing" of a spiking neuron is a non-differentiable event, which makes it incompatible with standard backpropagation. New methods, like "surrogate gradient" learning, attempt to approximate this spike event with a smooth function to enable gradient-based learning, but this is an area of intense and ongoing research.

This thesis confronts this central challenge: How to effectively and efficiently train spiking neural networks for complex, real-world temporal tasks. While hardware like Loihi provides the platform for on-chip learning, it still requires a robust and scalable algorithm. The existing approaches of ANN-to-SNN conversion or simple Hebbian rules are insufficient.

This thesis proposes a method to bridge this gap by... (...for example: "...developing a novel, event-driven surrogate gradient algorithm capable of training deep SNNs directly in the temporal domain," or "...introducing a hybrid learning rule that combines the efficiency of STDP with the task-driven power of error-based feedback," or "...proposing a new architecture for temporal credit assignment that is both hardware-friendly and scalable.")
]

#pagebreak()

= Method <method>

#v(2em)
== Neuromorphic Framework

#serif-text()[
(e.g., "A Novel Framework for On-Chip Synaptic Plasticity") This chapter is your first contribution. It's where you present your new idea. Derivation: Start from first principles. Walk the reader through the math, the logic, or the formal model you developed. The Model: Formally present your new algorithm, equation, or architecture. This is the "pure" theoretical part. Hypotheses: End the chapter by explicitly stating the hypotheses your theory predicts. Example: "Based on this framework, it is hypothesized that an SNN implementing this rule (1) will be able to learn the N-MNIST dataset... (2) will do so with a lower average spike rate than a baseline model... and (3) will be robust to synaptic noise..."
By doing this, you've already "banked" a major contribution before you even show a single graph.
]

#v(2em)
== Neurons And Encoding

#serif-text()[
The neuron models and encoding are intertwined and cannot be developed separatly, the same goes for learing.
encoding where the inputs get increasingly smaller as the treshold increases can encode order of the elements, evidence for bio-plauibility can be found from eq 1 where the R(u) is dependent on the membrane potential
]

#serif-text()[
A neuron should have the following charecteristcs
]
#box-text()[
  - Acuumulate spikes in some form (integrate)
  - Fire when some treshold has been reached
  - Leak the potential over time
]
#serif-text()[
A neural code should
]
#box-text()[
  - be fast
  - be effecient in terms of neurons used
  - able to encode a wide range of stimuli
  - robust to noise
]

#v(1em)
=== Rate Code

#serif-text()[
A rate code uses the firing rate of a single neuron as carrier of information
]

#v(1em)
=== Temporal Code

#serif-text()[
In an temporal code information is stored in time
time to first spike, each neuron/input sends out one spike and the imformation is stored in the delay, shorter delay means stronger input, in such a sceme the computation could work with a balance of excitatiry and inhibitory neurons, the first to arrive (the stronges ones) win a "race" and inhibits others.
]

#v(1em)
=== Population Code

#serif-text()[
Both rate codes and temportal codes is most likely also combined with population codes in the brain
]


#v(1em)
=== Phase Ambiguity for temporal encodings

#serif-text()[
For rate coding phase is a non issue as we can find the instantanious firing rate at any phase, for time to first spike encoding we need a reference signal. If the reference signal starts at time t0 we have started the phase and if the pattern does not match up with the reference signal we could miss it. Evidence suggests that brain waves could play the role of a global reference signal. This is the fundamental trade off between the two.
A learning scheme where inputs have to occur in the same episode repeatedly two inputs that happen at the same time yields a stronger response. If the pattern is random then they would sometimes occur in the same episode and sometimes not. Two strong responses should occur in the same time frame. 

If the post neuron fires then we should strengthen the weights]

#figure(
  include("figures/spiketrain.typ"),
  caption: [Proposed simplifed layout of a SNN. The neurons are connected with hirearcical busses
  that allow for the network to be configured as a _small world network_]
)

#serif-text()[ Footnote digression for longer patterns
Longer patterns require a latched state such as neurons entering repeated firing like a state machine

An important point is to declare whether a mechanism is bio plausible. An engineer might not care wether or not a mechanism is used by the brain and is crucial to the brains function. An engineer might only care about if the mechanics works and is effective for the system that is created in the engineers vision. An engineer might just use the brain as an inspiration. Evolution althoug achieved remarkable feats is not guaranteed to foster up the most optimal solution, only good enough to survive to the next generation. However discussing wether or not a mechanism is bio plausible is still useful for understanding our own brain. And creating bio plausible artificial systems can contribute to more than one field.

Some neurons have other properties like bursting modes or continuous firing once the threshold has been reached.

Inhibition should make a neuron not fire
]

#figure(
kind: "eq",
supplement: [Equation],
caption: [Weigthed sum],
$ T = sum w/t $
)

#serif-text()[
In a time to first spike scheme of we care about the order (the relative values since information is stored in time and order) we have to use weights and a neuron model that distinguish between inputs arriving earlier than others. I present a scheme where the first neuron that arrives starts a linear count where the slope of the counter is the weight additional inputs will increase or decrease the slope according to their weight. We can see that neurons arriving earlier will get more time to increase the counter and thus will carry a higher value. If the counter reaches a threshold the neuron will fire. The astute will notice that in this scheme the neuron will fire even for the smallest stimulus since the counter will count up a non zero value and eventually reach the threshold, to mitigate this we can simply say that if the counter is too slow the neuron will not fire we will see later that this scheme satisfies the criteria above.

The problem with this decoding is for strong stimuli we would ideally make the neuron respond immediately and fire, but it has to wait until the counter has reached the threshold to fix this we can also add the weight of the input directly to the potential while also starting a counter. Now if early strong inputs arrive they will fill up the potential and make the neuron fire almost immediately. Small inputs wil take some time 
]

#figure(
  include("figures/neuronmodel.typ"),
  caption: [Proposed simplifed layout of a SNN. The neurons are connected with hirearcical busses
  that allow for the network to be configured as a _small world network_]
)


#serif-text()[
Leaky integrate and fire models seem the best bet, however complex dynamics like exponential decay and analog weights and potentials seem excessive, we might do without. Binary weights 1 for excitatory and and 0 for inhibitory. Stronger weights can be modeled with multiple parallel synapses
]

#serif-text()[
Another way which is also based on relative firing order of single spikes could be a passcode encoding. Such an encoding could work by having neurons only react to a sequence. It has an internal state machine of sorts and will only advance to the next state if recives the correct input in the correct order. This encoding does only care about relative order not relative timings.
]

#v(2em)
== Learning

#serif-text()[
learning with binary weights
learning with more steps of quantized or continous weights
Say we want to detect the pattern ABC and the pattern ABD. First of all if the order does not matter set all the weights equal. If the order does matter the weights determine the order. Now if a neuron learns pattern ABC so well that it learns to fire on only AB then it can fire faster. However if a second neuron wants to learn ABD then inhibition from the AB neuron prohibits it. A solution can be that if a neuron originally learned ABC but now fires on AB but stil has a strong weight on C it should remember this and if it fires on AB but then C does not arrive it should be like "oh, C did not show maybe I am wrong to fire early" eg. Decrease weights for A and B
It predicts!

A second way is to have a hierarchy with bypass. So one layer detects only AB then the next layer has bypass of the first layer and the second combining AB and C or D

A second problem is how to decode order. When do we start the decreasing timer, how fast, should it be in time or in amount of spikes, what to do with phase? The phase should correct itself. The weights need to be as presise as the timing of the spikes? Or we could make the neuron sensitivity proportional to its inverse potential and add leaking
]

#figure(
kind:"algorithm",
caption: [Unsupervised local learning rule for induvidual neurons. Based on STDP],
supplement: [Algorithm],
mono-text(pseudocode-list(hooks:.5em, indentation:1em, booktabs:true)[
+ start with a collection of neurons with arbitrary connections #h(1fr)
+ *if* a pre-synaptic neuron fires *then*
  + it has a chance to grow a synapse to a random post-synaptic neuron 
+ *if* a post-synaptic neuron fires *then*
  + strengthen all connections to pre-synaptic neruons that fired before
  + remove connections to pre-synaptic neurons that did not fire or fired after
- 🛈  a neuron can be both pre-synaptic and post-synaptic
]))

#figure(
kind:"algorithm",
caption: [Growing rules for synapses],
supplement: [Algorithm],
mono-text(pseudocode-list(hooks:.5em, indentation:1em, booktabs:true)[
+ probability of growing a synapse is inversely\ proportional to the amount it already has #h(1fr)
+ earlier firings should get a better chance to grow synapses,\ although this is regulated by
  inhibitory action
]))

#v(2em)
== Network

#serif-text()[
The nwtwork architecthure should be paralizeable allowing for each neuron to operate independenly with only a local influence from other neurons, some neurons can act as hubs allowing clusters with specialzed tasks to communicate.
]
#figure(
  include("figures/architecture.typ"),
  caption: [Proposed simplifed layout of a SNN. The neurons are connected with hirearcical busses
  that allow for the network to be configured as a _small world network_]
)

#v(2em)
== Simulator

#serif-text()[
#lorem(100)
#lorem(100)

#lorem(100)
]

#pagebreak()

= Results <results>

#serif-text()[
#lorem(100)

#figure(include("figures/network.typ"),caption:[Neural network before learing])

#figure(include("figures/network.typ"),caption:[Neural network during learning])

#figure(include("figures/network.typ"),caption:[Neural network after learning])

#lorem(100)

#lorem(100)

#lorem(100)

#lorem(100)
]

#pagebreak()

= Discussion <discussion>

#serif-text()[
In this section we discuss the

We see a trade-off between the ability to learn and speed of learing and forgetting. Synaptic plasticitiy must be tuned in order for the right learing enviroment to form


#lorem(150)

#lorem(150)

#lorem(100)
#lorem(100)

#lorem(100)

#lorem(150)

#lorem(150)
#lorem(100)
]

#pagebreak()

= Conclusion <conclusion>

#serif-text()[
#lorem(100)

#lorem(100)

#lorem(100)

#lorem(100)

#lorem(100)
]

#pagebreak()

#set text(weight: "medium")
#bibliography("references.bib")
