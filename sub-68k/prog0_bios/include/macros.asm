;   ======================================================================
;       Macros
;   ======================================================================

;   Interrupt masking
m_disableInterrupts:    macro
	move #$2700, sr
	endm

m_enableInterrupts: macro
	move #$2000, sr
	endm
