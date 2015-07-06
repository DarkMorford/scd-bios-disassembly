;   ======================================================================
;       Coprocessor memory locations
;   ======================================================================

;   Sub-CPU (SEGA CD)
SubCPU_Bank     equ $20000  ; Sub-CPU memory bank mapped to $20000-$40000
SubCPU_Base0    equ $20000
SubCPU_Base1    equ $26000
SubCPU_Base2    equ $38000

;   Word RAM
WordRAM_Bank0   equ $200000 ; 2 Mbit, real memory in 1 Mbit mode
WordRAM_Bank1   equ $220000 ; VRAM image in 1 Mbit mode

;   Z80
Z80_Bank        equ $A00000 ; Z80 program RAM mapped to $A00000-$A02000
Z80_RAM_Base0   equ $A00000
Z80_RAM_Base1   equ $A00D00
Z80_RAM_Base2   equ $A01100

;   Cartridge memory space ($400000-$800000)
cartBoot    equ $400200
