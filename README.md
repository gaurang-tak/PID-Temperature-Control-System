# PID Temperature Control System – MATLAB & Simulink

## Project Overview

This project presents the modeling and closed-loop temperature control of a first-order thermal system using **P, PI, and PID controllers** in MATLAB and Simulink.

The objective is to regulate the normalized temperature at a reference value of **1** and compare the performance of different controllers based on:

- Rise time
- Settling time
- Peak time
- Overshoot
- Steady-state error

The project also analyzes the ability of the PID controller to maintain the desired temperature when an external disturbance is applied at **t = 30 seconds**.

### Controller Comparison

![P, PI and PID Controller Comparison](results/Combined_P_vs_PI_vs_PID_graph.png)

The comparison plot shows the response of the P, PI, and PID controllers toward the desired temperature setpoint.

---

## Software Used

- MATLAB
- Simulink
- Control System Toolbox

---

## Thermal Plant Model

The thermal system is modeled as a first-order plant with the following transfer function:

```math
G(s)=\frac{1}{10s+1}
