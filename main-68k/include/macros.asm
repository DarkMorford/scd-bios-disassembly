;   ======================================================================
;       Macros
;   ======================================================================

;   Word RAM macros
	include "macros\wordRam.asm"
	
;   VDP macros
	include "macros\vdp.asm"

;   Dealing with the Z80
m_z80RequestBus:    macro
	move.w #$100, (Z80_BUSREQ).l
	endm

m_z80WaitForBus:    macro
@z80WaitLoop:
	btst #0, (Z80_BUSREQ).l
	bne.s @z80WaitLoop
	endm

m_z80ReleaseBus:    macro
	move.w #0, (Z80_BUSREQ).l
	endm

;   Interrupt masking
m_disableInterrupts:    macro
	ori	#$700, sr
	endm

m_enableInterrupts: macro
	andi #$F8FF, sr
	endm

;   Status register
m_saveStatusRegister:   macro
	move sr, -(sp)
	endm

m_restoreStatusRegister:    macro
	move (sp)+, sr
	endm
