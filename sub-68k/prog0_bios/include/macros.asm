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
	
m_maskInterrupts:   macro level
	move #($2000 | (level << 8)), sr
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

;   Error conditions
;   CD-BIOS uses the carry flag to indicate success/failure
;   Carry flag set   -> failure
;   Carry flag clear -> success
m_setErrorFlag: macro
	move #1, ccr
	endm

m_clearErrorFlag:   macro
	or.w d1, d1
	endm
