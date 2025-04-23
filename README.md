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
- Wire five 220Ω resistors between the GND rail and the cathodes (short legs) of the LEDs.
- Connect GPIO pins (e.g., PA5 to PA9) to the anodes (long legs) of the LEDs.

 ![image](https://github.com/user-attachments/assets/eee06bde-d86c-4b22-9fda-96945e4d76f5)

- LEDs will illuminate in sequence starting from PA5 down to PA9, creating a clean light pattern.

- If you wire the circuit as shown, no code changes or rewiring will be necessary — everything should run right out of the box.

## Project Setup

- Build the Project: Ensure you have the ARM GCC toolchain installed. Then, run:

- make (run in bash)

- Flash to STM32 Board: Connect your STM32 board via ST-Link and flash the compiled binary:

- make flash (run in bash)

- After successful flashing, your LEDs on pins PA5–PA9 will toggle sequentially, producing a visual light pattern.

## Documentation

- STM32 Reference Manual: Detailed information on register configurations.

- STM32 Datasheet: Electrical characteristics and pin configurations.

- ST-Link Utility: Tool for flashing and debugging STM32 microcontrollers
