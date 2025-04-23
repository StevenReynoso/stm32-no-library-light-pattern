## Features

- Bare-Metal Programming: Direct register access without HAL or CMSIS abstractions.

- Multiple LED Control: Sequentially toggles five LEDs connected to different GPIO pins.

- Custom GPIO Configuration: Each LED is configured with specific modes, output types, speeds, and pull-up/down settings.

- Simple Delay Mechanism: Implements a basic delay loop for timing control.​

## Demo
  ![Untitled video - Made with Clipchamp](https://github.com/user-attachments/assets/96a7d372-afab-4b31-af86-140a39fba415)

##  Hardware Requirements

- STM32F446RE Nucleo board (or compatible STM32 board)
- 5x LEDs
- 5x 220Ω resistors
- Breadboard + jumper wires
- USB cable for power + programming

## Getting Started

- Clone the Repository:

- git clone https://github.com/StevenReynoso/stm32-no-library-light-pattern.git

- cd stm32-no-library-light-pattern

## STM32 Board Setup
- if using a breadboard, setup the ground from the stm32 board (right side) to the bread board
- setup (5) 220 ohm resistors, to ground and to 5 different Led light sources
- place wiring from the Anode of LED to the pin, we will use these pins for our 5 light sources, from PA5 downwards

 ![image](https://github.com/user-attachments/assets/eee06bde-d86c-4b22-9fda-96945e4d76f5)

- Lights will turn on from PA5 downwards as well, so keeping them inline is best

## Project Setup

- Build the Project: Ensure you have the ARM GCC toolchain installed. Then, run:

- make

- Flash to STM32 Board: Connect your STM32 board via ST-Link and flash the compiled binary:

- st-flash write main.bin 0x8000000

- Observe LED Pattern: Upon successful flashing, the LEDs connected to the specified GPIO pins should toggle sequentially, creating a light pattern.

## Documentation

- STM32 Reference Manual: Detailed information on register configurations.

- STM32 Datasheet: Electrical characteristics and pin configurations.

- ST-Link Utility: Tool for flashing and debugging STM32 microcontrollers
