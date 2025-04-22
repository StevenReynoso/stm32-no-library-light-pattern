/* === Memory Layout ===
   Define memory regions based on the STM32F446RE datasheet.
   - FLASH: Where program code and constants are stored (non-volatile).
   - SRAM:  Where variables and stack live at runtime (volatile).
*/

MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 512K    /* Read/execute memory for code and constants */
    SRAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 128K    /* Read/write/execute memory for variables and stack */
}

/* Stack pointer initialized to top of SRAM */
_estack = ORIGIN(SRAM) + LENGTH(SRAM);

/* Entry point of the program */
ENTRY(Reset_Handler)

SECTIONS
{
    
      /* === Vector Table Section ===                  Place the interrupt vector table at the beginning of FLASH.*/
    .isr_vector :
    {
        KEEP(*(.isr_vector))                           /* KEEP prevents removal by linker GC */
    } > FLASH

    
      /* === Code and Read-Only Data ===               Place .text (code) and .rodata (read-only data) in FLASH. */
    .text :
    {
        *(.text*)                                      /* All code sections */
        *(.rodata*)                                    /* All read-only constant data */
        _etext = .;                                    /* Mark end of text section (used as base address for .data init) */
    } > FLASH

    
                                                       /*.data holds variables with initial values, copied from FLASH to SRAM at startup. */
                                                       /* AT(_etext) tells the linker the source address in FLASH. */
    /* === Initialized Data Section === */
    .data : AT(_etext)
    {
        _sdata = .;                                    /* Start of .data in SRAM */
        *(.data*)                                      /* All initialized data */
        _edata = .;                                    /* End of .data in SRAM */
    } > SRAM

    
                                                       /* .bss holds zero-initialized variables.*/
                                                       /* The startup code clears this region in RAM.*/
    /* === Uninitialized Data Section === */
    .bss :
    {
        _sbss = .;                                     /* Start of .bss in SRAM */
        *(.bss*)                                       /* All uninitialized data */
        *(COMMON)                                      /* Common symbols (shared global vars) */
        _ebss = .;                                     /* End of .bss */
    } > SRAM

    /* === Alignment and Heap/Stack Base === */
    . = ALIGN(8);                                      /* Ensure 8-byte alignment for safe access */
    _end = .;                                          /* End of all sections; potential start for heap */
}