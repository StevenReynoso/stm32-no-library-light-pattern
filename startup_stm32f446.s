
/* === Cortex-M4 Startup Assembly ===
   Initializes the MCU at boot:
   - Defines interrupt vector table
   - Copies initialized data from FLASH to SRAM (.data)
   - Zeros uninitialized memory (.bss)
   - Jumps to main()
*/

.syntax unified                                 /* Use unified ARM syntax */
.cpu cortex-m4                                  /* Target Cortex-M4 CPU */
.thumb                                          /* Use Thumb instruction set */

/* === Interrupt Vector Table ===
   Placed in its own section in FLASH.
   First word: initial stack pointer
   Second word: address of Reset_Handler
   Remaining: ISR addresses or infinite loops
*/
.section .isr_vector, "a", %progbits
.global _vector_table
.type _vector_table, %object
.size _vector_table, . - _vector_table

_vector_table:
    .word _estack                               /* Initial stack pointer */
    .word Reset_Handler                         /* Reset vector */
    .word NMI                                   /* NMI Handler */
    .word Hard_Fault                            /* Hard Fault Handler */
    .word Mem_Manage                            /* Memory Management Fault Handler */
    .word Bus_Fault                             /* Bus Fault Handler */
    .word Usage_Fault                           /* Usage Fault Handler */
    .word 0                                     /* Reserved */
    .word 0                                     /* Reserved */
    .word 0                                     /* Reserved */
    .word 0                                     /* Reserved */
    .word SVCall                                /* Supervisor Call */
    .word Debug_Monitor                         /* Debug Monitor */
    .word 0                                     /* Reserved */
    .word PendSV                                /* Pendable Service Request */
    .word Systick                               /* SysTick Timer */

.section .text                                  /* Start of program code */
.global Reset_Handler
.type Reset_Handler, %function

/* === Reset Handler ===
   Runs after power-on or reset:
   - Copies .data section from FLASH to SRAM
   - Zeros .bss section in SRAM
   - Jumps to main()
*/
Reset_Handler:
    ldr r0, =_sdata                             /* Start of .data in SRAM */
    ldr r1, =_etext                             /* End of .text in FLASH (start of .data in FLASH) */
    ldr r2, =_edata                             /* End of .data in SRAM */
                    
.data_copy:                 
    cmp r0, r2                                  /* If r0 < r2, copy from FLASH to SRAM */
    ittt lt                 
    ldrlt r3, [r1], #4                  
    strlt r3, [r0], #4                  
    blt .data_copy                  
                    
    ldr r0, =_sbss                              /* Start of .bss in SRAM */
    ldr r1, =_ebss                              /* End of .bss in SRAM */
    movs r2, #0                                 /* Clear value = 0 */
                    
.bss_clear:                 
    cmp r0, r1                                  /* If r0 < r1, clear memory */
    it lt                   
    strlt r2, [r0], #4                  
    blt .bss_clear                  
                    
    bl main                                     /* Jump to main() */
                    
infinite_loop:                  
    b infinite_loop                             /* Trap if main returns */

/* === Default Interrupt Handlers ===
   Weak aliases that point to infinite loop
   Can be overridden in user code
*/
.weak NMI, Hard_Fault, Mem_Manage, Bus_Fault, Usage_Fault, SVCall, Debug_Monitor, PendSV, Systick
.thumb_set NMI,           infinite_loop
.thumb_set Hard_Fault,    infinite_loop
.thumb_set Mem_Manage,    infinite_loop
.thumb_set Bus_Fault,     infinite_loop
.thumb_set Usage_Fault,   infinite_loop
.thumb_set SVCall,        infinite_loop
.thumb_set Debug_Monitor, infinite_loop
.thumb_set PendSV,        infinite_loop
.thumb_set Systick,       infinite_loop
