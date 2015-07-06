;   ======================================================================
;       Variables
;   ======================================================================

	; Exception handlers
	include "variables\exceptionHandlers.asm"

	; VDP data storage
	include "variables\vdp.asm"

	; Inter-CPU communication buffers
	include "variables\communication.asm"

	; Joypad and other system I/O
	include "variables\joypad.asm"

; Next state for main state machine
nextState   equ $FFFFFDDA

; PRNG state
prngState   equ $FFFFFE2A

; Scratch area for decompression routines
decompScratch   equ $FFFFE000

; Code table for Nemesis decompression
nemesisCodeTable    equ $FFFFF700
