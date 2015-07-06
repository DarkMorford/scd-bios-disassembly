;   ======================================================================
;       Enigma decompression routine
;   ======================================================================

EniDec:

		movem.l	d0-d7/a3-a6,-(sp)
		movea.w	d0,a3
		move.b	(a1)+,d0
		ext.w	d0
		movea.w	d0,a5
		move.b	(a1)+,d0
		ext.w	d0
		ext.l	d0
		ror.l	#1,d0
		ror.w	#1,d0
		move.l	d0,d4
		movea.w	(a1)+,a6
		adda.w	a3,a6
		movea.w	(a1)+,a4
		adda.w	a3,a4
		move.b	(a1)+,d5
		asl.w	#8,d5
		move.b	(a1)+,d5
		moveq	#$10,d6

loc_1AC8:
		moveq	#7,d0
		move.w	d6,d7
		sub.w	d0,d7
		move.w	d5,d1
		lsr.w	d7,d1
		andi.w	#$7F,d1
		move.w	d1,d2
		cmpi.w	#$40,d1
		bcc.s	loc_1AE2
		moveq	#6,d0
		lsr.w	#1,d2

loc_1AE2:
		bsr.w	sub_1BEA
		andi.w	#$F,d2
		lsr.w	#4,d1
		add.w	d1,d1
		jmp	loc_1B3E(pc,d1.w)
; End of function EniDec


; =============== S U B	R O U T	I N E =======================================


sub_1AF2:

		move.w	a6,(a2)+
		addq.w	#1,a6
		dbf	d2,sub_1AF2
		bra.s	loc_1AC8
; End of function sub_1AF2


; =============== S U B	R O U T	I N E =======================================


sub_1AFC:
		move.w	a4,(a2)+
		dbf	d2,sub_1AFC
		bra.s	loc_1AC8
; End of function sub_1AFC


; =============== S U B	R O U T	I N E =======================================


sub_1B04:
		bsr.w	sub_1B66

loc_1B08:
		move.w	d1,(a2)+
		dbf	d2,loc_1B08
		bra.s	loc_1AC8
; End of function sub_1B04


; =============== S U B	R O U T	I N E =======================================


sub_1B10:
		bsr.w	sub_1B66

loc_1B14:
		move.w	d1,(a2)+
		addq.w	#1,d1
		dbf	d2,loc_1B14
		bra.s	loc_1AC8
; End of function sub_1B10


; =============== S U B	R O U T	I N E =======================================


sub_1B1E:
		bsr.w	sub_1B66

loc_1B22:
		move.w	d1,(a2)+
		subq.w	#1,d1
		dbf	d2,loc_1B22
		bra.s	loc_1AC8
; End of function sub_1B1E


; =============== S U B	R O U T	I N E =======================================


sub_1B2C:
		cmpi.w	#$F,d2
		beq.s	loc_1B4E

loc_1B32:
		bsr.w	sub_1B66
		move.w	d1,(a2)+
		dbf	d2,loc_1B32
		bra.s	loc_1AC8
; ---------------------------------------------------------------------------

loc_1B3E:
		bra.s	sub_1AF2
; ---------------------------------------------------------------------------
		bra.s	sub_1AF2
; ---------------------------------------------------------------------------
		bra.s	sub_1AFC
; ---------------------------------------------------------------------------
		bra.s	sub_1AFC
; ---------------------------------------------------------------------------
		bra.s	sub_1B04
; ---------------------------------------------------------------------------
		bra.s	sub_1B10
; ---------------------------------------------------------------------------
		bra.s	sub_1B1E
; ---------------------------------------------------------------------------
		bra.s	sub_1B2C
; ---------------------------------------------------------------------------

loc_1B4E:
		subq.w	#1,a1
		cmpi.w	#$10,d6
		bne.s	loc_1B58
		subq.w	#1,a1

loc_1B58:
		move.w	a1,d0
		lsr.w	#1,d0
		bcc.s	loc_1B60
		addq.w	#1,a1

loc_1B60:
		movem.l	(sp)+,d0-d7/a3-a6
		rts
; End of function sub_1B2C


; =============== S U B	R O U T	I N E =======================================


sub_1B66:
		move.w	a3,d3
		swap	d4
		bpl.s	loc_1B76
		subq.w	#1,d6
		btst	d6,d5
		beq.s	loc_1B76
		ori.w	#$1000,d3

loc_1B76:
		swap	d4
		bpl.s	loc_1B84
		subq.w	#1,d6
		btst	d6,d5
		beq.s	loc_1B84
		ori.w	#$800,d3

loc_1B84:
		move.w	d5,d1
		move.w	d6,d7
		sub.w	a5,d7
		bcc.s	loc_1BB4
		move.w	d7,d6
		addi.w	#$10,d6
		neg.w	d7
		lsl.w	d7,d1
		move.b	(a1),d5
		rol.b	d7,d5
		add.w	d7,d7
		and.w	loc_1BC8(pc,d7.w),d5
		add.w	d5,d1

loc_1BA2:
		move.w	a5,d0
		add.w	d0,d0
		and.w	loc_1BC8(pc,d0.w),d1
		add.w	d3,d1
		move.b	(a1)+,d5
		lsl.w	#8,d5
		move.b	(a1)+,d5
		rts
; ---------------------------------------------------------------------------

loc_1BB4:
		beq.s	loc_1BC6
		lsr.w	d7,d1
		move.w	a5,d0
		add.w	d0,d0
		and.w	loc_1BC8(pc,d0.w),d1
		add.w	d3,d1
		move.w	a5,d0
		bra.s	sub_1BEA
; ---------------------------------------------------------------------------

loc_1BC6:
		moveq	#$10,d6

loc_1BC8:
		bra.s	loc_1BA2
; End of function sub_1B66

; ---------------------------------------------------------------------------
		dc.w 1
		dc.w 3
		dc.w 7
		dc.w $F
		dc.w $1F
		dc.w $3F
		dc.w $7F
		dc.w $FF
		dc.w $1FF
		dc.w $3FF
		dc.w $7FF
		dc.w $FFF
		dc.w $1FFF
		dc.w $3FFF
		dc.w $7FFF
		dc.w $FFFF

; =============== S U B	R O U T	I N E =======================================


sub_1BEA:

		sub.w	d0,d6
		cmpi.w	#9,d6
		bcc.s	locret_1BF8
		addq.w	#8,d6
		asl.w	#8,d5
		move.b	(a1)+,d5

locret_1BF8:
		rts
; End of function sub_1BEA
