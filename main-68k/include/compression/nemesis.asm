;   ======================================================================
;       Nemesis decompression routine
;   ======================================================================

decompressNemesis:
	movem.l d0-d7/a1-a5, -(sp)
	lea sub_F0A(pc),  a3
	lea (VDP_DATA).l, a2

	bra.s loc_E9C
; ---------------------------------------------------------------------------

decompressNemesisToRam:
	movem.l d0-d7/a1-a5, -(sp)
	lea loc_F20(pc), a3

loc_E9C:
	lea (nemesisCodeTable).w, a4

	move.w (a1)+, d2
	add.w  d2, d2
	bcc.s  loc_EAA

	adda.w #$A, a3

loc_EAA:
	lsl.w   #2, d2
	movea.w d2, a5
	moveq   #8, d3
	moveq   #0, d2
	moveq   #0, d4
	bsr.w   sub_F3A

	move.b (a1)+, d5
	asl.w  #8, d5
	move.b (a1)+, d5
	moveq  #$10, d6

loc_EC0:
	moveq  #8, d0
	bsr.w  sub_F9C

	cmpi.w #$FC, d1
	bcc.s  loc_EFC

	add.w  d1, d1
	move.b (a4, d1.w), d0
	ext.w  d0
	bsr.w  sub_FB0

	move.b 1(a4, d1.w), d1

loc_EDC:
	move.w d1, d0
	andi.w #$F, d1
	andi.w #$F0, d0
	lsr.w  #4, d0

loc_EE8:
	lsl.l  #4, d4
	or.b   d1, d4
	subq.w #1, d3
	bne.s  loc_EF6
	jmp (a3)
; ---------------------------------------------------------------------------

loc_EF2:
	moveq #0, d4
	moveq #8, d3

loc_EF6:
	dbf d0, loc_EE8

	bra.s loc_EC0
; ---------------------------------------------------------------------------

loc_EFC:
	moveq #6, d0
	bsr.w sub_FB0

	moveq #7, d0
	bsr.w sub_FAC

	bra.s loc_EDC
; End of function decompressNemesis


; =============== S U B R O U T I N E =======================================


sub_F0A:
	move.l d4, (a2)
	subq.w #1, a5

	move.w a5, d4
	bne.s  loc_EF2
	bra.s  loc_F34
; ---------------------------------------------------------------------------
loc_F14:
	eor.l  d4, d2
	move.l d2, (a2)
	subq.w #1, a5

	move.w a5, d4
	bne.s  loc_EF2
	bra.s  loc_F34
; ---------------------------------------------------------------------------

loc_F20:
	move.l d4, (a2)+
	subq.w #1, a5

	move.w a5, d4
	bne.s  loc_EF2
	bra.s  loc_F34
; ---------------------------------------------------------------------------
loc_F2A:
	eor.l  d4, d2
	move.l d2, (a2)+
	subq.w #1, a5

	move.w a5, d4
	bne.s  loc_EF2

loc_F34:
	movem.l (sp)+, d0-d7/a1-a5
	rts
; End of function sub_F0A


; =============== S U B R O U T I N E =======================================


sub_F3A:
	move.b (a1)+, d0

loc_F3C:
	cmpi.b #$FF, d0
	bne.s  @loc_F44
	rts
; ---------------------------------------------------------------------------

@loc_F44:
	move.w d0, d7

loc_F46:
	move.b (a1)+, d0
	bmi.s  loc_F3C

	move.b d0, d1
	andi.w #$F, d7
	andi.w #$70, d1
	or.w   d1, d7

	andi.w #$F, d0

	move.b d0, d1
	lsl.w  #8, d1
	or.w   d1, d7
	moveq  #8, d1

	sub.w  d0, d1
	bne.s  @loc_F70

	move.b (a1)+, d0
	add.w  d0, d0
	move.w d7, (a4, d0.w)
	bra.s  loc_F46
; ---------------------------------------------------------------------------

@loc_F70:
	move.b (a1)+, d0
	lsl.w  d1, d0
	add.w  d0, d0

	moveq  #1, d5
	lsl.w  d1, d5
	subq.w #1, d5

	lea (a4, d0.w), a4

	@loc_F80:
		move.w d7, (a4)+
		dbf d5, @loc_F80

	lea (nemesisCodeTable).w, a4

loc_F8A:
	bra.s loc_F46
; End of function sub_F3A

; ---------------------------------------------------------------------------
word_F8C:
	dc.w   1
	dc.w   3
	dc.w   7
	dc.w  $F
	dc.w $1F
	dc.w $3F
	dc.w $7F
	dc.w $FF

; =============== S U B R O U T I N E =======================================


sub_F9C:
	move.w d6, d7
	sub.w  d0, d7

	move.w d5, d1
	lsr.w  d7, d1

	add.w d0, d0
	and.w loc_F8A(pc, d0.w), d1
	rts
; End of function sub_F9C


; =============== S U B R O U T I N E =======================================


sub_FAC:
	bsr.s sub_F9C
	lsr.w #1, d0
; End of function sub_FAC


; =============== S U B R O U T I N E =======================================


sub_FB0:
	sub.w  d0, d6
	cmpi.w #9, d6
	bcc.s  @locret_FBE

	addq.w #8, d6
	asl.w  #8, d5
	move.b (a1)+, d5

@locret_FBE:
	rts
; End of function sub_FB0
