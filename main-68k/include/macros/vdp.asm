;   ======================================================================
;       VDP Macros
;   ======================================================================

m_loadVdpWriteAddress:  macro address, storage
	if (narg = 1)
	move.l #((\address & $3FFF) << $10) | ((\address & $C000) >> $E) | $40000000, (VDP_CONTROL).l
	else
	move.l #((\address & $3FFF) << $10) | ((\address & $C000) >> $E) | $40000000, \storage
	endif
	endm
