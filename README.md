# Multi-Part Multi-Location Pick-and-Place Simulation Using NLMPC (MATLAB)

This repository contains a MATLAB-based simulation for a **ingle-part pick-and-place** and a **multi-part, multi-location pick-and-place robotic system** controlled using **Nonlinear Model Predictive Control (NLMPC)**. The simulation demonstrates how a **single robotic arm** can efficiently and accurately handle multiple objects from various source locations and deliver them to distinct target positions in a **single operational cycle**.

The NLMPC framework integrates:
- Real-time path optimization
- Penalization of velocity and acceleration for smooth motion
- Terminal constraints to ensure precise end-effector stopping
- Euclidean distance constraints for high terminal accuracy

This project is ideal for researchers, students, and engineers working on advanced robot motion planning, MPC, or industrial automation strategies.

---

## System Requirements

- **MATLAB R2022a or later**
- A computer with a **GPU** is recommended for smooth and fast simulation
- Required Toolboxes:
  - Model Predictive Control Toolbox
  - Robotics System Toolbox
  - Optimization Toolbox

---

## How to Run the Simulation

1. Open **MATLAB** (version 2022 or later).
2. Change the **current folder** to the directory containing this repository's files.
3. Open the file: `SimulationStarter.MLX`.
4. Click the **"Run"** button in the toolbar.
5. The simulation will start automatically and display the multi-part pick-and-place process in action.

---

## Exploring the Code

- To learn more about the **NLMPC controller**, system dynamics, and task planning:
  - Review the `.m` files and class definitions in the repository.
  - Each component is modular and includes comments to help guide your understanding.

---

## Project Highlights

- Single robotic arm handles **multiple objects and destinations** in a single cycle
- Uses **Nonlinear MPC** to adaptively plan optimized paths
- Ensures **smooth stopping** through terminal penalization
- High-precision placement via **Euclidean distance constraints**
- Real-time control ideal for **dynamic, complex environments**


