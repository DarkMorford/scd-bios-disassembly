;   ======================================================================
;       Constants
;   ======================================================================

	; "Vanilla" SEGA Genesis registers
	include "constants\registers.asm"

	; Gate Array (SEGA CD) registers
	include "constants\gateArray.asm"

	; Coprocessor (Z80/Sub-CPU) memory locations
	include "constants\coprocessors.asm"

	; Commands for the Z80 driver
	include "constants\z80Commands.asm"

;   Main loop states
STATE_NULL   equ 0
STATE_21F4   equ 4
STATE_3040   equ 8
STATE_LOAD   equ $C
STATE_7374   equ $10
STATE_LAUNCH equ $14

;   Common instructions
INST_JMP    equ $4EF9
