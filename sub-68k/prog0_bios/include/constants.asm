;   ======================================================================
;       Constants
;   ======================================================================

	; Gate Array registers
	include "constants\gateArray.asm"

	include "constants\bios.asm"
	include "constants\cdcRegisters.asm"
	include "constants\memoryMap.asm"

INST_JMP equ $4EF9

;   Interrupt levels
INT_GFX   equ 1
INT_MD    equ 2
INT_TIMER equ 3
INT_CDD   equ 4
INT_CDC   equ 5
INT_SCD   equ 6
