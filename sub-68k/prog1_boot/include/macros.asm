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

;   Status register
m_saveStatusRegister:   macro
	move sr, -(sp)
	endm

m_restoreStatusRegister:    macro
	move (sp)+, sr
	endm

m_restoreConditionBits:    macro
	move (sp)+, ccr
	endm
