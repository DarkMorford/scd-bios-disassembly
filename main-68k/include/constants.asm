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

	; Color-related constants
	include "constants\colors.asm"

	; CD module contants
	include "constants\cd.asm"

;   Main loop states
STATE_NULL      equ 0
STATE_ATTRACT   equ 4
STATE_3040      equ 8
STATE_LOAD      equ $C
STATE_7374      equ $10
STATE_LAUNCH    equ $14

;   Message text
MSG_CHECKINGDISC    equ 0
MSG_PLEASEWAIT      equ 1
MSG_PRESSSTART      equ 2
MSG_CLOSECDDOOR     equ 3

;   Common instructions
INST_JMP    equ $4EF9

;   Random-number generator
LCG_MULTIPLIER  equ $3619
LCG_INCREMENT   equ $5D35
