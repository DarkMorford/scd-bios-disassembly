;   ======================================================================
;       VDP Macros
;   ======================================================================

m_loadVramWriteAddress:  macro address, storage
	if (narg = 1)
	move.l #((\address & $3FFF) << $10) | ((\address & $C000) >> $E) | $40000000, (VDP_CONTROL).l
	else
	move.l #((\address & $3FFF) << $10) | ((\address & $C000) >> $E) | $40000000, \storage
	endif
	endm

m_loadCramWriteAddress:  macro address, storage
	if (narg = 1)
	move.l #((\address & $3FFF) << $10) | ((\address & $C000) >> $E) | $C0000000, (VDP_CONTROL).l
	else
	move.l #((\address & $3FFF) << $10) | ((\address & $C000) >> $E) | $C0000000, \storage
	endif
	endm

m_loadVsramWriteAddress:  macro address, storage
	if (narg = 1)
	move.l #((\address & $3FFF) << $10) | ((\address & $C000) >> $E) | $40000010, (VDP_CONTROL).l
	else
	move.l #((\address & $3FFF) << $10) | ((\address & $C000) >> $E) | $40000010, \storage
	endif
	endm
