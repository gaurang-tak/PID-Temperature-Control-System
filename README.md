# PID Temperature Control System

A MATLAB/Simulink-based temperature control system designed to analyze and compare the performance of P, PI, and PID controllers for a first-order thermal plant.

## 📌 Project Overview

Temperature control is an important application of feedback control systems. This project models a first-order thermal system and investigates how different controllers affect the system's transient and steady-state performance.

The project implements and compares:

- Proportional (P) Controller
- Proportional-Integral (PI) Controller
- Proportional-Integral-Derivative (PID) Controller

The controllers are evaluated using rise time, settling time, peak time, overshoot, and steady-state error.

The system is also tested under an external disturbance to analyze the disturbance-rejection capability of the PID controller.

---

## 🎯 Objectives

- Model a first-order thermal system using MATLAB/Simulink.
- Implement P, PI, and PID controllers.
- Compare the transient response of different controllers.
- Calculate important performance parameters.
- Analyze steady-state error.
- Test the PID controller under an external disturbance.
- Visualize the system response using MATLAB plots.

---

## ⚙️ System Model

The thermal plant is modeled as a first-order transfer function:

$$
G(s) = \frac{1}{10s+1}
$$

The system uses a closed-loop feedback configuration.

### Control Structure

```text
                    ┌─────────────────────┐
                    │   P / PI / PID      │
Setpoint ──► (+) ──►│     Controller      │──► Thermal Plant ──► Output
            ▲  -    └─────────────────────┘      G(s)=1/(10s+1)
            │                                             │
            └────────────────── Feedback ─────────────────┘
