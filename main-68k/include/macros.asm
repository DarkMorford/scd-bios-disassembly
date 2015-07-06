;   ======================================================================
;       Macros
;   ======================================================================

;   VDP-specific macros
	include "macros\vdpMacros.asm"

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
