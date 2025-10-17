
import numpy as np
import matplotlib.pyplot as plt

# --- 1. Define the domain for the plot ---
# Generate 500 points for 't' from -2 to 10 for a smooth curve.
t = np.linspace(-2, 10, 500)

t1 = 6
t2 = 3
w1 = 0.8
w2 = 0.2
th = 2

term1 = np.exp((t - t1) * w1)
term2 = np.exp((t - t2) * w2)
e1 = np.where(t >= t1, term1-1, 0)
e2 = np.where(t >= t2, term2-1, 0)

# --- 2. Define parameters and calculate values for the first function ---
# This function will show growth since the weights (w1, w2) are positive.
y1 = e1 + e2


# --- 4. Create the plot ---
plt.style.use('seaborn-v0_8-whitegrid') # Apply a nice style to the plot
fig, ax = plt.subplots(figsize=(10, 6)) # Create a figure and an axes object

# Plot the two functions with different colors and labels
ax.plot(t, y1, label='', color='red')
ax.plot(t, e1, label='', color='blue')
ax.plot(t, e2, label='', color='green')

spike = t[y1 > th][0]
perceptron = (t1*w1) + (t2*w2)
print(perceptron)
print(spike)


# --- 5. Add labels, title, and other plot elements ---
ax.set_title('Plot of Two Summed Exponential Functions', fontsize=16)
ax.set_xlabel('t (time)', fontsize=12)
ax.set_ylabel('Function Value', fontsize=12)

# Set a sensible y-limit to better view both curves
ax.set_ylim(-0.5, 10)

plt.show() # Show the final plot
