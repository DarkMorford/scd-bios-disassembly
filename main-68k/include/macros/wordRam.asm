;   ======================================================================
;       Word RAM Macros
;   ======================================================================

m_waitForWordRam2M: macro
@wordRamWaitLoop2M:
	btst #GA_MODE, (GA_MEM_MODE).l
	bne.s @wordRamWaitLoop2M
	endm

m_waitForWordRam1M: macro
@wordRamWaitLoop1M:
	btst #GA_MODE, (GA_MEM_MODE).l
	beq.s @wordRamWaitLoop1M
	endm

m_waitForWordRam1:
m_waitForWordRamReturn: macro
@wordRamWaitLoopReturn:
	btst #GA_RET, (GA_MEM_MODE).l
	beq.s @wordRamWaitLoopReturn
	endm

m_giveWordRamToSubCpu:  macro
@wordRamWaitLoopDmna:
	bset #GA_DMNA, (GA_MEM_MODE).l
	beq.s @wordRamWaitLoopDmna
	endm

m_waitForWordRam0:  macro
@wordRamWaitLoop0:
	btst #GA_RET, (GA_MEM_MODE).l
	bne.s @wordRamWaitLoop0
	endm
