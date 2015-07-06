;   ======================================================================
;       Kosinski decompression routine
;
;       Inputs:
;           a0: Compressed data location
;           a1: Write destination
;   ======================================================================

decompressKosinski:
	subq.l  #2, sp
	move.b  (a0)+, 1(sp)
	move.b  (a0)+, (sp)
	move.w  (sp), d5
	moveq   #15, d4

Kos_Decomp_Loop:
	lsr.w   #1, d5
	move    sr, d6
	dbf     d4, Kos_Decomp_ChkBit
	move.b  (a0)+, 1(sp)
	move.b  (a0)+, (sp)
	move.w  (sp), d5
	moveq   #15, d4

Kos_Decomp_ChkBit:
	move    d6, ccr
	bcc.s   Kos_Decomp_Match
	move.b  (a0)+, (a1)+
	bra.s   Kos_Decomp_Loop

;   ----------------------------------------------------------------------

Kos_Decomp_Match:
	moveq   #0, d3
	lsr.w   #1, d5
	move    sr, d6
	dbf     d4, Kos_Decomp_ChkBit2
	move.b  (a0)+, 1(sp)
	move.b  (a0)+, (sp)
	move.w  (sp), d5
	moveq   #15, d4

Kos_Decomp_ChkBit2:
	move    d6, ccr
	bcs.s   Kos_Decomp_FullMatch
	lsr.w   #1, d5
	dbf     d4, @1
	move.b  (a0)+, 1(sp)
	move.b  (a0)+, (sp)
	move.w  (sp), d5
	moveq   #15, d4

@1:
	roxl.w  #1, d3
	lsr.w   #1, d5
	dbf     d4, @2
	move.b  (a0)+, 1(sp)
	move.b  (a0)+, (sp)
	move.w  (sp), d5
	moveq   #15, d4

@2:
	roxl.w  #1, d3
	addq.w  #1, d3
	moveq   #-1, d2
	move.b  (a0)+, d2
	bra.s   Kos_Decomp_MatchLoop

;   ----------------------------------------------------------------------

Kos_Decomp_FullMatch:
	move.b  (a0)+, d0
	move.b  (a0)+, d1
	moveq   #-1, d2
	move.b  d1, d2
	lsl.w   #5, d2
	move.b  d0, d2
	andi.w  #7, d1
	beq.s   Kos_Decomp_FullMatch2
	move.b  d1, d3
	addq.w  #1, d3

Kos_Decomp_MatchLoop:
	move.b  (a1,d2.w), d0
	move.b  d0, (a1)+
	dbf     d3, Kos_Decomp_MatchLoop
	bra.s   Kos_Decomp_Loop

;   ----------------------------------------------------------------------

Kos_Decomp_FullMatch2:
	move.b  (a0)+, d1
	beq.s   Kos_Decomp_Done
	cmpi.b  #1, d1
	beq.w   Kos_Decomp_Loop
	move.b  d1, d3
	bra.s   Kos_Decomp_MatchLoop

;   ----------------------------------------------------------------------

Kos_Decomp_Done:
	addq.l  #2, sp
	rts
