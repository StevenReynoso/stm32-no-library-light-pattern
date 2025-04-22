# === Paths ===
BUILD_DIR = build                     											# Directory for compiled object files and final ELF/bin
SRC_DIR = src                         											# Directory containing .c source files
STARTUP = startup_stm32f446.s        											# Custom startup assembly file
LINKER = linker.ld                   											# Custom linker script

# === Tools ===
CC = arm-none-eabi-gcc               											# Cross-compiler for ARM Cortex-M targets
OBJCOPY = arm-none-eabi-objcopy      											# Tool to convert ELF to binary format

CFLAGS = -mcpu=cortex-m4 -mthumb -Wall -O0 -g -ffreestanding -nostdlib \
         -Isrc                       											# Compiler flags:
                                    											#  -mcpu=cortex-m4  -> Target the Cortex-M4 core
                                    											#  -mthumb          -> Use the Thumb instruction set (required by STM32)
                                    											#  -Wall            -> Enable all compiler warnings
                                    											#  -O0              -> No optimization (easier debugging)
                                    											#  -g               -> Include debug symbols for GDB
                                    											#  -ffreestanding   -> Do not assume standard runtime environment
                                    											#  -nostdlib        -> Do not link against standard libraries
                                    											#  -Isrc            -> Add 'src/' to include path for headers

LDFLAGS = -T$(LINKER)                											# Linker flag to specify the custom linker script

# === Files ===
C_SOURCES = $(wildcard $(SRC_DIR)/*.c)                   						# Collect all .c source files in src/
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(C_SOURCES))   		# Convert source file names to object file paths
OBJ_FILES += $(BUILD_DIR)/startup.o                                     		# Add compiled startup assembly to object list

# === Build Target ===
all: $(BUILD_DIR)/main.elf         												# Default target: build final ELF file

# Create build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile C source files into .o object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Compile startup assembly file into object file
$(BUILD_DIR)/startup.o: $(STARTUP) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Link all object files into a single ELF executable using custom linker script
$(BUILD_DIR)/main.elf: $(OBJ_FILES)
	$(CC) $(CFLAGS) $(OBJ_FILES) -o $@ $(LDFLAGS)

# === Binary Generation ===
# Convert ELF to raw binary for flashing
$(BUILD_DIR)/main.bin: $(BUILD_DIR)/main.elf
	$(OBJCOPY) -O binary $< $@

# === Flash Target ===
# Upload binary to STM32 board using ST-Link at Flash base address (0x08000000)
flash: $(BUILD_DIR)/main.bin
	st-flash write $< 0x08000000

# === Debug ===
# Launch debugger: starts st-util server and opens GDB session
debug: all
	st-util & arm-none-eabi-gdb $(BUILD_DIR)/main.elf

# === Clean ===
# Remove build directory and all generated files
clean:
	rm -rf $(BUILD_DIR)

# Declare targets that aren't actual files
.PHONY: all flash debug clean
