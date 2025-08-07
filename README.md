# FPGA Beginner Projects

Welcome to **FPGA Beginner Projects**, a growing collection of beginner-friendly Verilog and FPGA designs. This repository is meant to help new learners understand the basics of digital logic, simulation, and hardware implementation using real, practical examples.

This collection is **still growing** — more projects will be added over time. Stay tuned and thank you for your patience!

---

## 📦 Available Projects

### 1. [led-blinker-timer](./led-blinker-timer)

A simple timer-based LED blinker module that toggles an LED at a specified frequency.

**Features:**
- Fully parameterized: frequency, width
- Generates clean square-wave output
- Active-low LED control
- Testbench-ready with waveform preview
- Clean, commented Verilog code

### 2. [uart-transmitter-receiver](./uart-transmitter-receiver)

A UART transmitter module implemented using a finite state machine.

**Features:**
- UART TX: start bit, 8 data bits, stop bit
- Baud-rate synchronized
- Clean FSM-based implementation
- Suitable for FPGA-to-PC or FPGA-to-FPGA communication
- Easy to integrate into larger designs

---

## 🛠️ Coming Soon

The following beginner-level FPGA modules are currently being developed and will be added to this repository:

- UART Receiver (to complete the TX/RX pair)  
- Debouncer FSM: Button / Toggle  
- 7-Segment Display Driver: Multiplexer and Counter  
- PWM Generator: Dimming LED or Servo Control  
- Binary Counter with AXI GPIO: Control from Zynq PS  
- SPI Master / Slave: Implementing a basic SPI protocol  
- I2C Master: Sensor interface example  
- VGA Signal Generator: Display test pattern and color bars  
- Rotary Encoder Interface: Handling user rotary input  
- AXI-Lite Peripheral: Custom memory-mapped peripheral  
- GPIO Toggle from Linux: Zynq project using UIO driver  

---

## 🎯 Goal

This repository is designed to:

- Introduce basic Verilog modules and hardware design patterns  
- Provide synthesizable, simulation-ready code  
- Bridge low-level hardware concepts with practical system integration  
- Prepare you for deeper work in Embedded Systems and FPGAs

---

## 🙌 Stay Connected

If you find this helpful, don’t forget to **star** ⭐ the repo and check back later!  
New projects will be added as soon as they’re completed and verified.

---

## 👨‍💻 Author

**Muhammad Shofuwan Anwar**  
Graduate Student @ NTUST  
Focus: Embedded Systems | VLSI | FPGA

