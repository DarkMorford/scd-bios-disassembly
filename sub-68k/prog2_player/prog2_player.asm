;   ======================================================================
;                     SEGA CD BIOS 2.00w US Disassembly
;                          Sub-CPU CD Player Module
;   ======================================================================
;
;       Disassembly created by DarkMorford
;
;   ======================================================================

	include "constants.asm"
	include "structs.asm"
	include "variables.asm"
	include "macros.asm"

	org $18000

; =============== S U B R O U T I N E =======================================

sub_18000:
	bra.w playerVblank
; End of function sub_18000


; =============== S U B R O U T I N E =======================================

sub_18004:
	bra.w playerMain
; End of function sub_18004

; ---------------------------------------------------------------------------
	dc.b 'Bosanova'
; ---------------------------------------------------------------------------
	bra.w playerVblank
; ---------------------------------------------------------------------------
	bra.w playerMain
; ---------------------------------------------------------------------------
RAM_BASE:
	dcb.b 2304, 0

; =============== S U B R O U T I N E =======================================


playerVblank:              ; CODE XREF: sub_18000j
					; PLAYER:00018010j
	movem.l d0-a6, -(sp)

	jsr initAddressRegs(pc)

	addq.b  #1, 6(a5)

	jsr sub_18C26(pc)
	jsr sub_18CA4(pc)
	jsr sub_18E8A(pc)
	jsr sub_18EB0(pc)
	jsr sub_18E2C(pc)
	jsr sub_18948(pc)

	move.b  2(a5), $11(a4)

	movem.l (sp)+, d0-a6
	rts
; End of function playerVblank


; =============== S U B R O U T I N E =======================================


sub_18948:              ; CODE XREF: playerVblank+20p
		clr.b   $E(a5)
		lea $80(a5),a3
		moveq   #7,d7

loc_18952:              ; CODE XREF: sub_18948:loc_1895Ej
		adda.w  #$80,a3 ; 'Ä'
		tst.b   (a3)
		bpl.s   loc_1895E
		jsr sub_18980(pc)

loc_1895E:              ; CODE XREF: sub_18948+10j
		dbf d7,loc_18952
		lea $500(a5),a3
		move.b  #$80,$E(a5)
		moveq   #7,d7

loc_1896E:              ; CODE XREF: sub_18948+32j
		tst.b   (a3)
		bpl.s   loc_18976
		jsr sub_18980(pc)

loc_18976:              ; CODE XREF: sub_18948+28j
		adda.w  #$80,a3 ; 'Ä'
		dbf d7,loc_1896E
		rts
; End of function sub_18948


; =============== S U B R O U T I N E =======================================


sub_18980:              ; CODE XREF: sub_18948+12p
					; sub_18948+2Ap
		subq.b  #1,$B(a3)
		bne.s   loc_1899A
		bclr    #4,(a3)
		jsr sub_189A2(pc)
		jsr sub_18A98(pc)
		jsr sub_18A66(pc)
		bra.w   loc_18EF8
; ---------------------------------------------------------------------------

loc_1899A:              ; CODE XREF: sub_18980+4j
		jsr sub_18AAC(pc)
		bra.w   sub_18A52
; End of function sub_18980


; =============== S U B R O U T I N E =======================================


sub_189A2:              ; CODE XREF: sub_18980+Ap
		movea.l 4(a3),a2
		bclr    #1,(a3)

loc_189AA:              ; CODE XREF: sub_189A2+16j
		moveq   #0,d5
		move.b  (a2)+,d5
		cmpi.b  #$E0,d5
		bcs.s   loc_189BA
		jsr sub_190AE(pc)
		bra.s   loc_189AA
; ---------------------------------------------------------------------------

loc_189BA:              ; CODE XREF: sub_189A2+10j
		tst.b   d5
		bpl.s   loc_189CC
		jsr sub_189D4(pc)
		move.b  (a2)+,d5
		bpl.s   loc_189CC
		subq.w  #1,a2
		bra.w   loc_189F2
; ---------------------------------------------------------------------------

loc_189CC:              ; CODE XREF: sub_189A2+1Aj
					; sub_189A2+22j
		jsr sub_18A3A(pc)
		bra.w   loc_189F2
; End of function sub_189A2


; =============== S U B R O U T I N E =======================================


sub_189D4:              ; CODE XREF: sub_189A2+1Cp
		subi.b  #$80,d5
		beq.w   sub_18ED8
		lea word_18FEE(pc),a0
		add.b   8(a3),d5
		andi.w  #$7F,d5 ; ''
		lsl.w   #1,d5
		move.w  (a0,d5.w),$10(a3)
		rts
; End of function sub_189D4

; ---------------------------------------------------------------------------

loc_189F2:              ; CODE XREF: sub_189A2+26j
					; sub_189A2+2Ej
	move.l  a2,4(a3)
	move.b  $C(a3),$B(a3)
	btst    #4,(a3)
	bne.s   @locret_18A38
	jsr sub_18EE8(pc)
	move.b  $E(a3),$D(a3)
	move.l  $28(a3),$24(a3)
	move.l  $1C(a3),$20(a3)
	move.b  $30(a3),$31(a3)
	move.l  #PCM_DATA,$18(a3)
	clr.w   $14(a3)
	clr.w   $16(a3)
	clr.b   $12(a3)
	move.b  #7,$13(a3)

@locret_18A38:               
	rts

; =============== S U B R O U T I N E =======================================


sub_18A3A:              ; CODE XREF: sub_189A2:loc_189CCp
	move.b  d5,d0
	move.b  2(a3),d1

@loc_18A40:              
	subq.b  #1,d1
	beq.s   @loc_18A48
	add.b   d5,d0
	bra.s   @loc_18A40
; ---------------------------------------------------------------------------

@loc_18A48:              
	move.b  d0,$C(a3)
	move.b  d0,$B(a3)
	rts
; End of function sub_18A3A


; =============== S U B R O U T I N E =======================================


sub_18A52:              ; CODE XREF: sub_18980+1Ej
	tst.b   $D(a3)
	beq.s   @locret_18A64
	subq.b  #1,$D(a3)
	bne.s   @locret_18A64
	jsr sub_18ED8(pc)
	addq.w  #4,sp

@locret_18A64:               
	rts
; End of function sub_18A52


; =============== S U B R O U T I N E =======================================


sub_18A66:              ; CODE XREF: sub_18980+12p
	btst    #1,0(a3)
	bne.s   @loc_18A94
	move.w  $10(a3),d5
	move.b  $F(a3),d0
	ext.w   d0
	add.w   d0,d5
	move.w  d5,d1
	move.b  1(a3),d0
	ori.b   #$C0,d0
	move.b  d0,$F(a4)
	move.b  d1,5(a4)
	lsr.w   #8,d1
	move.b  d1,7(a4)
	rts
; ---------------------------------------------------------------------------

@loc_18A94:              
	addq.w  #4,sp
	rts
; End of function sub_18A66


; =============== S U B R O U T I N E =======================================


sub_18A98:              ; CODE XREF: sub_18980+Ep
	tst.b   $32(a3)
	bne.s   @locret_18AAA
	btst    #1,0(a3)
	bne.s   @locret_18AAA
	bra.w   loc_18B0C
; ---------------------------------------------------------------------------

@locret_18AAA:               
	rts
; End of function sub_18A98


; =============== S U B R O U T I N E =======================================


sub_18AAC:              ; CODE XREF: sub_18980:loc_1899Ap
		tst.b   $31(a3)
		beq.s   loc_18ABA
		subq.b  #1,$31(a3)
		beq.w   sub_18ED8

loc_18ABA:              ; CODE XREF: sub_18AAC+4j
		tst.b   $32(a3)
		bne.w   locret_18B0A
		btst    #1,0(a3)
		bne.w   locret_18B0A
		lea (unk_FF0020).l,a0
		moveq   #0,d0
		moveq   #0,d1
		move.b  1(a3),d1
		lsl.w   #2,d1
		move.l  (a0,d1.w),d0
		move.l  d0,d1
		lsl.w   #8,d0
		swap    d1
		move.b  d1,d0
		move.w  $14(a3),d1
		move.w  d0,$14(a3)
		cmp.w   d1,d0
		bcc.s   loc_18AFA
		subi.w  #$1E00,$16(a3)

loc_18AFA:              ; CODE XREF: sub_18AAC+46j
		andi.w  #$1FFF,d0
		addi.w  #$1000,d0
		move.w  $16(a3),d1
		cmp.w   d1,d0
		bhi.s   loc_18B0C

locret_18B0A:               ; CODE XREF: sub_18AAC+12j
					; sub_18AAC+1Cj
		rts
; ---------------------------------------------------------------------------

loc_18B0C:              ; CODE XREF: sub_18A98+Ej
					; sub_18AAC+5Cj
		addi.w  #$200,$16(a3)
		move.l  $20(a3),d6
		movea.l $24(a3),a2
		movea.l $18(a3),a0
		move.b  1(a3),d1
		lsl.b   #1,d1
		add.b   $12(a3),d1
		ori.b   #$80,d1
		move.b  d1,$F(a4)
		move.l  #$200,d0
		move.l  d0,d1

loc_18B38:              ; CODE XREF: sub_18AAC+B4j
		cmp.l   d0,d6
		bcc.s   loc_18B3E
		move.l  d6,d0

loc_18B3E:              ; CODE XREF: sub_18AAC+8Ej
		sub.l   d0,d6
		sub.l   d0,d1
		subq.l  #1,d0

loc_18B44:              ; CODE XREF: sub_18AAC+9Cj
		move.b  (a2)+,(a0)+
		addq.w  #1,a0
		dbf d0,loc_18B44
		tst.l   d1
		beq.s   loc_18B62
		moveq   #0,d0
		move.l  $1C(a3),d0
		sub.l   $2C(a3),d0
		suba.l  d0,a2
		add.l   d0,d6
		move.l  d1,d0
		bra.s   loc_18B38
; ---------------------------------------------------------------------------

loc_18B62:              ; CODE XREF: sub_18AAC+A2j
		tst.l   d6
		bne.s   loc_18B74
		moveq   #0,d0
		move.l  $1C(a3),d0
		sub.l   $2C(a3),d0
		suba.l  d0,a2
		move.l  d0,d6

loc_18B74:              ; CODE XREF: sub_18AAC+B8j
		move.l  d6,$20(a3)
		move.l  a2,$24(a3)
		subq.b  #1,$13(a3)
		bmi.s   loc_18B88
		move.l  a0,$18(a3)
		rts
; ---------------------------------------------------------------------------

loc_18B88:              ; CODE XREF: sub_18AAC+D4j
		move.l  #PCM_DATA,$18(a3)
		tst.b   $12(a3)
		bne.s   loc_18BA4
		move.b  #6,$13(a3)
		move.b  #1,$12(a3)
		rts
; ---------------------------------------------------------------------------

loc_18BA4:              ; CODE XREF: sub_18AAC+E8j
		move.b  #7,$13(a3)
		clr.b   $12(a3)
		rts
; End of function sub_18AAC


; =============== S U B R O U T I N E =======================================


sub_18BB0:              ; CODE XREF: PLAYER:00018F84j
					; playerMain+2Cj
	lea unk_19544(pc),a0
	move.l  (a0)+,d0
	beq.s   @locret_18C24
	bmi.s   @locret_18C24
	subq.w  #1,d0

@loc_18BBC:              ; CODE XREF: sub_18BB0:loc_18C20j
	movea.l (a0)+,a1
	adda.l  $10(a5),a1
	tst.b   $D(a1)
	beq.s   @loc_18C20
	movea.l 0(a1),a2
	adda.l  $10(a5),a2
	move.w  $E(a1),d1
	move.w  d1,d5
	rol.w   #4,d1
	ori.b   #$80,d1
	andi.w  #$F00,d5
	move.l  4(a1),d2
	move.w  d2,d3
	rol.w   #4,d3
	andi.w  #$F,d3

@loc_18BEC:              ; CODE XREF: sub_18BB0+6Cj
	move.b  d1,$F(a4)
	move.w  d2,d4
	cmpi.w  #$1000,d2
	bls.s   @loc_18BFC
	move.w  #$1000,d4

@loc_18BFC:              ; CODE XREF: sub_18BB0+46j
	add.w   d5,d2
	sub.w   d5,d4
	subq.w  #1,d4
	lea (PCM_DATA).l,a3
	adda.w  d5,a3
	adda.w  d5,a3

@loc_18C0C:              ; CODE XREF: sub_18BB0+60j
	move.b  (a2)+,(a3)+
	addq.w  #1,a3
	dbf d4,@loc_18C0C
	subi.w  #$1000,d2
	addq.b  #1,d1
	moveq   #0,d5
	dbf d3,@loc_18BEC

@loc_18C20:              ; CODE XREF: sub_18BB0+16j
	dbf d0,@loc_18BBC

@locret_18C24:               ; CODE XREF: sub_18BB0+6j sub_18BB0+8j
	rts
; End of function sub_18BB0


; =============== S U B R O U T I N E =======================================


sub_18C26:              ; CODE XREF: playerVblank+Cp
		tst.l   $A(a5)
		beq.s   locret_18C84
		lea $A(a5),a1
		move.b  3(a5),d3
		moveq   #3,d4

loc_18C36:              ; CODE XREF: sub_18C26:loc_18C78j
		moveq   #0,d0
		move.b  (a1),d0
		move.b  d0,d1
		clr.b   (a1)+
		cmpi.b  #$81,d0
		bcs.s   loc_18C78
		cmpi.b  #$8F,d0
		bls.w   loc_18C86
		cmpi.b  #$B0,d0
		bcs.s   loc_18C78
		cmpi.b  #$BF,d0
		bls.w   loc_18C90
		cmpi.b  #$E0,d0
		bcs.s   loc_18C78
		cmpi.b  #$E4,d0
		bls.w   loc_18C9A
		bra.s   loc_18C78
; ---------------------------------------------------------------------------

loc_18C6A:              ; CODE XREF: sub_18C26+68j
					; sub_18C26+72j ...
		move.b  (a0,d0.w),d2
		cmp.b   d3,d2
		bcs.s   loc_18C78
		move.b  d2,d3
		move.b  d1,9(a5)

loc_18C78:              ; CODE XREF: sub_18C26+1Cj
					; sub_18C26+2Aj ...
		dbf d4,loc_18C36
		tst.b   d3
		bmi.s   locret_18C84
		move.b  d3,3(a5)

locret_18C84:               ; CODE XREF: sub_18C26+4j
					; sub_18C26+58j
		rts
; ---------------------------------------------------------------------------

loc_18C86:              ; CODE XREF: sub_18C26+22j
		subi.b  #$81,d0
		lea unk_192F8(pc),a0
		bra.s   loc_18C6A
; ---------------------------------------------------------------------------

loc_18C90:              ; CODE XREF: sub_18C26+30j
		subi.b  #$B0,d0
		lea unk_192FA(pc),a0
		bra.s   loc_18C6A
; ---------------------------------------------------------------------------

loc_18C9A:              ; CODE XREF: sub_18C26+3Ej
		subi.b  #$E0,d0
		lea unk_192FA(pc),a0
		bra.s   loc_18C6A
; End of function sub_18C26


; =============== S U B R O U T I N E =======================================


sub_18CA4:              ; CODE XREF: playerVblank+10p
		moveq   #0,d7
		move.b  9(a5),d7
		beq.w   playerMain
		bpl.w   loc_18F7C
		move.b  #$80,9(a5)
		cmpi.b  #$81,d7
		bcs.s   locret_18CE2
		cmpi.b  #$8F,d7
		bls.w   loc_18CE4
		cmpi.b  #$B0,d7
		bcs.s   locret_18CE2
		cmpi.b  #$BF,d7
		bls.w   loc_18D90
		cmpi.b  #$E0,d7
		bcs.s   locret_18CE2
		cmpi.b  #$E4,d7
		bls.w   loc_18F08

locret_18CE2:               ; CODE XREF: sub_18CA4+18j
					; sub_18CA4+26j ...
		rts
; ---------------------------------------------------------------------------

loc_18CE4:              ; CODE XREF: sub_18CA4+1Ej
		jsr sub_18F54(pc)
		lea off_19300(pc),a2
		subi.b  #$81,d7
		andi.w  #$7F,d7 ; ''
		lsl.w   #2,d7
		movea.l (a2,d7.w),a2
		adda.l  $10(a5),a2
		movea.l a2,a0
		moveq   #0,d7
		move.b  2(a2),d7
		move.b  4(a2),d1
		move.b  5(a2),0(a5)
		move.b  5(a2),1(a5)
		addq.w  #6,a2
		lea $80(a5),a3
		lea unk_18D86(pc),a1
		move.b  #$80,d2
		subq.w  #1,d7

loc_18D26:              ; CODE XREF: sub_18CA4+D2j
		moveq   #0,d0
		move.w  (a2)+,d0
		add.l   a0,d0
		move.l  d0,4(a3)
		move.w  (a2)+,8(a3)
		move.b  (a1)+,d0
		move.b  d0,1(a3)
		ori.b   #$C0,d0
		move.b  d0,$F(a4)
		lsl.b   #5,d0
		move.b  d0,$D(a4)
		move.b  d0,$B(a4)
		move.b  #0,9(a4)
		move.b  #$FF,3(a4)
		move.b  9(a3),1(a4)
		move.b  d1,2(a3)
		move.b  d2,$A(a3)
		move.b  #$80,0(a3)
		move.b  #1,$B(a3)
		adda.w  #$80,a3 ; 'Ä'
		dbf d7,loc_18D26
		clr.b   $80(a5)
		move.b  #$FF,2(a5)
		rts
; ---------------------------------------------------------------------------
unk_18D86:  dc.b   7        ; DATA XREF: sub_18CA4+78o
		dc.b   0
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   7
		dc.b   6
		dc.b   0
; ---------------------------------------------------------------------------

loc_18D90:              ; CODE XREF: sub_18CA4+2Cj
		lea unk_192F8(pc),a2
		subi.b  #$B0,d7
		andi.w  #$7F,d7 ; ''
		lsl.w   #2,d7
		movea.l (a2,d7.w),a2
		adda.l  $10(a5),a2
		movea.l a2,a0
		moveq   #0,d7
		move.b  3(a2),d7
		move.b  2(a2),d1
		addq.w  #4,a2
		move.b  #$80,d2
		subq.w  #1,d7

loc_18DBA:              ; CODE XREF: sub_18CA4+182j
		lea $500(a5),a3
		moveq   #0,d0
		move.b  1(a2),d0
		lsl.w   #7,d0
		adda.w  d0,a3
		movea.l a3,a1
		move.w  #$1F,d0

loc_18DCE:              ; CODE XREF: sub_18CA4+12Cj
		clr.l   (a1)+
		dbf d0,loc_18DCE
		move.w  (a2)+,(a3)
		moveq   #0,d0
		move.w  (a2)+,d0
		add.l   a0,d0
		move.l  d0,4(a3)
		move.w  (a2)+,8(a3)
		move.b  1(a3),d0
		ori.b   #$C0,d0
		move.b  d0,$F(a4)
		lsl.b   #5,d0
		move.b  d0,$D(a4)
		move.b  d0,$B(a4)
		move.b  #0,9(a4)
		move.b  #$FF,3(a4)
		move.b  9(a3),1(a4)
		move.b  d1,2(a3)
		move.b  d2,$A(a3)
		move.b  #1,$B(a3)
		move.b  #0,$E(a3)
		move.b  #0,$F(a3)
		dbf d7,loc_18DBA
		rts
; End of function sub_18CA4


; =============== S U B R O U T I N E =======================================


sub_18E2C:              ; CODE XREF: playerVblank+1Cp
		moveq   #0,d0
		move.b  $14(a5),d0
		beq.s   locret_18E3E
		move.b  $17(a5),d0
		beq.s   loc_18E40
		subq.b  #1,$17(a5)

locret_18E3E:               ; CODE XREF: sub_18E2C+6j
		rts
; ---------------------------------------------------------------------------

loc_18E40:              ; CODE XREF: sub_18E2C+Cj
		subq.b  #1,$14(a5)
		beq.w   sub_18F54
		move.b  $16(a5),$17(a5)
		lea $80(a5),a3
		moveq   #8,d7
		move.b  $15(a5),d6
		add.b   d6,$18(a5)

loc_18E5C:              ; CODE XREF: sub_18E2C+58j
		tst.b   (a3)
		bpl.s   loc_18E80
		sub.b   d6,9(a3)
		bcc.s   loc_18E6E
		clr.b   9(a3)
		bclr    #7,(a3)

loc_18E6E:              ; CODE XREF: sub_18E2C+38j
		move.b  1(a3),d0
		ori.b   #$C0,d0
		move.b  d0,$F(a4)
		move.b  9(a3),1(a4)

loc_18E80:              ; CODE XREF: sub_18E2C+32j
		adda.w  #$80,a3 ; 'Ä'
		dbf d7,loc_18E5C
		rts
; End of function sub_18E2C


; =============== S U B R O U T I N E =======================================


sub_18E8A:              ; CODE XREF: playerVblank+14p
		tst.b   $F(a5)
		beq.s   locret_18EA8
		bmi.s   loc_18EAA
		cmpi.b  #2,$F(a5)
		beq.s   loc_18EA6
		move.b  #$FF,$11(a4)
		move.b  #2,$F(a5)

loc_18EA6:              ; CODE XREF: sub_18E8A+Ej
		addq.w  #4,sp

locret_18EA8:               ; CODE XREF: sub_18E8A+4j
		rts
; ---------------------------------------------------------------------------

loc_18EAA:              ; CODE XREF: sub_18E8A+6j
		clr.b   $F(a5)
		rts
; End of function sub_18E8A


; =============== S U B R O U T I N E =======================================


sub_18EB0:              ; CODE XREF: playerVblank+18p
		tst.b   0(a5)
		beq.s   locret_18ED6
		subq.b  #1,1(a5)
		bne.s   locret_18ED6
		move.b  0(a5),1(a5)
		lea $80(a5),a0
		move.w  #$80,d1 ; 'Ä'
		moveq   #8,d0

loc_18ECC:              ; CODE XREF: sub_18EB0+22j
		addq.b  #1,$B(a0)
		adda.w  d1,a0
		dbf d0,loc_18ECC

locret_18ED6:               ; CODE XREF: sub_18EB0+4j sub_18EB0+Aj
		rts
; End of function sub_18EB0


; =============== S U B R O U T I N E =======================================


sub_18ED8:              ; CODE XREF: sub_189D4+4j sub_18A52+Cp ...
		move.b  1(a3),d0
		bset    d0,2(a5)
		bset    #1,0(a3)
		rts
; End of function sub_18ED8


; =============== S U B R O U T I N E =======================================


sub_18EE8:              ; CODE XREF: PLAYER:00018A02p
		move.b  1(a3),d0
		bset    d0,2(a5)
		move.b  2(a5),$11(a4)
		rts
; End of function sub_18EE8

; ---------------------------------------------------------------------------

loc_18EF8:              ; CODE XREF: sub_18980+16j
		btst    #4,(a3)
		bne.s   locret_18F06
		move.b  1(a3),d0
		bclr    d0,2(a5)

locret_18F06:               ; CODE XREF: PLAYER:00018EFCj
		rts
; ---------------------------------------------------------------------------

loc_18F08:              ; CODE XREF: sub_18CA4+3Aj
		move.b  d7,d0
		subi.b  #$E0,d7
		lsl.w   #2,d7
		jmp loc_18F14(pc,d7.w)
; ---------------------------------------------------------------------------

loc_18F14:              ; CODE XREF: PLAYER:00018F10j
		jmp loc_18F28(pc)
; ---------------------------------------------------------------------------
		jmp loc_18F7C(pc)
; ---------------------------------------------------------------------------
		jmp loc_18F3C(pc)
; ---------------------------------------------------------------------------
		jmp loc_18F44(pc)
; ---------------------------------------------------------------------------
		jmp loc_18F4C(pc)
; ---------------------------------------------------------------------------

loc_18F28:              ; CODE XREF: PLAYER:loc_18F14j
		move.b  #$18,$14(a5)
		move.b  #1,$16(a5)
		move.b  #1,$15(a5)
		rts
; ---------------------------------------------------------------------------

loc_18F3C:              ; CODE XREF: PLAYER:00018F1Cj
		move.b  #1,$F(a5)
		rts
; ---------------------------------------------------------------------------

loc_18F44:              ; CODE XREF: PLAYER:00018F20j
		move.b  #$80,$F(a5)
		rts
; ---------------------------------------------------------------------------

loc_18F4C:              ; CODE XREF: PLAYER:00018F24j
		move.b  #$FF,$11(a4)
		rts

; =============== S U B R O U T I N E =======================================


sub_18F54:              ; CODE XREF: sub_18CA4:loc_18CE4p
					; sub_18E2C+18j ...
		move.b  #$FF,$11(a4)
		move.l  $10(a5),d1
		movea.l a5,a0
		move.w  #$23F,d0

loc_18F64:              ; CODE XREF: sub_18F54+12j
		clr.l   (a0)+
		dbf d0,loc_18F64
		move.l  d1,$10(a5)
		move.b  #$FF,2(a5)
		move.b  #$80,9(a5)
		rts
; End of function sub_18F54

; ---------------------------------------------------------------------------

loc_18F7C:              ; CODE XREF: sub_18CA4+Aj
					; PLAYER:00018F18j
		jsr sub_18F54(pc)
		jsr sub_18F88(pc)
		bra.w   sub_18BB0

; =============== S U B R O U T I N E =======================================


sub_18F88:              ; CODE XREF: PLAYER:00018F80p
					; playerMain+28p
	move.b #$81, d3

	moveq #7, d1
	@loc_18F8E:
		lea    (unk_FF3C01).l, a0
		move.b d3, $F(a4)
		moveq  #$FFFFFFFF, d2

		move.w #$1FF, d0
		@loc_18F9E:
			move.b d2, (a0)+
			addq.w #1, a0
			dbf    d0, @loc_18F9E

		addq.w #2, d3
		dbf    d1, @loc_18F8E
	rts
; End of function sub_18F88


; =============== S U B R O U T I N E =======================================


playerMain:              ; CODE XREF: sub_18004j
					; PLAYER:00018014j ...
	jsr initAddressRegs(pc)

	move.b #$FF, $11(a4)
	move.b #$80, $F(a4)

	lea    sub_18000(pc), a0
	suba.l $1C(a6), a0

	move.l a0, $10(a5)
	move.b #$FF, 2(a5)
	move.b #$80, 9(a5)

	jsr sub_18F88(pc)

	bra.w sub_18BB0
; End of function playerMain


; =============== S U B R O U T I N E =======================================


initAddressRegs:                ; CODE XREF: playerVblank+4p playerMainp
	lea unk_192D0(pc), a6
	lea RAM_BASE(pc), a5
	lea (unk_FF0000).l, a4
	rts
; End of function initAddressRegs

; ---------------------------------------------------------------------------
word_18FEE: dc.w 0          ; DATA XREF: sub_189D4+8o
		dc.w $FB
		dc.w $10B
		dc.w $11B
		dc.w $12A
		dc.w $13C
		dc.w $150
		dc.w $165
		dc.w $177
		dc.w $18D
		dc.w $1A6
		dc.w $1BE
		dc.b   1
		dc.b $DC ; ‹
		dc.b   1
		dc.b $FA ; ˙
		dc.b   2
		dc.b $13
		dc.b   2
		dc.b $30 ; 0
		dc.b   2
		dc.b $54 ; T
		dc.b   2
		dc.b $73 ; s
		dc.b   2
		dc.b $98 ; ò
		dc.b   2
		dc.b $C6 ; ∆
		dc.b   2
		dc.b $F0 ; 
		dc.b   3
		dc.b $1D
		dc.b   3
		dc.b $4B ; K
		dc.b   3
		dc.b $7A ; z
		dc.b   3
		dc.b $BA ; ∫
		dc.b   3
		dc.b $F1 ; Ò
		dc.b   4
		dc.b $2E ; .
		dc.b   4
		dc.b $67 ; g
		dc.b   4
		dc.b $A9 ; ©
		dc.b   4
		dc.b $F5 ; ı
		dc.b   5
		dc.b $42 ; B
		dc.b   5
		dc.b $8E ; é
		dc.b   5
		dc.b $E3 ; „
		dc.b   6
		dc.b $3B ; ;
		dc.b   6
		dc.b $96 ; ñ
		dc.b   6
		dc.b $F8 ; ¯
		dc.b   7
		dc.b $66 ; f
		dc.b   7
		dc.b $DC ; ‹
		dc.b   8
		dc.b $4F ; O
		dc.b   8
		dc.b $D2 ; “
		dc.b   9
		dc.b $56 ; V
		dc.b   9
		dc.b $DC ; ‹
		dc.b  $A
		dc.b $78 ; x
		dc.b  $B
		dc.b $19
		dc.b  $B
		dc.b $C7 ; «
		dc.b  $C
		dc.b $6F ; o
		dc.b  $D
		dc.b $38 ; 8
		dc.b  $E
		dc.b   0
		dc.b  $E
		dc.b $EA ; Í
		dc.b  $F
		dc.b $BA ; ∫
		dc.b $10
		dc.b $A6 ; ¶
		dc.b $11
		dc.b $86 ; Ü
		dc.b $12
		dc.b $80 ; Ä
		dc.b $13
		dc.b $96 ; ñ
		dc.b $14
		dc.b $CC ; Ã
		dc.b $16
		dc.b $24 ; $
		dc.b $17
		dc.b $46 ; F
		dc.b $18
		dc.b $DE ; ﬁ
		dc.b $1A
		dc.b $38 ; 8
		dc.b $1B
		dc.b $E0 ; ‡
		dc.b $1D
		dc.b $94 ; î
		dc.b $1F
		dc.b $65 ; e
		dc.b $20
		dc.b $FF
		dc.b $23 ; #
		dc.b $30 ; 0
		dc.b $25 ; %
		dc.b $26 ; &
		dc.b $27 ; '
		dc.b $53 ; S
		dc.b $29 ; )
		dc.b $B7 ; ∑
		dc.b $2C ; ,
		dc.b $63 ; c
		dc.b $2F ; /
		dc.b $63 ; c
		dc.b $31 ; 1
		dc.b $E0 ; ‡
		dc.b $34 ; 4
		dc.b $7B ; {
		dc.b $37 ; 7
		dc.b $7B ; {
		dc.b $3B ; ;
		dc.b $41 ; A
		dc.b $3E ; >
		dc.b $E8 ; Ë
		dc.b $42 ; B
		dc.b   6
		dc.b $46 ; F
		dc.b $84 ; Ñ
		dc.b $4A ; J
		dc.b $5A ; Z
		dc.b $4E ; N
		dc.b $B5 ; µ
		dc.b $53 ; S
		dc.b $79 ; y
		dc.b $58 ; X
		dc.b $E1 ; ·
		dc.b $5D ; ]
		dc.b $E0 ; ‡
		dc.b $63 ; c
		dc.b $C0 ; ¿
		dc.b $68 ; h
		dc.b $FF
		dc.b $6E ; n
		dc.b $FF
		dc.b $78 ; x
		dc.b $3C ; <
		dc.b $7F ; 
		dc.b $C2 ; ¬
		dc.b $83 ; É
		dc.b $FC ; ¸
		dc.b $8D ; ç
		dc.b $14
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $9D ; ù
		dc.b $80 ; Ä
		dc.b $AA ; ™
		dc.b $5D ; ]
		dc.b $B1 ; ±
		dc.b $F9 ; ˘
		dc.b $BB ; ª
		dc.b $BA ; ∫
		dc.b $CC ; Ã
		dc.b $77 ; w
		dc.b $D7 ; ◊
		dc.b $51 ; Q
		dc.b $E3 ; „
		dc.b $33 ; 3

; =============== S U B R O U T I N E =======================================


sub_190AE:              ; CODE XREF: sub_189A2+12p
		subi.w  #$E0,d5 ; '‡'
		lsl.w   #2,d5
		jmp loc_190B8(pc,d5.w)
; End of function sub_190AE

; ---------------------------------------------------------------------------

loc_190B8:              ; CODE XREF: sub_190AE+6j
		jmp loc_19136(pc)
; ---------------------------------------------------------------------------
		jmp loc_1914C(pc)
; ---------------------------------------------------------------------------
		jmp loc_19152(pc)
; ---------------------------------------------------------------------------
		jmp loc_19158(pc)
; ---------------------------------------------------------------------------
		jmp locret_19134(pc)
; ---------------------------------------------------------------------------
		jmp locret_19134(pc)
; ---------------------------------------------------------------------------
		jmp loc_19160(pc)
; ---------------------------------------------------------------------------
		jmp loc_1919A(pc)
; ---------------------------------------------------------------------------
		jmp loc_191A0(pc)
; ---------------------------------------------------------------------------
		jmp locret_19134(pc)
; ---------------------------------------------------------------------------
		jmp loc_191AA(pc)
; ---------------------------------------------------------------------------
		jmp loc_191B4(pc)
; ---------------------------------------------------------------------------
		jmp locret_19134(pc)
; ---------------------------------------------------------------------------
		jmp locret_19134(pc)
; ---------------------------------------------------------------------------
		jmp locret_19134(pc)
; ---------------------------------------------------------------------------
		jmp loc_191BA(pc)
; ---------------------------------------------------------------------------
		jmp loc_19242(pc)
; ---------------------------------------------------------------------------
		jmp loc_19242(pc)
; ---------------------------------------------------------------------------
		jmp loc_19242(pc)
; ---------------------------------------------------------------------------
		jmp locret_19134(pc)
; ---------------------------------------------------------------------------
		jmp loc_1925E(pc)
; ---------------------------------------------------------------------------
		jmp locret_19134(pc)
; ---------------------------------------------------------------------------
		jmp loc_1925E(pc)
; ---------------------------------------------------------------------------
		jmp loc_1926A(pc)
; ---------------------------------------------------------------------------
		jmp loc_19284(pc)
; ---------------------------------------------------------------------------
		jmp loc_19296(pc)
; ---------------------------------------------------------------------------
		jmp loc_192AA(pc)
; ---------------------------------------------------------------------------
		jmp loc_192B0(pc)
; ---------------------------------------------------------------------------
		jmp loc_192B8(pc)
; ---------------------------------------------------------------------------
		jmp locret_19134(pc)
; ---------------------------------------------------------------------------
		jmp unk_192D0(pc)
; ---------------------------------------------------------------------------

locret_19134:               ; CODE XREF: PLAYER:000190C8j
					; PLAYER:000190CCj ...
		rts
; ---------------------------------------------------------------------------

loc_19136:              ; CODE XREF: PLAYER:loc_190B8j
		move.b  1(a3),d0
		ori.b   #$C0,d0
		move.b  d0,$F(a4)
		move.b  (a2),3(a3)
		move.b  (a2)+,3(a4)
		rts
; ---------------------------------------------------------------------------

loc_1914C:              ; CODE XREF: PLAYER:000190BCj
		move.b  (a2)+,$F(a3)
		rts
; ---------------------------------------------------------------------------

loc_19152:              ; CODE XREF: PLAYER:000190C0j
		move.b  (a2)+,4(a5)
		rts
; ---------------------------------------------------------------------------

loc_19158:              ; CODE XREF: PLAYER:000190C4j
		move.b  #1,5(a5)
		rts
; ---------------------------------------------------------------------------

loc_19160:              ; CODE XREF: PLAYER:000190D0j
		move.b  1(a3),d0
		ori.b   #$C0,d0
		move.b  d0,$F(a4)
		move.b  (a2)+,d0
		bmi.s   loc_1917A
		add.b   d0,9(a3)
		bcs.s   loc_19188
		bra.w   loc_19180
; ---------------------------------------------------------------------------

loc_1917A:              ; CODE XREF: PLAYER:0001916Ej
		add.b   d0,9(a3)
		bcc.s   loc_19188

loc_19180:              ; CODE XREF: PLAYER:00019176j
		move.b  9(a3),1(a4)

locret_19186:               ; CODE XREF: PLAYER:0001918Cj
		rts
; ---------------------------------------------------------------------------

loc_19188:              ; CODE XREF: PLAYER:00019174j
					; PLAYER:0001917Ej
		tst.b   $14(a5)
		beq.s   locret_19186
		bclr    #7,(a3)
		move.b  #0,1(a4)
		rts
; ---------------------------------------------------------------------------

loc_1919A:              ; CODE XREF: PLAYER:000190D4j
		bset    #4,(a3)
		rts
; ---------------------------------------------------------------------------

loc_191A0:              ; CODE XREF: PLAYER:000190D8j
		move.b  (a2),$D(a3)
		move.b  (a2)+,$E(a3)
		rts
; ---------------------------------------------------------------------------

loc_191AA:              ; CODE XREF: PLAYER:000190E0j
		move.b  (a2),1(a5)
		move.b  (a2)+,0(a5)
		rts
; ---------------------------------------------------------------------------

loc_191B4:              ; CODE XREF: PLAYER:000190E4j
		move.b  (a2)+,$A(a5)
		rts
; ---------------------------------------------------------------------------

loc_191BA:              ; CODE XREF: PLAYER:000190F4j
		moveq   #0,d0
		move.b  (a2)+,d0
		lea unk_19544(pc),a0
		addq.w  #4,a0
		lsl.w   #2,d0
		movea.l (a0,d0.w),a0
		adda.l  $10(a5),a0
		move.b  $C(a0),$30(a3)
		move.b  $C(a0),$31(a3)
		move.b  $D(a0),$32(a3)
		bne.s   loc_19218
		movea.l 0(a0),a1
		adda.l  $10(a5),a1
		move.l  a1,$28(a3)
		move.l  a1,$24(a3)
		move.l  4(a0),$1C(a3)
		move.l  4(a0),$20(a3)
		move.l  8(a0),$2C(a3)
		move.l  #PCM_DATA,$18(a3)
		clr.b   $12(a3)
		move.b  #7,$13(a3)
		rts
; ---------------------------------------------------------------------------

loc_19218:              ; CODE XREF: PLAYER:000191E0j
		move.b  1(a3),d0
		ori.b   #$C0,d0
		move.b  d0,$F(a4)
		move.w  $E(a0),d0
		move.w  d0,d1
		lsr.w   #8,d0
		move.b  d0,$D(a4)
		move.l  8(a0),d0
		add.w   d1,d0
		move.b  d0,9(a4)
		lsr.w   #8,d0
		move.b  d0,$B(a4)
		rts
; ---------------------------------------------------------------------------

loc_19242:              ; CODE XREF: PLAYER:000190F8j
					; PLAYER:000190FCj ...
		bclr    #7,(a3)
		bclr    #4,(a3)
		jsr sub_18ED8
		tst.b   $E(a5)
		beq.w   loc_1925A
		clr.b   3(a5)

loc_1925A:              ; CODE XREF: PLAYER:00019252j
		addq.w  #8,sp
		rts
; ---------------------------------------------------------------------------

loc_1925E:              ; CODE XREF: PLAYER:00019108j
					; PLAYER:00019110j ...
		move.b  (a2)+,d0
		lsl.w   #8,d0
		move.b  (a2)+,d0
		adda.w  d0,a2
		subq.w  #1,a2
		rts
; ---------------------------------------------------------------------------

loc_1926A:              ; CODE XREF: PLAYER:00019114j
		moveq   #0,d0
		move.b  (a2)+,d0
		move.b  (a2)+,d1
		tst.b   $40(a3,d0.w)
		bne.s   loc_1927A
		move.b  d1,$40(a3,d0.w)

loc_1927A:              ; CODE XREF: PLAYER:00019274j
		subq.b  #1,$40(a3,d0.w)
		bne.s   loc_1925E
		addq.w  #2,a2
		rts
; ---------------------------------------------------------------------------

loc_19284:              ; CODE XREF: PLAYER:00019118j
		moveq   #0,d0
		move.b  $A(a3),d0
		subq.b  #4,d0
		move.l  a2,(a3,d0.w)
		move.b  d0,$A(a3)
		bra.s   loc_1925E
; ---------------------------------------------------------------------------

loc_19296:              ; CODE XREF: PLAYER:0001911Cj
		moveq   #0,d0
		move.b  $A(a3),d0
		movea.l (a3,d0.w),a2
		addq.w  #2,a2
		addq.b  #4,d0
		move.b  d0,$A(a3)
		rts
; ---------------------------------------------------------------------------

loc_192AA:              ; CODE XREF: PLAYER:00019120j
		move.b  (a2)+,2(a3)
		rts
; ---------------------------------------------------------------------------

loc_192B0:              ; CODE XREF: PLAYER:00019124j
		move.b  (a2)+,d0
		add.b   d0,8(a3)
		rts
; ---------------------------------------------------------------------------

loc_192B8:              ; CODE XREF: PLAYER:00019128j
		lea $80(a5),a0
		move.b  (a2)+,d0
		move.w  #$80,d1 ; 'Ä'
		moveq   #8,d2

loc_192C4:              ; CODE XREF: PLAYER:000192CAj
		move.b  d0,2(a0)
		adda.w  d1,a0
		dbf d2,loc_192C4
		rts
; ---------------------------------------------------------------------------
unk_192D0:  dc.b   0        ; CODE XREF: PLAYER:00019130j
					; DATA XREF: initAddressRegso
		dc.b   1
		dc.b $92 ; í
		dc.b $F8 ; ¯
		dc.b   0
		dc.b   1
		dc.b $92 ; í
		dc.b $D4 ; ‘
		dc.b   0
		dc.b   1
		dc.b $93 ; ì
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $92 ; í
		dc.b $F8 ; ¯
		dc.b   0
		dc.b   1
		dc.b $92 ; í
		dc.b $E0 ; ‡
		dc.b   0
		dc.b   1
		dc.b $92 ; í
		dc.b $E4 ; ‰
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $B0 ; ∞
		dc.b   0
		dc.b   1
		dc.b $80 ; Ä
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $92 ; í
		dc.b $FA ; ˙
		dc.b   0
		dc.b   1
		dc.b $92 ; í
		dc.b $FA ; ˙
unk_192F8:  dc.b $80 ; Ä     ; DATA XREF: sub_18C26+64o
					; sub_18CA4:loc_18D90o
		dc.b   0
unk_192FA:  dc.b $80 ; Ä     ; DATA XREF: sub_18C26+6Eo
					; sub_18C26+78o
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   0
off_19300:  dc.l off_19304      ; DATA XREF: sub_18CA4+44o
off_19304:  dc.l $800        ; DATA XREF: PLAYER:off_19300o
		dc.b   1
		dc.b $5F ; _
		dc.b   2
		dc.b $3E ; >
		dc.b   0
		dc.b $FF
		dc.b   0
		dc.b $26 ; &
		dc.b $F3 ; Û
		dc.b $FF
		dc.b   0
		dc.b $C7 ; «
		dc.b $F4 ; Ù
		dc.b $FF
		dc.b   0
		dc.b $CA ;  
		dc.b   0
		dc.b $3F ; ?
		dc.b   1
		dc.b $11
		dc.b $F4 ; Ù
		dc.b $FF
		dc.b   1
		dc.b $3D ; =
		dc.b $F4 ; Ù
		dc.b $5F ; _
		dc.b   1
		dc.b $DA ; ⁄
		dc.b   0
		dc.b $4F ; O
		dc.b   2
		dc.b $3E ; >
		dc.b $D0 ; –
		dc.b $19
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $48 ; H
		dc.b $99 ; ô
		dc.b  $C
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $54 ; T
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   2
		dc.b $FF
		dc.b $F3 ; Û
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $48 ; H
		dc.b $99 ; ô
		dc.b  $C
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $54 ; T
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $48 ; H
		dc.b $99 ; ô
		dc.b  $C
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $48 ; H
		dc.b $99 ; ô
		dc.b  $C
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   7
		dc.b $FF
		dc.b $EB ; Î
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b   6
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   3
		dc.b $FF
		dc.b $EB ; Î
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b   6
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   3
		dc.b $FF
		dc.b $EB ; Î
		dc.b $EF ; Ô
		dc.b   4
		dc.b $9C ; ú
		dc.b $10
		dc.b $99 ; ô
		dc.b $96 ; ñ
		dc.b $EF ; Ô
		dc.b   0
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $18
		dc.b $EF ; Ô
		dc.b   1
		dc.b $99 ; ô
		dc.b   6
		dc.b $99 ; ô
		dc.b $F6 ; ˆ
		dc.b $FF
		dc.b $85 ; Ö
		dc.b $F2 ; Ú
		dc.b $EF ; Ô
		dc.b   1
		dc.b $F2 ; Ú
		dc.b $EF ; Ô
		dc.b   2
		dc.b $E0 ; ‡
		dc.b $8F ; è
		dc.b $80 ; Ä
		dc.b $60 ; `
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $18
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   7
		dc.b $FF
		dc.b $F7 ; ˜
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b  $C
		dc.b $99 ; ô
		dc.b   6
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b  $C
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $18
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   3
		dc.b $FF
		dc.b $F7 ; ˜
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b  $C
		dc.b $99 ; ô
		dc.b   6
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b  $C
		dc.b $99 ; ô
		dc.b   6
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $18
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   3
		dc.b $FF
		dc.b $F7 ; ˜
		dc.b $80 ; Ä
		dc.b $60 ; `
		dc.b $F6 ; ˆ
		dc.b $FF
		dc.b $C8 ; »
		dc.b $F2 ; Ú
		dc.b $EF ; Ô
		dc.b   3
		dc.b $E0 ; ‡
		dc.b $FA ; ˙
		dc.b $A5 ; •
		dc.b $60 ; `
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   2
		dc.b $FF
		dc.b $F7 ; ˜
		dc.b $E2 ; ‚
		dc.b $FF
		dc.b $A5 ; •
		dc.b $60 ; `
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $A5 ; •
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $A5 ; •
		dc.b $80 ; Ä
		dc.b $A5 ; •
		dc.b $80 ; Ä
		dc.b $30 ; 0
		dc.b $E0 ; ‡
		dc.b $CF ; œ
		dc.b $A4 ; §
		dc.b $30 ; 0
		dc.b $E0 ; ‡
		dc.b $FA ; ˙
		dc.b $F6 ; ˆ
		dc.b $FF
		dc.b $E4 ; ‰
		dc.b $F2 ; Ú
		dc.b $EF ; Ô
		dc.b   6
		dc.b $94 ; î
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $54 ; T
		dc.b $95 ; ï
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $54 ; T
		dc.b $97 ; ó
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $54 ; T
		dc.b $95 ; ï
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $48 ; H
		dc.b $97 ; ó
		dc.b  $C
		dc.b $94 ; î
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $54 ; T
		dc.b $95 ; ï
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $54 ; T
		dc.b $97 ; ó
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $30 ; 0
		dc.b $95 ; ï
		dc.b  $C
		dc.b $94 ; î
		dc.b $92 ; í
		dc.b $80 ; Ä
		dc.b $54 ; T
		dc.b $99 ; ô
		dc.b  $C
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $A5 ; •
		dc.b   6
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $18
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $A5 ; •
		dc.b   6
		dc.b $80 ; Ä
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   4
		dc.b $FF
		dc.b $E5 ; Â
		dc.b $97 ; ó
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $A3 ; £
		dc.b   6
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $A3 ; £
		dc.b   6
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $A5 ; •
		dc.b   6
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $A5 ; •
		dc.b   6
		dc.b $80 ; Ä
		dc.b $12
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $A3 ; £
		dc.b   6
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $A3 ; £
		dc.b   6
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $A5 ; •
		dc.b   6
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $24 ; $
		dc.b $A5 ; •
		dc.b   6
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $30 ; 0
		dc.b $F6 ; ˆ
		dc.b $FF
		dc.b $8D ; ç
		dc.b $F2 ; Ú
		dc.b $EF ; Ô
		dc.b   5
		dc.b $E6 ; Ê
		dc.b $40 ; @
		dc.b $94 ; î
		dc.b $60 ; `
		dc.b $95 ; ï
		dc.b $97 ; ó
		dc.b $48 ; H
		dc.b $E7 ; Á
		dc.b $97 ; ó
		dc.b  $C
		dc.b $9B ; õ
		dc.b $9C ; ú
		dc.b $24 ; $
		dc.b $9B ; õ
		dc.b $97 ; ó
		dc.b $18
		dc.b $94 ; î
		dc.b $48 ; H
		dc.b $E7 ; Á
		dc.b $94 ; î
		dc.b  $C
		dc.b $97 ; ó
		dc.b $99 ; ô
		dc.b $48 ; H
		dc.b $97 ; ó
		dc.b  $C
		dc.b $99 ; ô
		dc.b $9B ; õ
		dc.b $24 ; $
		dc.b $9C ; ú
		dc.b $9E ; û
		dc.b $18
		dc.b $A0 ; †
		dc.b  $C
		dc.b $A1 ; °
		dc.b $A0 ; †
		dc.b $48 ; H
		dc.b $E6 ; Ê
		dc.b $C0 ; ¿
		dc.b $FB ; ˚
		dc.b  $C
		dc.b $8D ; ç
		dc.b $18
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b  $C
		dc.b $8B ; ã
		dc.b $F7 ; ˜
		dc.b   1
		dc.b   3
		dc.b $FF
		dc.b $F1 ; Ò
		dc.b $8D ; ç
		dc.b $18
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $18
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $18
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $18
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b  $C
		dc.b $88 ; à
		dc.b $8D ; ç
		dc.b $18
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $18
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $F7 ; ˜
		dc.b   0
		dc.b   2
		dc.b $FF
		dc.b $E6 ; Ê
		dc.b $F6 ; ˆ
		dc.b $FF
		dc.b $C9 ; …
		dc.b $F2 ; Ú
		dc.b $F2 ; Ú
		dc.b   0
unk_19544:  dc.b   0        ; DATA XREF: sub_18BB0o
					; PLAYER:000191BEo
		dc.b   0
		dc.b   0
		dc.b   7
		dc.b   0
		dc.b   1
		dc.b $95 ; ï
		dc.b $64 ; d
		dc.b   0
		dc.b   1
		dc.b $95 ; ï
		dc.b $74 ; t
		dc.b   0
		dc.b   1
		dc.b $95 ; ï
		dc.b $84 ; Ñ
		dc.b   0
		dc.b   1
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b   0
		dc.b   1
		dc.b $95 ; ï
		dc.b $A4 ; §
		dc.b   0
		dc.b   1
		dc.b $95 ; ï
		dc.b $B4 ; ¥
		dc.b   0
		dc.b   1
		dc.b $95 ; ï
		dc.b $C4 ; ƒ
		dc.b   0
		dc.b   1
		dc.b $95 ; ï
		dc.b $D4 ; ‘
		dc.b   0
		dc.b   0
		dc.b   9
		dc.b $69 ; i
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   6
		dc.b   1
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $9F ; ü
		dc.b $3D ; =
		dc.b   0
		dc.b   0
		dc.b  $C
		dc.b $31 ; 1
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $20
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $AB ; ´
		dc.b $6E ; n
		dc.b   0
		dc.b   0
		dc.b   4
		dc.b $7C ; |
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   3
		dc.b   1
		dc.b $40 ; @
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $AF ; Ø
		dc.b $EA ; Í
		dc.b   0
		dc.b   0
		dc.b $1F
		dc.b $FF
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $1B
		dc.b   1
		dc.b $60 ; `
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $CF ; œ
		dc.b $E9 ; È
		dc.b   0
		dc.b   0
		dc.b  $D
		dc.b $1C
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $80 ; Ä
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $DD ; ›
		dc.b   5
		dc.b   0
		dc.b   0
		dc.b  $C
		dc.b $77 ; w
		dc.b   0
		dc.b   0
		dc.b   5
		dc.b $BD ; Ω
		dc.b   0
		dc.b   0
		dc.b $A0 ; †
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b $E9 ; È
		dc.b $7C ; |
		dc.b   0
		dc.b   0
		dc.b   6
		dc.b $AC ; ¨
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b  $A
		dc.b   1
		dc.b $C0 ; ¿
		dc.b   0
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   7
		dc.b   8
		dc.b   6
		dc.b   7
		dc.b   6
		dc.b   3
		dc.b   3
		dc.b   1
		dc.b   5
		dc.b   6
		dc.b $81 ; Å
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $92 ; í
		dc.b $90 ; ê
		dc.b $87 ; á
		dc.b $90 ; ê
		dc.b $8D ; ç
		dc.b $92 ; í
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $85 ; Ö
		dc.b   2
		dc.b $80 ; Ä
		dc.b $8A ; ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   3
		dc.b   3
		dc.b   7
		dc.b   8
		dc.b  $A
		dc.b  $E
		dc.b $11
		dc.b $15
		dc.b $17
		dc.b $1B
		dc.b $1C
		dc.b $1D
		dc.b $1D
		dc.b $23 ; #
		dc.b $22 ; "
		dc.b $21 ; !
		dc.b $1F
		dc.b $1A
		dc.b $1B
		dc.b $14
		dc.b $13
		dc.b  $E
		dc.b $10
		dc.b   2
		dc.b   4
		dc.b $80 ; Ä
		dc.b   3
		dc.b $89 ; â
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $94 ; î
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $A0 ; †
		dc.b $A0 ; †
		dc.b $A5 ; •
		dc.b $A7 ; ß
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $A9 ; ©
		dc.b $AD ; ≠
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $B1 ; ±
		dc.b $AE ; Æ
		dc.b $AC ; ¨
		dc.b $A9 ; ©
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $98 ; ò
		dc.b $99 ; ô
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $88 ; à
		dc.b $84 ; Ñ
		dc.b   4
		dc.b   5
		dc.b  $A
		dc.b  $E
		dc.b $10
		dc.b $13
		dc.b $17
		dc.b $16
		dc.b $1A
		dc.b $20
		dc.b $20
		dc.b $24 ; $
		dc.b $27 ; '
		dc.b $2B ; +
		dc.b $2D ; -
		dc.b $31 ; 1
		dc.b $33 ; 3
		dc.b $38 ; 8
		dc.b $39 ; 9
		dc.b $3B ; ;
		dc.b $40 ; @
		dc.b $3F ; ?
		dc.b $3D ; =
		dc.b $3E ; >
		dc.b $3C ; <
		dc.b $39 ; 9
		dc.b $3C ; <
		dc.b $36 ; 6
		dc.b $32 ; 2
		dc.b $30 ; 0
		dc.b $2F ; /
		dc.b $2C ; ,
		dc.b $27 ; '
		dc.b $20
		dc.b $1F
		dc.b $1A
		dc.b $14
		dc.b $12
		dc.b  $E
		dc.b   9
		dc.b   2
		dc.b $81 ; Å
		dc.b $88 ; à
		dc.b $8E ; é
		dc.b $92 ; í
		dc.b $97 ; ó
		dc.b $9B ; õ
		dc.b $A4 ; §
		dc.b $A8 ; ®
		dc.b $AF ; Ø
		dc.b $B1 ; ±
		dc.b $B6 ; ∂
		dc.b $BB ; ª
		dc.b $BE ; æ
		dc.b $C0 ; ¿
		dc.b $C3 ; √
		dc.b $C5 ; ≈
		dc.b $C5 ; ≈
		dc.b $C5 ; ≈
		dc.b $C6 ; ∆
		dc.b $C6 ; ∆
		dc.b $C6 ; ∆
		dc.b $C6 ; ∆
		dc.b $C5 ; ≈
		dc.b $C8 ; »
		dc.b $C5 ; ≈
		dc.b $C5 ; ≈
		dc.b $C2 ; ¬
		dc.b $C0 ; ¿
		dc.b $C0 ; ¿
		dc.b $BC ; º
		dc.b $B9 ; π
		dc.b $B2 ; ≤
		dc.b $AF ; Ø
		dc.b $A9 ; ©
		dc.b $A4 ; §
		dc.b $9D ; ù
		dc.b $98 ; ò
		dc.b $92 ; í
		dc.b $8D ; ç
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   5
		dc.b  $B
		dc.b  $E
		dc.b $13
		dc.b $18
		dc.b $1A
		dc.b $1E
		dc.b $21 ; !
		dc.b $24 ; $
		dc.b $25 ; %
		dc.b $28 ; (
		dc.b $2B ; +
		dc.b $2C ; ,
		dc.b $2E ; .
		dc.b $30 ; 0
		dc.b $33 ; 3
		dc.b $35 ; 5
		dc.b $36 ; 6
		dc.b $36 ; 6
		dc.b $36 ; 6
		dc.b $37 ; 7
		dc.b $37 ; 7
		dc.b $36 ; 6
		dc.b $36 ; 6
		dc.b $35 ; 5
		dc.b $35 ; 5
		dc.b $30 ; 0
		dc.b $34 ; 4
		dc.b $2F ; /
		dc.b $2C ; ,
		dc.b $2F ; /
		dc.b $29 ; )
		dc.b $25 ; %
		dc.b $24 ; $
		dc.b $22 ; "
		dc.b $21 ; !
		dc.b $20
		dc.b $1F
		dc.b $1D
		dc.b $1B
		dc.b $19
		dc.b $18
		dc.b $16
		dc.b $12
		dc.b $10
		dc.b  $D
		dc.b  $A
		dc.b   5
		dc.b   4
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $89 ; â
		dc.b $8C ; å
		dc.b $8F ; è
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $9C ; ú
		dc.b $9E ; û
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $9D ; ù
		dc.b $9F ; ü
		dc.b $A0 ; †
		dc.b $9E ; û
		dc.b $9F ; ü
		dc.b $9F ; ü
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $9B ; õ
		dc.b $9D ; ù
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $98 ; ò
		dc.b $97 ; ó
		dc.b $95 ; ï
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $95 ; ï
		dc.b $93 ; ì
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $95 ; ï
		dc.b $95 ; ï
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   4
		dc.b   9
		dc.b  $B
		dc.b  $C
		dc.b $12
		dc.b $16
		dc.b $18
		dc.b $1B
		dc.b $1F
		dc.b $22 ; "
		dc.b $24 ; $
		dc.b $28 ; (
		dc.b $2A ; *
		dc.b $2E ; .
		dc.b $31 ; 1
		dc.b $32 ; 2
		dc.b $36 ; 6
		dc.b $37 ; 7
		dc.b $39 ; 9
		dc.b $3C ; <
		dc.b $3E ; >
		dc.b $3F ; ?
		dc.b $41 ; A
		dc.b $42 ; B
		dc.b $43 ; C
		dc.b $44 ; D
		dc.b $44 ; D
		dc.b $44 ; D
		dc.b $45 ; E
		dc.b $44 ; D
		dc.b $44 ; D
		dc.b $43 ; C
		dc.b $43 ; C
		dc.b $43 ; C
		dc.b $41 ; A
		dc.b $3F ; ?
		dc.b $3F ; ?
		dc.b $3B ; ;
		dc.b $39 ; 9
		dc.b $38 ; 8
		dc.b $35 ; 5
		dc.b $31 ; 1
		dc.b $2E ; .
		dc.b $2A ; *
		dc.b $28 ; (
		dc.b $22 ; "
		dc.b $1D
		dc.b $19
		dc.b $13
		dc.b  $D
		dc.b   6
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b $8C ; å
		dc.b $93 ; ì
		dc.b $9A ; ö
		dc.b $9E ; û
		dc.b $A5 ; •
		dc.b $AC ; ¨
		dc.b $B4 ; ¥
		dc.b $BB ; ª
		dc.b $C1 ; ¡
		dc.b $C6 ; ∆
		dc.b $CD ; Õ
		dc.b $D3 ; ”
		dc.b $D8 ; ÿ
		dc.b $DC ; ‹
		dc.b $E0 ; ‡
		dc.b $E3 ; „
		dc.b $E6 ; Ê
		dc.b $E9 ; È
		dc.b $EB ; Î
		dc.b $ED ; Ì
		dc.b $EE ; Ó
		dc.b $EF ; Ô
		dc.b $F0 ; 
		dc.b $EE ; Ó
		dc.b $EE ; Ó
		dc.b $EB ; Î
		dc.b $EA ; Í
		dc.b $E7 ; Á
		dc.b $E3 ; „
		dc.b $E2 ; ‚
		dc.b $DD ; ›
		dc.b $D9 ; Ÿ
		dc.b $D4 ; ‘
		dc.b $CF ; œ
		dc.b $CB ; À
		dc.b $C5 ; ≈
		dc.b $BD ; Ω
		dc.b $B8 ; ∏
		dc.b $B1 ; ±
		dc.b $A9 ; ©
		dc.b $A1 ; °
		dc.b $9B ; õ
		dc.b $95 ; ï
		dc.b $8F ; è
		dc.b $87 ; á
		dc.b $80 ; Ä
		dc.b   7
		dc.b  $F
		dc.b $14
		dc.b $1B
		dc.b $22 ; "
		dc.b $28 ; (
		dc.b $2E ; .
		dc.b $35 ; 5
		dc.b $3B ; ;
		dc.b $40 ; @
		dc.b $44 ; D
		dc.b $49 ; I
		dc.b $4F ; O
		dc.b $53 ; S
		dc.b $55 ; U
		dc.b $5A ; Z
		dc.b $5E ; ^
		dc.b $5F ; _
		dc.b $61 ; a
		dc.b $62 ; b
		dc.b $63 ; c
		dc.b $67 ; g
		dc.b $65 ; e
		dc.b $65 ; e
		dc.b $66 ; f
		dc.b $65 ; e
		dc.b $63 ; c
		dc.b $63 ; c
		dc.b $60 ; `
		dc.b $5D ; ]
		dc.b $5B ; [
		dc.b $59 ; Y
		dc.b $55 ; U
		dc.b $52 ; R
		dc.b $4E ; N
		dc.b $4A ; J
		dc.b $46 ; F
		dc.b $40 ; @
		dc.b $3C ; <
		dc.b $37 ; 7
		dc.b $30 ; 0
		dc.b $2C ; ,
		dc.b $24 ; $
		dc.b $1F
		dc.b $1A
		dc.b $13
		dc.b  $E
		dc.b   9
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $8F ; è
		dc.b $93 ; ì
		dc.b $9A ; ö
		dc.b $9F ; ü
		dc.b $A3 ; £
		dc.b $A8 ; ®
		dc.b $AD ; ≠
		dc.b $AF ; Ø
		dc.b $B2 ; ≤
		dc.b $B6 ; ∂
		dc.b $B8 ; ∏
		dc.b $BA ; ∫
		dc.b $BC ; º
		dc.b $BE ; æ
		dc.b $BF ; ø
		dc.b $C0 ; ¿
		dc.b $C1 ; ¡
		dc.b $C1 ; ¡
		dc.b $C1 ; ¡
		dc.b $C0 ; ¿
		dc.b $C0 ; ¿
		dc.b $BF ; ø
		dc.b $BD ; Ω
		dc.b $BC ; º
		dc.b $BB ; ª
		dc.b $B8 ; ∏
		dc.b $B5 ; µ
		dc.b $B3 ; ≥
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AC ; ¨
		dc.b $A8 ; ®
		dc.b $A6 ; ¶
		dc.b $A3 ; £
		dc.b $9F ; ü
		dc.b $9B ; õ
		dc.b $99 ; ô
		dc.b $96 ; ñ
		dc.b $92 ; í
		dc.b $8F ; è
		dc.b $8B ; ã
		dc.b $88 ; à
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   1
		dc.b   7
		dc.b  $A
		dc.b  $D
		dc.b $11
		dc.b $15
		dc.b $17
		dc.b $1A
		dc.b $1D
		dc.b $20
		dc.b $23 ; #
		dc.b $24 ; $
		dc.b $27 ; '
		dc.b $28 ; (
		dc.b $29 ; )
		dc.b $2A ; *
		dc.b $2B ; +
		dc.b $2B ; +
		dc.b $2B ; +
		dc.b $2B ; +
		dc.b $2B ; +
		dc.b $2A ; *
		dc.b $2A ; *
		dc.b $28 ; (
		dc.b $28 ; (
		dc.b $26 ; &
		dc.b $23 ; #
		dc.b $22 ; "
		dc.b $20
		dc.b $1C
		dc.b $18
		dc.b $14
		dc.b $11
		dc.b  $D
		dc.b   7
		dc.b   4
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b $8D ; ç
		dc.b $93 ; ì
		dc.b $98 ; ò
		dc.b $9E ; û
		dc.b $A3 ; £
		dc.b $A8 ; ®
		dc.b $AE ; Æ
		dc.b $B4 ; ¥
		dc.b $B8 ; ∏
		dc.b $BD ; Ω
		dc.b $C2 ; ¬
		dc.b $C6 ; ∆
		dc.b $CA ;  
		dc.b $CF ; œ
		dc.b $D1 ; —
		dc.b $D5 ; ’
		dc.b $D7 ; ◊
		dc.b $D7 ; ◊
		dc.b $D8 ; ÿ
		dc.b $D9 ; Ÿ
		dc.b $D8 ; ÿ
		dc.b $D8 ; ÿ
		dc.b $D7 ; ◊
		dc.b $D5 ; ’
		dc.b $D2 ; “
		dc.b $CF ; œ
		dc.b $CC ; Ã
		dc.b $C8 ; »
		dc.b $C3 ; √
		dc.b $BE ; æ
		dc.b $B9 ; π
		dc.b $B3 ; ≥
		dc.b $AD ; ≠
		dc.b $A7 ; ß
		dc.b $A1 ; °
		dc.b $9A ; ö
		dc.b $93 ; ì
		dc.b $8B ; ã
		dc.b $85 ; Ö
		dc.b   3
		dc.b  $B
		dc.b $13
		dc.b $1A
		dc.b $22 ; "
		dc.b $29 ; )
		dc.b $31 ; 1
		dc.b $38 ; 8
		dc.b $3E ; >
		dc.b $46 ; F
		dc.b $4C ; L
		dc.b $54 ; T
		dc.b $59 ; Y
		dc.b $5D ; ]
		dc.b $61 ; a
		dc.b $65 ; e
		dc.b $68 ; h
		dc.b $6B ; k
		dc.b $6E ; n
		dc.b $70 ; p
		dc.b $72 ; r
		dc.b $73 ; s
		dc.b $74 ; t
		dc.b $75 ; u
		dc.b $76 ; v
		dc.b $76 ; v
		dc.b $76 ; v
		dc.b $76 ; v
		dc.b $76 ; v
		dc.b $75 ; u
		dc.b $75 ; u
		dc.b $74 ; t
		dc.b $71 ; q
		dc.b $6F ; o
		dc.b $6C ; l
		dc.b $68 ; h
		dc.b $63 ; c
		dc.b $5E ; ^
		dc.b $59 ; Y
		dc.b $52 ; R
		dc.b $4C ; L
		dc.b $45 ; E
		dc.b $3F ; ?
		dc.b $38 ; 8
		dc.b $2F ; /
		dc.b $27 ; '
		dc.b $1F
		dc.b $15
		dc.b  $E
		dc.b   6
		dc.b $83 ; É
		dc.b $8A ; ä
		dc.b $92 ; í
		dc.b $9A ; ö
		dc.b $A1 ; °
		dc.b $A8 ; ®
		dc.b $AE ; Æ
		dc.b $B5 ; µ
		dc.b $BC ; º
		dc.b $C2 ; ¬
		dc.b $C7 ; «
		dc.b $CD ; Õ
		dc.b $D2 ; “
		dc.b $D7 ; ◊
		dc.b $DA ; ⁄
		dc.b $DF ; ﬂ
		dc.b $E2 ; ‚
		dc.b $E5 ; Â
		dc.b $E7 ; Á
		dc.b $E9 ; È
		dc.b $EB ; Î
		dc.b $ED ; Ì
		dc.b $EE ; Ó
		dc.b $F0 ; 
		dc.b $EF ; Ô
		dc.b $EF ; Ô
		dc.b $EE ; Ó
		dc.b $ED ; Ì
		dc.b $EC ; Ï
		dc.b $EA ; Í
		dc.b $E6 ; Ê
		dc.b $E5 ; Â
		dc.b $E1 ; ·
		dc.b $DD ; ›
		dc.b $D9 ; Ÿ
		dc.b $D6 ; ÷
		dc.b $D1 ; —
		dc.b $CE ; Œ
		dc.b $C9 ; …
		dc.b $C4 ; ƒ
		dc.b $BF ; ø
		dc.b $BB ; ª
		dc.b $B6 ; ∂
		dc.b $B1 ; ±
		dc.b $AD ; ≠
		dc.b $A9 ; ©
		dc.b $A4 ; §
		dc.b $9E ; û
		dc.b $9B ; õ
		dc.b $97 ; ó
		dc.b $93 ; ì
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   4
		dc.b   7
		dc.b  $A
		dc.b  $D
		dc.b $10
		dc.b $14
		dc.b $17
		dc.b $19
		dc.b $1C
		dc.b $1F
		dc.b $22 ; "
		dc.b $25 ; %
		dc.b $27 ; '
		dc.b $29 ; )
		dc.b $2C ; ,
		dc.b $2E ; .
		dc.b $30 ; 0
		dc.b $32 ; 2
		dc.b $34 ; 4
		dc.b $35 ; 5
		dc.b $36 ; 6
		dc.b $38 ; 8
		dc.b $38 ; 8
		dc.b $38 ; 8
		dc.b $39 ; 9
		dc.b $3A ; :
		dc.b $3A ; :
		dc.b $39 ; 9
		dc.b $3A ; :
		dc.b $39 ; 9
		dc.b $39 ; 9
		dc.b $38 ; 8
		dc.b $37 ; 7
		dc.b $35 ; 5
		dc.b $33 ; 3
		dc.b $33 ; 3
		dc.b $32 ; 2
		dc.b $30 ; 0
		dc.b $2F ; /
		dc.b $2D ; -
		dc.b $2B ; +
		dc.b $29 ; )
		dc.b $28 ; (
		dc.b $26 ; &
		dc.b $24 ; $
		dc.b $22 ; "
		dc.b $20
		dc.b $1E
		dc.b $1C
		dc.b $1A
		dc.b $18
		dc.b $16
		dc.b $14
		dc.b $13
		dc.b $11
		dc.b $10
		dc.b  $F
		dc.b  $D
		dc.b  $C
		dc.b  $A
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   5
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $95 ; ï
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $9B ; õ
		dc.b $9B ; õ
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9E ; û
		dc.b $9E ; û
		dc.b $9E ; û
		dc.b $9E ; û
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9B ; õ
		dc.b $9A ; ö
		dc.b $99 ; ô
		dc.b $98 ; ò
		dc.b $97 ; ó
		dc.b $95 ; ï
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   1
		dc.b   4
		dc.b   6
		dc.b   8
		dc.b  $B
		dc.b  $D
		dc.b  $E
		dc.b $11
		dc.b $12
		dc.b $14
		dc.b $16
		dc.b $17
		dc.b $19
		dc.b $1A
		dc.b $1B
		dc.b $1B
		dc.b $1C
		dc.b $1E
		dc.b $1D
		dc.b $1E
		dc.b $1E
		dc.b $1E
		dc.b $1F
		dc.b $1E
		dc.b $1E
		dc.b $1F
		dc.b $1E
		dc.b $1D
		dc.b $1C
		dc.b $1B
		dc.b $1A
		dc.b $19
		dc.b $17
		dc.b $16
		dc.b $14
		dc.b $12
		dc.b $11
		dc.b $10
		dc.b  $E
		dc.b  $C
		dc.b  $A
		dc.b   8
		dc.b   7
		dc.b   5
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $90 ; ê
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   2
		dc.b   3
		dc.b   5
		dc.b   7
		dc.b   9
		dc.b  $B
		dc.b  $D
		dc.b  $F
		dc.b $11
		dc.b $13
		dc.b $16
		dc.b $17
		dc.b $19
		dc.b $1A
		dc.b $1C
		dc.b $1D
		dc.b $1E
		dc.b $1F
		dc.b $1F
		dc.b $1F
		dc.b $20
		dc.b $20
		dc.b $20
		dc.b $1F
		dc.b $1F
		dc.b $1E
		dc.b $1D
		dc.b $1B
		dc.b $1A
		dc.b $18
		dc.b $17
		dc.b $14
		dc.b $13
		dc.b $10
		dc.b  $D
		dc.b  $A
		dc.b   8
		dc.b   4
		dc.b   1
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $8E ; é
		dc.b $91 ; ë
		dc.b $94 ; î
		dc.b $97 ; ó
		dc.b $9A ; ö
		dc.b $9D ; ù
		dc.b $A0 ; †
		dc.b $A2 ; ¢
		dc.b $A4 ; §
		dc.b $A7 ; ß
		dc.b $A9 ; ©
		dc.b $AB ; ´
		dc.b $AC ; ¨
		dc.b $AE ; Æ
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B2 ; ≤
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B4 ; ¥
		dc.b $B5 ; µ
		dc.b $B5 ; µ
		dc.b $B5 ; µ
		dc.b $B4 ; ¥
		dc.b $B4 ; ¥
		dc.b $B3 ; ≥
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $AC ; ¨
		dc.b $AA ; ™
		dc.b $A9 ; ©
		dc.b $A6 ; ¶
		dc.b $A4 ; §
		dc.b $A1 ; °
		dc.b $9F ; ü
		dc.b $9D ; ù
		dc.b $99 ; ô
		dc.b $97 ; ó
		dc.b $94 ; î
		dc.b $91 ; ë
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   3
		dc.b   6
		dc.b  $A
		dc.b  $D
		dc.b $10
		dc.b $14
		dc.b $17
		dc.b $1A
		dc.b $1D
		dc.b $20
		dc.b $23 ; #
		dc.b $24 ; $
		dc.b $26 ; &
		dc.b $28 ; (
		dc.b $2A ; *
		dc.b $2C ; ,
		dc.b $2D ; -
		dc.b $2E ; .
		dc.b $30 ; 0
		dc.b $30 ; 0
		dc.b $31 ; 1
		dc.b $31 ; 1
		dc.b $31 ; 1
		dc.b $31 ; 1
		dc.b $31 ; 1
		dc.b $31 ; 1
		dc.b $30 ; 0
		dc.b $30 ; 0
		dc.b $2F ; /
		dc.b $2E ; .
		dc.b $2D ; -
		dc.b $2B ; +
		dc.b $2A ; *
		dc.b $29 ; )
		dc.b $28 ; (
		dc.b $27 ; '
		dc.b $25 ; %
		dc.b $23 ; #
		dc.b $22 ; "
		dc.b $20
		dc.b $1E
		dc.b $1C
		dc.b $1A
		dc.b $17
		dc.b $15
		dc.b $13
		dc.b $11
		dc.b  $F
		dc.b  $D
		dc.b  $B
		dc.b   9
		dc.b   6
		dc.b   4
		dc.b   3
		dc.b   1
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $95 ; ï
		dc.b $96 ; ñ
		dc.b $97 ; ó
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $97 ; ó
		dc.b $96 ; ñ
		dc.b $95 ; ï
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b  $A
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $D
		dc.b  $E
		dc.b  $E
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b  $E
		dc.b  $F
		dc.b  $E
		dc.b  $E
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b   4
		dc.b   5
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b  $B
		dc.b  $C
		dc.b  $D
		dc.b  $F
		dc.b $10
		dc.b $11
		dc.b $12
		dc.b $14
		dc.b $15
		dc.b $15
		dc.b $16
		dc.b $17
		dc.b $18
		dc.b $19
		dc.b $19
		dc.b $1A
		dc.b $1A
		dc.b $1A
		dc.b $1B
		dc.b $1B
		dc.b $1B
		dc.b $1B
		dc.b $1A
		dc.b $1A
		dc.b $19
		dc.b $19
		dc.b $18
		dc.b $17
		dc.b $16
		dc.b $15
		dc.b $14
		dc.b $13
		dc.b $12
		dc.b $10
		dc.b  $F
		dc.b  $E
		dc.b  $C
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   3
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $D
		dc.b  $E
		dc.b  $F
		dc.b  $F
		dc.b $10
		dc.b $10
		dc.b $11
		dc.b $11
		dc.b $11
		dc.b $12
		dc.b $12
		dc.b $12
		dc.b $12
		dc.b $12
		dc.b $12
		dc.b $12
		dc.b $11
		dc.b $11
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b  $F
		dc.b  $E
		dc.b  $E
		dc.b  $D
		dc.b  $C
		dc.b  $C
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $10
		dc.b $18
		dc.b $2B ; +
		dc.b $54 ; T
		dc.b $4A ; J
		dc.b $6A ; j
		dc.b $5D ; ]
		dc.b $66 ; f
		dc.b $54 ; T
		dc.b $78 ; x
		dc.b $39 ; 9
		dc.b $23 ; #
		dc.b   3
		dc.b $A4 ; §
		dc.b $BE ; æ
		dc.b $B8 ; ∏
		dc.b $D2 ; “
		dc.b $C8 ; »
		dc.b $EA ; Í
		dc.b $E7 ; Á
		dc.b $D6 ; ÷
		dc.b $FD ; ˝
		dc.b $D2 ; “
		dc.b $FC ; ¸
		dc.b $AB ; ´
		dc.b $D3 ; ”
		dc.b $9D ; ù
		dc.b $95 ; ï
		dc.b $B9 ; π
		dc.b $AA ; ™
		dc.b $9D ; ù
		dc.b $93 ; ì
		dc.b   5
		dc.b $27 ; '
		dc.b $25 ; %
		dc.b $55 ; U
		dc.b $48 ; H
		dc.b $45 ; E
		dc.b $53 ; S
		dc.b $53 ; S
		dc.b $2F ; /
		dc.b $74 ; t
		dc.b $4F ; O
		dc.b $7F ; 
		dc.b $67 ; g
		dc.b $6C ; l
		dc.b $3A ; :
		dc.b $18
		dc.b $33 ; 3
		dc.b  $A
		dc.b   6
		dc.b $89 ; â
		dc.b $A5 ; •
		dc.b $BE ; æ
		dc.b $CC ; Ã
		dc.b $E1 ; ·
		dc.b $E5 ; Â
		dc.b $EE ; Ó
		dc.b $ED ; Ì
		dc.b $F9 ; ˘
		dc.b $FA ; ˙
		dc.b $FD ; ˝
		dc.b $FE ; ˛
		dc.b $DF ; ﬂ
		dc.b $B4 ; ¥
		dc.b $9C ; ú
		dc.b $80 ; Ä
		dc.b $1A
		dc.b $1E
		dc.b $3F ; ?
		dc.b $26 ; &
		dc.b $3F ; ?
		dc.b $3B ; ;
		dc.b $63 ; c
		dc.b $4F ; O
		dc.b $73 ; s
		dc.b $49 ; I
		dc.b $56 ; V
		dc.b $56 ; V
		dc.b $6A ; j
		dc.b $39 ; 9
		dc.b $49 ; I
		dc.b $33 ; 3
		dc.b $20
		dc.b $18
		dc.b   5
		dc.b $89 ; â
		dc.b $CF ; œ
		dc.b $BE ; æ
		dc.b $E2 ; ‚
		dc.b $E6 ; Ê
		dc.b $E1 ; ·
		dc.b $C7 ; «
		dc.b $AF ; Ø
		dc.b $EE ; Ó
		dc.b $B1 ; ±
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $A3 ; £
		dc.b $B6 ; ∂
		dc.b $8C ; å
		dc.b  $F
		dc.b   2
		dc.b $26 ; &
		dc.b  $C
		dc.b $25 ; %
		dc.b $12
		dc.b $1B
		dc.b $2F ; /
		dc.b $3C ; <
		dc.b $4C ; L
		dc.b $43 ; C
		dc.b $46 ; F
		dc.b $30 ; 0
		dc.b $31 ; 1
		dc.b $2C ; ,
		dc.b $2C ; ,
		dc.b $34 ; 4
		dc.b $31 ; 1
		dc.b $1B
		dc.b $1A
		dc.b   9
		dc.b $95 ; ï
		dc.b $99 ; ô
		dc.b $A2 ; ¢
		dc.b $D0 ; –
		dc.b $98 ; ò
		dc.b $CC ; Ã
		dc.b $9F ; ü
		dc.b $DB ; €
		dc.b $D7 ; ◊
		dc.b $C0 ; ¿
		dc.b $D0 ; –
		dc.b $AD ; ≠
		dc.b $BE ; æ
		dc.b $93 ; ì
		dc.b $90 ; ê
		dc.b $82 ; Ç
		dc.b $A3 ; £
		dc.b $96 ; ñ
		dc.b $85 ; Ö
		dc.b $1A
		dc.b $1E
		dc.b $41 ; A
		dc.b $35 ; 5
		dc.b $5A ; Z
		dc.b $5C ; \
		dc.b $76 ; v
		dc.b $6C ; l
		dc.b $65 ; e
		dc.b $5C ; \
		dc.b $40 ; @
		dc.b $2C ; ,
		dc.b $1D
		dc.b  $C
		dc.b  $B
		dc.b $9D ; ù
		dc.b $A3 ; £
		dc.b $A9 ; ©
		dc.b $C6 ; ∆
		dc.b $BC ; º
		dc.b $D5 ; ’
		dc.b $B2 ; ≤
		dc.b $B0 ; ∞
		dc.b $C1 ; ¡
		dc.b $BF ; ø
		dc.b $9E ; û
		dc.b $C6 ; ∆
		dc.b $A8 ; ®
		dc.b $9E ; û
		dc.b $B4 ; ¥
		dc.b $92 ; í
		dc.b   2
		dc.b  $E
		dc.b   2
		dc.b $18
		dc.b $11
		dc.b $34 ; 4
		dc.b $47 ; G
		dc.b $3C ; <
		dc.b $49 ; I
		dc.b $39 ; 9
		dc.b $38 ; 8
		dc.b $39 ; 9
		dc.b $27 ; '
		dc.b $28 ; (
		dc.b $2B ; +
		dc.b $20
		dc.b $34 ; 4
		dc.b $19
		dc.b $13
		dc.b $8D ; ç
		dc.b $80 ; Ä
		dc.b $A9 ; ©
		dc.b $95 ; ï
		dc.b $9C ; ú
		dc.b $B5 ; µ
		dc.b $94 ; î
		dc.b $B6 ; ∂
		dc.b $91 ; ë
		dc.b $AE ; Æ
		dc.b $A4 ; §
		dc.b $A4 ; §
		dc.b $A2 ; ¢
		dc.b $AF ; Ø
		dc.b $8A ; ä
		dc.b $B5 ; µ
		dc.b $A8 ; ®
		dc.b $AE ; Æ
		dc.b $82 ; Ç
		dc.b $A3 ; £
		dc.b $91 ; ë
		dc.b $82 ; Ç
		dc.b   3
		dc.b $11
		dc.b $1C
		dc.b $18
		dc.b $38 ; 8
		dc.b $38 ; 8
		dc.b $24 ; $
		dc.b $30 ; 0
		dc.b $3D ; =
		dc.b $2F ; /
		dc.b $34 ; 4
		dc.b $26 ; &
		dc.b $2A ; *
		dc.b $21 ; !
		dc.b   6
		dc.b $22 ; "
		dc.b  $A
		dc.b $96 ; ñ
		dc.b  $B
		dc.b $8A ; ä
		dc.b   9
		dc.b $B1 ; ±
		dc.b $A8 ; ®
		dc.b $A9 ; ©
		dc.b $CD ; Õ
		dc.b $C8 ; »
		dc.b $B2 ; ≤
		dc.b $AB ; ´
		dc.b $A0 ; †
		dc.b $A8 ; ®
		dc.b $93 ; ì
		dc.b $9D ; ù
		dc.b   4
		dc.b $95 ; ï
		dc.b   7
		dc.b   4
		dc.b $8C ; å
		dc.b $16
		dc.b $20
		dc.b $23 ; #
		dc.b $24 ; $
		dc.b $46 ; F
		dc.b $2E ; .
		dc.b $33 ; 3
		dc.b $36 ; 6
		dc.b $39 ; 9
		dc.b $30 ; 0
		dc.b $25 ; %
		dc.b $18
		dc.b $27 ; '
		dc.b  $B
		dc.b  $A
		dc.b $83 ; É
		dc.b $8E ; é
		dc.b $88 ; à
		dc.b $A9 ; ©
		dc.b $9B ; õ
		dc.b $9F ; ü
		dc.b $A8 ; ®
		dc.b $98 ; ò
		dc.b $95 ; ï
		dc.b $89 ; â
		dc.b $B0 ; ∞
		dc.b $97 ; ó
		dc.b $8E ; é
		dc.b $A8 ; ®
		dc.b $A5 ; •
		dc.b $8F ; è
		dc.b $AD ; ≠
		dc.b $80 ; Ä
		dc.b   2
		dc.b   1
		dc.b $2A ; *
		dc.b  $F
		dc.b $26 ; &
		dc.b $82 ; Ç
		dc.b  $D
		dc.b $17
		dc.b $15
		dc.b $17
		dc.b $33 ; 3
		dc.b  $F
		dc.b $2D ; -
		dc.b $16
		dc.b $26 ; &
		dc.b $1B
		dc.b $1C
		dc.b  $A
		dc.b $19
		dc.b $21 ; !
		dc.b $8E ; é
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $97 ; ó
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $A5 ; •
		dc.b $A5 ; •
		dc.b $BA ; ∫
		dc.b $C2 ; ¬
		dc.b $A4 ; §
		dc.b $B9 ; π
		dc.b $A9 ; ©
		dc.b $B3 ; ≥
		dc.b $A3 ; £
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b $99 ; ô
		dc.b $93 ; ì
		dc.b $83 ; É
		dc.b   1
		dc.b $1E
		dc.b $22 ; "
		dc.b $1F
		dc.b $3F ; ?
		dc.b $32 ; 2
		dc.b $38 ; 8
		dc.b $3D ; =
		dc.b $32 ; 2
		dc.b $3B ; ;
		dc.b $28 ; (
		dc.b $1F
		dc.b $22 ; "
		dc.b $1D
		dc.b $10
		dc.b  $A
		dc.b $14
		dc.b $82 ; Ç
		dc.b $8E ; é
		dc.b $9D ; ù
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $A4 ; §
		dc.b $BD ; Ω
		dc.b $B6 ; ∂
		dc.b $B4 ; ¥
		dc.b $B5 ; µ
		dc.b $A0 ; †
		dc.b $BB ; ª
		dc.b $AA ; ™
		dc.b $8D ; ç
		dc.b $89 ; â
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $1E
		dc.b $20
		dc.b $19
		dc.b $22 ; "
		dc.b $17
		dc.b $1E
		dc.b $25 ; %
		dc.b $2A ; *
		dc.b $21 ; !
		dc.b $24 ; $
		dc.b $31 ; 1
		dc.b $20
		dc.b $2F ; /
		dc.b $29 ; )
		dc.b $1D
		dc.b $34 ; 4
		dc.b $19
		dc.b $19
		dc.b   1
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $93 ; ì
		dc.b $A3 ; £
		dc.b $AF ; Ø
		dc.b $8E ; é
		dc.b $B2 ; ≤
		dc.b $A2 ; ¢
		dc.b $9E ; û
		dc.b $A3 ; £
		dc.b $A2 ; ¢
		dc.b $A4 ; §
		dc.b $91 ; ë
		dc.b $AD ; ≠
		dc.b $AA ; ™
		dc.b $80 ; Ä
		dc.b $A8 ; ®
		dc.b $82 ; Ç
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $15
		dc.b $19
		dc.b $18
		dc.b $26 ; &
		dc.b $2F ; /
		dc.b $33 ; 3
		dc.b $25 ; %
		dc.b $2C ; ,
		dc.b $1C
		dc.b $2E ; .
		dc.b $27 ; '
		dc.b $1D
		dc.b $2E ; .
		dc.b $22 ; "
		dc.b $28 ; (
		dc.b $15
		dc.b  $F
		dc.b   7
		dc.b $90 ; ê
		dc.b $93 ; ì
		dc.b $A0 ; †
		dc.b $B2 ; ≤
		dc.b $AB ; ´
		dc.b $B2 ; ≤
		dc.b $C2 ; ¬
		dc.b $C6 ; ∆
		dc.b $BB ; ª
		dc.b $AD ; ≠
		dc.b $A6 ; ¶
		dc.b $A0 ; †
		dc.b $A4 ; §
		dc.b $8A ; ä
		dc.b $93 ; ì
		dc.b $80 ; Ä
		dc.b   9
		dc.b $11
		dc.b $14
		dc.b $28 ; (
		dc.b $27 ; '
		dc.b $2C ; ,
		dc.b $24 ; $
		dc.b $2F ; /
		dc.b $25 ; %
		dc.b $37 ; 7
		dc.b $2E ; .
		dc.b $15
		dc.b $26 ; &
		dc.b  $E
		dc.b $1F
		dc.b   2
		dc.b  $E
		dc.b   6
		dc.b $8A ; ä
		dc.b $96 ; ñ
		dc.b $85 ; Ö
		dc.b $96 ; ñ
		dc.b $A8 ; ®
		dc.b $96 ; ñ
		dc.b $A9 ; ©
		dc.b $9B ; õ
		dc.b $96 ; ñ
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $8B ; ã
		dc.b $A7 ; ß
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $88 ; à
		dc.b   2
		dc.b   3
		dc.b   7
		dc.b  $C
		dc.b $11
		dc.b $20
		dc.b  $C
		dc.b $1F
		dc.b $17
		dc.b $13
		dc.b  $E
		dc.b $13
		dc.b $16
		dc.b  $D
		dc.b $17
		dc.b  $E
		dc.b $14
		dc.b $12
		dc.b  $F
		dc.b $10
		dc.b   3
		dc.b   2
		dc.b $81 ; Å
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $98 ; ò
		dc.b $95 ; ï
		dc.b $A4 ; §
		dc.b $A7 ; ß
		dc.b $9E ; û
		dc.b $8F ; è
		dc.b $A4 ; §
		dc.b $85 ; Ö
		dc.b $9C ; ú
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b  $A
		dc.b   6
		dc.b $24 ; $
		dc.b $1A
		dc.b $19
		dc.b $27 ; '
		dc.b $26 ; &
		dc.b $23 ; #
		dc.b $20
		dc.b $1C
		dc.b $11
		dc.b $1B
		dc.b  $E
		dc.b   2
		dc.b   1
		dc.b   7
		dc.b $81 ; Å
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b $93 ; ì
		dc.b $8B ; ã
		dc.b $A0 ; †
		dc.b $97 ; ó
		dc.b $9A ; ö
		dc.b $9D ; ù
		dc.b $9F ; ü
		dc.b $9E ; û
		dc.b $93 ; ì
		dc.b $A3 ; £
		dc.b $90 ; ê
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $82 ; Ç
		dc.b   3
		dc.b   7
		dc.b  $A
		dc.b $20
		dc.b  $B
		dc.b $29 ; )
		dc.b $17
		dc.b $1D
		dc.b $19
		dc.b $18
		dc.b $13
		dc.b  $B
		dc.b $15
		dc.b   4
		dc.b   4
		dc.b   8
		dc.b   8
		dc.b   1
		dc.b $86 ; Ü
		dc.b $8C ; å
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $97 ; ó
		dc.b $8E ; é
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $8D ; ç
		dc.b $88 ; à
		dc.b $95 ; ï
		dc.b $88 ; à
		dc.b $94 ; î
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $93 ; ì
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b   2
		dc.b $85 ; Ö
		dc.b   7
		dc.b   1
		dc.b   5
		dc.b $18
		dc.b $19
		dc.b  $F
		dc.b $1C
		dc.b $1A
		dc.b $19
		dc.b $1B
		dc.b $12
		dc.b $14
		dc.b   8
		dc.b   2
		dc.b  $B
		dc.b   6
		dc.b   3
		dc.b   8
		dc.b   1
		dc.b $86 ; Ü
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b $9E ; û
		dc.b $9A ; ö
		dc.b $95 ; ï
		dc.b $A1 ; °
		dc.b $94 ; î
		dc.b $93 ; ì
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   4
		dc.b   3
		dc.b  $B
		dc.b  $D
		dc.b  $F
		dc.b  $D
		dc.b $16
		dc.b $14
		dc.b $1F
		dc.b $1D
		dc.b $12
		dc.b $1B
		dc.b $12
		dc.b $15
		dc.b $11
		dc.b   8
		dc.b   8
		dc.b   1
		dc.b $86 ; Ü
		dc.b $8F ; è
		dc.b $88 ; à
		dc.b $A2 ; ¢
		dc.b $99 ; ô
		dc.b $9B ; õ
		dc.b $93 ; ì
		dc.b $95 ; ï
		dc.b $98 ; ò
		dc.b $90 ; ê
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $80 ; Ä
		dc.b $8F ; è
		dc.b   8
		dc.b $84 ; Ñ
		dc.b   6
		dc.b  $C
		dc.b $10
		dc.b $11
		dc.b $17
		dc.b $18
		dc.b $20
		dc.b $11
		dc.b $1C
		dc.b  $D
		dc.b $14
		dc.b  $E
		dc.b   7
		dc.b   7
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $8D ; ç
		dc.b $86 ; Ü
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $90 ; ê
		dc.b $8D ; ç
		dc.b $88 ; à
		dc.b $96 ; ñ
		dc.b $8E ; é
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $81 ; Å
		dc.b   2
		dc.b $81 ; Å
		dc.b   9
		dc.b   9
		dc.b  $D
		dc.b  $D
		dc.b $13
		dc.b $19
		dc.b $18
		dc.b $16
		dc.b $1B
		dc.b $13
		dc.b $15
		dc.b $11
		dc.b  $D
		dc.b $80 ; Ä
		dc.b   1
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $93 ; ì
		dc.b $8A ; ä
		dc.b $8E ; é
		dc.b $91 ; ë
		dc.b $8B ; ã
		dc.b $91 ; ë
		dc.b $94 ; î
		dc.b $8C ; å
		dc.b $95 ; ï
		dc.b $93 ; ì
		dc.b $91 ; ë
		dc.b $94 ; î
		dc.b $8E ; é
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b  $A
		dc.b   9
		dc.b  $E
		dc.b $19
		dc.b $15
		dc.b $19
		dc.b $13
		dc.b $14
		dc.b  $F
		dc.b   8
		dc.b  $E
		dc.b   1
		dc.b   5
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $92 ; í
		dc.b $83 ; É
		dc.b $90 ; ê
		dc.b $8B ; ã
		dc.b $94 ; î
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $8E ; é
		dc.b $91 ; ë
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b   4
		dc.b   1
		dc.b   8
		dc.b $84 ; Ñ
		dc.b  $C
		dc.b   7
		dc.b   7
		dc.b   4
		dc.b  $A
		dc.b   5
		dc.b $10
		dc.b   9
		dc.b $12
		dc.b  $C
		dc.b $14
		dc.b  $A
		dc.b   7
		dc.b   4
		dc.b   2
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $92 ; í
		dc.b $90 ; ê
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $82 ; Ç
		dc.b $89 ; â
		dc.b $82 ; Ç
		dc.b   2
		dc.b   4
		dc.b   8
		dc.b   7
		dc.b   9
		dc.b  $E
		dc.b   8
		dc.b $10
		dc.b $11
		dc.b  $C
		dc.b $12
		dc.b $11
		dc.b   9
		dc.b  $F
		dc.b   9
		dc.b  $A
		dc.b   4
		dc.b   2
		dc.b $82 ; Ç
		dc.b $89 ; â
		dc.b $8B ; ã
		dc.b $90 ; ê
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $8F ; è
		dc.b $92 ; í
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b   1
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   5
		dc.b   8
		dc.b   8
		dc.b  $A
		dc.b   7
		dc.b $13
		dc.b  $F
		dc.b  $E
		dc.b  $C
		dc.b  $E
		dc.b  $E
		dc.b   8
		dc.b   8
		dc.b   2
		dc.b   6
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   3
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   7
		dc.b   7
		dc.b  $C
		dc.b   7
		dc.b  $A
		dc.b   9
		dc.b  $E
		dc.b  $F
		dc.b  $F
		dc.b  $B
		dc.b  $E
		dc.b   7
		dc.b   5
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $91 ; ë
		dc.b $89 ; â
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   7
		dc.b   7
		dc.b  $C
		dc.b  $F
		dc.b  $E
		dc.b $10
		dc.b $12
		dc.b $10
		dc.b $12
		dc.b  $F
		dc.b $12
		dc.b $12
		dc.b  $C
		dc.b $10
		dc.b  $A
		dc.b  $A
		dc.b   1
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $89 ; â
		dc.b $8E ; é
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $94 ; î
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   2
		dc.b   3
		dc.b   5
		dc.b   5
		dc.b   8
		dc.b  $B
		dc.b   9
		dc.b  $D
		dc.b  $C
		dc.b  $D
		dc.b $11
		dc.b  $D
		dc.b  $C
		dc.b  $A
		dc.b   6
		dc.b   6
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b $80 ; Ä
		dc.b   3
		dc.b $81 ; Å
		dc.b   1
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b   6
		dc.b   4
		dc.b   7
		dc.b   9
		dc.b   8
		dc.b  $E
		dc.b  $C
		dc.b  $E
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b   8
		dc.b   7
		dc.b   3
		dc.b   1
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   3
		dc.b   9
		dc.b   8
		dc.b  $C
		dc.b  $D
		dc.b  $E
		dc.b  $C
		dc.b  $C
		dc.b  $B
		dc.b  $B
		dc.b   9
		dc.b  $A
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   1
		dc.b   2
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   5
		dc.b   2
		dc.b $80 ; Ä
		dc.b   2
		dc.b   4
		dc.b   8
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b   6
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b $82 ; Ç
		dc.b   2
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   4
		dc.b   5
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b  $B
		dc.b  $C
		dc.b   8
		dc.b  $B
		dc.b   7
		dc.b   8
		dc.b   4
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b   5
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   3
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   9
		dc.b   6
		dc.b   8
		dc.b   3
		dc.b   5
		dc.b   2
		dc.b   4
		dc.b   2
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   6
		dc.b   3
		dc.b   5
		dc.b   1
		dc.b   2
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   6
		dc.b   8
		dc.b   8
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   9
		dc.b   6
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b   1
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b   9
		dc.b   4
		dc.b   4
		dc.b   6
		dc.b   8
		dc.b  $A
		dc.b   8
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b  $A
		dc.b  $A
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   6
		dc.b   2
		dc.b $81 ; Å
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b   2
		dc.b   6
		dc.b   9
		dc.b  $A
		dc.b  $E
		dc.b  $D
		dc.b $10
		dc.b $11
		dc.b  $D
		dc.b $12
		dc.b  $E
		dc.b  $F
		dc.b  $A
		dc.b   9
		dc.b   6
		dc.b   4
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   4
		dc.b   8
		dc.b   9
		dc.b  $B
		dc.b  $C
		dc.b  $E
		dc.b $10
		dc.b $11
		dc.b $13
		dc.b $13
		dc.b $12
		dc.b  $E
		dc.b   9
		dc.b   5
		dc.b   1
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $90 ; ê
		dc.b $8D ; ç
		dc.b $91 ; ë
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b   4
		dc.b   6
		dc.b   7
		dc.b  $A
		dc.b   8
		dc.b  $E
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $B
		dc.b  $B
		dc.b  $D
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   3
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b   2
		dc.b   2
		dc.b   5
		dc.b   5
		dc.b  $A
		dc.b   9
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b   8
		dc.b  $B
		dc.b   9
		dc.b   6
		dc.b   2
		dc.b   3
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   2
		dc.b   3
		dc.b   2
		dc.b   4
		dc.b   6
		dc.b   9
		dc.b  $A
		dc.b  $F
		dc.b  $C
		dc.b  $E
		dc.b  $C
		dc.b  $B
		dc.b  $A
		dc.b  $C
		dc.b  $A
		dc.b   9
		dc.b   9
		dc.b   3
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $90 ; ê
		dc.b $8E ; é
		dc.b $91 ; ë
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b   2
		dc.b   4
		dc.b  $A
		dc.b   9
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $D
		dc.b  $D
		dc.b  $E
		dc.b  $F
		dc.b  $D
		dc.b  $D
		dc.b   8
		dc.b   6
		dc.b   6
		dc.b   3
		dc.b   3
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $82 ; Ç
		dc.b   1
		dc.b   6
		dc.b   9
		dc.b  $B
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $E
		dc.b $12
		dc.b  $E
		dc.b  $F
		dc.b  $D
		dc.b   8
		dc.b   7
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b   3
		dc.b $82 ; Ç
		dc.b   4
		dc.b   1
		dc.b   4
		dc.b   6
		dc.b   8
		dc.b  $A
		dc.b  $B
		dc.b  $E
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $B
		dc.b  $B
		dc.b   7
		dc.b   5
		dc.b   2
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   7
		dc.b   8
		dc.b  $A
		dc.b  $B
		dc.b  $C
		dc.b $10
		dc.b  $D
		dc.b  $B
		dc.b  $B
		dc.b   8
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   1
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   4
		dc.b $80 ; Ä
		dc.b   4
		dc.b   2
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   4
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   4
		dc.b   2
		dc.b   3
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b $81 ; Å
		dc.b $87 ; á
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b   3
		dc.b   5
		dc.b   3
		dc.b   5
		dc.b   5
		dc.b   3
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   7
		dc.b   4
		dc.b   7
		dc.b   9
		dc.b   4
		dc.b   5
		dc.b   2
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b   1
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b   3
		dc.b $80 ; Ä
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   6
		dc.b   1
		dc.b   5
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   2
		dc.b   2
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   4
		dc.b   3
		dc.b   8
		dc.b   7
		dc.b   9
		dc.b   8
		dc.b   5
		dc.b   4
		dc.b   7
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   1
		dc.b   4
		dc.b   4
		dc.b   6
		dc.b   2
		dc.b   6
		dc.b   2
		dc.b   4
		dc.b   2
		dc.b   5
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   2
		dc.b   4
		dc.b $81 ; Å
		dc.b   3
		dc.b   3
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   3
		dc.b   5
		dc.b  $A
		dc.b   7
		dc.b   8
		dc.b  $A
		dc.b   8
		dc.b  $A
		dc.b   7
		dc.b   7
		dc.b   9
		dc.b   6
		dc.b   8
		dc.b   5
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   7
		dc.b   8
		dc.b  $B
		dc.b  $A
		dc.b  $A
		dc.b   8
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   6
		dc.b   7
		dc.b   4
		dc.b   4
		dc.b   1
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   1
		dc.b   4
		dc.b   5
		dc.b   7
		dc.b   6
		dc.b   9
		dc.b   7
		dc.b   9
		dc.b  $B
		dc.b   9
		dc.b   8
		dc.b  $B
		dc.b  $B
		dc.b  $A
		dc.b  $B
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   2
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b   5
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b  $B
		dc.b  $A
		dc.b  $D
		dc.b  $A
		dc.b  $A
		dc.b  $D
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   6
		dc.b   9
		dc.b   3
		dc.b   1
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $90 ; ê
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   2
		dc.b   7
		dc.b  $A
		dc.b  $C
		dc.b  $E
		dc.b $10
		dc.b $11
		dc.b $11
		dc.b  $F
		dc.b  $F
		dc.b  $C
		dc.b  $D
		dc.b  $B
		dc.b   9
		dc.b   4
		dc.b   5
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $8C ; å
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b   1
		dc.b   1
		dc.b   6
		dc.b   7
		dc.b   9
		dc.b   8
		dc.b  $C
		dc.b  $B
		dc.b  $E
		dc.b  $E
		dc.b $12
		dc.b  $D
		dc.b  $E
		dc.b  $B
		dc.b   9
		dc.b  $A
		dc.b   4
		dc.b   3
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $87 ; á
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   6
		dc.b   9
		dc.b  $B
		dc.b  $B
		dc.b  $E
		dc.b  $D
		dc.b  $D
		dc.b  $A
		dc.b   9
		dc.b   9
		dc.b   6
		dc.b   6
		dc.b   2
		dc.b   1
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   1
		dc.b   2
		dc.b   7
		dc.b   6
		dc.b   8
		dc.b  $B
		dc.b  $A
		dc.b  $B
		dc.b  $D
		dc.b  $B
		dc.b  $F
		dc.b  $A
		dc.b  $B
		dc.b   9
		dc.b   6
		dc.b   5
		dc.b   3
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   9
		dc.b   6
		dc.b  $A
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b   8
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   3
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   2
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b  $B
		dc.b  $C
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   3
		dc.b   3
		dc.b   1
		dc.b   5
		dc.b $80 ; Ä
		dc.b   3
		dc.b   2
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   4
		dc.b   3
		dc.b   6
		dc.b  $A
		dc.b  $A
		dc.b  $C
		dc.b  $E
		dc.b  $C
		dc.b  $D
		dc.b  $C
		dc.b  $A
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   4
		dc.b   2
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b   2
		dc.b   3
		dc.b   7
		dc.b  $A
		dc.b   7
		dc.b  $C
		dc.b  $A
		dc.b  $B
		dc.b  $C
		dc.b  $B
		dc.b  $B
		dc.b   9
		dc.b   9
		dc.b   5
		dc.b   2
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b   1
		dc.b $80 ; Ä
		dc.b   3
		dc.b   4
		dc.b   7
		dc.b  $A
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $D
		dc.b  $B
		dc.b  $C
		dc.b  $D
		dc.b   7
		dc.b   6
		dc.b   2
		dc.b   2
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   2
		dc.b   4
		dc.b   4
		dc.b   8
		dc.b   7
		dc.b   8
		dc.b   7
		dc.b   8
		dc.b   6
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   9
		dc.b   5
		dc.b   6
		dc.b   4
		dc.b $81 ; Å
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   8
		dc.b   4
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   6
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   5
		dc.b   2
		dc.b   4
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   3
		dc.b   4
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   4
		dc.b   5
		dc.b   2
		dc.b   3
		dc.b   1
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b  $C
		dc.b $8F ; è
		dc.b  $B
		dc.b  $B
		dc.b $8F ; è
		dc.b   2
		dc.b   3
		dc.b $9C ; ú
		dc.b  $B
		dc.b   6
		dc.b $89 ; â
		dc.b $91 ; ë
		dc.b  $B
		dc.b   7
		dc.b $A5 ; •
		dc.b $82 ; Ç
		dc.b $1E
		dc.b $1C
		dc.b $BB ; ª
		dc.b $85 ; Ö
		dc.b $14
		dc.b $99 ; ô
		dc.b $11
		dc.b $41 ; A
		dc.b $9C ; ú
		dc.b $8C ; å
		dc.b  $E
		dc.b $44 ; D
		dc.b $A1 ; °
		dc.b $22 ; "
		dc.b $46 ; F
		dc.b $2C ; ,
		dc.b $B8 ; ∏
		dc.b $AD ; ≠
		dc.b $38 ; 8
		dc.b $45 ; E
		dc.b $A1 ; °
		dc.b $B1 ; ±
		dc.b $2C ; ,
		dc.b $B5 ; µ
		dc.b $56 ; V
		dc.b $B8 ; ∏
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b  $C
		dc.b $B6 ; ∂
		dc.b $A7 ; ß
		dc.b $80 ; Ä
		dc.b $94 ; î
		dc.b $A6 ; ¶
		dc.b $1A
		dc.b $CA ;  
		dc.b $95 ; ï
		dc.b $3E ; >
		dc.b   4
		dc.b $B4 ; ¥
		dc.b $10
		dc.b $2C ; ,
		dc.b $23 ; #
		dc.b $9D ; ù
		dc.b $80 ; Ä
		dc.b $50 ; P
		dc.b $B4 ; ¥
		dc.b $6F ; o
		dc.b  $C
		dc.b $8A ; ä
		dc.b $43 ; C
		dc.b $1B
		dc.b $13
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $35 ; 5
		dc.b $E3 ; „
		dc.b $49 ; I
		dc.b $B5 ; µ
		dc.b $A7 ; ß
		dc.b   1
		dc.b $25 ; %
		dc.b $DB ; €
		dc.b $B5 ; µ
		dc.b $88 ; à
		dc.b $92 ; í
		dc.b $AA ; ™
		dc.b $CC ; Ã
		dc.b $31 ; 1
		dc.b $A6 ; ¶
		dc.b $90 ; ê
		dc.b $87 ; á
		dc.b  $D
		dc.b $8D ; ç
		dc.b $42 ; B
		dc.b $BA ; ∫
		dc.b $2F ; /
		dc.b $9B ; õ
		dc.b $6F ; o
		dc.b $C4 ; ƒ
		dc.b $57 ; W
		dc.b $20
		dc.b $C0 ; ¿
		dc.b $3F ; ?
		dc.b $4B ; K
		dc.b $B4 ; ¥
		dc.b   2
		dc.b $46 ; F
		dc.b $A1 ; °
		dc.b $8B ; ã
		dc.b $A5 ; •
		dc.b   4
		dc.b   9
		dc.b $AA ; ™
		dc.b $1D
		dc.b $9E ; û
		dc.b $98 ; ò
		dc.b $4B ; K
		dc.b $93 ; ì
		dc.b $17
		dc.b $AB ; ´
		dc.b $26 ; &
		dc.b $22 ; "
		dc.b $D8 ; ÿ
		dc.b $9F ; ü
		dc.b  $A
		dc.b $87 ; á
		dc.b   7
		dc.b $BF ; ø
		dc.b $10
		dc.b $13
		dc.b $BE ; æ
		dc.b $1A
		dc.b $A7 ; ß
		dc.b $19
		dc.b $AC ; ¨
		dc.b $3F ; ?
		dc.b $97 ; ó
		dc.b $8F ; è
		dc.b $85 ; Ö
		dc.b $78 ; x
		dc.b $EA ; Í
		dc.b $45 ; E
		dc.b $C3 ; √
		dc.b $36 ; 6
		dc.b $28 ; (
		dc.b $AA ; ™
		dc.b $81 ; Å
		dc.b $36 ; 6
		dc.b $93 ; ì
		dc.b $27 ; '
		dc.b $A4 ; §
		dc.b $22 ; "
		dc.b $18
		dc.b $B6 ; ∂
		dc.b $1D
		dc.b $A5 ; •
		dc.b  $C
		dc.b $8B ; ã
		dc.b $B4 ; ¥
		dc.b  $C
		dc.b $CA ;  
		dc.b $3E ; >
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $C0 ; ¿
		dc.b $3D ; =
		dc.b   2
		dc.b $1C
		dc.b $91 ; ë
		dc.b $88 ; à
		dc.b $82 ; Ç
		dc.b $26 ; &
		dc.b $84 ; Ñ
		dc.b $C7 ; «
		dc.b $31 ; 1
		dc.b $12
		dc.b $A2 ; ¢
		dc.b   1
		dc.b $99 ; ô
		dc.b $1E
		dc.b $8D ; ç
		dc.b $18
		dc.b $BE ; æ
		dc.b $84 ; Ñ
		dc.b   9
		dc.b $30 ; 0
		dc.b $BA ; ∫
		dc.b $11
		dc.b $B1 ; ±
		dc.b $45 ; E
		dc.b $AB ; ´
		dc.b $1C
		dc.b $97 ; ó
		dc.b $2E ; .
		dc.b $8B ; ã
		dc.b $12
		dc.b $95 ; ï
		dc.b $2A ; *
		dc.b   8
		dc.b   5
		dc.b   6
		dc.b $25 ; %
		dc.b   2
		dc.b $12
		dc.b $91 ; ë
		dc.b $13
		dc.b $47 ; G
		dc.b $FE ; ˛
		dc.b $62 ; b
		dc.b   1
		dc.b  $F
		dc.b $B3 ; ≥
		dc.b $35 ; 5
		dc.b $18
		dc.b $B5 ; µ
		dc.b $4A ; J
		dc.b $22 ; "
		dc.b $96 ; ñ
		dc.b $8E ; é
		dc.b $3F ; ?
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8A ; ä
		dc.b  $E
		dc.b $81 ; Å
		dc.b   5
		dc.b $22 ; "
		dc.b $B4 ; ¥
		dc.b $9F ; ü
		dc.b $6A ; j
		dc.b $A4 ; §
		dc.b $8C ; å
		dc.b $AA ; ™
		dc.b $23 ; #
		dc.b $86 ; Ü
		dc.b $A4 ; §
		dc.b $94 ; î
		dc.b $33 ; 3
		dc.b $B5 ; µ
		dc.b  $F
		dc.b $D0 ; –
		dc.b $92 ; í
		dc.b $2F ; /
		dc.b $B8 ; ∏
		dc.b $B3 ; ≥
		dc.b $17
		dc.b $B8 ; ∏
		dc.b $11
		dc.b $1E
		dc.b $12
		dc.b   9
		dc.b $B4 ; ¥
		dc.b $74 ; t
		dc.b $B2 ; ≤
		dc.b   1
		dc.b   2
		dc.b $14
		dc.b  $D
		dc.b $AC ; ¨
		dc.b   2
		dc.b $2E ; .
		dc.b $9C ; ú
		dc.b $2C ; ,
		dc.b $C5 ; ≈
		dc.b $89 ; â
		dc.b $39 ; 9
		dc.b $BD ; Ω
		dc.b $97 ; ó
		dc.b $4E ; N
		dc.b $D0 ; –
		dc.b $3C ; <
		dc.b $8A ; ä
		dc.b $B6 ; ∂
		dc.b $27 ; '
		dc.b   2
		dc.b   9
		dc.b $80 ; Ä
		dc.b $B6 ; ∂
		dc.b $87 ; á
		dc.b $22 ; "
		dc.b $96 ; ñ
		dc.b $13
		dc.b $B4 ; ¥
		dc.b $27 ; '
		dc.b $16
		dc.b $83 ; É
		dc.b $94 ; î
		dc.b $39 ; 9
		dc.b $13
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b  $C
		dc.b $BE ; æ
		dc.b $4A ; J
		dc.b  $B
		dc.b   9
		dc.b $B0 ; ∞
		dc.b $17
		dc.b $69 ; i
		dc.b $C6 ; ∆
		dc.b   7
		dc.b $29 ; )
		dc.b $8C ; å
		dc.b $98 ; ò
		dc.b $3C ; <
		dc.b $93 ; ì
		dc.b $A1 ; °
		dc.b $24 ; $
		dc.b $3D ; =
		dc.b $CB ; À
		dc.b $93 ; ì
		dc.b $8A ; ä
		dc.b $15
		dc.b $84 ; Ñ
		dc.b $91 ; ë
		dc.b $A6 ; ¶
		dc.b $9C ; ú
		dc.b $16
		dc.b $83 ; É
		dc.b $BD ; Ω
		dc.b $35 ; 5
		dc.b  $C
		dc.b $8F ; è
		dc.b $A5 ; •
		dc.b $35 ; 5
		dc.b $AA ; ™
		dc.b $2F ; /
		dc.b $12
		dc.b $D1 ; —
		dc.b $86 ; Ü
		dc.b $1C
		dc.b $29 ; )
		dc.b $A3 ; £
		dc.b $C3 ; √
		dc.b $5A ; Z
		dc.b  $C
		dc.b $C6 ; ∆
		dc.b $2D ; -
		dc.b $A5 ; •
		dc.b $63 ; c
		dc.b $BD ; Ω
		dc.b  $A
		dc.b $8C ; å
		dc.b $9B ; õ
		dc.b $72 ; r
		dc.b $FE ; ˛
		dc.b $12
		dc.b  $C
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $97 ; ó
		dc.b $91 ; ë
		dc.b  $D
		dc.b $99 ; ô
		dc.b $3A ; :
		dc.b $F2 ; Ú
		dc.b $96 ; ñ
		dc.b $39 ; 9
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $9E ; û
		dc.b $94 ; î
		dc.b $21 ; !
		dc.b $80 ; Ä
		dc.b $8F ; è
		dc.b $29 ; )
		dc.b $AA ; ™
		dc.b $59 ; Y
		dc.b $8B ; ã
		dc.b $BA ; ∫
		dc.b $48 ; H
		dc.b $10
		dc.b $1C
		dc.b $84 ; Ñ
		dc.b $8E ; é
		dc.b $12
		dc.b   6
		dc.b $1D
		dc.b $B9 ; π
		dc.b $BB ; ª
		dc.b $44 ; D
		dc.b $91 ; ë
		dc.b $C4 ; ƒ
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b $8D ; ç
		dc.b $86 ; Ü
		dc.b $A5 ; •
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $15
		dc.b $8B ; ã
		dc.b $AC ; ¨
		dc.b   6
		dc.b $1D
		dc.b $AA ; ™
		dc.b $25 ; %
		dc.b   4
		dc.b $AC ; ¨
		dc.b $49 ; I
		dc.b $16
		dc.b $C2 ; ¬
		dc.b $31 ; 1
		dc.b $15
		dc.b   8
		dc.b $AA ; ™
		dc.b $84 ; Ñ
		dc.b $70 ; p
		dc.b $AD ; ≠
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b   5
		dc.b $99 ; ô
		dc.b $24 ; $
		dc.b $94 ; î
		dc.b $A6 ; ¶
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b $16
		dc.b $D3 ; ”
		dc.b $30 ; 0
		dc.b   4
		dc.b $17
		dc.b $9C ; ú
		dc.b $9B ; õ
		dc.b $20
		dc.b $3E ; >
		dc.b $CE ; Œ
		dc.b $2E ; .
		dc.b $9C ; ú
		dc.b  $E
		dc.b $16
		dc.b $AD ; ≠
		dc.b $3A ; :
		dc.b  $D
		dc.b $88 ; à
		dc.b $32 ; 2
		dc.b $C0 ; ¿
		dc.b $48 ; H
		dc.b $8F ; è
		dc.b $16
		dc.b   2
		dc.b $86 ; Ü
		dc.b   5
		dc.b $45 ; E
		dc.b $C9 ; …
		dc.b $1D
		dc.b $84 ; Ñ
		dc.b $48 ; H
		dc.b $B7 ; ∑
		dc.b $BB ; ª
		dc.b $49 ; I
		dc.b $1B
		dc.b $B1 ; ±
		dc.b $25 ; %
		dc.b $85 ; Ö
		dc.b $12
		dc.b $8A ; ä
		dc.b $10
		dc.b $85 ; Ö
		dc.b  $B
		dc.b $31 ; 1
		dc.b $CC ; Ã
		dc.b $3E ; >
		dc.b $9D ; ù
		dc.b  $F
		dc.b $8C ; å
		dc.b $3F ; ?
		dc.b $C0 ; ¿
		dc.b $97 ; ó
		dc.b $42 ; B
		dc.b $A1 ; °
		dc.b $82 ; Ç
		dc.b $9E ; û
		dc.b $2C ; ,
		dc.b $9F ; ü
		dc.b $A4 ; §
		dc.b $28 ; (
		dc.b $8A ; ä
		dc.b $CD ; Õ
		dc.b $54 ; T
		dc.b $9A ; ö
		dc.b $8F ; è
		dc.b   9
		dc.b $32 ; 2
		dc.b  $A
		dc.b $C9 ; …
		dc.b $3D ; =
		dc.b $1C
		dc.b $B2 ; ≤
		dc.b $16
		dc.b   5
		dc.b $90 ; ê
		dc.b $8E ; é
		dc.b $57 ; W
		dc.b $DF ; ﬂ
		dc.b $21 ; !
		dc.b $3E ; >
		dc.b $CF ; œ
		dc.b   3
		dc.b $3E ; >
		dc.b $B3 ; ≥
		dc.b   8
		dc.b $93 ; ì
		dc.b $1B
		dc.b $BA ; ∫
		dc.b $15
		dc.b $2D ; -
		dc.b $C7 ; «
		dc.b $87 ; á
		dc.b  $A
		dc.b $16
		dc.b $A4 ; §
		dc.b $8E ; é
		dc.b $2B ; +
		dc.b $93 ; ì
		dc.b $19
		dc.b $8D ; ç
		dc.b $80 ; Ä
		dc.b $96 ; ñ
		dc.b $71 ; q
		dc.b $9C ; ú
		dc.b $C6 ; ∆
		dc.b $48 ; H
		dc.b $19
		dc.b $B5 ; µ
		dc.b $21 ; !
		dc.b $17
		dc.b  $A
		dc.b $9A ; ö
		dc.b $48 ; H
		dc.b $9F ; ü
		dc.b $94 ; î
		dc.b $2A ; *
		dc.b $82 ; Ç
		dc.b $AE ; Æ
		dc.b $16
		dc.b $A3 ; £
		dc.b  $D
		dc.b $A2 ; ¢
		dc.b $84 ; Ñ
		dc.b $9D ; ù
		dc.b $2A ; *
		dc.b   6
		dc.b $A6 ; ¶
		dc.b   8
		dc.b $24 ; $
		dc.b $13
		dc.b $BF ; ø
		dc.b $27 ; '
		dc.b $11
		dc.b $87 ; á
		dc.b  $D
		dc.b   9
		dc.b $8A ; ä
		dc.b  $C
		dc.b   1
		dc.b   9
		dc.b $93 ; ì
		dc.b $15
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b  $E
		dc.b $B9 ; π
		dc.b $4B ; K
		dc.b $83 ; É
		dc.b $A9 ; ©
		dc.b $2E ; .
		dc.b $C6 ; ∆
		dc.b $3F ; ?
		dc.b   6
		dc.b $B5 ; µ
		dc.b $35 ; 5
		dc.b $9D ; ù
		dc.b   6
		dc.b $1D
		dc.b $AA ; ™
		dc.b $1E
		dc.b   7
		dc.b $1A
		dc.b $8A ; ä
		dc.b   2
		dc.b $90 ; ê
		dc.b $31 ; 1
		dc.b $9E ; û
		dc.b $8F ; è
		dc.b $2E ; .
		dc.b $A6 ; ¶
		dc.b  $A
		dc.b $25 ; %
		dc.b $A1 ; °
		dc.b $15
		dc.b $10
		dc.b $9B ; õ
		dc.b   8
		dc.b   9
		dc.b $A3 ; £
		dc.b $1D
		dc.b $91 ; ë
		dc.b $85 ; Ö
		dc.b $9E ; û
		dc.b $37 ; 7
		dc.b $A2 ; ¢
		dc.b $99 ; ô
		dc.b $89 ; â
		dc.b $44 ; D
		dc.b $B9 ; π
		dc.b $A4 ; §
		dc.b $33 ; 3
		dc.b $88 ; à
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $15
		dc.b $13
		dc.b $A6 ; ¶
		dc.b $13
		dc.b  $A
		dc.b $88 ; à
		dc.b $18
		dc.b $AF ; Ø
		dc.b $91 ; ë
		dc.b $3B ; ;
		dc.b $C1 ; ¡
		dc.b   6
		dc.b $1B
		dc.b $A0 ; †
		dc.b $93 ; ì
		dc.b  $B
		dc.b $1B
		dc.b   2
		dc.b $8F ; è
		dc.b $10
		dc.b $9B ; õ
		dc.b $A2 ; ¢
		dc.b $34 ; 4
		dc.b $A1 ; °
		dc.b $85 ; Ö
		dc.b   2
		dc.b $93 ; ì
		dc.b $14
		dc.b   7
		dc.b $83 ; É
		dc.b $A0 ; †
		dc.b $2F ; /
		dc.b $91 ; ë
		dc.b $98 ; ò
		dc.b $11
		dc.b $2F ; /
		dc.b $C6 ; ∆
		dc.b $25 ; %
		dc.b $84 ; Ñ
		dc.b   7
		dc.b $85 ; Ö
		dc.b $22 ; "
		dc.b $94 ; î
		dc.b $8D ; ç
		dc.b $1E
		dc.b   1
		dc.b $AC ; ¨
		dc.b $38 ; 8
		dc.b $9F ; ü
		dc.b $2A ; *
		dc.b $8A ; ä
		dc.b   8
		dc.b $2E ; .
		dc.b $9D ; ù
		dc.b $11
		dc.b   1
		dc.b $19
		dc.b $93 ; ì
		dc.b $40 ; @
		dc.b $A7 ; ß
		dc.b $90 ; ê
		dc.b $23 ; #
		dc.b $1F
		dc.b $91 ; ë
		dc.b $26 ; &
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $2E ; .
		dc.b $A2 ; ¢
		dc.b $80 ; Ä
		dc.b $4C ; L
		dc.b $AC ; ¨
		dc.b   5
		dc.b $8E ; é
		dc.b $4A ; J
		dc.b $B3 ; ≥
		dc.b   6
		dc.b $29 ; )
		dc.b $A8 ; ®
		dc.b $14
		dc.b $15
		dc.b $BC ; º
		dc.b $16
		dc.b   5
		dc.b   8
		dc.b $80 ; Ä
		dc.b $98 ; ò
		dc.b $23 ; #
		dc.b   3
		dc.b $A8 ; ®
		dc.b $28 ; (
		dc.b $83 ; É
		dc.b $8A ; ä
		dc.b $2B ; +
		dc.b $85 ; Ö
		dc.b $99 ; ô
		dc.b   7
		dc.b $3E ; >
		dc.b $BB ; ª
		dc.b $26 ; &
		dc.b  $B
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $13
		dc.b $85 ; Ö
		dc.b   6
		dc.b $96 ; ñ
		dc.b $84 ; Ñ
		dc.b   8
		dc.b $81 ; Å
		dc.b $90 ; ê
		dc.b $A9 ; ©
		dc.b $30 ; 0
		dc.b $AA ; ™
		dc.b $9D ; ù
		dc.b $2D ; -
		dc.b $83 ; É
		dc.b $98 ; ò
		dc.b $23 ; #
		dc.b $A7 ; ß
		dc.b $17
		dc.b $14
		dc.b $97 ; ó
		dc.b $20
		dc.b   4
		dc.b  $F
		dc.b $9B ; õ
		dc.b  $C
		dc.b $24 ; $
		dc.b $A7 ; ß
		dc.b $16
		dc.b   2
		dc.b $94 ; î
		dc.b $1B
		dc.b $B2 ; ≤
		dc.b $36 ; 6
		dc.b $8E ; é
		dc.b $90 ; ê
		dc.b   3
		dc.b $14
		dc.b $91 ; ë
		dc.b $2A ; *
		dc.b $AD ; ≠
		dc.b $20
		dc.b $82 ; Ç
		dc.b $8A ; ä
		dc.b $28 ; (
		dc.b $9E ; û
		dc.b   1
		dc.b $2F ; /
		dc.b $A6 ; ¶
		dc.b $15
		dc.b $10
		dc.b $AB ; ´
		dc.b $32 ; 2
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b  $E
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $96 ; ñ
		dc.b $1A
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $A0 ; †
		dc.b $10
		dc.b   7
		dc.b $9F ; ü
		dc.b $1D
		dc.b $92 ; í
		dc.b $88 ; à
		dc.b $22 ; "
		dc.b $A8 ; ®
		dc.b  $F
		dc.b $1C
		dc.b $99 ; ô
		dc.b $89 ; â
		dc.b $1F
		dc.b $90 ; ê
		dc.b $11
		dc.b $96 ; ñ
		dc.b  $B
		dc.b  $F
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   8
		dc.b  $C
		dc.b $17
		dc.b $9C ; ú
		dc.b $82 ; Ç
		dc.b $2E ; .
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b  $F
		dc.b  $D
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b   9
		dc.b   5
		dc.b $94 ; î
		dc.b $10
		dc.b $86 ; Ü
		dc.b   6
		dc.b $97 ; ó
		dc.b $82 ; Ç
		dc.b $15
		dc.b $90 ; ê
		dc.b $85 ; Ö
		dc.b  $E
		dc.b   8
		dc.b $8A ; ä
		dc.b  $F
		dc.b $96 ; ñ
		dc.b  $A
		dc.b $80 ; Ä
		dc.b  $C
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b   4
		dc.b   3
		dc.b  $B
		dc.b   4
		dc.b $83 ; É
		dc.b $14
		dc.b $97 ; ó
		dc.b $14
		dc.b $8D ; ç
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b  $A
		dc.b $99 ; ô
		dc.b   2
		dc.b   8
		dc.b $83 ; É
		dc.b $93 ; ì
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   8
		dc.b   7
		dc.b $B7 ; ∑
		dc.b $24 ; $
		dc.b  $E
		dc.b $91 ; ë
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b $2E ; .
		dc.b $9E ; û
		dc.b $93 ; ì
		dc.b $20
		dc.b $8B ; ã
		dc.b   4
		dc.b   1
		dc.b $97 ; ó
		dc.b $21 ; !
		dc.b $89 ; â
		dc.b   7
		dc.b $9D ; ù
		dc.b $1A
		dc.b $8B ; ã
		dc.b  $B
		dc.b $94 ; î
		dc.b $14
		dc.b $9A ; ö
		dc.b $19
		dc.b $8D ; ç
		dc.b   2
		dc.b   6
		dc.b $89 ; â
		dc.b   7
		dc.b $15
		dc.b $A0 ; †
		dc.b $19
		dc.b   9
		dc.b $92 ; í
		dc.b  $B
		dc.b $86 ; Ü
		dc.b  $B
		dc.b   9
		dc.b $89 ; â
		dc.b   4
		dc.b $81 ; Å
		dc.b  $B
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b   7
		dc.b   7
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b  $F
		dc.b $8C ; å
		dc.b   3
		dc.b $12
		dc.b $90 ; ê
		dc.b   5
		dc.b   7
		dc.b   4
		dc.b   6
		dc.b $8D ; ç
		dc.b  $A
		dc.b  $B
		dc.b $82 ; Ç
		dc.b $8C ; å
		dc.b $12
		dc.b $83 ; É
		dc.b   7
		dc.b $92 ; í
		dc.b $18
		dc.b $8C ; å
		dc.b   6
		dc.b   7
		dc.b $89 ; â
		dc.b $80 ; Ä
		dc.b  $D
		dc.b $8D ; ç
		dc.b   6
		dc.b  $E
		dc.b $8E ; é
		dc.b   5
		dc.b $84 ; Ñ
		dc.b  $B
		dc.b $8B ; ã
		dc.b  $A
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b   5
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b   5
		dc.b   2
		dc.b $80 ; Ä
		dc.b   3
		dc.b   7
		dc.b $88 ; à
		dc.b   6
		dc.b   1
		dc.b   6
		dc.b $87 ; á
		dc.b   1
		dc.b   6
		dc.b   3
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b  $B
		dc.b   3
		dc.b $8E ; é
		dc.b $12
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b   6
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b   9
		dc.b $8C ; å
		dc.b   7
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b   4
		dc.b $85 ; Ö
		dc.b   4
		dc.b   3
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   4
		dc.b   6
		dc.b $87 ; á
		dc.b   1
		dc.b $80 ; Ä
		dc.b   6
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   3
		dc.b   8
		dc.b $8B ; ã
		dc.b  $C
		dc.b $88 ; à
		dc.b $80 ; Ä
		dc.b   5
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b   4
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b $82 ; Ç
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $86 ; Ü
		dc.b   3
		dc.b   3
		dc.b $84 ; Ñ
		dc.b   4
		dc.b $83 ; É
		dc.b   3
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   7
		dc.b $86 ; Ü
		dc.b   1
		dc.b   5
		dc.b   1
		dc.b $86 ; Ü
		dc.b  $A
		dc.b $82 ; Ç
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   8
		dc.b $81 ; Å
		dc.b   2
		dc.b   2
		dc.b $83 ; É
		dc.b   2
		dc.b   3
		dc.b $83 ; É
		dc.b   4
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   4
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   3
		dc.b $82 ; Ç
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   3
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   3
		dc.b $84 ; Ñ
		dc.b   5
		dc.b $85 ; Ö
		dc.b   5
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   3
		dc.b $84 ; Ñ
		dc.b   2
		dc.b $80 ; Ä
		dc.b   2
		dc.b $82 ; Ç
		dc.b   1
		dc.b $80 ; Ä
		dc.b   3
		dc.b $82 ; Ç
		dc.b   1
		dc.b $81 ; Å
		dc.b   3
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b   4
		dc.b $85 ; Ö
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $83 ; É
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   2
		dc.b $82 ; Ç
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   3
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b   2
		dc.b $9C ; ú
		dc.b $D4 ; ‘
		dc.b $27 ; '
		dc.b $1D
		dc.b $2A ; *
		dc.b $99 ; ô
		dc.b $29 ; )
		dc.b $1C
		dc.b $94 ; î
		dc.b $9D ; ù
		dc.b $29 ; )
		dc.b   5
		dc.b $1E
		dc.b $BC ; º
		dc.b $20
		dc.b $1C
		dc.b $92 ; í
		dc.b $10
		dc.b $80 ; Ä
		dc.b   9
		dc.b $1D
		dc.b $97 ; ó
		dc.b   6
		dc.b $94 ; î
		dc.b $91 ; ë
		dc.b $87 ; á
		dc.b   7
		dc.b $9B ; õ
		dc.b $8F ; è
		dc.b $1D
		dc.b $9E ; û
		dc.b $16
		dc.b $9A ; ö
		dc.b $17
		dc.b   8
		dc.b $8A ; ä
		dc.b $13
		dc.b   6
		dc.b $85 ; Ö
		dc.b $16
		dc.b $93 ; ì
		dc.b $16
		dc.b  $F
		dc.b $94 ; î
		dc.b   4
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $1B
		dc.b $B5 ; µ
		dc.b $16
		dc.b $14
		dc.b $86 ; Ü
		dc.b $8B ; ã
		dc.b   7
		dc.b $17
		dc.b $88 ; à
		dc.b   2
		dc.b $A6 ; ¶
		dc.b $8D ; ç
		dc.b $2C ; ,
		dc.b $BD ; Ω
		dc.b  $E
		dc.b $2F ; /
		dc.b $FE ; ˛
		dc.b $56 ; V
		dc.b $18
		dc.b $2D ; -
		dc.b   1
		dc.b $98 ; ò
		dc.b $15
		dc.b   8
		dc.b $10
		dc.b $84 ; Ñ
		dc.b $D0 ; –
		dc.b   2
		dc.b $40 ; @
		dc.b $82 ; Ç
		dc.b $96 ; ñ
		dc.b $94 ; î
		dc.b $85 ; Ö
		dc.b $39 ; 9
		dc.b $8A ; ä
		dc.b $AD ; ≠
		dc.b $91 ; ë
		dc.b $2A ; *
		dc.b $89 ; â
		dc.b $C2 ; ¬
		dc.b $27 ; '
		dc.b $11
		dc.b $B1 ; ±
		dc.b $1D
		dc.b $8D ; ç
		dc.b   4
		dc.b   2
		dc.b $81 ; Å
		dc.b $28 ; (
		dc.b $81 ; Å
		dc.b $8D ; ç
		dc.b $18
		dc.b  $F
		dc.b $BE ; æ
		dc.b $14
		dc.b $25 ; %
		dc.b $80 ; Ä
		dc.b $8B ; ã
		dc.b $A9 ; ©
		dc.b $42 ; B
		dc.b $88 ; à
		dc.b $BD ; Ω
		dc.b $89 ; â
		dc.b $17
		dc.b   9
		dc.b $17
		dc.b $A5 ; •
		dc.b $54 ; T
		dc.b $91 ; ë
		dc.b $A5 ; •
		dc.b $27 ; '
		dc.b $B6 ; ∂
		dc.b   8
		dc.b  $A
		dc.b $8F ; è
		dc.b $1F
		dc.b $93 ; ì
		dc.b   3
		dc.b $86 ; Ü
		dc.b $12
		dc.b $83 ; É
		dc.b $94 ; î
		dc.b $80 ; Ä
		dc.b  $B
		dc.b $97 ; ó
		dc.b $12
		dc.b $11
		dc.b   2
		dc.b $AF ; Ø
		dc.b   8
		dc.b $95 ; ï
		dc.b $84 ; Ñ
		dc.b $2B ; +
		dc.b $BD ; Ω
		dc.b $9A ; ö
		dc.b $34 ; 4
		dc.b $84 ; Ñ
		dc.b $93 ; ì
		dc.b $A0 ; †
		dc.b $3C ; <
		dc.b $82 ; Ç
		dc.b $A0 ; †
		dc.b   2
		dc.b $81 ; Å
		dc.b $26 ; &
		dc.b $2D ; -
		dc.b $8A ; ä
		dc.b $96 ; ñ
		dc.b $25 ; %
		dc.b   5
		dc.b $96 ; ñ
		dc.b $19
		dc.b $BB ; ª
		dc.b $2F ; /
		dc.b   1
		dc.b $9D ; ù
		dc.b  $B
		dc.b $1C
		dc.b $B8 ; ∏
		dc.b $24 ; $
		dc.b $95 ; ï
		dc.b $1A
		dc.b $87 ; á
		dc.b $8D ; ç
		dc.b $9D ; ù
		dc.b $3A ; :
		dc.b $89 ; â
		dc.b $9C ; ú
		dc.b $12
		dc.b  $C
		dc.b $98 ; ò
		dc.b   8
		dc.b $92 ; í
		dc.b $27 ; '
		dc.b $A4 ; §
		dc.b $A3 ; £
		dc.b  $C
		dc.b $20
		dc.b $9F ; ü
		dc.b $A4 ; §
		dc.b $26 ; &
		dc.b   2
		dc.b $8C ; å
		dc.b $A1 ; °
		dc.b   7
		dc.b $32 ; 2
		dc.b $86 ; Ü
		dc.b $92 ; í
		dc.b $80 ; Ä
		dc.b $1A
		dc.b $21 ; !
		dc.b $10
		dc.b   3
		dc.b   6
		dc.b   2
		dc.b $83 ; É
		dc.b $9C ; ú
		dc.b   9
		dc.b   6
		dc.b   3
		dc.b $1A
		dc.b $B0 ; ∞
		dc.b $30 ; 0
		dc.b   2
		dc.b $8F ; è
		dc.b $A0 ; †
		dc.b  $F
		dc.b $21 ; !
		dc.b $D6 ; ÷
		dc.b $21 ; !
		dc.b $17
		dc.b $87 ; á
		dc.b $A5 ; •
		dc.b $9E ; û
		dc.b  $F
		dc.b $2F ; /
		dc.b $AA ; ™
		dc.b $86 ; Ü
		dc.b  $E
		dc.b  $A
		dc.b   1
		dc.b $9C ; ú
		dc.b $15
		dc.b $1B
		dc.b $94 ; î
		dc.b $90 ; ê
		dc.b $3D ; =
		dc.b $92 ; í
		dc.b   9
		dc.b $8E ; é
		dc.b   3
		dc.b $1C
		dc.b   1
		dc.b $BA ; ∫
		dc.b $52 ; R
		dc.b $1C
		dc.b $99 ; ô
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b   9
		dc.b   7
		dc.b $86 ; Ü
		dc.b $98 ; ò
		dc.b $26 ; &
		dc.b  $D
		dc.b $A4 ; §
		dc.b $8D ; ç
		dc.b   4
		dc.b   5
		dc.b $91 ; ë
		dc.b $89 ; â
		dc.b $98 ; ò
		dc.b  $F
		dc.b  $C
		dc.b $96 ; ñ
		dc.b   7
		dc.b $1C
		dc.b $B3 ; ≥
		dc.b   5
		dc.b $1D
		dc.b $8D ; ç
		dc.b $20
		dc.b  $A
		dc.b $9F ; ü
		dc.b $91 ; ë
		dc.b $26 ; &
		dc.b   7
		dc.b $9E ; û
		dc.b $11
		dc.b $14
		dc.b $85 ; Ö
		dc.b   7
		dc.b $27 ; '
		dc.b $C1 ; ¡
		dc.b   5
		dc.b $34 ; 4
		dc.b  $C
		dc.b $B7 ; ∑
		dc.b $19
		dc.b $AC ; ¨
		dc.b $39 ; 9
		dc.b $8A ; ä
		dc.b $D4 ; ‘
		dc.b $2A ; *
		dc.b $1F
		dc.b $9A ; ö
		dc.b $89 ; â
		dc.b   6
		dc.b $8F ; è
		dc.b  $F
		dc.b   9
		dc.b $A0 ; †
		dc.b $3E ; >
		dc.b $9F ; ü
		dc.b $8A ; ä
		dc.b $41 ; A
		dc.b $95 ; ï
		dc.b $A4 ; §
		dc.b $16
		dc.b   6
		dc.b   8
		dc.b $B5 ; µ
		dc.b  $E
		dc.b $2A ; *
		dc.b $8E ; é
		dc.b $95 ; ï
		dc.b $16
		dc.b $16
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b $3A ; :
		dc.b $A4 ; §
		dc.b $AE ; Æ
		dc.b  $B
		dc.b $1D
		dc.b $96 ; ñ
		dc.b $8B ; ã
		dc.b   4
		dc.b   8
		dc.b   4
		dc.b   9
		dc.b $A4 ; §
		dc.b $8F ; è
		dc.b $48 ; H
		dc.b $C1 ; ¡
		dc.b $17
		dc.b $2F ; /
		dc.b $A1 ; °
		dc.b $2E ; .
		dc.b $27 ; '
		dc.b $A0 ; †
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $3C ; <
		dc.b $A8 ; ®
		dc.b $83 ; É
		dc.b $90 ; ê
		dc.b $9A ; ö
		dc.b  $A
		dc.b   3
		dc.b  $D
		dc.b $8F ; è
		dc.b $23 ; #
		dc.b $8E ; é
		dc.b   2
		dc.b $10
		dc.b $1E
		dc.b $85 ; Ö
		dc.b $AA ; ™
		dc.b   3
		dc.b $20
		dc.b   4
		dc.b $99 ; ô
		dc.b $26 ; &
		dc.b $A3 ; £
		dc.b  $E
		dc.b $B9 ; π
		dc.b $A4 ; §
		dc.b $A2 ; ¢
		dc.b $3D ; =
		dc.b $22 ; "
		dc.b $C5 ; ≈
		dc.b $80 ; Ä
		dc.b $37 ; 7
		dc.b   6
		dc.b $26 ; &
		dc.b $A5 ; •
		dc.b $2D ; -
		dc.b $37 ; 7
		dc.b $8D ; ç
		dc.b $A7 ; ß
		dc.b   7
		dc.b $31 ; 1
		dc.b $8D ; ç
		dc.b $10
		dc.b $15
		dc.b $AB ; ´
		dc.b $9B ; õ
		dc.b $4A ; J
		dc.b $A7 ; ß
		dc.b $1B
		dc.b $A0 ; †
		dc.b $D5 ; ’
		dc.b $1E
		dc.b  $B
		dc.b  $E
		dc.b $8B ; ã
		dc.b $80 ; Ä
		dc.b $B8 ; ∏
		dc.b $83 ; É
		dc.b $2E ; .
		dc.b $90 ; ê
		dc.b $BD ; Ω
		dc.b $31 ; 1
		dc.b $24 ; $
		dc.b $B6 ; ∂
		dc.b $85 ; Ö
		dc.b  $A
		dc.b $25 ; %
		dc.b $86 ; Ü
		dc.b $18
		dc.b $14
		dc.b $8B ; ã
		dc.b $98 ; ò
		dc.b   8
		dc.b $11
		dc.b $9A ; ö
		dc.b $17
		dc.b $A3 ; £
		dc.b   8
		dc.b $3B ; ;
		dc.b   2
		dc.b $89 ; â
		dc.b  $C
		dc.b   4
		dc.b $9C ; ú
		dc.b $9A ; ö
		dc.b $33 ; 3
		dc.b $82 ; Ç
		dc.b $B0 ; ∞
		dc.b $20
		dc.b $80 ; Ä
		dc.b $8F ; è
		dc.b $8A ; ä
		dc.b $40 ; @
		dc.b $9B ; õ
		dc.b $98 ; ò
		dc.b   5
		dc.b $C5 ; ≈
		dc.b $28 ; (
		dc.b   8
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b $89 ; â
		dc.b $9A ; ö
		dc.b $39 ; 9
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $A2 ; ¢
		dc.b $31 ; 1
		dc.b $98 ; ò
		dc.b $A8 ; ®
		dc.b $15
		dc.b $87 ; á
		dc.b $34 ; 4
		dc.b   1
		dc.b $B0 ; ∞
		dc.b $15
		dc.b $81 ; Å
		dc.b $1A
		dc.b $19
		dc.b $A6 ; ¶
		dc.b $19
		dc.b $82 ; Ç
		dc.b  $F
		dc.b $18
		dc.b $11
		dc.b $8A ; ä
		dc.b $1C
		dc.b $9F ; ü
		dc.b $A0 ; †
		dc.b $37 ; 7
		dc.b   3
		dc.b $AD ; ≠
		dc.b $24 ; $
		dc.b $86 ; Ü
		dc.b $C4 ; ƒ
		dc.b $92 ; í
		dc.b $8A ; ä
		dc.b $1D
		dc.b $AE ; Æ
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b $A9 ; ©
		dc.b $3D ; =
		dc.b $96 ; ñ
		dc.b $21 ; !
		dc.b $B1 ; ±
		dc.b $31 ; 1
		dc.b $8B ; ã
		dc.b $85 ; Ö
		dc.b $4B ; K
		dc.b $82 ; Ç
		dc.b   9
		dc.b $9B ; õ
		dc.b $1C
		dc.b $1C
		dc.b $A5 ; •
		dc.b $11
		dc.b $11
		dc.b $8E ; é
		dc.b $2C ; ,
		dc.b $AE ; Æ
		dc.b $1B
		dc.b $11
		dc.b $8A ; ä
		dc.b $93 ; ì
		dc.b  $E
		dc.b $81 ; Å
		dc.b $9D ; ù
		dc.b $85 ; Ö
		dc.b  $E
		dc.b  $A
		dc.b $99 ; ô
		dc.b $C5 ; ≈
		dc.b $29 ; )
		dc.b $16
		dc.b $AC ; ¨
		dc.b   7
		dc.b $90 ; ê
		dc.b   7
		dc.b $8F ; è
		dc.b $9D ; ù
		dc.b $3F ; ?
		dc.b $8C ; å
		dc.b   7
		dc.b $2A ; *
		dc.b $91 ; ë
		dc.b $12
		dc.b $86 ; Ü
		dc.b $18
		dc.b $B8 ; ∏
		dc.b  $D
		dc.b   1
		dc.b $82 ; Ç
		dc.b $20
		dc.b $B6 ; ∂
		dc.b $34 ; 4
		dc.b $AC ; ¨
		dc.b $84 ; Ñ
		dc.b $48 ; H
		dc.b $B1 ; ±
		dc.b $18
		dc.b $86 ; Ü
		dc.b $16
		dc.b $92 ; í
		dc.b   9
		dc.b $86 ; Ü
		dc.b $82 ; Ç
		dc.b $1D
		dc.b $8C ; å
		dc.b $9C ; ú
		dc.b $12
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $93 ; ì
		dc.b  $F
		dc.b $9B ; õ
		dc.b $9A ; ö
		dc.b $31 ; 1
		dc.b $27 ; '
		dc.b   1
		dc.b $A2 ; ¢
		dc.b $8F ; è
		dc.b $4D ; M
		dc.b $A4 ; §
		dc.b $B2 ; ≤
		dc.b $16
		dc.b $17
		dc.b $8B ; ã
		dc.b $82 ; Ç
		dc.b $A6 ; ¶
		dc.b $23 ; #
		dc.b $82 ; Ç
		dc.b $12
		dc.b $A6 ; ¶
		dc.b $14
		dc.b  $F
		dc.b $96 ; ñ
		dc.b $8F ; è
		dc.b $23 ; #
		dc.b $30 ; 0
		dc.b $8D ; ç
		dc.b $DD ; ›
		dc.b  $E
		dc.b $41 ; A
		dc.b $A7 ; ß
		dc.b $93 ; ì
		dc.b $2E ; .
		dc.b $9F ; ü
		dc.b $84 ; Ñ
		dc.b $BA ; ∫
		dc.b $2A ; *
		dc.b  $B
		dc.b $80 ; Ä
		dc.b $8E ; é
		dc.b $3A ; :
		dc.b $A8 ; ®
		dc.b $24 ; $
		dc.b $22 ; "
		dc.b $A6 ; ¶
		dc.b $3B ; ;
		dc.b $85 ; Ö
		dc.b   8
		dc.b $9A ; ö
		dc.b $30 ; 0
		dc.b $8D ; ç
		dc.b $93 ; ì
		dc.b   6
		dc.b $AA ; ™
		dc.b $92 ; í
		dc.b $84 ; Ñ
		dc.b  $F
		dc.b   7
		dc.b $8C ; å
		dc.b $95 ; ï
		dc.b $84 ; Ñ
		dc.b $A4 ; §
		dc.b $2E ; .
		dc.b $80 ; Ä
		dc.b $14
		dc.b $21 ; !
		dc.b $B0 ; ∞
		dc.b $12
		dc.b   1
		dc.b   3
		dc.b  $B
		dc.b   7
		dc.b $A4 ; §
		dc.b $20
		dc.b $A0 ; †
		dc.b $18
		dc.b $95 ; ï
		dc.b $12
		dc.b $1C
		dc.b $C0 ; ¿
		dc.b $18
		dc.b $1F
		dc.b   9
		dc.b $81 ; Å
		dc.b $9A ; ö
		dc.b  $D
		dc.b   3
		dc.b $93 ; ì
		dc.b $81 ; Å
		dc.b $2D ; -
		dc.b $A3 ; £
		dc.b $1E
		dc.b $8D ; ç
		dc.b $16
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b  $D
		dc.b $8C ; å
		dc.b $17
		dc.b $95 ; ï
		dc.b   1
		dc.b $1C
		dc.b   1
		dc.b $AA ; ™
		dc.b   6
		dc.b   8
		dc.b   2
		dc.b   9
		dc.b $A2 ; ¢
		dc.b $21 ; !
		dc.b $22 ; "
		dc.b $C2 ; ¬
		dc.b $92 ; í
		dc.b $36 ; 6
		dc.b $97 ; ó
		dc.b $99 ; ô
		dc.b $8A ; ä
		dc.b $41 ; A
		dc.b $A4 ; §
		dc.b   6
		dc.b $31 ; 1
		dc.b $BF ; ø
		dc.b $3B ; ;
		dc.b $95 ; ï
		dc.b $21 ; !
		dc.b $93 ; ì
		dc.b $32 ; 2
		dc.b $9C ; ú
		dc.b $8C ; å
		dc.b $86 ; Ü
		dc.b $9E ; û
		dc.b $1C
		dc.b  $E
		dc.b   5
		dc.b $A5 ; •
		dc.b $1A
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $8D ; ç
		dc.b $AB ; ´
		dc.b $1E
		dc.b   8
		dc.b $AE ; Æ
		dc.b $80 ; Ä
		dc.b $31 ; 1
		dc.b $B1 ; ±
		dc.b $25 ; %
		dc.b $85 ; Ö
		dc.b $9F ; ü
		dc.b $1D
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   6
		dc.b $21 ; !
		dc.b $80 ; Ä
		dc.b   9
		dc.b $8B ; ã
		dc.b $97 ; ó
		dc.b $40 ; @
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b  $A
		dc.b $86 ; Ü
		dc.b $91 ; ë
		dc.b $11
		dc.b $87 ; á
		dc.b  $F
		dc.b $B3 ; ≥
		dc.b $15
		dc.b $83 ; É
		dc.b $97 ; ó
		dc.b $14
		dc.b $25 ; %
		dc.b   2
		dc.b $C4 ; ƒ
		dc.b $14
		dc.b $84 ; Ñ
		dc.b  $B
		dc.b  $E
		dc.b $A6 ; ¶
		dc.b   2
		dc.b  $E
		dc.b $85 ; Ö
		dc.b $9D ; ù
		dc.b $30 ; 0
		dc.b $91 ; ë
		dc.b  $D
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $10
		dc.b $8C ; å
		dc.b $19
		dc.b $91 ; ë
		dc.b $27 ; '
		dc.b $A7 ; ß
		dc.b $1D
		dc.b $10
		dc.b   8
		dc.b $82 ; Ç
		dc.b   1
		dc.b $8C ; å
		dc.b $A4 ; §
		dc.b $3B ; ;
		dc.b $84 ; Ñ
		dc.b $91 ; ë
		dc.b $28 ; (
		dc.b   3
		dc.b $92 ; í
		dc.b $99 ; ô
		dc.b   7
		dc.b $21 ; !
		dc.b $95 ; ï
		dc.b $82 ; Ç
		dc.b   2
		dc.b $9C ; ú
		dc.b $12
		dc.b   7
		dc.b $21 ; !
		dc.b $9B ; õ
		dc.b $BF ; ø
		dc.b   5
		dc.b $42 ; B
		dc.b $9B ; õ
		dc.b $AE ; Æ
		dc.b $3C ; <
		dc.b $AF ; Ø
		dc.b $1F
		dc.b $A3 ; £
		dc.b $87 ; á
		dc.b $58 ; X
		dc.b $9E ; û
		dc.b $A3 ; £
		dc.b $2E ; .
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $80 ; Ä
		dc.b $1E
		dc.b $21 ; !
		dc.b $AE ; Æ
		dc.b  $A
		dc.b  $A
		dc.b $8D ; ç
		dc.b $15
		dc.b   4
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $96 ; ñ
		dc.b $81 ; Å
		dc.b $1F
		dc.b   9
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $27 ; '
		dc.b $9D ; ù
		dc.b $82 ; Ç
		dc.b $1E
		dc.b  $D
		dc.b  $D
		dc.b $B1 ; ±
		dc.b $8B ; ã
		dc.b $1E
		dc.b $88 ; à
		dc.b $11
		dc.b $9A ; ö
		dc.b $98 ; ò
		dc.b $34 ; 4
		dc.b $9C ; ú
		dc.b $88 ; à
		dc.b $27 ; '
		dc.b $A5 ; •
		dc.b $B9 ; π
		dc.b $33 ; 3
		dc.b $86 ; Ü
		dc.b $32 ; 2
		dc.b $A7 ; ß
		dc.b $8C ; å
		dc.b $15
		dc.b  $F
		dc.b $8B ; ã
		dc.b $98 ; ò
		dc.b $1D
		dc.b   6
		dc.b  $A
		dc.b $8B ; ã
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $2A ; *
		dc.b $8F ; è
		dc.b  $A
		dc.b $8C ; å
		dc.b  $C
		dc.b   9
		dc.b $8C ; å
		dc.b $13
		dc.b $B0 ; ∞
		dc.b  $F
		dc.b $A6 ; ¶
		dc.b $3A ; :
		dc.b $8F ; è
		dc.b $81 ; Å
		dc.b $1C
		dc.b $95 ; ï
		dc.b $15
		dc.b $83 ; É
		dc.b $AC ; ¨
		dc.b $2A ; *
		dc.b $11
		dc.b $B3 ; ≥
		dc.b $29 ; )
		dc.b $90 ; ê
		dc.b $9C ; ú
		dc.b $40 ; @
		dc.b $A7 ; ß
		dc.b   8
		dc.b $12
		dc.b $AA ; ™
		dc.b $18
		dc.b $22 ; "
		dc.b $93 ; ì
		dc.b $A6 ; ¶
		dc.b   3
		dc.b $20
		dc.b $84 ; Ñ
		dc.b $98 ; ò
		dc.b $28 ; (
		dc.b   5
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $2A ; *
		dc.b $97 ; ó
		dc.b $B4 ; ¥
		dc.b $50 ; P
		dc.b $80 ; Ä
		dc.b $9B ; õ
		dc.b   9
		dc.b $AF ; Ø
		dc.b $62 ; b
		dc.b $C1 ; ¡
		dc.b   1
		dc.b $14
		dc.b $AA ; ™
		dc.b $42 ; B
		dc.b $86 ; Ü
		dc.b $B1 ; ±
		dc.b $1B
		dc.b $8E ; é
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $13
		dc.b $11
		dc.b $96 ; ñ
		dc.b   6
		dc.b $12
		dc.b $97 ; ó
		dc.b   7
		dc.b $87 ; á
		dc.b $2C ; ,
		dc.b  $F
		dc.b $89 ; â
		dc.b $B1 ; ±
		dc.b $1D
		dc.b   9
		dc.b $8D ; ç
		dc.b $96 ; ñ
		dc.b $8A ; ä
		dc.b $22 ; "
		dc.b $10
		dc.b $87 ; á
		dc.b $9A ; ö
		dc.b $34 ; 4
		dc.b $B2 ; ≤
		dc.b  $D
		dc.b   5
		dc.b $86 ; Ü
		dc.b  $D
		dc.b $AD ; ≠
		dc.b  $E
		dc.b   5
		dc.b $95 ; ï
		dc.b $10
		dc.b $A7 ; ß
		dc.b $23 ; #
		dc.b $35 ; 5
		dc.b $A1 ; °
		dc.b $96 ; ñ
		dc.b $44 ; D
		dc.b $B4 ; ¥
		dc.b $20
		dc.b $85 ; Ö
		dc.b $AC ; ¨
		dc.b $44 ; D
		dc.b $88 ; à
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $94 ; î
		dc.b $82 ; Ç
		dc.b $91 ; ë
		dc.b $28 ; (
		dc.b $AA ; ™
		dc.b   5
		dc.b $1E
		dc.b $91 ; ë
		dc.b $8E ; é
		dc.b $28 ; (
		dc.b $BD ; Ω
		dc.b   1
		dc.b $26 ; &
		dc.b $99 ; ô
		dc.b $12
		dc.b  $E
		dc.b $B5 ; µ
		dc.b $17
		dc.b $14
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b   6
		dc.b $82 ; Ç
		dc.b $33 ; 3
		dc.b   2
		dc.b $8F ; è
		dc.b $9C ; ú
		dc.b $81 ; Å
		dc.b $24 ; $
		dc.b $8C ; å
		dc.b   4
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $2F ; /
		dc.b $B1 ; ±
		dc.b $11
		dc.b   6
		dc.b $AB ; ´
		dc.b $35 ; 5
		dc.b $AE ; Æ
		dc.b $A2 ; ¢
		dc.b $43 ; C
		dc.b $95 ; ï
		dc.b   2
		dc.b $81 ; Å
		dc.b $95 ; ï
		dc.b  $C
		dc.b $90 ; ê
		dc.b $13
		dc.b $11
		dc.b $96 ; ñ
		dc.b $93 ; ì
		dc.b $10
		dc.b $89 ; â
		dc.b  $B
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b   1
		dc.b   3
		dc.b $83 ; É
		dc.b $8E ; é
		dc.b   8
		dc.b  $B
		dc.b   1
		dc.b $30 ; 0
		dc.b $A7 ; ß
		dc.b $1B
		dc.b $21 ; !
		dc.b $92 ; í
		dc.b $90 ; ê
		dc.b   5
		dc.b $8A ; ä
		dc.b $1E
		dc.b  $E
		dc.b $BA ; ∫
		dc.b $35 ; 5
		dc.b $88 ; à
		dc.b $B9 ; π
		dc.b $85 ; Ö
		dc.b $3E ; >
		dc.b $AA ; ™
		dc.b $83 ; É
		dc.b $98 ; ò
		dc.b $28 ; (
		dc.b $93 ; ì
		dc.b   9
		dc.b $A2 ; ¢
		dc.b $1C
		dc.b   9
		dc.b   1
		dc.b $A1 ; °
		dc.b $10
		dc.b   5
		dc.b $22 ; "
		dc.b $9D ; ù
		dc.b $97 ; ó
		dc.b $2C ; ,
		dc.b $9C ; ú
		dc.b $1E
		dc.b  $B
		dc.b $9B ; õ
		dc.b $12
		dc.b $9E ; û
		dc.b $19
		dc.b $24 ; $
		dc.b $9D ; ù
		dc.b $A4 ; §
		dc.b   7
		dc.b $30 ; 0
		dc.b $87 ; á
		dc.b $9E ; û
		dc.b $93 ; ì
		dc.b $3D ; =
		dc.b $93 ; ì
		dc.b $8B ; ã
		dc.b $8F ; è
		dc.b $94 ; î
		dc.b $2F ; /
		dc.b $87 ; á
		dc.b $A8 ; ®
		dc.b $41 ; A
		dc.b $96 ; ñ
		dc.b $A8 ; ®
		dc.b   8
		dc.b $14
		dc.b $33 ; 3
		dc.b $CE ; Œ
		dc.b   5
		dc.b $3F ; ?
		dc.b $9C ; ú
		dc.b $12
		dc.b $AD ; ≠
		dc.b   8
		dc.b $32 ; 2
		dc.b $A8 ; ®
		dc.b $86 ; Ü
		dc.b $38 ; 8
		dc.b $93 ; ì
		dc.b $17
		dc.b $B2 ; ≤
		dc.b $17
		dc.b   6
		dc.b $84 ; Ñ
		dc.b $AA ; ™
		dc.b $20
		dc.b   5
		dc.b $96 ; ñ
		dc.b $94 ; î
		dc.b $2C ; ,
		dc.b $92 ; í
		dc.b   9
		dc.b $C6 ; ∆
		dc.b $2C ; ,
		dc.b $1F
		dc.b $83 ; É
		dc.b $8D ; ç
		dc.b $92 ; í
		dc.b $1B
		dc.b  $F
		dc.b $90 ; ê
		dc.b $8A ; ä
		dc.b  $B
		dc.b  $B
		dc.b $8F ; è
		dc.b   1
		dc.b   9
		dc.b $A5 ; •
		dc.b $21 ; !
		dc.b $A5 ; •
		dc.b $13
		dc.b $33 ; 3
		dc.b $D5 ; ’
		dc.b $3A ; :
		dc.b $13
		dc.b $81 ; Å
		dc.b $98 ; ò
		dc.b $18
		dc.b $AE ; Æ
		dc.b $24 ; $
		dc.b $34 ; 4
		dc.b $C8 ; »
		dc.b $11
		dc.b $1C
		dc.b $A4 ; §
		dc.b  $E
		dc.b   6
		dc.b $9B ; õ
		dc.b $8D ; ç
		dc.b $20
		dc.b $21 ; !
		dc.b $A9 ; ©
		dc.b $8E ; é
		dc.b  $D
		dc.b $28 ; (
		dc.b $8E ; é
		dc.b $B0 ; ∞
		dc.b $14
		dc.b   9
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $11
		dc.b $AD ; ≠
		dc.b $84 ; Ñ
		dc.b $29 ; )
		dc.b $98 ; ò
		dc.b   7
		dc.b $83 ; É
		dc.b $98 ; ò
		dc.b  $A
		dc.b $36 ; 6
		dc.b $A9 ; ©
		dc.b $8A ; ä
		dc.b   6
		dc.b $2D ; -
		dc.b $98 ; ò
		dc.b $97 ; ó
		dc.b $1C
		dc.b   3
		dc.b $25 ; %
		dc.b $AC ; ¨
		dc.b $89 ; â
		dc.b $11
		dc.b   7
		dc.b $9B ; õ
		dc.b $19
		dc.b  $B
		dc.b $80 ; Ä
		dc.b $89 ; â
		dc.b $9A ; ö
		dc.b $10
		dc.b $19
		dc.b $9D ; ù
		dc.b $98 ; ò
		dc.b $38 ; 8
		dc.b $9A ; ö
		dc.b   1
		dc.b $8B ; ã
		dc.b   9
		dc.b  $D
		dc.b $89 ; â
		dc.b $8D ; ç
		dc.b  $F
		dc.b $19
		dc.b $9E ; û
		dc.b $1F
		dc.b   6
		dc.b $A3 ; £
		dc.b $19
		dc.b $B1 ; ±
		dc.b $24 ; $
		dc.b $2D ; -
		dc.b $AC ; ¨
		dc.b $9D ; ù
		dc.b $1C
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $AA ; ™
		dc.b   3
		dc.b $20
		dc.b  $A
		dc.b $91 ; ë
		dc.b $82 ; Ç
		dc.b   5
		dc.b  $D
		dc.b  $C
		dc.b $8D ; ç
		dc.b $84 ; Ñ
		dc.b $1A
		dc.b $84 ; Ñ
		dc.b   9
		dc.b $89 ; â
		dc.b   7
		dc.b $A2 ; ¢
		dc.b  $C
		dc.b $39 ; 9
		dc.b $AA ; ™
		dc.b  $D
		dc.b $8B ; ã
		dc.b $A3 ; £
		dc.b $48 ; H
		dc.b $99 ; ô
		dc.b $BD ; Ω
		dc.b   9
		dc.b $30 ; 0
		dc.b  $A
		dc.b $94 ; î
		dc.b $8A ; ä
		dc.b $29 ; )
		dc.b $85 ; Ö
		dc.b $8A ; ä
		dc.b $94 ; î
		dc.b $29 ; )
		dc.b $B2 ; ≤
		dc.b $17
		dc.b   4
		dc.b $94 ; î
		dc.b $1A
		dc.b $97 ; ó
		dc.b $8C ; å
		dc.b $3B ; ;
		dc.b $B2 ; ≤
		dc.b   9
		dc.b $9A ; ö
		dc.b $26 ; &
		dc.b $85 ; Ö
		dc.b $A9 ; ©
		dc.b   2
		dc.b  $F
		dc.b $80 ; Ä
		dc.b   5
		dc.b $23 ; #
		dc.b $98 ; ò
		dc.b $8D ; ç
		dc.b   5
		dc.b $17
		dc.b $99 ; ô
		dc.b $13
		dc.b $90 ; ê
		dc.b $16
		dc.b $14
		dc.b $86 ; Ü
		dc.b $1B
		dc.b $85 ; Ö
		dc.b $A1 ; °
		dc.b $34 ; 4
		dc.b   5
		dc.b $96 ; ñ
		dc.b  $F
		dc.b $93 ; ì
		dc.b   8
		dc.b $83 ; É
		dc.b $AC ; ¨
		dc.b $15
		dc.b $8D ; ç
		dc.b   7
		dc.b $88 ; à
		dc.b $8E ; é
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $94 ; î
		dc.b $28 ; (
		dc.b $A8 ; ®
		dc.b   3
		dc.b  $B
		dc.b $10
		dc.b $10
		dc.b $93 ; ì
		dc.b $86 ; Ü
		dc.b $13
		dc.b $14
		dc.b $83 ; É
		dc.b  $F
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $23 ; #
		dc.b $90 ; ê
		dc.b  $D
		dc.b $A0 ; †
		dc.b $13
		dc.b $12
		dc.b $13
		dc.b $A8 ; ®
		dc.b $91 ; ë
		dc.b $83 ; É
		dc.b $1F
		dc.b $8B ; ã
		dc.b $B1 ; ±
		dc.b $94 ; î
		dc.b $1D
		dc.b $16
		dc.b $94 ; î
		dc.b   1
		dc.b   4
		dc.b   6
		dc.b $80 ; Ä
		dc.b $8D ; ç
		dc.b $1E
		dc.b $85 ; Ö
		dc.b $9D ; ù
		dc.b $14
		dc.b   9
		dc.b   1
		dc.b $A7 ; ß
		dc.b $80 ; Ä
		dc.b $2C ; ,
		dc.b $80 ; Ä
		dc.b $B8 ; ∏
		dc.b $20
		dc.b   6
		dc.b $84 ; Ñ
		dc.b $25 ; %
		dc.b $A7 ; ß
		dc.b $14
		dc.b $18
		dc.b $92 ; í
		dc.b   8
		dc.b   8
		dc.b   2
		dc.b $23 ; #
		dc.b $AA ; ™
		dc.b $9B ; õ
		dc.b $30 ; 0
		dc.b $A9 ; ©
		dc.b $87 ; á
		dc.b $2F ; /
		dc.b $8C ; å
		dc.b $99 ; ô
		dc.b  $D
		dc.b $97 ; ó
		dc.b  $C
		dc.b $24 ; $
		dc.b $A3 ; £
		dc.b $84 ; Ñ
		dc.b $13
		dc.b $94 ; î
		dc.b $21 ; !
		dc.b $A4 ; §
		dc.b  $F
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $8F ; è
		dc.b $82 ; Ç
		dc.b $10
		dc.b $96 ; ñ
		dc.b  $D
		dc.b   4
		dc.b $84 ; Ñ
		dc.b $9A ; ö
		dc.b $24 ; $
		dc.b $11
		dc.b $89 ; â
		dc.b $1C
		dc.b $89 ; â
		dc.b $93 ; ì
		dc.b  $D
		dc.b   5
		dc.b $20
		dc.b $90 ; ê
		dc.b $92 ; í
		dc.b $12
		dc.b $92 ; í
		dc.b  $A
		dc.b  $F
		dc.b $A4 ; §
		dc.b $86 ; Ü
		dc.b  $B
		dc.b $83 ; É
		dc.b $9F ; ü
		dc.b   4
		dc.b  $C
		dc.b $2B ; +
		dc.b $A4 ; §
		dc.b $B1 ; ±
		dc.b $1B
		dc.b $23 ; #
		dc.b $8A ; ä
		dc.b $10
		dc.b $88 ; à
		dc.b $96 ; ñ
		dc.b  $E
		dc.b  $C
		dc.b $80 ; Ä
		dc.b   2
		dc.b $8B ; ã
		dc.b $12
		dc.b   1
		dc.b   2
		dc.b   4
		dc.b $82 ; Ç
		dc.b  $E
		dc.b  $D
		dc.b $98 ; ò
		dc.b $82 ; Ç
		dc.b   7
		dc.b $18
		dc.b  $B
		dc.b $AB ; ´
		dc.b  $D
		dc.b $89 ; â
		dc.b   6
		dc.b $99 ; ô
		dc.b $19
		dc.b $8B ; ã
		dc.b $80 ; Ä
		dc.b $9D ; ù
		dc.b $85 ; Ö
		dc.b   9
		dc.b $19
		dc.b $95 ; ï
		dc.b $9F ; ü
		dc.b $3D ; =
		dc.b  $C
		dc.b $B4 ; ¥
		dc.b $83 ; É
		dc.b $36 ; 6
		dc.b $85 ; Ö
		dc.b $B6 ; ∂
		dc.b $20
		dc.b $1D
		dc.b $82 ; Ç
		dc.b  $D
		dc.b $12
		dc.b $A3 ; £
		dc.b   3
		dc.b $11
		dc.b $91 ; ë
		dc.b $16
		dc.b $8E ; é
		dc.b $19
		dc.b $88 ; à
		dc.b $AB ; ´
		dc.b $16
		dc.b $22 ; "
		dc.b $BA ; ∫
		dc.b  $E
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b $18
		dc.b $85 ; Ö
		dc.b $8D ; ç
		dc.b   5
		dc.b $84 ; Ñ
		dc.b $25 ; %
		dc.b $98 ; ò
		dc.b $85 ; Ö
		dc.b $18
		dc.b $80 ; Ä
		dc.b $A2 ; ¢
		dc.b $86 ; Ü
		dc.b $2F ; /
		dc.b   1
		dc.b $AB ; ´
		dc.b  $C
		dc.b $1F
		dc.b   6
		dc.b $AF ; Ø
		dc.b $19
		dc.b $20
		dc.b $A6 ; ¶
		dc.b $80 ; Ä
		dc.b   9
		dc.b $17
		dc.b $83 ; É
		dc.b  $B
		dc.b $8C ; å
		dc.b   3
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $1E
		dc.b $9E ; û
		dc.b $18
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $27 ; '
		dc.b $A6 ; ¶
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b $32 ; 2
		dc.b $A7 ; ß
		dc.b $8F ; è
		dc.b $17
		dc.b  $E
		dc.b $94 ; î
		dc.b $89 ; â
		dc.b   9
		dc.b   4
		dc.b  $F
		dc.b $80 ; Ä
		dc.b $92 ; í
		dc.b $1F
		dc.b $94 ; î
		dc.b   2
		dc.b $85 ; Ö
		dc.b $1F
		dc.b $8B ; ã
		dc.b $93 ; ì
		dc.b $13
		dc.b   8
		dc.b  $A
		dc.b $85 ; Ö
		dc.b $8C ; å
		dc.b   7
		dc.b $A1 ; °
		dc.b $16
		dc.b $12
		dc.b $B1 ; ±
		dc.b $3A ; :
		dc.b $9A ; ö
		dc.b $85 ; Ö
		dc.b $8E ; é
		dc.b $82 ; Ç
		dc.b $11
		dc.b $8B ; ã
		dc.b  $A
		dc.b $14
		dc.b $A6 ; ¶
		dc.b $93 ; ì
		dc.b $2E ; .
		dc.b $97 ; ó
		dc.b   6
		dc.b $88 ; à
		dc.b $81 ; Å
		dc.b $19
		dc.b $A0 ; †
		dc.b $1E
		dc.b  $E
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $8D ; ç
		dc.b $34 ; 4
		dc.b  $E
		dc.b $A8 ; ®
		dc.b $20
		dc.b $87 ; á
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $A4 ; §
		dc.b $2F ; /
		dc.b  $F
		dc.b $A0 ; †
		dc.b   4
		dc.b $85 ; Ö
		dc.b  $A
		dc.b $92 ; í
		dc.b  $F
		dc.b   8
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $24 ; $
		dc.b $9D ; ù
		dc.b  $A
		dc.b $10
		dc.b $A4 ; §
		dc.b $8E ; é
		dc.b $1F
		dc.b $9B ; õ
		dc.b $1D
		dc.b   4
		dc.b   7
		dc.b $86 ; Ü
		dc.b $9A ; ö
		dc.b $82 ; Ç
		dc.b $1A
		dc.b   2
		dc.b  $E
		dc.b $96 ; ñ
		dc.b $1D
		dc.b $A0 ; †
		dc.b $11
		dc.b   7
		dc.b   8
		dc.b $11
		dc.b $9F ; ü
		dc.b  $F
		dc.b $1B
		dc.b $9A ; ö
		dc.b   6
		dc.b $93 ; ì
		dc.b $8C ; å
		dc.b   3
		dc.b  $A
		dc.b   2
		dc.b $81 ; Å
		dc.b   9
		dc.b $12
		dc.b $B0 ; ∞
		dc.b  $D
		dc.b $82 ; Ç
		dc.b   8
		dc.b $99 ; ô
		dc.b $23 ; #
		dc.b $89 ; â
		dc.b $8E ; é
		dc.b $90 ; ê
		dc.b $16
		dc.b $11
		dc.b $8F ; è
		dc.b   1
		dc.b   7
		dc.b $11
		dc.b $19
		dc.b $BA ; ∫
		dc.b $39 ; 9
		dc.b $97 ; ó
		dc.b $8E ; é
		dc.b  $B
		dc.b   9
		dc.b  $B
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b  $F
		dc.b $86 ; Ü
		dc.b $A6 ; ¶
		dc.b $10
		dc.b   5
		dc.b $1F
		dc.b $94 ; î
		dc.b $9E ; û
		dc.b $1D
		dc.b $81 ; Å
		dc.b  $A
		dc.b $8B ; ã
		dc.b $17
		dc.b $A7 ; ß
		dc.b $1B
		dc.b $17
		dc.b $8D ; ç
		dc.b $86 ; Ü
		dc.b   4
		dc.b $92 ; í
		dc.b   3
		dc.b   6
		dc.b $8B ; ã
		dc.b   3
		dc.b $15
		dc.b $14
		dc.b $9C ; ú
		dc.b $9A ; ö
		dc.b   7
		dc.b $33 ; 3
		dc.b $91 ; ë
		dc.b $87 ; á
		dc.b $8D ; ç
		dc.b $2A ; *
		dc.b $81 ; Å
		dc.b $94 ; î
		dc.b   6
		dc.b $14
		dc.b $A5 ; •
		dc.b  $B
		dc.b $8D ; ç
		dc.b $22 ; "
		dc.b $80 ; Ä
		dc.b $A1 ; °
		dc.b $15
		dc.b   8
		dc.b $99 ; ô
		dc.b $90 ; ê
		dc.b $19
		dc.b $12
		dc.b   4
		dc.b   8
		dc.b $9D ; ù
		dc.b   3
		dc.b $1D
		dc.b $8A ; ä
		dc.b $8E ; é
		dc.b   4
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b   1
		dc.b $8E ; é
		dc.b $17
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b   3
		dc.b  $D
		dc.b  $B
		dc.b $92 ; í
		dc.b  $B
		dc.b   9
		dc.b $89 ; â
		dc.b $9A ; ö
		dc.b $19
		dc.b  $B
		dc.b $1A
		dc.b $A7 ; ß
		dc.b  $E
		dc.b $10
		dc.b $90 ; ê
		dc.b $94 ; î
		dc.b $21 ; !
		dc.b   6
		dc.b $84 ; Ñ
		dc.b $94 ; î
		dc.b $24 ; $
		dc.b   6
		dc.b $94 ; î
		dc.b  $D
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $1D
		dc.b $A4 ; §
		dc.b   2
		dc.b $13
		dc.b   9
		dc.b $9B ; õ
		dc.b $92 ; í
		dc.b $11
		dc.b   8
		dc.b $9B ; õ
		dc.b $2D ; -
		dc.b $A3 ; £
		dc.b $85 ; Ö
		dc.b $28 ; (
		dc.b $9D ; ù
		dc.b   2
		dc.b $81 ; Å
		dc.b   4
		dc.b $12
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $1B
		dc.b $8F ; è
		dc.b $81 ; Å
		dc.b $17
		dc.b $A6 ; ¶
		dc.b  $E
		dc.b  $A
		dc.b   8
		dc.b $94 ; î
		dc.b $85 ; Ö
		dc.b $20
		dc.b $9C ; ú
		dc.b   8
		dc.b $14
		dc.b $8E ; é
		dc.b   3
		dc.b $8A ; ä
		dc.b $14
		dc.b $81 ; Å
		dc.b   8
		dc.b $90 ; ê
		dc.b $8A ; ä
		dc.b $23 ; #
		dc.b $80 ; Ä
		dc.b $8E ; é
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $18
		dc.b $89 ; â
		dc.b $A0 ; †
		dc.b $27 ; '
		dc.b $85 ; Ö
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b   2
		dc.b  $E
		dc.b $81 ; Å
		dc.b $91 ; ë
		dc.b $84 ; Ñ
		dc.b $1B
		dc.b $89 ; â
		dc.b $99 ; ô
		dc.b $88 ; à
		dc.b $34 ; 4
		dc.b $A2 ; ¢
		dc.b   2
		dc.b $83 ; É
		dc.b $12
		dc.b $33 ; 3
		dc.b $B3 ; ≥
		dc.b  $B
		dc.b   4
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b   7
		dc.b   8
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b $93 ; ì
		dc.b $25 ; %
		dc.b $AE ; Æ
		dc.b $19
		dc.b   3
		dc.b   5
		dc.b $83 ; É
		dc.b $91 ; ë
		dc.b $28 ; (
		dc.b $96 ; ñ
		dc.b   4
		dc.b   2
		dc.b  $F
		dc.b   2
		dc.b  $D
		dc.b $8D ; ç
		dc.b  $A
		dc.b $98 ; ò
		dc.b $81 ; Å
		dc.b $13
		dc.b  $B
		dc.b $8E ; é
		dc.b $8A ; ä
		dc.b  $B
		dc.b $14
		dc.b $AD ; ≠
		dc.b $20
		dc.b $95 ; ï
		dc.b $17
		dc.b $13
		dc.b $9E ; û
		dc.b $8A ; ä
		dc.b $21 ; !
		dc.b $93 ; ì
		dc.b  $B
		dc.b $A7 ; ß
		dc.b  $B
		dc.b $18
		dc.b $90 ; ê
		dc.b   3
		dc.b   3
		dc.b $89 ; â
		dc.b   3
		dc.b $85 ; Ö
		dc.b  $B
		dc.b $91 ; ë
		dc.b $82 ; Ç
		dc.b $36 ; 6
		dc.b $90 ; ê
		dc.b $98 ; ò
		dc.b $14
		dc.b $80 ; Ä
		dc.b $8D ; ç
		dc.b  $B
		dc.b   7
		dc.b $9A ; ö
		dc.b $21 ; !
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b  $E
		dc.b   4
		dc.b $89 ; â
		dc.b $A8 ; ®
		dc.b $1C
		dc.b $1A
		dc.b $9B ; õ
		dc.b  $B
		dc.b $87 ; á
		dc.b $13
		dc.b $97 ; ó
		dc.b $85 ; Ö
		dc.b $21 ; !
		dc.b $8C ; å
		dc.b $1A
		dc.b $98 ; ò
		dc.b   8
		dc.b $9C ; ú
		dc.b $17
		dc.b $83 ; É
		dc.b $90 ; ê
		dc.b  $C
		dc.b  $B
		dc.b   7
		dc.b $83 ; É
		dc.b   5
		dc.b  $E
		dc.b $A9 ; ©
		dc.b $21 ; !
		dc.b $90 ; ê
		dc.b   6
		dc.b $18
		dc.b $A3 ; £
		dc.b $21 ; !
		dc.b $8B ; ã
		dc.b   9
		dc.b   3
		dc.b $B4 ; ¥
		dc.b $18
		dc.b $17
		dc.b $A4 ; §
		dc.b $18
		dc.b $92 ; í
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $18
		dc.b $97 ; ó
		dc.b $84 ; Ñ
		dc.b $12
		dc.b $13
		dc.b $9C ; ú
		dc.b $92 ; í
		dc.b $28 ; (
		dc.b $8E ; é
		dc.b   6
		dc.b   4
		dc.b $94 ; î
		dc.b $21 ; !
		dc.b   1
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b  $D
		dc.b $A1 ; °
		dc.b   7
		dc.b $11
		dc.b $17
		dc.b $97 ; ó
		dc.b $80 ; Ä
		dc.b $96 ; ñ
		dc.b $18
		dc.b $88 ; à
		dc.b $A0 ; †
		dc.b $18
		dc.b $14
		dc.b $81 ; Å
		dc.b $A3 ; £
		dc.b   8
		dc.b $94 ; î
		dc.b $2F ; /
		dc.b $95 ; ï
		dc.b $8A ; ä
		dc.b   8
		dc.b $88 ; à
		dc.b $81 ; Å
		dc.b $26 ; &
		dc.b $8F ; è
		dc.b $84 ; Ñ
		dc.b   1
		dc.b $96 ; ñ
		dc.b $10
		dc.b $12
		dc.b $81 ; Å
		dc.b $9F ; ü
		dc.b $12
		dc.b $29 ; )
		dc.b $AF ; Ø
		dc.b   8
		dc.b   6
		dc.b $1D
		dc.b $13
		dc.b $A9 ; ©
		dc.b $85 ; Ö
		dc.b $1A
		dc.b $95 ; ï
		dc.b $20
		dc.b $83 ; É
		dc.b  $B
		dc.b $8A ; ä
		dc.b $A6 ; ¶
		dc.b $10
		dc.b  $B
		dc.b   8
		dc.b $A5 ; •
		dc.b $90 ; ê
		dc.b $17
		dc.b $14
		dc.b $99 ; ô
		dc.b $8B ; ã
		dc.b $28 ; (
		dc.b $94 ; î
		dc.b $8C ; å
		dc.b $8F ; è
		dc.b $18
		dc.b $89 ; â
		dc.b  $B
		dc.b $85 ; Ö
		dc.b   7
		dc.b $96 ; ñ
		dc.b   4
		dc.b $1C
		dc.b $80 ; Ä
		dc.b $10
		dc.b $8E ; é
		dc.b $9D ; ù
		dc.b $16
		dc.b $14
		dc.b $19
		dc.b $A0 ; †
		dc.b   2
		dc.b $82 ; Ç
		dc.b   1
		dc.b  $D
		dc.b  $B
		dc.b $A3 ; £
		dc.b $15
		dc.b  $D
		dc.b $92 ; í
		dc.b $9F ; ü
		dc.b $80 ; Ä
		dc.b $16
		dc.b $8D ; ç
		dc.b  $A
		dc.b $94 ; î
		dc.b $9E ; û
		dc.b $35 ; 5
		dc.b $88 ; à
		dc.b $8F ; è
		dc.b   1
		dc.b   8
		dc.b   7
		dc.b $82 ; Ç
		dc.b   9
		dc.b $12
		dc.b $95 ; ï
		dc.b $87 ; á
		dc.b $10
		dc.b $82 ; Ç
		dc.b $2B ; +
		dc.b $AD ; ≠
		dc.b $16
		dc.b $1A
		dc.b $9A ; ö
		dc.b   3
		dc.b $87 ; á
		dc.b  $D
		dc.b   8
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b   5
		dc.b   9
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $8C ; å
		dc.b   1
		dc.b $92 ; í
		dc.b   7
		dc.b   7
		dc.b $1B
		dc.b $A0 ; †
		dc.b $9A ; ö
		dc.b $1C
		dc.b $30 ; 0
		dc.b $A6 ; ¶
		dc.b   1
		dc.b $81 ; Å
		dc.b $1C
		dc.b $97 ; ó
		dc.b $8C ; å
		dc.b $86 ; Ü
		dc.b $22 ; "
		dc.b $14
		dc.b $9D ; ù
		dc.b $88 ; à
		dc.b $18
		dc.b $89 ; â
		dc.b  $A
		dc.b   5
		dc.b $88 ; à
		dc.b $8D ; ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   8
		dc.b  $A
		dc.b $81 ; Å
		dc.b $A1 ; °
		dc.b $1E
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $10
		dc.b   4
		dc.b $8A ; ä
		dc.b  $B
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $8D ; ç
		dc.b $32 ; 2
		dc.b $8E ; é
		dc.b $80 ; Ä
		dc.b $A1 ; °
		dc.b $16
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b $22 ; "
		dc.b $A5 ; •
		dc.b   5
		dc.b $1D
		dc.b   2
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b   6
		dc.b $90 ; ê
		dc.b  $D
		dc.b $81 ; Å
		dc.b $1D
		dc.b $95 ; ï
		dc.b   6
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $10
		dc.b $8A ; ä
		dc.b $15
		dc.b   5
		dc.b   2
		dc.b $98 ; ò
		dc.b   1
		dc.b $18
		dc.b $AC ; ¨
		dc.b $23 ; #
		dc.b $8C ; å
		dc.b   6
		dc.b   7
		dc.b $86 ; Ü
		dc.b $8B ; ã
		dc.b  $A
		dc.b $92 ; í
		dc.b   3
		dc.b  $F
		dc.b $8B ; ã
		dc.b $81 ; Å
		dc.b  $A
		dc.b   6
		dc.b $9B ; õ
		dc.b   5
		dc.b   5
		dc.b $93 ; ì
		dc.b $34 ; 4
		dc.b $86 ; Ü
		dc.b $98 ; ò
		dc.b $8D ; ç
		dc.b $14
		dc.b $19
		dc.b $AB ; ´
		dc.b  $D
		dc.b   6
		dc.b   9
		dc.b $16
		dc.b $A0 ; †
		dc.b   6
		dc.b $12
		dc.b $8B ; ã
		dc.b   1
		dc.b $94 ; î
		dc.b $16
		dc.b  $B
		dc.b $93 ; ì
		dc.b $87 ; á
		dc.b $12
		dc.b   9
		dc.b $94 ; î
		dc.b $8B ; ã
		dc.b $12
		dc.b  $F
		dc.b $98 ; ò
		dc.b $89 ; â
		dc.b $83 ; É
		dc.b $16
		dc.b $83 ; É
		dc.b $96 ; ñ
		dc.b $13
		dc.b   4
		dc.b $8B ; ã
		dc.b $14
		dc.b $98 ; ò
		dc.b   5
		dc.b  $B
		dc.b $8C ; å
		dc.b $93 ; ì
		dc.b $18
		dc.b   3
		dc.b $84 ; Ñ
		dc.b  $C
		dc.b $2A ; *
		dc.b $AC ; ¨
		dc.b $8C ; å
		dc.b $19
		dc.b $96 ; ñ
		dc.b $2F ; /
		dc.b $A5 ; •
		dc.b $10
		dc.b $10
		dc.b $A2 ; ¢
		dc.b $1D
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b   7
		dc.b $96 ; ñ
		dc.b $12
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $90 ; ê
		dc.b $89 ; â
		dc.b $10
		dc.b   6
		dc.b   6
		dc.b $94 ; î
		dc.b   5
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b   5
		dc.b $92 ; í
		dc.b $2D ; -
		dc.b $8F ; è
		dc.b $81 ; Å
		dc.b  $B
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b  $E
		dc.b $82 ; Ç
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $96 ; ñ
		dc.b $15
		dc.b $80 ; Ä
		dc.b   4
		dc.b $85 ; Ö
		dc.b $95 ; ï
		dc.b $8D ; ç
		dc.b   5
		dc.b $1D
		dc.b $97 ; ó
		dc.b   9
		dc.b $8B ; ã
		dc.b  $B
		dc.b $9B ; õ
		dc.b   3
		dc.b $12
		dc.b   1
		dc.b   7
		dc.b $92 ; í
		dc.b $86 ; Ü
		dc.b $2C ; ,
		dc.b $9C ; ú
		dc.b $8C ; å
		dc.b $15
		dc.b $88 ; à
		dc.b $91 ; ë
		dc.b $17
		dc.b  $A
		dc.b $84 ; Ñ
		dc.b   1
		dc.b $90 ; ê
		dc.b   1
		dc.b $18
		dc.b $9F ; ü
		dc.b  $A
		dc.b $1D
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $8E ; é
		dc.b   1
		dc.b  $A
		dc.b  $D
		dc.b $8B ; ã
		dc.b   1
		dc.b  $D
		dc.b $8E ; é
		dc.b  $C
		dc.b $94 ; î
		dc.b $89 ; â
		dc.b $19
		dc.b $89 ; â
		dc.b  $C
		dc.b $8A ; ä
		dc.b  $C
		dc.b   9
		dc.b $9B ; õ
		dc.b   5
		dc.b   8
		dc.b $86 ; Ü
		dc.b   2
		dc.b   1
		dc.b   8
		dc.b $92 ; í
		dc.b   6
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $A4 ; §
		dc.b $38 ; 8
		dc.b $92 ; í
		dc.b $8A ; ä
		dc.b $14
		dc.b $8D ; ç
		dc.b   8
		dc.b $1A
		dc.b $AE ; Æ
		dc.b $17
		dc.b  $F
		dc.b  $D
		dc.b $82 ; Ç
		dc.b $9B ; õ
		dc.b $80 ; Ä
		dc.b $14
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b  $E
		dc.b $98 ; ò
		dc.b $17
		dc.b $9A ; ö
		dc.b  $C
		dc.b  $E
		dc.b $99 ; ô
		dc.b   8
		dc.b $90 ; ê
		dc.b  $A
		dc.b $13
		dc.b $95 ; ï
		dc.b  $D
		dc.b  $C
		dc.b $97 ; ó
		dc.b  $D
		dc.b $96 ; ñ
		dc.b $21 ; !
		dc.b $8E ; é
		dc.b $14
		dc.b  $A
		dc.b $8A ; ä
		dc.b   7
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $21 ; !
		dc.b $A5 ; •
		dc.b  $C
		dc.b $10
		dc.b $8F ; è
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $93 ; ì
		dc.b $1D
		dc.b $93 ; ì
		dc.b $82 ; Ç
		dc.b $1D
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b  $C
		dc.b $9D ; ù
		dc.b $17
		dc.b $84 ; Ñ
		dc.b   1
		dc.b $1C
		dc.b $9F ; ü
		dc.b $2B ; +
		dc.b $A9 ; ©
		dc.b $83 ; É
		dc.b  $B
		dc.b  $E
		dc.b $93 ; ì
		dc.b   6
		dc.b $8B ; ã
		dc.b $2A ; *
		dc.b $93 ; ì
		dc.b $89 ; â
		dc.b   6
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $16
		dc.b $85 ; Ö
		dc.b   3
		dc.b $1F
		dc.b $A0 ; †
		dc.b $87 ; á
		dc.b $12
		dc.b $8A ; ä
		dc.b   8
		dc.b  $D
		dc.b   4
		dc.b   4
		dc.b $92 ; í
		dc.b   2
		dc.b $10
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b   5
		dc.b   7
		dc.b $84 ; Ñ
		dc.b $17
		dc.b $93 ; ì
		dc.b $99 ; ô
		dc.b $17
		dc.b $92 ; í
		dc.b $86 ; Ü
		dc.b $1A
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b   8
		dc.b  $B
		dc.b $93 ; ì
		dc.b $8E ; é
		dc.b   7
		dc.b $1A
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b $8D ; ç
		dc.b $1F
		dc.b $88 ; à
		dc.b   5
		dc.b $97 ; ó
		dc.b $1F
		dc.b $96 ; ñ
		dc.b $12
		dc.b $82 ; Ç
		dc.b $14
		dc.b   8
		dc.b $A9 ; ©
		dc.b   4
		dc.b   3
		dc.b $16
		dc.b $9A ; ö
		dc.b $13
		dc.b   8
		dc.b  $F
		dc.b $93 ; ì
		dc.b $9C ; ú
		dc.b $16
		dc.b   8
		dc.b   7
		dc.b $91 ; ë
		dc.b   5
		dc.b   5
		dc.b $19
		dc.b $A0 ; †
		dc.b $8D ; ç
		dc.b   6
		dc.b   5
		dc.b $8B ; ã
		dc.b  $D
		dc.b   7
		dc.b $8A ; ä
		dc.b $83 ; É
		dc.b   1
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b   8
		dc.b $84 ; Ñ
		dc.b $1C
		dc.b   7
		dc.b $92 ; í
		dc.b $81 ; Å
		dc.b  $C
		dc.b $84 ; Ñ
		dc.b $90 ; ê
		dc.b   5
		dc.b   7
		dc.b $14
		dc.b $9B ; õ
		dc.b  $B
		dc.b  $F
		dc.b $9C ; ú
		dc.b $86 ; Ü
		dc.b  $B
		dc.b $15
		dc.b $A1 ; °
		dc.b $22 ; "
		dc.b $94 ; î
		dc.b   1
		dc.b $1D
		dc.b $94 ; î
		dc.b $90 ; ê
		dc.b   5
		dc.b $13
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $82 ; Ç
		dc.b $12
		dc.b $87 ; á
		dc.b $92 ; í
		dc.b   9
		dc.b   6
		dc.b $8B ; ã
		dc.b $1D
		dc.b   4
		dc.b $86 ; Ü
		dc.b $92 ; í
		dc.b  $A
		dc.b   6
		dc.b   2
		dc.b   2
		dc.b $8D ; ç
		dc.b   6
		dc.b   8
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   2
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b  $E
		dc.b   5
		dc.b   6
		dc.b $96 ; ñ
		dc.b  $D
		dc.b   8
		dc.b $99 ; ô
		dc.b $88 ; à
		dc.b $22 ; "
		dc.b   7
		dc.b $8B ; ã
		dc.b $9B ; õ
		dc.b $89 ; â
		dc.b $1C
		dc.b   8
		dc.b $90 ; ê
		dc.b $98 ; ò
		dc.b $1F
		dc.b  $A
		dc.b $96 ; ñ
		dc.b $13
		dc.b $87 ; á
		dc.b  $E
		dc.b  $C
		dc.b $A1 ; °
		dc.b   9
		dc.b $18
		dc.b $8D ; ç
		dc.b $18
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $8B ; ã
		dc.b   5
		dc.b $18
		dc.b $93 ; ì
		dc.b $85 ; Ö
		dc.b   9
		dc.b $8B ; ã
		dc.b   4
		dc.b $83 ; É
		dc.b   1
		dc.b $1C
		dc.b $A6 ; ¶
		dc.b $86 ; Ü
		dc.b $1A
		dc.b $96 ; ñ
		dc.b $22 ; "
		dc.b $90 ; ê
		dc.b $95 ; ï
		dc.b  $E
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $8F ; è
		dc.b $16
		dc.b $11
		dc.b $98 ; ò
		dc.b $94 ; î
		dc.b  $F
		dc.b   8
		dc.b $81 ; Å
		dc.b  $A
		dc.b $81 ; Å
		dc.b $10
		dc.b $85 ; Ö
		dc.b   7
		dc.b $86 ; Ü
		dc.b  $E
		dc.b  $F
		dc.b $9F ; ü
		dc.b $11
		dc.b $84 ; Ñ
		dc.b   7
		dc.b $8C ; å
		dc.b $14
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $83 ; É
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $8B ; ã
		dc.b   1
		dc.b $89 ; â
		dc.b $10
		dc.b   1
		dc.b $83 ; É
		dc.b $12
		dc.b $8E ; é
		dc.b  $E
		dc.b $9A ; ö
		dc.b  $E
		dc.b   8
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $14
		dc.b $9D ; ù
		dc.b   5
		dc.b  $B
		dc.b   1
		dc.b $11
		dc.b $8F ; è
		dc.b $87 ; á
		dc.b   4
		dc.b $20
		dc.b $93 ; ì
		dc.b $83 ; É
		dc.b   5
		dc.b $11
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b   5
		dc.b   2
		dc.b   4
		dc.b   6
		dc.b $89 ; â
		dc.b  $A
		dc.b $9C ; ú
		dc.b   8
		dc.b   7
		dc.b $8F ; è
		dc.b $81 ; Å
		dc.b   3
		dc.b $8D ; ç
		dc.b  $F
		dc.b   3
		dc.b $8E ; é
		dc.b   7
		dc.b $83 ; É
		dc.b $8B ; ã
		dc.b  $F
		dc.b $8A ; ä
		dc.b $11
		dc.b  $D
		dc.b $96 ; ñ
		dc.b $13
		dc.b   7
		dc.b $83 ; É
		dc.b   5
		dc.b $87 ; á
		dc.b   7
		dc.b   3
		dc.b $80 ; Ä
		dc.b $89 ; â
		dc.b $83 ; É
		dc.b  $D
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $22 ; "
		dc.b $93 ; ì
		dc.b  $D
		dc.b $88 ; à
		dc.b   8
		dc.b $88 ; à
		dc.b $8E ; é
		dc.b   5
		dc.b $24 ; $
		dc.b $9A ; ö
		dc.b $8E ; é
		dc.b $14
		dc.b   5
		dc.b   2
		dc.b $86 ; Ü
		dc.b $A1 ; °
		dc.b $21 ; !
		dc.b  $F
		dc.b $A6 ; ¶
		dc.b $88 ; à
		dc.b $11
		dc.b $1B
		dc.b $A2 ; ¢
		dc.b   3
		dc.b   8
		dc.b $86 ; Ü
		dc.b $16
		dc.b $9E ; û
		dc.b $11
		dc.b $1A
		dc.b $9B ; õ
		dc.b $83 ; É
		dc.b   8
		dc.b $12
		dc.b  $D
		dc.b $94 ; î
		dc.b   9
		dc.b  $B
		dc.b $8B ; ã
		dc.b $11
		dc.b $90 ; ê
		dc.b  $A
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b   9
		dc.b   3
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b   5
		dc.b $8C ; å
		dc.b   1
		dc.b   5
		dc.b   2
		dc.b  $A
		dc.b $88 ; à
		dc.b $90 ; ê
		dc.b  $C
		dc.b   5
		dc.b $82 ; Ç
		dc.b $8B ; ã
		dc.b  $B
		dc.b  $D
		dc.b $97 ; ó
		dc.b  $D
		dc.b $8F ; è
		dc.b $19
		dc.b $82 ; Ç
		dc.b $90 ; ê
		dc.b $83 ; É
		dc.b  $C
		dc.b   6
		dc.b  $B
		dc.b $8B ; ã
		dc.b $10
		dc.b $8F ; è
		dc.b  $D
		dc.b $8E ; é
		dc.b $10
		dc.b $17
		dc.b $9B ; õ
		dc.b $8D ; ç
		dc.b $10
		dc.b $80 ; Ä
		dc.b $99 ; ô
		dc.b $2E ; .
		dc.b $92 ; í
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b   2
		dc.b $11
		dc.b $8F ; è
		dc.b $10
		dc.b $A3 ; £
		dc.b $11
		dc.b   8
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b  $E
		dc.b   2
		dc.b $96 ; ñ
		dc.b  $E
		dc.b $83 ; É
		dc.b   1
		dc.b  $B
		dc.b   2
		dc.b $83 ; É
		dc.b   4
		dc.b $84 ; Ñ
		dc.b   5
		dc.b  $E
		dc.b $85 ; Ö
		dc.b $92 ; í
		dc.b  $D
		dc.b $86 ; Ü
		dc.b  $B
		dc.b $86 ; Ü
		dc.b $8F ; è
		dc.b $13
		dc.b   3
		dc.b $A3 ; £
		dc.b $17
		dc.b  $E
		dc.b $90 ; ê
		dc.b $87 ; á
		dc.b   9
		dc.b   9
		dc.b $86 ; Ü
		dc.b $8C ; å
		dc.b $80 ; Ä
		dc.b $12
		dc.b   1
		dc.b $91 ; ë
		dc.b   3
		dc.b  $E
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b  $D
		dc.b $88 ; à
		dc.b   5
		dc.b   9
		dc.b $87 ; á
		dc.b $91 ; ë
		dc.b $1C
		dc.b $86 ; Ü
		dc.b  $E
		dc.b $80 ; Ä
		dc.b $8C ; å
		dc.b   3
		dc.b $81 ; Å
		dc.b  $F
		dc.b $84 ; Ñ
		dc.b $9E ; û
		dc.b $29 ; )
		dc.b $9E ; û
		dc.b  $A
		dc.b $80 ; Ä
		dc.b   5
		dc.b $88 ; à
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $8D ; ç
		dc.b  $D
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $11
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b   1
		dc.b $1E
		dc.b $8F ; è
		dc.b $87 ; á
		dc.b   6
		dc.b  $A
		dc.b   9
		dc.b $9D ; ù
		dc.b  $B
		dc.b $18
		dc.b $90 ; ê
		dc.b $85 ; Ö
		dc.b $8B ; ã
		dc.b   5
		dc.b $1D
		dc.b $99 ; ô
		dc.b   2
		dc.b $8E ; é
		dc.b $10
		dc.b  $F
		dc.b $B2 ; ≤
		dc.b $25 ; %
		dc.b   4
		dc.b $8A ; ä
		dc.b   5
		dc.b   2
		dc.b   3
		dc.b   6
		dc.b $8B ; ã
		dc.b $16
		dc.b $91 ; ë
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b  $A
		dc.b   8
		dc.b $93 ; ì
		dc.b   9
		dc.b $92 ; í
		dc.b $86 ; Ü
		dc.b $10
		dc.b $86 ; Ü
		dc.b   2
		dc.b $81 ; Å
		dc.b $87 ; á
		dc.b $8F ; è
		dc.b $21 ; !
		dc.b   9
		dc.b $9D ; ù
		dc.b $11
		dc.b $81 ; Å
		dc.b $1D
		dc.b $94 ; î
		dc.b $83 ; É
		dc.b $23 ; #
		dc.b $98 ; ò
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b $19
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b   7
		dc.b $8E ; é
		dc.b $83 ; É
		dc.b $89 ; â
		dc.b $14
		dc.b $90 ; ê
		dc.b  $A
		dc.b $9D ; ù
		dc.b   8
		dc.b $12
		dc.b $84 ; Ñ
		dc.b $95 ; ï
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b   9
		dc.b  $C
		dc.b $8D ; ç
		dc.b $98 ; ò
		dc.b $1B
		dc.b $80 ; Ä
		dc.b   1
		dc.b $17
		dc.b $84 ; Ñ
		dc.b $94 ; î
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $1A
		dc.b $83 ; É
		dc.b $89 ; â
		dc.b   3
		dc.b $11
		dc.b $80 ; Ä
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b  $C
		dc.b $91 ; ë
		dc.b $8A ; ä
		dc.b  $C
		dc.b $19
		dc.b $89 ; â
		dc.b $8B ; ã
		dc.b $92 ; í
		dc.b $17
		dc.b $94 ; î
		dc.b $1B
		dc.b $8F ; è
		dc.b $14
		dc.b $A2 ; ¢
		dc.b   7
		dc.b  $F
		dc.b $9C ; ú
		dc.b $1A
		dc.b   3
		dc.b $99 ; ô
		dc.b $25 ; %
		dc.b $88 ; à
		dc.b $9F ; ü
		dc.b $15
		dc.b   8
		dc.b   5
		dc.b $8E ; é
		dc.b $80 ; Ä
		dc.b  $C
		dc.b   6
		dc.b   1
		dc.b $10
		dc.b $93 ; ì
		dc.b   5
		dc.b $94 ; î
		dc.b   7
		dc.b $22 ; "
		dc.b $89 ; â
		dc.b $90 ; ê
		dc.b   4
		dc.b   8
		dc.b $8A ; ä
		dc.b   9
		dc.b $96 ; ñ
		dc.b $19
		dc.b   9
		dc.b $9C ; ú
		dc.b   5
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $83 ; É
		dc.b $91 ; ë
		dc.b $84 ; Ñ
		dc.b   3
		dc.b $12
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $11
		dc.b $9C ; ú
		dc.b $85 ; Ö
		dc.b  $C
		dc.b   4
		dc.b  $B
		dc.b $8C ; å
		dc.b   3
		dc.b $10
		dc.b   1
		dc.b $8C ; å
		dc.b $83 ; É
		dc.b $23 ; #
		dc.b $8D ; ç
		dc.b $83 ; É
		dc.b $8B ; ã
		dc.b  $A
		dc.b   4
		dc.b $16
		dc.b $96 ; ñ
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   3
		dc.b  $C
		dc.b $8D ; ç
		dc.b $90 ; ê
		dc.b $82 ; Ç
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $93 ; ì
		dc.b  $A
		dc.b   6
		dc.b $86 ; Ü
		dc.b $8C ; å
		dc.b $86 ; Ü
		dc.b  $C
		dc.b $14
		dc.b $89 ; â
		dc.b $83 ; É
		dc.b $89 ; â
		dc.b  $E
		dc.b $81 ; Å
		dc.b $22 ; "
		dc.b   6
		dc.b $99 ; ô
		dc.b $81 ; Å
		dc.b   1
		dc.b   6
		dc.b  $F
		dc.b $91 ; ë
		dc.b  $B
		dc.b $80 ; Ä
		dc.b   9
		dc.b $89 ; â
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b   8
		dc.b $84 ; Ñ
		dc.b $8B ; ã
		dc.b $17
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b   9
		dc.b $89 ; â
		dc.b $9A ; ö
		dc.b $14
		dc.b   8
		dc.b   3
		dc.b $95 ; ï
		dc.b  $A
		dc.b $96 ; ñ
		dc.b $10
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $10
		dc.b   7
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b   4
		dc.b   2
		dc.b   6
		dc.b $8B ; ã
		dc.b   6
		dc.b   7
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $11
		dc.b   7
		dc.b $93 ; ì
		dc.b $96 ; ñ
		dc.b $18
		dc.b  $E
		dc.b  $E
		dc.b $9B ; õ
		dc.b $8C ; å
		dc.b $28 ; (
		dc.b $86 ; Ü
		dc.b $91 ; ë
		dc.b $88 ; à
		dc.b  $E
		dc.b $18
		dc.b $9F ; ü
		dc.b  $B
		dc.b   7
		dc.b $90 ; ê
		dc.b $12
		dc.b $94 ; î
		dc.b  $E
		dc.b $92 ; í
		dc.b $8F ; è
		dc.b $29 ; )
		dc.b $98 ; ò
		dc.b   9
		dc.b $87 ; á
		dc.b $8F ; è
		dc.b $11
		dc.b $12
		dc.b $A5 ; •
		dc.b   3
		dc.b $17
		dc.b  $C
		dc.b $84 ; Ñ
		dc.b $90 ; ê
		dc.b  $C
		dc.b  $F
		dc.b $A0 ; †
		dc.b $1E
		dc.b   5
		dc.b $82 ; Ç
		dc.b $8E ; é
		dc.b   7
		dc.b   4
		dc.b   3
		dc.b $95 ; ï
		dc.b   6
		dc.b $81 ; Å
		dc.b $13
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b $90 ; ê
		dc.b $14
		dc.b $80 ; Ä
		dc.b $94 ; î
		dc.b $89 ; â
		dc.b  $F
		dc.b   1
		dc.b   3
		dc.b   7
		dc.b   4
		dc.b   4
		dc.b $98 ; ò
		dc.b   8
		dc.b  $A
		dc.b $89 ; â
		dc.b $11
		dc.b $80 ; Ä
		dc.b $89 ; â
		dc.b   8
		dc.b $8B ; ã
		dc.b $85 ; Ö
		dc.b $13
		dc.b $89 ; â
		dc.b $83 ; É
		dc.b   1
		dc.b $84 ; Ñ
		dc.b  $B
		dc.b $83 ; É
		dc.b $8A ; ä
		dc.b   6
		dc.b $8D ; ç
		dc.b   9
		dc.b  $F
		dc.b   1
		dc.b $16
		dc.b $9F ; ü
		dc.b  $C
		dc.b   8
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b $18
		dc.b   2
		dc.b $8E ; é
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b   7
		dc.b   1
		dc.b $86 ; Ü
		dc.b $8C ; å
		dc.b $19
		dc.b $91 ; ë
		dc.b $80 ; Ä
		dc.b $8A ; ä
		dc.b $13
		dc.b $8A ; ä
		dc.b $83 ; É
		dc.b  $E
		dc.b $82 ; Ç
		dc.b  $B
		dc.b $87 ; á
		dc.b   2
		dc.b  $B
		dc.b $93 ; ì
		dc.b $81 ; Å
		dc.b  $B
		dc.b   6
		dc.b $12
		dc.b $87 ; á
		dc.b $90 ; ê
		dc.b $13
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $14
		dc.b $96 ; ñ
		dc.b  $E
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b $14
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $85 ; Ö
		dc.b $17
		dc.b   8
		dc.b $8B ; ã
		dc.b $90 ; ê
		dc.b $10
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b   7
		dc.b   5
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   9
		dc.b $87 ; á
		dc.b   6
		dc.b $93 ; ì
		dc.b   5
		dc.b $10
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b   8
		dc.b $16
		dc.b $92 ; í
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b $15
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b  $C
		dc.b $81 ; Å
		dc.b $8C ; å
		dc.b   4
		dc.b $19
		dc.b $9C ; ú
		dc.b  $E
		dc.b   8
		dc.b $80 ; Ä
		dc.b $8B ; ã
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $12
		dc.b $86 ; Ü
		dc.b $9F ; ü
		dc.b $1B
		dc.b  $C
		dc.b $8A ; ä
		dc.b   1
		dc.b $91 ; ë
		dc.b   8
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   8
		dc.b   8
		dc.b $A0 ; †
		dc.b $19
		dc.b $86 ; Ü
		dc.b $8D ; ç
		dc.b $18
		dc.b $96 ; ñ
		dc.b  $D
		dc.b $11
		dc.b $98 ; ò
		dc.b  $D
		dc.b   8
		dc.b $81 ; Å
		dc.b   7
		dc.b $8F ; è
		dc.b $1A
		dc.b   7
		dc.b $80 ; Ä
		dc.b $8C ; å
		dc.b $80 ; Ä
		dc.b $12
		dc.b $98 ; ò
		dc.b   2
		dc.b   8
		dc.b $90 ; ê
		dc.b   2
		dc.b $89 ; â
		dc.b   8
		dc.b   1
		dc.b $8E ; é
		dc.b   8
		dc.b $81 ; Å
		dc.b $1B
		dc.b $88 ; à
		dc.b $8E ; é
		dc.b $83 ; É
		dc.b $15
		dc.b $88 ; à
		dc.b $8C ; å
		dc.b $12
		dc.b   8
		dc.b $8C ; å
		dc.b $81 ; Å
		dc.b   5
		dc.b  $C
		dc.b $9A ; ö
		dc.b $84 ; Ñ
		dc.b $11
		dc.b  $B
		dc.b $8B ; ã
		dc.b   3
		dc.b $85 ; Ö
		dc.b $1A
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b $9C ; ú
		dc.b $1C
		dc.b   8
		dc.b $90 ; ê
		dc.b   4
		dc.b $89 ; â
		dc.b   4
		dc.b $80 ; Ä
		dc.b $8C ; å
		dc.b  $C
		dc.b   5
		dc.b $8A ; ä
		dc.b   5
		dc.b $11
		dc.b $98 ; ò
		dc.b $83 ; É
		dc.b $14
		dc.b $89 ; â
		dc.b  $D
		dc.b $86 ; Ü
		dc.b $9A ; ö
		dc.b $20
		dc.b   6
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $13
		dc.b   1
		dc.b   7
		dc.b $8B ; ã
		dc.b $22 ; "
		dc.b $93 ; ì
		dc.b $8E ; é
		dc.b   4
		dc.b   5
		dc.b $86 ; Ü
		dc.b  $D
		dc.b $8C ; å
		dc.b $15
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b   9
		dc.b   9
		dc.b $92 ; í
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b  $F
		dc.b $90 ; ê
		dc.b $16
		dc.b $94 ; î
		dc.b   6
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   3
		dc.b  $B
		dc.b   3
		dc.b $81 ; Å
		dc.b $90 ; ê
		dc.b   5
		dc.b $87 ; á
		dc.b $11
		dc.b   1
		dc.b   3
		dc.b $82 ; Ç
		dc.b   2
		dc.b $87 ; á
		dc.b $12
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b  $E
		dc.b $81 ; Å
		dc.b $8D ; ç
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b $86 ; Ü
		dc.b $94 ; î
		dc.b   4
		dc.b  $A
		dc.b   6
		dc.b $81 ; Å
		dc.b $8A ; ä
		dc.b  $E
		dc.b $82 ; Ç
		dc.b $8E ; é
		dc.b $85 ; Ö
		dc.b $13
		dc.b   3
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b  $F
		dc.b   3
		dc.b   5
		dc.b $8D ; ç
		dc.b   7
		dc.b  $A
		dc.b $93 ; ì
		dc.b   5
		dc.b $15
		dc.b $83 ; É
		dc.b   4
		dc.b $8B ; ã
		dc.b $92 ; í
		dc.b $1B
		dc.b $8E ; é
		dc.b   4
		dc.b   9
		dc.b  $D
		dc.b $95 ; ï
		dc.b $82 ; Ç
		dc.b   4
		dc.b  $D
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b $8F ; è
		dc.b $1E
		dc.b $88 ; à
		dc.b $9A ; ö
		dc.b   7
		dc.b $26 ; &
		dc.b $98 ; ò
		dc.b $8E ; é
		dc.b $82 ; Ç
		dc.b $12
		dc.b $15
		dc.b $9A ; ö
		dc.b   3
		dc.b   4
		dc.b $92 ; í
		dc.b   4
		dc.b   2
		dc.b $10
		dc.b  $B
		dc.b $95 ; ï
		dc.b $80 ; Ä
		dc.b $13
		dc.b   1
		dc.b $82 ; Ç
		dc.b $92 ; í
		dc.b   4
		dc.b $16
		dc.b $98 ; ò
		dc.b $83 ; É
		dc.b  $C
		dc.b  $D
		dc.b $88 ; à
		dc.b  $A
		dc.b $91 ; ë
		dc.b $87 ; á
		dc.b $1E
		dc.b $84 ; Ñ
		dc.b $8C ; å
		dc.b  $B
		dc.b $94 ; î
		dc.b   5
		dc.b  $A
		dc.b $85 ; Ö
		dc.b   9
		dc.b $9A ; ö
		dc.b $1F
		dc.b   3
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $81 ; Å
		dc.b $19
		dc.b $95 ; ï
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b $15
		dc.b   6
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b  $A
		dc.b $8D ; ç
		dc.b   9
		dc.b  $C
		dc.b $93 ; ì
		dc.b   1
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b  $D
		dc.b   2
		dc.b $8F ; è
		dc.b   7
		dc.b  $D
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b  $C
		dc.b $8D ; ç
		dc.b   7
		dc.b  $A
		dc.b $87 ; á
		dc.b $11
		dc.b $86 ; Ü
		dc.b $8F ; è
		dc.b  $F
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b  $A
		dc.b $91 ; ë
		dc.b   8
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b  $F
		dc.b $82 ; Ç
		dc.b $8E ; é
		dc.b   8
		dc.b   3
		dc.b $85 ; Ö
		dc.b   5
		dc.b   9
		dc.b $87 ; á
		dc.b   1
		dc.b $81 ; Å
		dc.b  $D
		dc.b $13
		dc.b $93 ; ì
		dc.b   2
		dc.b   5
		dc.b $8E ; é
		dc.b $14
		dc.b $8F ; è
		dc.b   3
		dc.b   5
		dc.b   3
		dc.b $80 ; Ä
		dc.b $8D ; ç
		dc.b   8
		dc.b   3
		dc.b $87 ; á
		dc.b   6
		dc.b $88 ; à
		dc.b   1
		dc.b $81 ; Å
		dc.b  $D
		dc.b   2
		dc.b $82 ; Ç
		dc.b $92 ; í
		dc.b $83 ; É
		dc.b  $E
		dc.b $12
		dc.b $89 ; â
		dc.b $8E ; é
		dc.b   9
		dc.b   6
		dc.b   7
		dc.b $93 ; ì
		dc.b $81 ; Å
		dc.b $16
		dc.b  $C
		dc.b $98 ; ò
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   9
		dc.b   8
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b  $F
		dc.b $80 ; Ä
		dc.b   5
		dc.b $81 ; Å
		dc.b $8E ; é
		dc.b   4
		dc.b   3
		dc.b   5
		dc.b $81 ; Å
		dc.b $89 ; â
		dc.b  $A
		dc.b  $F
		dc.b $9D ; ù
		dc.b $82 ; Ç
		dc.b $15
		dc.b   8
		dc.b   2
		dc.b $96 ; ñ
		dc.b   3
		dc.b   3
		dc.b   7
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   3
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   1
		dc.b $8C ; å
		dc.b  $C
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $13
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b  $E
		dc.b   8
		dc.b   9
		dc.b $91 ; ë
		dc.b $87 ; á
		dc.b $10
		dc.b   7
		dc.b $89 ; â
		dc.b   2
		dc.b $86 ; Ü
		dc.b   2
		dc.b   2
		dc.b $87 ; á
		dc.b   2
		dc.b   7
		dc.b   3
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $15
		dc.b $8D ; ç
		dc.b $83 ; É
		dc.b  $C
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b   5
		dc.b   9
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $80 ; Ä
		dc.b $10
		dc.b $88 ; à
		dc.b   3
		dc.b   4
		dc.b   8
		dc.b $93 ; ì
		dc.b   6
		dc.b $15
		dc.b $8D ; ç
		dc.b $87 ; á
		dc.b   1
		dc.b  $B
		dc.b   2
		dc.b $8A ; ä
		dc.b $83 ; É
		dc.b  $D
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b   3
		dc.b   5
		dc.b  $E
		dc.b $97 ; ó
		dc.b $12
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b $8C ; å
		dc.b $17
		dc.b   8
		dc.b $96 ; ñ
		dc.b   1
		dc.b   2
		dc.b $82 ; Ç
		dc.b   9
		dc.b $8D ; ç
		dc.b $80 ; Ä
		dc.b   9
		dc.b $84 ; Ñ
		dc.b $90 ; ê
		dc.b  $F
		dc.b  $F
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b $93 ; ì
		dc.b $12
		dc.b   8
		dc.b $8B ; ã
		dc.b   8
		dc.b $87 ; á
		dc.b   6
		dc.b $8C ; å
		dc.b $10
		dc.b $82 ; Ç
		dc.b  $B
		dc.b $88 ; à
		dc.b  $B
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b   5
		dc.b   3
		dc.b $82 ; Ç
		dc.b  $A
		dc.b $90 ; ê
		dc.b   1
		dc.b  $C
		dc.b  $E
		dc.b $9B ; õ
		dc.b   7
		dc.b   2
		dc.b $8C ; å
		dc.b   3
		dc.b $8D ; ç
		dc.b  $D
		dc.b  $F
		dc.b $8F ; è
		dc.b $85 ; Ö
		dc.b   3
		dc.b $81 ; Å
		dc.b  $C
		dc.b $88 ; à
		dc.b   2
		dc.b   4
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b   9
		dc.b  $F
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b $17
		dc.b $89 ; â
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   5
		dc.b $8E ; é
		dc.b  $D
		dc.b $84 ; Ñ
		dc.b  $F
		dc.b $82 ; Ç
		dc.b   3
		dc.b $8C ; å
		dc.b   5
		dc.b   7
		dc.b   2
		dc.b $85 ; Ö
		dc.b   5
		dc.b $87 ; á
		dc.b   6
		dc.b $86 ; Ü
		dc.b $10
		dc.b $98 ; ò
		dc.b   3
		dc.b  $B
		dc.b   1
		dc.b   1
		dc.b $92 ; í
		dc.b $82 ; Ç
		dc.b  $B
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $8D ; ç
		dc.b  $D
		dc.b $82 ; Ç
		dc.b $18
		dc.b $8F ; è
		dc.b  $A
		dc.b $8A ; ä
		dc.b   9
		dc.b $80 ; Ä
		dc.b   6
		dc.b $89 ; â
		dc.b $81 ; Å
		dc.b $10
		dc.b $8F ; è
		dc.b $11
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b  $E
		dc.b $81 ; Å
		dc.b $91 ; ë
		dc.b  $D
		dc.b $85 ; Ö
		dc.b   3
		dc.b $88 ; à
		dc.b   6
		dc.b   7
		dc.b $8E ; é
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $13
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b   5
		dc.b  $D
		dc.b   1
		dc.b $99 ; ô
		dc.b   7
		dc.b  $C
		dc.b $10
		dc.b $8C ; å
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b   6
		dc.b   6
		dc.b   4
		dc.b $85 ; Ö
		dc.b   4
		dc.b $86 ; Ü
		dc.b $17
		dc.b $84 ; Ñ
		dc.b  $C
		dc.b $81 ; Å
		dc.b $92 ; í
		dc.b  $F
		dc.b $13
		dc.b $9A ; ö
		dc.b   3
		dc.b  $F
		dc.b $8F ; è
		dc.b   8
		dc.b $8D ; ç
		dc.b   7
		dc.b   2
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b   3
		dc.b $91 ; ë
		dc.b  $F
		dc.b   4
		dc.b $8C ; å
		dc.b  $C
		dc.b   1
		dc.b $85 ; Ö
		dc.b $10
		dc.b $81 ; Å
		dc.b $89 ; â
		dc.b  $F
		dc.b   2
		dc.b   1
		dc.b $8E ; é
		dc.b   6
		dc.b $15
		dc.b   5
		dc.b $8D ; ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   3
		dc.b   9
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $89 ; â
		dc.b $83 ; É
		dc.b   6
		dc.b $8A ; ä
		dc.b $17
		dc.b $8C ; å
		dc.b   2
		dc.b   3
		dc.b $8A ; ä
		dc.b   1
		dc.b   6
		dc.b   1
		dc.b   3
		dc.b $97 ; ó
		dc.b $10
		dc.b $83 ; É
		dc.b  $E
		dc.b $8B ; ã
		dc.b   8
		dc.b   4
		dc.b $8E ; é
		dc.b $8A ; ä
		dc.b $14
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $91 ; ë
		dc.b   6
		dc.b $14
		dc.b $8F ; è
		dc.b   3
		dc.b  $D
		dc.b   2
		dc.b   9
		dc.b $8B ; ã
		dc.b $85 ; Ö
		dc.b  $B
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b $87 ; á
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b  $D
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b   1
		dc.b $87 ; á
		dc.b   6
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b   4
		dc.b   2
		dc.b   9
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b $13
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b  $A
		dc.b $82 ; Ç
		dc.b   6
		dc.b $89 ; â
		dc.b   6
		dc.b   9
		dc.b   4
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b   2
		dc.b  $A
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b   9
		dc.b  $F
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b  $B
		dc.b   1
		dc.b   4
		dc.b $8A ; ä
		dc.b $84 ; Ñ
		dc.b   9
		dc.b  $C
		dc.b $8D ; ç
		dc.b $84 ; Ñ
		dc.b  $A
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b  $A
		dc.b   2
		dc.b $86 ; Ü
		dc.b   6
		dc.b   4
		dc.b $8D ; ç
		dc.b   6
		dc.b $82 ; Ç
		dc.b   9
		dc.b  $C
		dc.b $90 ; ê
		dc.b $87 ; á
		dc.b  $F
		dc.b $87 ; á
		dc.b $80 ; Ä
		dc.b   4
		dc.b   1
		dc.b   6
		dc.b   1
		dc.b   1
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b  $F
		dc.b $83 ; É
		dc.b   7
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b  $B
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   1
		dc.b   5
		dc.b $8C ; å
		dc.b  $A
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b  $D
		dc.b  $A
		dc.b $8F ; è
		dc.b  $C
		dc.b   3
		dc.b $85 ; Ö
		dc.b $8A ; ä
		dc.b   5
		dc.b   5
		dc.b   9
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b  $D
		dc.b $84 ; Ñ
		dc.b $8B ; ã
		dc.b   9
		dc.b $80 ; Ä
		dc.b   4
		dc.b $8D ; ç
		dc.b $82 ; Ç
		dc.b  $E
		dc.b $8F ; è
		dc.b   3
		dc.b  $C
		dc.b $8D ; ç
		dc.b   8
		dc.b $84 ; Ñ
		dc.b   5
		dc.b   7
		dc.b $8A ; ä
		dc.b   1
		dc.b $8B ; ã
		dc.b $16
		dc.b $8E ; é
		dc.b   2
		dc.b   2
		dc.b $11
		dc.b   5
		dc.b $98 ; ò
		dc.b   6
		dc.b   4
		dc.b  $C
		dc.b $90 ; ê
		dc.b   5
		dc.b $83 ; É
		dc.b   3
		dc.b  $B
		dc.b $8E ; é
		dc.b   9
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b   5
		dc.b $85 ; Ö
		dc.b  $B
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b  $D
		dc.b  $A
		dc.b $80 ; Ä
		dc.b $8A ; ä
		dc.b   5
		dc.b   8
		dc.b   5
		dc.b $8C ; å
		dc.b  $A
		dc.b   2
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b   4
		dc.b  $D
		dc.b $8B ; ã
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b  $E
		dc.b $98 ; ò
		dc.b   5
		dc.b $12
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b   3
		dc.b  $E
		dc.b  $B
		dc.b $87 ; á
		dc.b $8D ; ç
		dc.b $1C
		dc.b $88 ; à
		dc.b $8F ; è
		dc.b   6
		dc.b  $E
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b  $C
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $17
		dc.b $8C ; å
		dc.b $99 ; ô
		dc.b  $B
		dc.b   9
		dc.b $83 ; É
		dc.b   3
		dc.b $8D ; ç
		dc.b $83 ; É
		dc.b $19
		dc.b $8D ; ç
		dc.b   6
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b $93 ; ì
		dc.b  $F
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   5
		dc.b   9
		dc.b $86 ; Ü
		dc.b $8C ; å
		dc.b  $A
		dc.b   6
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $8E ; é
		dc.b $81 ; Å
		dc.b $10
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $88 ; à
		dc.b   9
		dc.b $10
		dc.b $87 ; á
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $11
		dc.b $9E ; û
		dc.b $10
		dc.b  $F
		dc.b $9A ; ö
		dc.b   4
		dc.b  $A
		dc.b   9
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b   8
		dc.b   4
		dc.b $85 ; Ö
		dc.b $8B ; ã
		dc.b $82 ; Ç
		dc.b   1
		dc.b   8
		dc.b $83 ; É
		dc.b   7
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b   1
		dc.b   9
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b $8C ; å
		dc.b $1D
		dc.b $8B ; ã
		dc.b $86 ; Ü
		dc.b   6
		dc.b  $B
		dc.b $88 ; à
		dc.b   7
		dc.b $80 ; Ä
		dc.b $8A ; ä
		dc.b  $C
		dc.b   8
		dc.b $97 ; ó
		dc.b  $C
		dc.b $85 ; Ö
		dc.b   4
		dc.b   9
		dc.b $80 ; Ä
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $8B ; ã
		dc.b  $B
		dc.b   2
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $14
		dc.b $8B ; ã
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b   6
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b   1
		dc.b $85 ; Ö
		dc.b  $D
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $85 ; Ö
		dc.b  $A
		dc.b $90 ; ê
		dc.b   2
		dc.b $17
		dc.b $84 ; Ñ
		dc.b $88 ; à
		dc.b   2
		dc.b   3
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $8D ; ç
		dc.b  $B
		dc.b   4
		dc.b $82 ; Ç
		dc.b   2
		dc.b $88 ; à
		dc.b $10
		dc.b $89 ; â
		dc.b  $B
		dc.b $8D ; ç
		dc.b   5
		dc.b  $B
		dc.b $97 ; ó
		dc.b $13
		dc.b $81 ; Å
		dc.b $97 ; ó
		dc.b   5
		dc.b $80 ; Ä
		dc.b  $D
		dc.b $80 ; Ä
		dc.b $8C ; å
		dc.b $82 ; Ç
		dc.b  $F
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b  $D
		dc.b $85 ; Ö
		dc.b   8
		dc.b $81 ; Å
		dc.b   3
		dc.b   3
		dc.b $8A ; ä
		dc.b   2
		dc.b  $D
		dc.b $84 ; Ñ
		dc.b   9
		dc.b $91 ; ë
		dc.b   5
		dc.b $17
		dc.b $82 ; Ç
		dc.b $A1 ; °
		dc.b  $E
		dc.b $82 ; Ç
		dc.b  $B
		dc.b $8E ; é
		dc.b   3
		dc.b  $E
		dc.b $8F ; è
		dc.b $82 ; Ç
		dc.b   7
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   8
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b  $D
		dc.b   9
		dc.b $85 ; Ö
		dc.b $8F ; è
		dc.b $14
		dc.b $8A ; ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b   9
		dc.b   6
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b   8
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b   1
		dc.b   7
		dc.b $12
		dc.b $95 ; ï
		dc.b $87 ; á
		dc.b  $E
		dc.b  $A
		dc.b $89 ; â
		dc.b   6
		dc.b  $D
		dc.b $8F ; è
		dc.b  $B
		dc.b $8D ; ç
		dc.b   8
		dc.b   7
		dc.b $8D ; ç
		dc.b   2
		dc.b $83 ; É
		dc.b   8
		dc.b $81 ; Å
		dc.b $8F ; è
		dc.b $14
		dc.b   3
		dc.b $8F ; è
		dc.b $8A ; ä
		dc.b $18
		dc.b   1
		dc.b $81 ; Å
		dc.b $90 ; ê
		dc.b  $E
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $13
		dc.b   3
		dc.b $8E ; é
		dc.b $81 ; Å
		dc.b   7
		dc.b   2
		dc.b $8A ; ä
		dc.b $82 ; Ç
		dc.b  $A
		dc.b   3
		dc.b   6
		dc.b $8F ; è
		dc.b   1
		dc.b $15
		dc.b   3
		dc.b $90 ; ê
		dc.b $84 ; Ñ
		dc.b  $C
		dc.b  $A
		dc.b $8E ; é
		dc.b  $D
		dc.b   4
		dc.b $8F ; è
		dc.b   4
		dc.b $87 ; á
		dc.b  $E
		dc.b   3
		dc.b $94 ; î
		dc.b   7
		dc.b  $B
		dc.b $85 ; Ö
		dc.b $8C ; å
		dc.b $82 ; Ç
		dc.b  $A
		dc.b $10
		dc.b $93 ; ì
		dc.b $8A ; ä
		dc.b  $F
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b  $A
		dc.b $8A ; ä
		dc.b  $F
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b  $E
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b  $C
		dc.b   4
		dc.b $8A ; ä
		dc.b   6
		dc.b  $F
		dc.b $8A ; ä
		dc.b  $F
		dc.b $90 ; ê
		dc.b   9
		dc.b   4
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $11
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b   3
		dc.b   8
		dc.b $85 ; Ö
		dc.b $8F ; è
		dc.b $16
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b   3
		dc.b $8E ; é
		dc.b   8
		dc.b   6
		dc.b $8C ; å
		dc.b   6
		dc.b   6
		dc.b   2
		dc.b $89 ; â
		dc.b $10
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b $8C ; å
		dc.b   8
		dc.b   6
		dc.b   2
		dc.b $8A ; ä
		dc.b   3
		dc.b   7
		dc.b   4
		dc.b $8E ; é
		dc.b   6
		dc.b $13
		dc.b $89 ; â
		dc.b $81 ; Å
		dc.b $88 ; à
		dc.b   2
		dc.b   9
		dc.b $8C ; å
		dc.b   4
		dc.b  $A
		dc.b $82 ; Ç
		dc.b   6
		dc.b $83 ; É
		dc.b   7
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $91 ; ë
		dc.b $13
		dc.b   7
		dc.b $8D ; ç
		dc.b $84 ; Ñ
		dc.b $11
		dc.b   3
		dc.b $8F ; è
		dc.b $8D ; ç
		dc.b $19
		dc.b $88 ; à
		dc.b  $B
		dc.b $8A ; ä
		dc.b $83 ; É
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $94 ; î
		dc.b   8
		dc.b   7
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b  $A
		dc.b $83 ; É
		dc.b   1
		dc.b $8F ; è
		dc.b  $E
		dc.b  $A
		dc.b $8D ; ç
		dc.b   5
		dc.b   6
		dc.b  $C
		dc.b $8B ; ã
		dc.b $8E ; é
		dc.b $13
		dc.b   6
		dc.b $93 ; ì
		dc.b $11
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b   8
		dc.b $8B ; ã
		dc.b $81 ; Å
		dc.b   1
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b  $A
		dc.b $88 ; à
		dc.b   9
		dc.b $94 ; î
		dc.b  $C
		dc.b $10
		dc.b $8C ; å
		dc.b $81 ; Å
		dc.b  $B
		dc.b  $C
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b  $D
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b  $E
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $12
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b   5
		dc.b $15
		dc.b $85 ; Ö
		dc.b $95 ; ï
		dc.b $80 ; Ä
		dc.b $11
		dc.b   1
		dc.b $91 ; ë
		dc.b $80 ; Ä
		dc.b   9
		dc.b   3
		dc.b $8E ; é
		dc.b   7
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   6
		dc.b   7
		dc.b $87 ; á
		dc.b $80 ; Ä
		dc.b   9
		dc.b   7
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $12
		dc.b $81 ; Å
		dc.b   3
		dc.b $8B ; ã
		dc.b   8
		dc.b   8
		dc.b $90 ; ê
		dc.b   4
		dc.b   8
		dc.b $85 ; Ö
		dc.b   5
		dc.b   1
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   4
		dc.b $8C ; å
		dc.b $10
		dc.b $83 ; É
		dc.b $91 ; ë
		dc.b   7
		dc.b $16
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b   2
		dc.b   1
		dc.b $13
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b $1A
		dc.b   6
		dc.b $8F ; è
		dc.b $84 ; Ñ
		dc.b   1
		dc.b  $D
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b   6
		dc.b  $D
		dc.b $85 ; Ö
		dc.b $90 ; ê
		dc.b   5
		dc.b  $E
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b   6
		dc.b   6
		dc.b   1
		dc.b $8E ; é
		dc.b $81 ; Å
		dc.b   8
		dc.b   7
		dc.b $92 ; í
		dc.b  $A
		dc.b  $F
		dc.b $84 ; Ñ
		dc.b $90 ; ê
		dc.b   3
		dc.b  $B
		dc.b $8A ; ä
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b   9
		dc.b   5
		dc.b   7
		dc.b $8A ; ä
		dc.b   8
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b   5
		dc.b   3
		dc.b   7
		dc.b   7
		dc.b $83 ; É
		dc.b $89 ; â
		dc.b   7
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b  $C
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b  $C
		dc.b   3
		dc.b $85 ; Ö
		dc.b $8D ; ç
		dc.b   9
		dc.b   4
		dc.b   7
		dc.b   1
		dc.b $87 ; á
		dc.b  $D
		dc.b   2
		dc.b $8E ; é
		dc.b $81 ; Å
		dc.b   8
		dc.b   7
		dc.b $89 ; â
		dc.b   7
		dc.b   4
		dc.b $8D ; ç
		dc.b   3
		dc.b   5
		dc.b $83 ; É
		dc.b   2
		dc.b $87 ; á
		dc.b  $E
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $12
		dc.b $91 ; ë
		dc.b   5
		dc.b   7
		dc.b $8E ; é
		dc.b   7
		dc.b   4
		dc.b   8
		dc.b $94 ; î
		dc.b   5
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   2
		dc.b   8
		dc.b $92 ; í
		dc.b $84 ; Ñ
		dc.b $16
		dc.b $89 ; â
		dc.b $8C ; å
		dc.b $11
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b   4
		dc.b   5
		dc.b $80 ; Ä
		dc.b $97 ; ó
		dc.b   4
		dc.b   9
		dc.b  $E
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b  $C
		dc.b   7
		dc.b $85 ; Ö
		dc.b $92 ; í
		dc.b  $A
		dc.b $18
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b   1
		dc.b  $A
		dc.b $84 ; Ñ
		dc.b $8C ; å
		dc.b   5
		dc.b   4
		dc.b   2
		dc.b   8
		dc.b $82 ; Ç
		dc.b   3
		dc.b $8B ; ã
		dc.b $82 ; Ç
		dc.b $13
		dc.b $8E ; é
		dc.b $81 ; Å
		dc.b   8
		dc.b  $A
		dc.b $80 ; Ä
		dc.b $89 ; â
		dc.b $95 ; ï
		dc.b $14
		dc.b  $A
		dc.b $84 ; Ñ
		dc.b $8B ; ã
		dc.b $81 ; Å
		dc.b $10
		dc.b $83 ; É
		dc.b $90 ; ê
		dc.b $10
		dc.b $84 ; Ñ
		dc.b   1
		dc.b  $B
		dc.b   4
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   1
		dc.b $8A ; ä
		dc.b $10
		dc.b $8F ; è
		dc.b $83 ; É
		dc.b $1B
		dc.b $8B ; ã
		dc.b   2
		dc.b $88 ; à
		dc.b   8
		dc.b $8D ; ç
		dc.b   5
		dc.b $85 ; Ö
		dc.b  $F
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b $8A ; ä
		dc.b $13
		dc.b   7
		dc.b $8E ; é
		dc.b $88 ; à
		dc.b  $C
		dc.b $11
		dc.b $84 ; Ñ
		dc.b $90 ; ê
		dc.b  $B
		dc.b   6
		dc.b $91 ; ë
		dc.b $81 ; Å
		dc.b  $E
		dc.b $8D ; ç
		dc.b   2
		dc.b  $E
		dc.b $8C ; å
		dc.b $80 ; Ä
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b $15
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b  $A
		dc.b $20
		dc.b $99 ; ô
		dc.b $80 ; Ä
		dc.b   1
		dc.b   9
		dc.b  $F
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b  $A
		dc.b  $D
		dc.b $8C ; å
		dc.b $88 ; à
		dc.b   8
		dc.b $8A ; ä
		dc.b $11
		dc.b $87 ; á
		dc.b   6
		dc.b $85 ; Ö
		dc.b $90 ; ê
		dc.b   2
		dc.b  $A
		dc.b   4
		dc.b $95 ; ï
		dc.b $8B ; ã
		dc.b $27 ; '
		dc.b $85 ; Ö
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b   5
		dc.b  $E
		dc.b $87 ; á
		dc.b $8F ; è
		dc.b $14
		dc.b   6
		dc.b  $A
		dc.b $8D ; ç
		dc.b $83 ; É
		dc.b   4
		dc.b   5
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $10
		dc.b $86 ; Ü
		dc.b $8B ; ã
		dc.b  $A
		dc.b   6
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b  $F
		dc.b $87 ; á
		dc.b   1
		dc.b   9
		dc.b $89 ; â
		dc.b   2
		dc.b   3
		dc.b $94 ; î
		dc.b   7
		dc.b  $C
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   1
		dc.b   5
		dc.b $83 ; É
		dc.b $90 ; ê
		dc.b  $A
		dc.b  $B
		dc.b $88 ; à
		dc.b  $C
		dc.b $8E ; é
		dc.b   6
		dc.b  $C
		dc.b $8C ; å
		dc.b $83 ; É
		dc.b  $C
		dc.b $88 ; à
		dc.b   9
		dc.b $82 ; Ç
		dc.b   4
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b   9
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b  $A
		dc.b $82 ; Ç
		dc.b $89 ; â
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b  $A
		dc.b  $C
		dc.b $8F ; è
		dc.b $82 ; Ç
		dc.b   7
		dc.b   4
		dc.b $87 ; á
		dc.b   2
		dc.b   4
		dc.b $80 ; Ä
		dc.b   8
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b  $D
		dc.b   3
		dc.b $8F ; è
		dc.b  $E
		dc.b $92 ; í
		dc.b $84 ; Ñ
		dc.b $16
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b   7
		dc.b $86 ; Ü
		dc.b   3
		dc.b   1
		dc.b $84 ; Ñ
		dc.b  $C
		dc.b $81 ; Å
		dc.b   2
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b  $F
		dc.b $85 ; Ö
		dc.b $8B ; ã
		dc.b $15
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b  $A
		dc.b $84 ; Ñ
		dc.b  $E
		dc.b $8B ; ã
		dc.b $91 ; ë
		dc.b   6
		dc.b  $D
		dc.b   6
		dc.b $91 ; ë
		dc.b   5
		dc.b  $D
		dc.b $89 ; â
		dc.b $82 ; Ç
		dc.b   2
		dc.b   4
		dc.b   2
		dc.b   1
		dc.b $86 ; Ü
		dc.b   6
		dc.b   2
		dc.b $86 ; Ü
		dc.b   5
		dc.b   5
		dc.b   2
		dc.b $83 ; É
		dc.b $8A ; ä
		dc.b $11
		dc.b $83 ; É
		dc.b $8A ; ä
		dc.b   9
		dc.b $87 ; á
		dc.b   6
		dc.b   1
		dc.b $81 ; Å
		dc.b   3
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b   3
		dc.b  $A
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b   5
		dc.b  $D
		dc.b $85 ; Ö
		dc.b $94 ; î
		dc.b $11
		dc.b $14
		dc.b $8F ; è
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $16
		dc.b   2
		dc.b $92 ; í
		dc.b $80 ; Ä
		dc.b   8
		dc.b $84 ; Ñ
		dc.b   2
		dc.b   4
		dc.b   7
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b  $A
		dc.b   5
		dc.b $94 ; î
		dc.b $81 ; Å
		dc.b $19
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b   5
		dc.b $12
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b   3
		dc.b   3
		dc.b  $B
		dc.b $83 ; É
		dc.b $8E ; é
		dc.b   4
		dc.b   7
		dc.b $88 ; à
		dc.b  $E
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b   4
		dc.b $11
		dc.b $8B ; ã
		dc.b $84 ; Ñ
		dc.b   1
		dc.b $81 ; Å
		dc.b   5
		dc.b $80 ; Ä
		dc.b   2
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b   2
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b  $A
		dc.b $81 ; Å
		dc.b   4
		dc.b $82 ; Ç
		dc.b   1
		dc.b   4
		dc.b   4
		dc.b $8C ; å
		dc.b   9
		dc.b   4
		dc.b   1
		dc.b   7
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b  $D
		dc.b $84 ; Ñ
		dc.b   4
		dc.b  $D
		dc.b $8C ; å
		dc.b $85 ; Ö
		dc.b   6
		dc.b   5
		dc.b   1
		dc.b $8A ; ä
		dc.b   5
		dc.b  $C
		dc.b $92 ; í
		dc.b $85 ; Ö
		dc.b  $F
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   4
		dc.b $81 ; Å
		dc.b $8C ; å
		dc.b $82 ; Ç
		dc.b   9
		dc.b   7
		dc.b $82 ; Ç
		dc.b $92 ; í
		dc.b   5
		dc.b  $E
		dc.b $82 ; Ç
		dc.b   6
		dc.b $8D ; ç
		dc.b $86 ; Ü
		dc.b $17
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b   7
		dc.b   6
		dc.b   7
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b   3
		dc.b $81 ; Å
		dc.b   6
		dc.b $85 ; Ö
		dc.b  $D
		dc.b $8B ; ã
		dc.b $82 ; Ç
		dc.b   2
		dc.b $87 ; á
		dc.b $17
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b   5
		dc.b   7
		dc.b $80 ; Ä
		dc.b $89 ; â
		dc.b   5
		dc.b   8
		dc.b $94 ; î
		dc.b  $A
		dc.b   5
		dc.b $87 ; á
		dc.b  $D
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b   6
		dc.b $86 ; Ü
		dc.b $82 ; Ç
		dc.b   6
		dc.b $12
		dc.b $8B ; ã
		dc.b $92 ; í
		dc.b  $D
		dc.b  $A
		dc.b $84 ; Ñ
		dc.b $88 ; à
		dc.b   6
		dc.b  $C
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b  $E
		dc.b $8E ; é
		dc.b   5
		dc.b   1
		dc.b   1
		dc.b   7
		dc.b $87 ; á
		dc.b   2
		dc.b  $A
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b $91 ; ë
		dc.b $14
		dc.b  $E
		dc.b $8A ; ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   7
		dc.b $84 ; Ñ
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b  $E
		dc.b $8F ; è
		dc.b  $B
		dc.b $88 ; à
		dc.b $84 ; Ñ
		dc.b   2
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b   8
		dc.b   7
		dc.b   5
		dc.b $8D ; ç
		dc.b   6
		dc.b $11
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $10
		dc.b   4
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b  $A
		dc.b $87 ; á
		dc.b   3
		dc.b $85 ; Ö
		dc.b   4
		dc.b $83 ; É
		dc.b   1
		dc.b   8
		dc.b   4
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $8F ; è
		dc.b $10
		dc.b   3
		dc.b $86 ; Ü
		dc.b   1
		dc.b $85 ; Ö
		dc.b   4
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b   5
		dc.b $8B ; ã
		dc.b  $A
		dc.b   3
		dc.b   4
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b   3
		dc.b $10
		dc.b $87 ; á
		dc.b   3
		dc.b $8C ; å
		dc.b $13
		dc.b  $E
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b  $B
		dc.b   1
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b  $C
		dc.b $81 ; Å
		dc.b   6
		dc.b $8E ; é
		dc.b $10
		dc.b $90 ; ê
		dc.b $8C ; å
		dc.b $11
		dc.b   6
		dc.b $8A ; ä
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b   9
		dc.b   5
		dc.b $84 ; Ñ
		dc.b $88 ; à
		dc.b $81 ; Å
		dc.b  $F
		dc.b   3
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   6
		dc.b $88 ; à
		dc.b   5
		dc.b   5
		dc.b   2
		dc.b   7
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b   3
		dc.b   8
		dc.b   4
		dc.b $90 ; ê
		dc.b   3
		dc.b   2
		dc.b   7
		dc.b $8F ; è
		dc.b $82 ; Ç
		dc.b   8
		dc.b   7
		dc.b $88 ; à
		dc.b $80 ; Ä
		dc.b   7
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b   8
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   7
		dc.b $81 ; Å
		dc.b $13
		dc.b $83 ; É
		dc.b $90 ; ê
		dc.b $80 ; Ä
		dc.b   8
		dc.b   4
		dc.b   1
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $19
		dc.b $85 ; Ö
		dc.b $8F ; è
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b   8
		dc.b $85 ; Ö
		dc.b $8E ; é
		dc.b  $B
		dc.b   5
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b   7
		dc.b $84 ; Ñ
		dc.b   8
		dc.b  $D
		dc.b   3
		dc.b $91 ; ë
		dc.b $83 ; É
		dc.b  $F
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b   3
		dc.b  $C
		dc.b   3
		dc.b $81 ; Å
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b   7
		dc.b $86 ; Ü
		dc.b $10
		dc.b $8A ; ä
		dc.b $95 ; ï
		dc.b $14
		dc.b  $A
		dc.b $89 ; â
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b   1
		dc.b  $C
		dc.b   9
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b   6
		dc.b   2
		dc.b   2
		dc.b $88 ; à
		dc.b $81 ; Å
		dc.b  $A
		dc.b   9
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b   8
		dc.b $95 ; ï
		dc.b $12
		dc.b   3
		dc.b $8C ; å
		dc.b  $B
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b  $D
		dc.b $84 ; Ñ
		dc.b $8A ; ä
		dc.b   8
		dc.b   4
		dc.b   2
		dc.b $8A ; ä
		dc.b   9
		dc.b $89 ; â
		dc.b  $C
		dc.b $81 ; Å
		dc.b $8B ; ã
		dc.b   2
		dc.b   7
		dc.b  $C
		dc.b   8
		dc.b $8D ; ç
		dc.b $85 ; Ö
		dc.b   1
		dc.b   2
		dc.b  $B
		dc.b $88 ; à
		dc.b   4
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b $12
		dc.b $92 ; í
		dc.b $84 ; Ñ
		dc.b   6
		dc.b  $E
		dc.b $8F ; è
		dc.b   1
		dc.b   1
		dc.b   5
		dc.b $86 ; Ü
		dc.b   3
		dc.b   2
		dc.b $87 ; á
		dc.b   6
		dc.b $8D ; ç
		dc.b $16
		dc.b   9
		dc.b $9A ; ö
		dc.b $82 ; Ç
		dc.b $16
		dc.b $89 ; â
		dc.b   8
		dc.b $8C ; å
		dc.b   6
		dc.b  $C
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b   1
		dc.b   7
		dc.b   1
		dc.b   2
		dc.b $88 ; à
		dc.b $80 ; Ä
		dc.b   5
		dc.b   3
		dc.b   1
		dc.b   6
		dc.b $8A ; ä
		dc.b $83 ; É
		dc.b   5
		dc.b $10
		dc.b   1
		dc.b $92 ; í
		dc.b $88 ; à
		dc.b  $F
		dc.b   4
		dc.b $87 ; á
		dc.b   2
		dc.b   2
		dc.b   9
		dc.b   3
		dc.b $94 ; î
		dc.b  $E
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b   7
		dc.b   6
		dc.b $88 ; à
		dc.b $82 ; Ç
		dc.b   8
		dc.b   6
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b   3
		dc.b   5
		dc.b   9
		dc.b $8D ; ç
		dc.b   1
		dc.b  $D
		dc.b $8C ; å
		dc.b   3
		dc.b $81 ; Å
		dc.b   1
		dc.b  $D
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   2
		dc.b   1
		dc.b   3
		dc.b $83 ; É
		dc.b   3
		dc.b   6
		dc.b $88 ; à
		dc.b $80 ; Ä
		dc.b   5
		dc.b  $B
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b   9
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $11
		dc.b   3
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $80 ; Ä
		dc.b   6
		dc.b   8
		dc.b $89 ; â
		dc.b   4
		dc.b $81 ; Å
		dc.b   4
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b  $B
		dc.b   1
		dc.b $87 ; á
		dc.b   3
		dc.b   7
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   7
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b  $A
		dc.b   3
		dc.b   5
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b   7
		dc.b   6
		dc.b $90 ; ê
		dc.b $11
		dc.b $82 ; Ç
		dc.b $89 ; â
		dc.b $82 ; Ç
		dc.b  $C
		dc.b   5
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b  $D
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b  $D
		dc.b $8A ; ä
		dc.b $8E ; é
		dc.b  $B
		dc.b   5
		dc.b $81 ; Å
		dc.b  $C
		dc.b $83 ; É
		dc.b $90 ; ê
		dc.b  $B
		dc.b $81 ; Å
		dc.b   2
		dc.b  $A
		dc.b $81 ; Å
		dc.b $89 ; â
		dc.b   7
		dc.b   3
		dc.b $84 ; Ñ
		dc.b   9
		dc.b   2
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b   7
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b  $B
		dc.b   1
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b   9
		dc.b   9
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b   2
		dc.b $83 ; É
		dc.b   4
		dc.b $83 ; É
		dc.b  $A
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   3
		dc.b   1
		dc.b $88 ; à
		dc.b   2
		dc.b $13
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $11
		dc.b   1
		dc.b   6
		dc.b $8F ; è
		dc.b $85 ; Ö
		dc.b   1
		dc.b   9
		dc.b $83 ; É
		dc.b $8A ; ä
		dc.b   8
		dc.b   5
		dc.b $93 ; ì
		dc.b  $B
		dc.b   2
		dc.b $81 ; Å
		dc.b   7
		dc.b $85 ; Ö
		dc.b   2
		dc.b   2
		dc.b $82 ; Ç
		dc.b   5
		dc.b   9
		dc.b   4
		dc.b $91 ; ë
		dc.b   9
		dc.b   7
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b  $A
		dc.b $8A ; ä
		dc.b   3
		dc.b $80 ; Ä
		dc.b $8A ; ä
		dc.b  $B
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   8
		dc.b $86 ; Ü
		dc.b   2
		dc.b   7
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   2
		dc.b $87 ; á
		dc.b   7
		dc.b   2
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b  $C
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b   4
		dc.b   8
		dc.b $88 ; à
		dc.b $90 ; ê
		dc.b $17
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b  $C
		dc.b $83 ; É
		dc.b $89 ; â
		dc.b   3
		dc.b $80 ; Ä
		dc.b  $E
		dc.b $84 ; Ñ
		dc.b $8C ; å
		dc.b   6
		dc.b   4
		dc.b   6
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   6
		dc.b $82 ; Ç
		dc.b   4
		dc.b   3
		dc.b $85 ; Ö
		dc.b   6
		dc.b $8A ; ä
		dc.b   6
		dc.b $83 ; É
		dc.b   5
		dc.b $85 ; Ö
		dc.b   8
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $10
		dc.b $8A ; ä
		dc.b   4
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $80 ; Ä
		dc.b   5
		dc.b $8A ; ä
		dc.b   5
		dc.b  $A
		dc.b   2
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b   7
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $81 ; Å
		dc.b   9
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $8C ; å
		dc.b $80 ; Ä
		dc.b   9
		dc.b $8A ; ä
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b   5
		dc.b   5
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b $11
		dc.b $89 ; â
		dc.b   6
		dc.b  $A
		dc.b $89 ; â
		dc.b   5
		dc.b   4
		dc.b $87 ; á
		dc.b  $A
		dc.b   2
		dc.b   3
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   2
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $8C ; å
		dc.b  $B
		dc.b   9
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b  $F
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b   1
		dc.b $80 ; Ä
		dc.b   3
		dc.b $83 ; É
		dc.b   5
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   8
		dc.b $86 ; Ü
		dc.b   8
		dc.b   4
		dc.b $88 ; à
		dc.b   3
		dc.b   3
		dc.b $88 ; à
		dc.b   9
		dc.b  $B
		dc.b $8A ; ä
		dc.b   1
		dc.b   8
		dc.b $85 ; Ö
		dc.b   3
		dc.b $8B ; ã
		dc.b $84 ; Ñ
		dc.b   6
		dc.b   4
		dc.b   4
		dc.b   6
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b   5
		dc.b   6
		dc.b   4
		dc.b $8A ; ä
		dc.b   2
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $8C ; å
		dc.b   2
		dc.b   2
		dc.b  $B
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   8
		dc.b   2
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b   8
		dc.b   8
		dc.b $89 ; â
		dc.b $11
		dc.b $83 ; É
		dc.b $8A ; ä
		dc.b   7
		dc.b   3
		dc.b $85 ; Ö
		dc.b   4
		dc.b $81 ; Å
		dc.b   8
		dc.b   4
		dc.b $84 ; Ñ
		dc.b $88 ; à
		dc.b   7
		dc.b  $D
		dc.b $91 ; ë
		dc.b  $B
		dc.b   6
		dc.b $8D ; ç
		dc.b   5
		dc.b $83 ; É
		dc.b   3
		dc.b $81 ; Å
		dc.b $8F ; è
		dc.b $80 ; Ä
		dc.b   6
		dc.b   9
		dc.b   1
		dc.b $8D ; ç
		dc.b $82 ; Ç
		dc.b   8
		dc.b   2
		dc.b   2
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b  $D
		dc.b   5
		dc.b $88 ; à
		dc.b $81 ; Å
		dc.b  $C
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   4
		dc.b   1
		dc.b $87 ; á
		dc.b   7
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b   2
		dc.b $87 ; á
		dc.b   5
		dc.b  $A
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   6
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   9
		dc.b   2
		dc.b $82 ; Ç
		dc.b   1
		dc.b   1
		dc.b $8C ; å
		dc.b $11
		dc.b   6
		dc.b $8F ; è
		dc.b   1
		dc.b   2
		dc.b   6
		dc.b   2
		dc.b   2
		dc.b $8C ; å
		dc.b   2
		dc.b  $B
		dc.b   5
		dc.b $90 ; ê
		dc.b   5
		dc.b   9
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   1
		dc.b  $B
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b   4
		dc.b   1
		dc.b $85 ; Ö
		dc.b   9
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   7
		dc.b $80 ; Ä
		dc.b $89 ; â
		dc.b  $E
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b   1
		dc.b $85 ; Ö
		dc.b  $C
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   3
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b   5
		dc.b   4
		dc.b $82 ; Ç
		dc.b   2
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   3
		dc.b   5
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b   4
		dc.b  $E
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b   1
		dc.b   3
		dc.b $83 ; É
		dc.b   1
		dc.b  $A
		dc.b $88 ; à
		dc.b   2
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   6
		dc.b $80 ; Ä
		dc.b $8A ; ä
		dc.b   9
		dc.b   3
		dc.b $88 ; à
		dc.b   5
		dc.b   8
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b  $A
		dc.b   2
		dc.b $85 ; Ö
		dc.b   8
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b   7
		dc.b   4
		dc.b $83 ; É
		dc.b   2
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b   4
		dc.b   2
		dc.b   6
		dc.b   6
		dc.b $8E ; é
		dc.b   9
		dc.b $80 ; Ä
		dc.b   3
		dc.b $85 ; Ö
		dc.b   8
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b   2
		dc.b $83 ; É
		dc.b   5
		dc.b   6
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b   6
		dc.b  $F
		dc.b $84 ; Ñ
		dc.b $8C ; å
		dc.b   2
		dc.b   5
		dc.b $80 ; Ä
		dc.b   6
		dc.b   1
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b   4
		dc.b   4
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   5
		dc.b $8A ; ä
		dc.b   4
		dc.b $85 ; Ö
		dc.b   5
		dc.b $10
		dc.b $8E ; é
		dc.b   2
		dc.b $80 ; Ä
		dc.b   4
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   8
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b  $C
		dc.b $82 ; Ç
		dc.b   1
		dc.b   4
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   5
		dc.b $83 ; É
		dc.b   1
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b   4
		dc.b   3
		dc.b   6
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b   8
		dc.b   3
		dc.b $84 ; Ñ
		dc.b   5
		dc.b $8B ; ã
		dc.b  $E
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   4
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b  $C
		dc.b $8C ; å
		dc.b   1
		dc.b   8
		dc.b $89 ; â
		dc.b   2
		dc.b   8
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   2
		dc.b   5
		dc.b $86 ; Ü
		dc.b   7
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   6
		dc.b   2
		dc.b   2
		dc.b   6
		dc.b $8C ; å
		dc.b $85 ; Ö
		dc.b   5
		dc.b  $A
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b   8
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $88 ; à
		dc.b $84 ; Ñ
		dc.b $11
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $85 ; Ö
		dc.b   9
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b   7
		dc.b   3
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   9
		dc.b $83 ; É
		dc.b   4
		dc.b   9
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b   5
		dc.b   6
		dc.b   3
		dc.b   2
		dc.b $88 ; à
		dc.b   5
		dc.b $87 ; á
		dc.b   4
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $88 ; à
		dc.b   3
		dc.b   6
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $81 ; Å
		dc.b   1
		dc.b $84 ; Ñ
		dc.b  $B
		dc.b   3
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b   9
		dc.b   3
		dc.b   5
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   8
		dc.b $8B ; ã
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b  $B
		dc.b   2
		dc.b $8D ; ç
		dc.b   3
		dc.b   3
		dc.b   1
		dc.b $88 ; à
		dc.b   3
		dc.b   7
		dc.b $87 ; á
		dc.b   1
		dc.b   5
		dc.b   1
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b   6
		dc.b   3
		dc.b $81 ; Å
		dc.b   3
		dc.b $81 ; Å
		dc.b   5
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b   7
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   4
		dc.b   6
		dc.b   2
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b   3
		dc.b   6
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b  $B
		dc.b $85 ; Ö
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b   3
		dc.b $82 ; Ç
		dc.b   6
		dc.b $82 ; Ç
		dc.b   6
		dc.b $80 ; Ä
		dc.b   5
		dc.b $86 ; Ü
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   9
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b   3
		dc.b   5
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   8
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b   6
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b   5
		dc.b $87 ; á
		dc.b   4
		dc.b   4
		dc.b $83 ; É
		dc.b   2
		dc.b   2
		dc.b $83 ; É
		dc.b   7
		dc.b   8
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b   5
		dc.b $83 ; É
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b  $E
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b   5
		dc.b $83 ; É
		dc.b   6
		dc.b   5
		dc.b $88 ; à
		dc.b   6
		dc.b $86 ; Ü
		dc.b   2
		dc.b   5
		dc.b $81 ; Å
		dc.b   3
		dc.b   2
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b  $B
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b   2
		dc.b   3
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   6
		dc.b   2
		dc.b $88 ; à
		dc.b $80 ; Ä
		dc.b   1
		dc.b   8
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b   6
		dc.b $83 ; É
		dc.b   3
		dc.b   5
		dc.b $84 ; Ñ
		dc.b   4
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   7
		dc.b $87 ; á
		dc.b   4
		dc.b   3
		dc.b   4
		dc.b $87 ; á
		dc.b $83 ; É
		dc.b   8
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b   5
		dc.b $82 ; Ç
		dc.b   5
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b   5
		dc.b   4
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   2
		dc.b   3
		dc.b   5
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   2
		dc.b $81 ; Å
		dc.b   8
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b   9
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b $80 ; Ä
		dc.b   4
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   4
		dc.b $80 ; Ä
		dc.b   3
		dc.b $8A ; ä
		dc.b   2
		dc.b   5
		dc.b $81 ; Å
		dc.b   3
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b   6
		dc.b   2
		dc.b $83 ; É
		dc.b   6
		dc.b   7
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b   6
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   7
		dc.b $81 ; Å
		dc.b $87 ; á
		dc.b $80 ; Ä
		dc.b   6
		dc.b $81 ; Å
		dc.b   4
		dc.b $86 ; Ü
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   4
		dc.b   2
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b   6
		dc.b   1
		dc.b $83 ; É
		dc.b   4
		dc.b $82 ; Ç
		dc.b   4
		dc.b $83 ; É
		dc.b   9
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b  $C
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b   2
		dc.b $83 ; É
		dc.b   7
		dc.b   1
		dc.b $83 ; É
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   9
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b   7
		dc.b   4
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   9
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $82 ; Ç
		dc.b   4
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b   2
		dc.b $8A ; ä
		dc.b   6
		dc.b   6
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b  $A
		dc.b $89 ; â
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $8B ; ã
		dc.b $80 ; Ä
		dc.b   8
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   4
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   1
		dc.b   5
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   2
		dc.b   4
		dc.b   3
		dc.b $89 ; â
		dc.b   4
		dc.b   4
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b   7
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   3
		dc.b $81 ; Å
		dc.b   3
		dc.b $85 ; Ö
		dc.b   8
		dc.b $81 ; Å
		dc.b $88 ; à
		dc.b   6
		dc.b  $A
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b   6
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   6
		dc.b $83 ; É
		dc.b   1
		dc.b   3
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b  $B
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   1
		dc.b $82 ; Ç
		dc.b   3
		dc.b   5
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b   8
		dc.b   3
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b   5
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b   3
		dc.b   4
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   8
		dc.b   4
		dc.b $87 ; á
		dc.b   5
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b   7
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b  $C
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   2
		dc.b   4
		dc.b   1
		dc.b $81 ; Å
		dc.b   5
		dc.b   3
		dc.b $80 ; Ä
		dc.b   1
		dc.b $85 ; Ö
		dc.b   1
		dc.b   4
		dc.b $85 ; Ö
		dc.b   1
		dc.b $82 ; Ç
		dc.b $89 ; â
		dc.b   3
		dc.b  $A
		dc.b   1
		dc.b $8C ; å
		dc.b   4
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   8
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   4
		dc.b   1
		dc.b   3
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   6
		dc.b   2
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   2
		dc.b   1
		dc.b   4
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b   8
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   2
		dc.b   4
		dc.b $81 ; Å
		dc.b $88 ; à
		dc.b   5
		dc.b $80 ; Ä
		dc.b   4
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   4
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b   1
		dc.b $82 ; Ç
		dc.b   4
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   1
		dc.b   8
		dc.b $84 ; Ñ
		dc.b   4
		dc.b   2
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b   6
		dc.b   4
		dc.b   2
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b   4
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   3
		dc.b   1
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   9
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   3
		dc.b   1
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b   8
		dc.b   3
		dc.b $87 ; á
		dc.b   4
		dc.b $86 ; Ü
		dc.b   4
		dc.b   8
		dc.b   2
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b   7
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   4
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b $88 ; à
		dc.b   5
		dc.b   3
		dc.b   4
		dc.b $87 ; á
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b   3
		dc.b $83 ; É
		dc.b   2
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   5
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   4
		dc.b $87 ; á
		dc.b   6
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b $81 ; Å
		dc.b   4
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b   6
		dc.b   3
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b $81 ; Å
		dc.b  $A
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b   3
		dc.b   1
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b   8
		dc.b   3
		dc.b   2
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b   3
		dc.b   8
		dc.b   1
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b   8
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b   2
		dc.b  $C
		dc.b $83 ; É
		dc.b $8B ; ã
		dc.b   7
		dc.b   4
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b $85 ; Ö
		dc.b   8
		dc.b   1
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   8
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b   1
		dc.b   2
		dc.b   5
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   3
		dc.b $82 ; Ç
		dc.b   3
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b   5
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   6
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b  $A
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b   5
		dc.b $80 ; Ä
		dc.b   3
		dc.b $81 ; Å
		dc.b   1
		dc.b   7
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   5
		dc.b   2
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   6
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   2
		dc.b   6
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b   3
		dc.b   4
		dc.b   2
		dc.b   1
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b   5
		dc.b   5
		dc.b $84 ; Ñ
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   3
		dc.b   2
		dc.b   4
		dc.b $86 ; Ü
		dc.b   2
		dc.b   7
		dc.b $83 ; É
		dc.b   2
		dc.b $83 ; É
		dc.b   5
		dc.b   3
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b   4
		dc.b   2
		dc.b   1
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b $83 ; É
		dc.b   3
		dc.b   3
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   6
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   2
		dc.b   6
		dc.b $80 ; Ä
		dc.b   1
		dc.b $83 ; É
		dc.b   1
		dc.b $81 ; Å
		dc.b   3
		dc.b   1
		dc.b $86 ; Ü
		dc.b   8
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b   1
		dc.b $82 ; Ç
		dc.b   5
		dc.b   1
		dc.b $83 ; É
		dc.b   3
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   4
		dc.b $81 ; Å
		dc.b   1
		dc.b $83 ; É
		dc.b   4
		dc.b   4
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b $81 ; Å
		dc.b   4
		dc.b   3
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   2
		dc.b   5
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   3
		dc.b   3
		dc.b $87 ; á
		dc.b   6
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   1
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   2
		dc.b   4
		dc.b $81 ; Å
		dc.b $88 ; à
		dc.b $80 ; Ä
		dc.b   8
		dc.b   4
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b   2
		dc.b   3
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b   1
		dc.b   5
		dc.b   2
		dc.b   2
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   1
		dc.b   4
		dc.b   7
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b   6
		dc.b   2
		dc.b $82 ; Ç
		dc.b   1
		dc.b $82 ; Ç
		dc.b   4
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   4
		dc.b   5
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   5
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   1
		dc.b   3
		dc.b   4
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   4
		dc.b   3
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   4
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   1
		dc.b   5
		dc.b   4
		dc.b $89 ; â
		dc.b $81 ; Å
		dc.b   7
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   3
		dc.b   1
		dc.b $82 ; Ç
		dc.b   3
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   3
		dc.b   3
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   3
		dc.b $82 ; Ç
		dc.b   1
		dc.b   4
		dc.b $81 ; Å
		dc.b   4
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b   7
		dc.b   1
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b $82 ; Ç
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   1
		dc.b   1
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b   3
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   2
		dc.b   1
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   3
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   2
		dc.b $82 ; Ç
		dc.b   5
		dc.b $85 ; Ö
		dc.b   1
		dc.b   2
		dc.b   4
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b   3
		dc.b $80 ; Ä
		dc.b   1
		dc.b   5
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   2
		dc.b $82 ; Ç
		dc.b   4
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   2
		dc.b $81 ; Å
		dc.b   4
		dc.b   1
		dc.b $83 ; É
		dc.b   3
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b   4
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b   2
		dc.b $82 ; Ç
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   5
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   3
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   1
		dc.b   2
		dc.b   4
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   5
		dc.b   3
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   3
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b   5
		dc.b   4
		dc.b $82 ; Ç
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   2
		dc.b   3
		dc.b $82 ; Ç
		dc.b   3
		dc.b $83 ; É
		dc.b   4
		dc.b   3
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   5
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b   3
		dc.b   2
		dc.b $81 ; Å
		dc.b   3
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   4
		dc.b $81 ; Å
		dc.b   5
		dc.b   1
		dc.b $82 ; Ç
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   3
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b   3
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b   3
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   4
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   4
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   4
		dc.b   2
		dc.b   1
		dc.b   3
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b   3
		dc.b $82 ; Ç
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   3
		dc.b $82 ; Ç
		dc.b   2
		dc.b $82 ; Ç
		dc.b   1
		dc.b   4
		dc.b $84 ; Ñ
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   4
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $82 ; Ç
		dc.b   2
		dc.b   3
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   5
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   3
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b   7
		dc.b $82 ; Ç
		dc.b   2
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b   6
		dc.b   1
		dc.b $82 ; Ç
		dc.b   1
		dc.b   2
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   3
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   5
		dc.b   6
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   5
		dc.b   1
		dc.b $86 ; Ü
		dc.b   1
		dc.b   5
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   4
		dc.b   1
		dc.b $82 ; Ç
		dc.b   3
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b $82 ; Ç
		dc.b   3
		dc.b   4
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   5
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   3
		dc.b   1
		dc.b $82 ; Ç
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b   3
		dc.b   3
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   4
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   5
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b $82 ; Ç
		dc.b   4
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b   3
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $82 ; Ç
		dc.b   2
		dc.b   1
		dc.b   4
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   1
		dc.b   5
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b   5
		dc.b   1
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b   3
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b   3
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b $82 ; Ç
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $82 ; Ç
		dc.b   1
		dc.b   3
		dc.b $82 ; Ç
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   5
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   3
		dc.b $82 ; Ç
		dc.b   3
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $82 ; Ç
		dc.b   3
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b   1
		dc.b $82 ; Ç
		dc.b   2
		dc.b   2
		dc.b $82 ; Ç
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   4
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b   3
		dc.b   1
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   3
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   3
		dc.b   1
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b   3
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $83 ; É
		dc.b   2
		dc.b   3
		dc.b   2
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   3
		dc.b $82 ; Ç
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   1
		dc.b   3
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   4
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   3
		dc.b   2
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   5
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   5
		dc.b   1
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   2
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   5
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $82 ; Ç
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b   3
		dc.b $83 ; É
		dc.b   1
		dc.b   5
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b   2
		dc.b   1
		dc.b $82 ; Ç
		dc.b   3
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   4
		dc.b   1
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   3
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   3
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   3
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b   3
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   3
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   3
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   3
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b   1
		dc.b $82 ; Ç
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b   3
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   4
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b   4
		dc.b   3
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b $82 ; Ç
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   3
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   3
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   3
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   5
		dc.b $23 ; #
		dc.b $1B
		dc.b $22 ; "
		dc.b $4B ; K
		dc.b $6B ; k
		dc.b $71 ; q
		dc.b $3A ; :
		dc.b $67 ; g
		dc.b $5D ; ]
		dc.b $4D ; M
		dc.b $3F ; ?
		dc.b $5D ; ]
		dc.b $13
		dc.b $5A ; Z
		dc.b $19
		dc.b $14
		dc.b $1B
		dc.b $26 ; &
		dc.b $16
		dc.b $C6 ; ∆
		dc.b $85 ; Ö
		dc.b $A1 ; °
		dc.b $B9 ; π
		dc.b $B3 ; ≥
		dc.b $BA ; ∫
		dc.b $BE ; æ
		dc.b $C4 ; ƒ
		dc.b $DF ; ﬂ
		dc.b $C0 ; ¿
		dc.b $F1 ; Ò
		dc.b $F7 ; ˜
		dc.b $FB ; ˚
		dc.b $E4 ; ‰
		dc.b $DA ; ⁄
		dc.b $F7 ; ˜
		dc.b $E9 ; È
		dc.b $CA ;  
		dc.b $C8 ; »
		dc.b $E1 ; ·
		dc.b $BA ; ∫
		dc.b $BA ; ∫
		dc.b $D5 ; ’
		dc.b $90 ; ê
		dc.b $A4 ; §
		dc.b $99 ; ô
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $14
		dc.b  $D
		dc.b $2A ; *
		dc.b $21 ; !
		dc.b $1F
		dc.b $3F ; ?
		dc.b $31 ; 1
		dc.b $57 ; W
		dc.b $4A ; J
		dc.b $5E ; ^
		dc.b $72 ; r
		dc.b $69 ; i
		dc.b $55 ; U
		dc.b $6B ; k
		dc.b $7F ; 
		dc.b $5E ; ^
		dc.b $68 ; h
		dc.b $57 ; W
		dc.b $5E ; ^
		dc.b $47 ; G
		dc.b $3F ; ?
		dc.b $59 ; Y
		dc.b $26 ; &
		dc.b $1C
		dc.b $15
		dc.b $81 ; Å
		dc.b   6
		dc.b $98 ; ò
		dc.b $A2 ; ¢
		dc.b $BD ; Ω
		dc.b $B5 ; µ
		dc.b $B2 ; ≤
		dc.b $D7 ; ◊
		dc.b $DD ; ›
		dc.b $F2 ; Ú
		dc.b $EE ; Ó
		dc.b $F4 ; Ù
		dc.b $E8 ; Ë
		dc.b $FC ; ¸
		dc.b $F5 ; ı
		dc.b $F5 ; ı
		dc.b $E1 ; ·
		dc.b $E5 ; Â
		dc.b $E1 ; ·
		dc.b $DD ; ›
		dc.b $C1 ; ¡
		dc.b $BF ; ø
		dc.b $A7 ; ß
		dc.b $A9 ; ©
		dc.b $97 ; ó
		dc.b $A4 ; §
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $14
		dc.b $20
		dc.b $31 ; 1
		dc.b $33 ; 3
		dc.b $38 ; 8
		dc.b $47 ; G
		dc.b $4A ; J
		dc.b $64 ; d
		dc.b $5B ; [
		dc.b $4E ; N
		dc.b $5F ; _
		dc.b $61 ; a
		dc.b $55 ; U
		dc.b $5E ; ^
		dc.b $59 ; Y
		dc.b $4A ; J
		dc.b $3E ; >
		dc.b $4D ; M
		dc.b $4A ; J
		dc.b $33 ; 3
		dc.b $25 ; %
		dc.b $29 ; )
		dc.b $1D
		dc.b $18
		dc.b   6
		dc.b   8
		dc.b $98 ; ò
		dc.b $8F ; è
		dc.b $9F ; ü
		dc.b $9F ; ü
		dc.b $A8 ; ®
		dc.b $A6 ; ¶
		dc.b $C1 ; ¡
		dc.b $C0 ; ¿
		dc.b $CA ;  
		dc.b $CC ; Ã
		dc.b $D3 ; ”
		dc.b $E6 ; Ê
		dc.b $DD ; ›
		dc.b $D8 ; ÿ
		dc.b $D3 ; ”
		dc.b $E3 ; „
		dc.b $D5 ; ’
		dc.b $D6 ; ÷
		dc.b $D1 ; —
		dc.b $CB ; À
		dc.b $C1 ; ¡
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $9D ; ù
		dc.b $92 ; í
		dc.b $8D ; ç
		dc.b   4
		dc.b  $F
		dc.b $11
		dc.b $20
		dc.b $35 ; 5
		dc.b $38 ; 8
		dc.b $41 ; A
		dc.b $4B ; K
		dc.b $51 ; Q
		dc.b $58 ; X
		dc.b $5F ; _
		dc.b $5F ; _
		dc.b $62 ; b
		dc.b $62 ; b
		dc.b $59 ; Y
		dc.b $5D ; ]
		dc.b $4E ; N
		dc.b $5D ; ]
		dc.b $47 ; G
		dc.b $3B ; ;
		dc.b $46 ; F
		dc.b $37 ; 7
		dc.b $33 ; 3
		dc.b $22 ; "
		dc.b $1A
		dc.b  $B
		dc.b $80 ; Ä
		dc.b   8
		dc.b $8B ; ã
		dc.b $9C ; ú
		dc.b $A2 ; ¢
		dc.b $B6 ; ∂
		dc.b $BA ; ∫
		dc.b $BB ; ª
		dc.b $BE ; æ
		dc.b $CB ; À
		dc.b $D4 ; ‘
		dc.b $D0 ; –
		dc.b $D9 ; Ÿ
		dc.b $CE ; Œ
		dc.b $D3 ; ”
		dc.b $D0 ; –
		dc.b $DB ; €
		dc.b $D0 ; –
		dc.b $CD ; Õ
		dc.b $C5 ; ≈
		dc.b $CA ;  
		dc.b $C4 ; ƒ
		dc.b $BD ; Ω
		dc.b $B1 ; ±
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $92 ; í
		dc.b $96 ; ñ
		dc.b $8D ; ç
		dc.b   8
		dc.b  $E
		dc.b $14
		dc.b $18
		dc.b $29 ; )
		dc.b $36 ; 6
		dc.b $39 ; 9
		dc.b $44 ; D
		dc.b $4C ; L
		dc.b $4D ; M
		dc.b $52 ; R
		dc.b $5D ; ]
		dc.b $51 ; Q
		dc.b $59 ; Y
		dc.b $58 ; X
		dc.b $55 ; U
		dc.b $58 ; X
		dc.b $50 ; P
		dc.b $45 ; E
		dc.b $49 ; I
		dc.b $3D ; =
		dc.b $2F ; /
		dc.b $2F ; /
		dc.b $25 ; %
		dc.b $1D
		dc.b  $F
		dc.b  $B
		dc.b $87 ; á
		dc.b $92 ; í
		dc.b $94 ; î
		dc.b $99 ; ô
		dc.b $A8 ; ®
		dc.b $B9 ; π
		dc.b $B6 ; ∂
		dc.b $BF ; ø
		dc.b $C2 ; ¬
		dc.b $CE ; Œ
		dc.b $D6 ; ÷
		dc.b $CC ; Ã
		dc.b $D2 ; “
		dc.b $D2 ; “
		dc.b $D0 ; –
		dc.b $CC ; Ã
		dc.b $D4 ; ‘
		dc.b $CD ; Õ
		dc.b $CD ; Õ
		dc.b $C3 ; √
		dc.b $B9 ; π
		dc.b $B7 ; ∑
		dc.b $A7 ; ß
		dc.b $B0 ; ∞
		dc.b $97 ; ó
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $87 ; á
		dc.b  $A
		dc.b  $D
		dc.b $1B
		dc.b $24 ; $
		dc.b $29 ; )
		dc.b $2F ; /
		dc.b $35 ; 5
		dc.b $40 ; @
		dc.b $4A ; J
		dc.b $46 ; F
		dc.b $46 ; F
		dc.b $4F ; O
		dc.b $4E ; N
		dc.b $51 ; Q
		dc.b $4F ; O
		dc.b $52 ; R
		dc.b $4C ; L
		dc.b $48 ; H
		dc.b $43 ; C
		dc.b $39 ; 9
		dc.b $38 ; 8
		dc.b $3A ; :
		dc.b $32 ; 2
		dc.b $27 ; '
		dc.b $1E
		dc.b $1A
		dc.b $16
		dc.b  $D
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b $94 ; î
		dc.b $9C ; ú
		dc.b $9F ; ü
		dc.b $AB ; ´
		dc.b $B5 ; µ
		dc.b $BB ; ª
		dc.b $BE ; æ
		dc.b $C0 ; ¿
		dc.b $C3 ; √
		dc.b $CB ; À
		dc.b $CA ;  
		dc.b $CA ;  
		dc.b $D1 ; —
		dc.b $D0 ; –
		dc.b $CF ; œ
		dc.b $C5 ; ≈
		dc.b $C6 ; ∆
		dc.b $BE ; æ
		dc.b $B0 ; ∞
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $A1 ; °
		dc.b $98 ; ò
		dc.b $8F ; è
		dc.b $85 ; Ö
		dc.b   6
		dc.b  $C
		dc.b $14
		dc.b $19
		dc.b $24 ; $
		dc.b $27 ; '
		dc.b $33 ; 3
		dc.b $36 ; 6
		dc.b $36 ; 6
		dc.b $40 ; @
		dc.b $48 ; H
		dc.b $4E ; N
		dc.b $4B ; K
		dc.b $4B ; K
		dc.b $4E ; N
		dc.b $4A ; J
		dc.b $4D ; M
		dc.b $4C ; L
		dc.b $45 ; E
		dc.b $3F ; ?
		dc.b $3B ; ;
		dc.b $39 ; 9
		dc.b $2C ; ,
		dc.b $2C ; ,
		dc.b $24 ; $
		dc.b $1D
		dc.b  $E
		dc.b  $A
		dc.b   1
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b $97 ; ó
		dc.b $9D ; ù
		dc.b $9E ; û
		dc.b $A3 ; £
		dc.b $AD ; ≠
		dc.b $B6 ; ∂
		dc.b $B7 ; ∑
		dc.b $B8 ; ∏
		dc.b $BD ; Ω
		dc.b $BF ; ø
		dc.b $BE ; æ
		dc.b $C2 ; ¬
		dc.b $C5 ; ≈
		dc.b $C8 ; »
		dc.b $C2 ; ¬
		dc.b $C3 ; √
		dc.b $BF ; ø
		dc.b $BB ; ª
		dc.b $B7 ; ∑
		dc.b $B0 ; ∞
		dc.b $AC ; ¨
		dc.b $A4 ; §
		dc.b $A0 ; †
		dc.b $93 ; ì
		dc.b $91 ; ë
		dc.b $87 ; á
		dc.b $80 ; Ä
		dc.b  $D
		dc.b $14
		dc.b $1B
		dc.b $21 ; !
		dc.b $25 ; %
		dc.b $34 ; 4
		dc.b $38 ; 8
		dc.b $38 ; 8
		dc.b $3E ; >
		dc.b $46 ; F
		dc.b $49 ; I
		dc.b $50 ; P
		dc.b $4B ; K
		dc.b $4C ; L
		dc.b $4A ; J
		dc.b $4A ; J
		dc.b $47 ; G
		dc.b $42 ; B
		dc.b $3D ; =
		dc.b $37 ; 7
		dc.b $2F ; /
		dc.b $28 ; (
		dc.b $25 ; %
		dc.b $1D
		dc.b $16
		dc.b   8
		dc.b   4
		dc.b $82 ; Ç
		dc.b $89 ; â
		dc.b $95 ; ï
		dc.b $99 ; ô
		dc.b $A4 ; §
		dc.b $A8 ; ®
		dc.b $A9 ; ©
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B8 ; ∏
		dc.b $C1 ; ¡
		dc.b $C1 ; ¡
		dc.b $C3 ; √
		dc.b $C1 ; ¡
		dc.b $C0 ; ¿
		dc.b $C2 ; ¬
		dc.b $C1 ; ¡
		dc.b $BD ; Ω
		dc.b $BB ; ª
		dc.b $B6 ; ∂
		dc.b $B7 ; ∑
		dc.b $AC ; ¨
		dc.b $A9 ; ©
		dc.b $A4 ; §
		dc.b $98 ; ò
		dc.b $95 ; ï
		dc.b $8C ; å
		dc.b $87 ; á
		dc.b $80 ; Ä
		dc.b   3
		dc.b  $B
		dc.b $13
		dc.b $17
		dc.b $1F
		dc.b $21 ; !
		dc.b $29 ; )
		dc.b $2A ; *
		dc.b $34 ; 4
		dc.b $36 ; 6
		dc.b $40 ; @
		dc.b $44 ; D
		dc.b $42 ; B
		dc.b $46 ; F
		dc.b $42 ; B
		dc.b $43 ; C
		dc.b $42 ; B
		dc.b $45 ; E
		dc.b $3D ; =
		dc.b $38 ; 8
		dc.b $39 ; 9
		dc.b $32 ; 2
		dc.b $2B ; +
		dc.b $27 ; '
		dc.b $1B
		dc.b $13
		dc.b  $E
		dc.b   5
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b $8F ; è
		dc.b $94 ; î
		dc.b $9A ; ö
		dc.b $A0 ; †
		dc.b $A9 ; ©
		dc.b $B1 ; ±
		dc.b $B5 ; µ
		dc.b $B9 ; π
		dc.b $BC ; º
		dc.b $BF ; ø
		dc.b $BF ; ø
		dc.b $BE ; æ
		dc.b $C0 ; ¿
		dc.b $C0 ; ¿
		dc.b $C1 ; ¡
		dc.b $BE ; æ
		dc.b $BD ; Ω
		dc.b $BC ; º
		dc.b $B2 ; ≤
		dc.b $B0 ; ∞
		dc.b $A9 ; ©
		dc.b $9F ; ü
		dc.b $9D ; ù
		dc.b $98 ; ò
		dc.b $90 ; ê
		dc.b $88 ; à
		dc.b $82 ; Ç
		dc.b   8
		dc.b  $F
		dc.b $14
		dc.b $1D
		dc.b $24 ; $
		dc.b $2A ; *
		dc.b $2D ; -
		dc.b $30 ; 0
		dc.b $35 ; 5
		dc.b $34 ; 4
		dc.b $39 ; 9
		dc.b $3A ; :
		dc.b $40 ; @
		dc.b $3E ; >
		dc.b $3C ; <
		dc.b $3C ; <
		dc.b $3E ; >
		dc.b $3A ; :
		dc.b $34 ; 4
		dc.b $30 ; 0
		dc.b $2E ; .
		dc.b $28 ; (
		dc.b $26 ; &
		dc.b $1D
		dc.b $19
		dc.b $14
		dc.b  $F
		dc.b  $B
		dc.b   5
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $8D ; ç
		dc.b $95 ; ï
		dc.b $98 ; ò
		dc.b $9D ; ù
		dc.b $A2 ; ¢
		dc.b $A8 ; ®
		dc.b $AD ; ≠
		dc.b $B1 ; ±
		dc.b $B5 ; µ
		dc.b $B7 ; ∑
		dc.b $BA ; ∫
		dc.b $BB ; ª
		dc.b $BC ; º
		dc.b $BE ; æ
		dc.b $BD ; Ω
		dc.b $B8 ; ∏
		dc.b $B6 ; ∂
		dc.b $B5 ; µ
		dc.b $AE ; Æ
		dc.b $A9 ; ©
		dc.b $A5 ; •
		dc.b $9E ; û
		dc.b $97 ; ó
		dc.b $93 ; ì
		dc.b $8B ; ã
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b   6
		dc.b  $D
		dc.b $11
		dc.b $19
		dc.b $20
		dc.b $24 ; $
		dc.b $2A ; *
		dc.b $2E ; .
		dc.b $31 ; 1
		dc.b $34 ; 4
		dc.b $37 ; 7
		dc.b $38 ; 8
		dc.b $3B ; ;
		dc.b $3E ; >
		dc.b $3C ; <
		dc.b $3C ; <
		dc.b $38 ; 8
		dc.b $39 ; 9
		dc.b $33 ; 3
		dc.b $2E ; .
		dc.b $2D ; -
		dc.b $28 ; (
		dc.b $24 ; $
		dc.b $1E
		dc.b $17
		dc.b $10
		dc.b  $C
		dc.b   3
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b $8F ; è
		dc.b $93 ; ì
		dc.b $99 ; ô
		dc.b $9D ; ù
		dc.b $A0 ; †
		dc.b $A7 ; ß
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $AE ; Æ
		dc.b $B2 ; ≤
		dc.b $B4 ; ¥
		dc.b $B3 ; ≥
		dc.b $B1 ; ±
		dc.b $B4 ; ¥
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AC ; ¨
		dc.b $AD ; ≠
		dc.b $A9 ; ©
		dc.b $A6 ; ¶
		dc.b $9E ; û
		dc.b $9B ; õ
		dc.b $96 ; ñ
		dc.b $92 ; í
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b $80 ; Ä
		dc.b   2
		dc.b   8
		dc.b  $E
		dc.b $16
		dc.b $1A
		dc.b $1F
		dc.b $23 ; #
		dc.b $26 ; &
		dc.b $2A ; *
		dc.b $2F ; /
		dc.b $32 ; 2
		dc.b $34 ; 4
		dc.b $35 ; 5
		dc.b $3A ; :
		dc.b $36 ; 6
		dc.b $37 ; 7
		dc.b $35 ; 5
		dc.b $35 ; 5
		dc.b $30 ; 0
		dc.b $2C ; ,
		dc.b $28 ; (
		dc.b $23 ; #
		dc.b $22 ; "
		dc.b $1D
		dc.b $14
		dc.b $11
		dc.b  $D
		dc.b   8
		dc.b   3
		dc.b $86 ; Ü
		dc.b $8C ; å
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $97 ; ó
		dc.b $9D ; ù
		dc.b $A0 ; †
		dc.b $A6 ; ¶
		dc.b $A9 ; ©
		dc.b $AD ; ≠
		dc.b $AF ; Ø
		dc.b $B1 ; ±
		dc.b $B2 ; ≤
		dc.b $B5 ; µ
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AD ; ≠
		dc.b $AA ; ™
		dc.b $A7 ; ß
		dc.b $A2 ; ¢
		dc.b $9F ; ü
		dc.b $9A ; ö
		dc.b $97 ; ó
		dc.b $93 ; ì
		dc.b $8D ; ç
		dc.b $87 ; á
		dc.b $83 ; É
		dc.b   2
		dc.b   5
		dc.b  $A
		dc.b $11
		dc.b $17
		dc.b $1A
		dc.b $1D
		dc.b $20
		dc.b $26 ; &
		dc.b $2B ; +
		dc.b $2D ; -
		dc.b $2D ; -
		dc.b $2F ; /
		dc.b $31 ; 1
		dc.b $33 ; 3
		dc.b $34 ; 4
		dc.b $32 ; 2
		dc.b $30 ; 0
		dc.b $30 ; 0
		dc.b $2D ; -
		dc.b $29 ; )
		dc.b $26 ; &
		dc.b $24 ; $
		dc.b $1F
		dc.b $17
		dc.b $12
		dc.b  $F
		dc.b   9
		dc.b   3
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $8F ; è
		dc.b $93 ; ì
		dc.b $97 ; ó
		dc.b $9C ; ú
		dc.b $A1 ; °
		dc.b $A5 ; •
		dc.b $A7 ; ß
		dc.b $A9 ; ©
		dc.b $AB ; ´
		dc.b $AD ; ≠
		dc.b $AD ; ≠
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $AE ; Æ
		dc.b $AC ; ¨
		dc.b $AA ; ™
		dc.b $A7 ; ß
		dc.b $A5 ; •
		dc.b $A2 ; ¢
		dc.b $9F ; ü
		dc.b $9B ; õ
		dc.b $98 ; ò
		dc.b $93 ; ì
		dc.b $8F ; è
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b   1
		dc.b   6
		dc.b  $B
		dc.b $10
		dc.b $15
		dc.b $19
		dc.b $1C
		dc.b $21 ; !
		dc.b $24 ; $
		dc.b $25 ; %
		dc.b $29 ; )
		dc.b $2D ; -
		dc.b $2F ; /
		dc.b $2E ; .
		dc.b $2E ; .
		dc.b $2E ; .
		dc.b $2D ; -
		dc.b $2B ; +
		dc.b $2B ; +
		dc.b $28 ; (
		dc.b $25 ; %
		dc.b $22 ; "
		dc.b $1E
		dc.b $1C
		dc.b $17
		dc.b $13
		dc.b $10
		dc.b   9
		dc.b   5
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $88 ; à
		dc.b $8D ; ç
		dc.b $90 ; ê
		dc.b $95 ; ï
		dc.b $99 ; ô
		dc.b $9D ; ù
		dc.b $A1 ; °
		dc.b $A4 ; §
		dc.b $A4 ; §
		dc.b $A7 ; ß
		dc.b $AA ; ™
		dc.b $AC ; ¨
		dc.b $AD ; ≠
		dc.b $AD ; ≠
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $A9 ; ©
		dc.b $A7 ; ß
		dc.b $A6 ; ¶
		dc.b $A2 ; ¢
		dc.b $9C ; ú
		dc.b $9A ; ö
		dc.b $97 ; ó
		dc.b $93 ; ì
		dc.b $8E ; é
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b   2
		dc.b   7
		dc.b  $C
		dc.b $10
		dc.b $14
		dc.b $17
		dc.b $1C
		dc.b $1F
		dc.b $21 ; !
		dc.b $23 ; #
		dc.b $25 ; %
		dc.b $27 ; '
		dc.b $28 ; (
		dc.b $29 ; )
		dc.b $28 ; (
		dc.b $2A ; *
		dc.b $2A ; *
		dc.b $27 ; '
		dc.b $26 ; &
		dc.b $24 ; $
		dc.b $22 ; "
		dc.b $20
		dc.b $1E
		dc.b $1B
		dc.b $17
		dc.b $13
		dc.b $10
		dc.b  $B
		dc.b   7
		dc.b   2
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $93 ; ì
		dc.b $98 ; ò
		dc.b $99 ; ô
		dc.b $9B ; õ
		dc.b $9F ; ü
		dc.b $A4 ; §
		dc.b $A6 ; ¶
		dc.b $A7 ; ß
		dc.b $A7 ; ß
		dc.b $A8 ; ®
		dc.b $A8 ; ®
		dc.b $A9 ; ©
		dc.b $A8 ; ®
		dc.b $A7 ; ß
		dc.b $A7 ; ß
		dc.b $A5 ; •
		dc.b $A1 ; °
		dc.b $A0 ; †
		dc.b $9C ; ú
		dc.b $97 ; ó
		dc.b $94 ; î
		dc.b $90 ; ê
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   4
		dc.b   9
		dc.b  $D
		dc.b $10
		dc.b $14
		dc.b $19
		dc.b $1C
		dc.b $1F
		dc.b $22 ; "
		dc.b $25 ; %
		dc.b $27 ; '
		dc.b $29 ; )
		dc.b $29 ; )
		dc.b $29 ; )
		dc.b $28 ; (
		dc.b $26 ; &
		dc.b $26 ; &
		dc.b $27 ; '
		dc.b $24 ; $
		dc.b $20
		dc.b $1E
		dc.b $1C
		dc.b $19
		dc.b $16
		dc.b $13
		dc.b  $E
		dc.b  $A
		dc.b   7
		dc.b   3
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $8C ; å
		dc.b $90 ; ê
		dc.b $93 ; ì
		dc.b $96 ; ñ
		dc.b $9A ; ö
		dc.b $9D ; ù
		dc.b $9E ; û
		dc.b $A1 ; °
		dc.b $A2 ; ¢
		dc.b $A5 ; •
		dc.b $A5 ; •
		dc.b $A6 ; ¶
		dc.b $A5 ; •
		dc.b $A6 ; ¶
		dc.b $A6 ; ¶
		dc.b $A3 ; £
		dc.b $A3 ; £
		dc.b $A0 ; †
		dc.b $9D ; ù
		dc.b $9A ; ö
		dc.b $98 ; ò
		dc.b $96 ; ñ
		dc.b $92 ; í
		dc.b $8E ; é
		dc.b $8A ; ä
		dc.b $87 ; á
		dc.b $83 ; É
		dc.b   1
		dc.b   5
		dc.b   8
		dc.b  $C
		dc.b $10
		dc.b $14
		dc.b $17
		dc.b $1A
		dc.b $1C
		dc.b $20
		dc.b $23 ; #
		dc.b $24 ; $
		dc.b $24 ; $
		dc.b $27 ; '
		dc.b $28 ; (
		dc.b $28 ; (
		dc.b $27 ; '
		dc.b $26 ; &
		dc.b $24 ; $
		dc.b $24 ; $
		dc.b $21 ; !
		dc.b $1F
		dc.b $1B
		dc.b $19
		dc.b $16
		dc.b $12
		dc.b  $E
		dc.b  $A
		dc.b   6
		dc.b   1
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $8F ; è
		dc.b $93 ; ì
		dc.b $96 ; ñ
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $9C ; ú
		dc.b $9E ; û
		dc.b $A1 ; °
		dc.b $A2 ; ¢
		dc.b $A3 ; £
		dc.b $A3 ; £
		dc.b $A3 ; £
		dc.b $A3 ; £
		dc.b $A2 ; ¢
		dc.b $A1 ; °
		dc.b $A0 ; †
		dc.b $9F ; ü
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $99 ; ô
		dc.b $96 ; ñ
		dc.b $93 ; ì
		dc.b $8F ; è
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   4
		dc.b   8
		dc.b  $C
		dc.b  $F
		dc.b $13
		dc.b $17
		dc.b $1A
		dc.b $1C
		dc.b $1E
		dc.b $21 ; !
		dc.b $23 ; #
		dc.b $24 ; $
		dc.b $25 ; %
		dc.b $25 ; %
		dc.b $24 ; $
		dc.b $24 ; $
		dc.b $24 ; $
		dc.b $22 ; "
		dc.b $21 ; !
		dc.b $1F
		dc.b $1C
		dc.b $1A
		dc.b $17
		dc.b $14
		dc.b $10
		dc.b  $C
		dc.b   9
		dc.b   6
		dc.b   3
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $90 ; ê
		dc.b $94 ; î
		dc.b $97 ; ó
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $9C ; ú
		dc.b $9F ; ü
		dc.b $A1 ; °
		dc.b $A1 ; °
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $A3 ; £
		dc.b $A3 ; £
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $A0 ; †
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $99 ; ô
		dc.b $96 ; ñ
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $8E ; é
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b   2
		dc.b   6
		dc.b   9
		dc.b  $D
		dc.b $10
		dc.b $12
		dc.b $15
		dc.b $19
		dc.b $1B
		dc.b $1D
		dc.b $1F
		dc.b $21 ; !
		dc.b $22 ; "
		dc.b $23 ; #
		dc.b $23 ; #
		dc.b $23 ; #
		dc.b $23 ; #
		dc.b $23 ; #
		dc.b $22 ; "
		dc.b $20
		dc.b $1D
		dc.b $1B
		dc.b $19
		dc.b $17
		dc.b $14
		dc.b $11
		dc.b  $E
		dc.b  $B
		dc.b   7
		dc.b   3
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $8C ; å
		dc.b $8F ; è
		dc.b $92 ; í
		dc.b $95 ; ï
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $9C ; ú
		dc.b $9E ; û
		dc.b $A0 ; †
		dc.b $A1 ; °
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $A1 ; °
		dc.b $A1 ; °
		dc.b $A1 ; °
		dc.b $A0 ; †
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $9A ; ö
		dc.b $98 ; ò
		dc.b $95 ; ï
		dc.b $91 ; ë
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b   1
		dc.b   4
		dc.b   7
		dc.b  $B
		dc.b  $F
		dc.b $12
		dc.b $14
		dc.b $17
		dc.b $19
		dc.b $1B
		dc.b $1D
		dc.b $1F
		dc.b $20
		dc.b $21 ; !
		dc.b $22 ; "
		dc.b $22 ; "
		dc.b $21 ; !
		dc.b $21 ; !
		dc.b $20
		dc.b $1E
		dc.b $1D
		dc.b $1C
		dc.b $19
		dc.b $16
		dc.b $14
		dc.b $11
		dc.b  $E
		dc.b  $A
		dc.b   7
		dc.b   4
		dc.b   1
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $89 ; â
		dc.b $8D ; ç
		dc.b $90 ; ê
		dc.b $93 ; ì
		dc.b $96 ; ñ
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $9C ; ú
		dc.b $9D ; ù
		dc.b $9F ; ü
		dc.b $A0 ; †
		dc.b $A0 ; †
		dc.b $A0 ; †
		dc.b $A1 ; °
		dc.b $A0 ; †
		dc.b $A0 ; †
		dc.b $9F ; ü
		dc.b $9D ; ù
		dc.b $9B ; õ
		dc.b $99 ; ô
		dc.b $96 ; ñ
		dc.b $93 ; ì
		dc.b $90 ; ê
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b   1
		dc.b   4
		dc.b   7
		dc.b  $A
		dc.b  $E
		dc.b $12
		dc.b $14
		dc.b $16
		dc.b $18
		dc.b $1A
		dc.b $1C
		dc.b $1E
		dc.b $1F
		dc.b $20
		dc.b $21 ; !
		dc.b $21 ; !
		dc.b $21 ; !
		dc.b $1F
		dc.b $1E
		dc.b $1D
		dc.b $1C
		dc.b $1A
		dc.b $18
		dc.b $15
		dc.b $14
		dc.b $11
		dc.b  $E
		dc.b  $B
		dc.b   8
		dc.b   4
		dc.b   1
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b $92 ; í
		dc.b $94 ; î
		dc.b $96 ; ñ
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $9C ; ú
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9E ; û
		dc.b $9E ; û
		dc.b $9E ; û
		dc.b $9E ; û
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9B ; õ
		dc.b $99 ; ô
		dc.b $97 ; ó
		dc.b $96 ; ñ
		dc.b $94 ; î
		dc.b $91 ; ë
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   1
		dc.b   5
		dc.b   9
		dc.b  $C
		dc.b  $E
		dc.b $11
		dc.b $14
		dc.b $16
		dc.b $18
		dc.b $1A
		dc.b $1C
		dc.b $1D
		dc.b $1E
		dc.b $1F
		dc.b $20
		dc.b $20
		dc.b $20
		dc.b $1F
		dc.b $1E
		dc.b $1D
		dc.b $1B
		dc.b $19
		dc.b $16
		dc.b $14
		dc.b $11
		dc.b  $F
		dc.b  $C
		dc.b   8
		dc.b   5
		dc.b   2
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $94 ; î
		dc.b $97 ; ó
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $9B ; õ
		dc.b $9C ; ú
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9A ; ö
		dc.b $99 ; ô
		dc.b $98 ; ò
		dc.b $96 ; ñ
		dc.b $94 ; î
		dc.b $92 ; í
		dc.b $8F ; è
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   3
		dc.b   6
		dc.b   9
		dc.b  $C
		dc.b $10
		dc.b $12
		dc.b $14
		dc.b $16
		dc.b $19
		dc.b $1B
		dc.b $1C
		dc.b $1D
		dc.b $1D
		dc.b $1D
		dc.b $1E
		dc.b $1F
		dc.b $1E
		dc.b $1D
		dc.b $1C
		dc.b $1A
		dc.b $19
		dc.b $17
		dc.b $14
		dc.b $12
		dc.b $10
		dc.b  $E
		dc.b  $A
		dc.b   7
		dc.b   4
		dc.b   1
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $94 ; î
		dc.b $96 ; ñ
		dc.b $97 ; ó
		dc.b $99 ; ô
		dc.b $9B ; õ
		dc.b $9B ; õ
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9B ; õ
		dc.b $9A ; ö
		dc.b $99 ; ô
		dc.b $98 ; ò
		dc.b $96 ; ñ
		dc.b $94 ; î
		dc.b $93 ; ì
		dc.b $90 ; ê
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   3
		dc.b   5
		dc.b   8
		dc.b  $C
		dc.b  $E
		dc.b $11
		dc.b $13
		dc.b $16
		dc.b $18
		dc.b $19
		dc.b $1B
		dc.b $1C
		dc.b $1C
		dc.b $1D
		dc.b $1D
		dc.b $1D
		dc.b $1D
		dc.b $1D
		dc.b $1B
		dc.b $1A
		dc.b $18
		dc.b $16
		dc.b $14
		dc.b $12
		dc.b  $F
		dc.b  $C
		dc.b   9
		dc.b   7
		dc.b   4
		dc.b   1
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $90 ; ê
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $96 ; ñ
		dc.b $97 ; ó
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $9B ; õ
		dc.b $9B ; õ
		dc.b $9B ; õ
		dc.b $9B ; õ
		dc.b $9A ; ö
		dc.b $9A ; ö
		dc.b $99 ; ô
		dc.b $98 ; ò
		dc.b $96 ; ñ
		dc.b $95 ; ï
		dc.b $93 ; ì
		dc.b $91 ; ë
		dc.b $8F ; è
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   3
		dc.b   6
		dc.b   9
		dc.b  $B
		dc.b  $E
		dc.b $10
		dc.b $13
		dc.b $14
		dc.b $16
		dc.b $18
		dc.b $19
		dc.b $1A
		dc.b $1B
		dc.b $1B
		dc.b $1B
		dc.b $1B
		dc.b $1B
		dc.b $1B
		dc.b $1A
		dc.b $18
		dc.b $17
		dc.b $15
		dc.b $13
		dc.b $11
		dc.b  $E
		dc.b  $C
		dc.b  $A
		dc.b   8
		dc.b   5
		dc.b   2
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b $90 ; ê
		dc.b $92 ; í
		dc.b $94 ; î
		dc.b $95 ; ï
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $9A ; ö
		dc.b $9A ; ö
		dc.b $9A ; ö
		dc.b $99 ; ô
		dc.b $98 ; ò
		dc.b $97 ; ó
		dc.b $96 ; ñ
		dc.b $95 ; ï
		dc.b $93 ; ì
		dc.b $91 ; ë
		dc.b $8F ; è
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   3
		dc.b   6
		dc.b   9
		dc.b  $B
		dc.b  $D
		dc.b  $F
		dc.b $12
		dc.b $14
		dc.b $15
		dc.b $17
		dc.b $17
		dc.b $18
		dc.b $19
		dc.b $1A
		dc.b $1A
		dc.b $1A
		dc.b $1A
		dc.b $19
		dc.b $18
		dc.b $18
		dc.b $16
		dc.b $14
		dc.b $13
		dc.b $11
		dc.b  $F
		dc.b  $C
		dc.b   9
		dc.b   7
		dc.b   5
		dc.b   2
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $96 ; ñ
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $97 ; ó
		dc.b $96 ; ñ
		dc.b $95 ; ï
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $90 ; ê
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   2
		dc.b   5
		dc.b   7
		dc.b   9
		dc.b  $B
		dc.b  $E
		dc.b $10
		dc.b $12
		dc.b $14
		dc.b $15
		dc.b $16
		dc.b $17
		dc.b $18
		dc.b $19
		dc.b $19
		dc.b $19
		dc.b $19
		dc.b $19
		dc.b $18
		dc.b $17
		dc.b $15
		dc.b $14
		dc.b $12
		dc.b $10
		dc.b  $E
		dc.b  $C
		dc.b  $B
		dc.b   8
		dc.b   5
		dc.b   3
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $95 ; ï
		dc.b $97 ; ó
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $97 ; ó
		dc.b $97 ; ó
		dc.b $96 ; ñ
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $8F ; è
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   2
		dc.b   4
		dc.b   6
		dc.b   8
		dc.b  $B
		dc.b  $D
		dc.b  $F
		dc.b $11
		dc.b $12
		dc.b $14
		dc.b $15
		dc.b $16
		dc.b $17
		dc.b $18
		dc.b $18
		dc.b $18
		dc.b $18
		dc.b $17
		dc.b $17
		dc.b $16
		dc.b $15
		dc.b $13
		dc.b $12
		dc.b $10
		dc.b  $E
		dc.b  $C
		dc.b  $A
		dc.b   8
		dc.b   6
		dc.b   4
		dc.b   1
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $95 ; ï
		dc.b $96 ; ñ
		dc.b $96 ; ñ
		dc.b $96 ; ñ
		dc.b $96 ; ñ
		dc.b $95 ; ï
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $8F ; è
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $80 ; Ä
		dc.b   2
		dc.b   4
		dc.b   6
		dc.b   8
		dc.b  $B
		dc.b  $D
		dc.b  $F
		dc.b $10
		dc.b $12
		dc.b $13
		dc.b $15
		dc.b $16
		dc.b $17
		dc.b $17
		dc.b $18
		dc.b $17
		dc.b $17
		dc.b $17
		dc.b $16
		dc.b $15
		dc.b $14
		dc.b $13
		dc.b $11
		dc.b  $F
		dc.b  $D
		dc.b  $B
		dc.b   9
		dc.b   7
		dc.b   5
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $95 ; ï
		dc.b $95 ; ï
		dc.b $95 ; ï
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b   1
		dc.b   3
		dc.b   5
		dc.b   7
		dc.b   9
		dc.b  $B
		dc.b  $D
		dc.b  $F
		dc.b $10
		dc.b $12
		dc.b $13
		dc.b $14
		dc.b $15
		dc.b $15
		dc.b $16
		dc.b $16
		dc.b $16
		dc.b $16
		dc.b $15
		dc.b $14
		dc.b $13
		dc.b $12
		dc.b $11
		dc.b $10
		dc.b  $E
		dc.b  $D
		dc.b  $A
		dc.b   9
		dc.b   6
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b   5
		dc.b   7
		dc.b   9
		dc.b  $B
		dc.b  $D
		dc.b  $E
		dc.b $10
		dc.b $11
		dc.b $12
		dc.b $14
		dc.b $14
		dc.b $15
		dc.b $15
		dc.b $15
		dc.b $15
		dc.b $15
		dc.b $14
		dc.b $14
		dc.b $13
		dc.b $12
		dc.b $11
		dc.b  $F
		dc.b  $D
		dc.b  $B
		dc.b   9
		dc.b   8
		dc.b   6
		dc.b   3
		dc.b   1
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $90 ; ê
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b   5
		dc.b   7
		dc.b   9
		dc.b  $A
		dc.b  $C
		dc.b  $E
		dc.b  $F
		dc.b $10
		dc.b $11
		dc.b $13
		dc.b $13
		dc.b $14
		dc.b $14
		dc.b $15
		dc.b $14
		dc.b $14
		dc.b $13
		dc.b $13
		dc.b $12
		dc.b $11
		dc.b  $F
		dc.b  $E
		dc.b  $D
		dc.b  $B
		dc.b   9
		dc.b   7
		dc.b   5
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $90 ; ê
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   2
		dc.b   4
		dc.b   6
		dc.b   7
		dc.b   9
		dc.b  $A
		dc.b  $C
		dc.b  $D
		dc.b  $E
		dc.b $10
		dc.b $10
		dc.b $11
		dc.b $12
		dc.b $12
		dc.b $13
		dc.b $13
		dc.b $13
		dc.b $13
		dc.b $12
		dc.b $12
		dc.b $10
		dc.b  $F
		dc.b  $E
		dc.b  $D
		dc.b  $C
		dc.b  $A
		dc.b   9
		dc.b   7
		dc.b   5
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b   5
		dc.b   6
		dc.b   8
		dc.b  $A
		dc.b  $B
		dc.b  $D
		dc.b  $E
		dc.b  $F
		dc.b $10
		dc.b $11
		dc.b $11
		dc.b $12
		dc.b $12
		dc.b $12
		dc.b $12
		dc.b $12
		dc.b $11
		dc.b $11
		dc.b $10
		dc.b  $F
		dc.b  $E
		dc.b  $D
		dc.b  $B
		dc.b  $A
		dc.b   8
		dc.b   7
		dc.b   5
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b   1
		dc.b   2
		dc.b   4
		dc.b   5
		dc.b   7
		dc.b   8
		dc.b  $A
		dc.b  $B
		dc.b  $C
		dc.b  $D
		dc.b  $E
		dc.b  $F
		dc.b $10
		dc.b $11
		dc.b $11
		dc.b $11
		dc.b $11
		dc.b $11
		dc.b $11
		dc.b $10
		dc.b  $F
		dc.b  $F
		dc.b  $E
		dc.b  $D
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b   7
		dc.b   5
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   2
		dc.b   3
		dc.b   5
		dc.b   6
		dc.b   8
		dc.b   9
		dc.b  $B
		dc.b  $C
		dc.b  $D
		dc.b  $E
		dc.b  $F
		dc.b  $F
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b $10
		dc.b  $F
		dc.b  $F
		dc.b  $E
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   5
		dc.b   4
		dc.b   2
		dc.b   1
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   8
		dc.b   9
		dc.b  $A
		dc.b  $C
		dc.b  $D
		dc.b  $D
		dc.b  $E
		dc.b  $E
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b  $F
		dc.b  $E
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b  $A
		dc.b  $B
		dc.b  $C
		dc.b  $D
		dc.b  $D
		dc.b  $E
		dc.b  $E
		dc.b  $E
		dc.b  $E
		dc.b  $E
		dc.b  $E
		dc.b  $E
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b  $A
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $D
		dc.b  $D
		dc.b  $E
		dc.b  $E
		dc.b  $E
		dc.b  $E
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $C
		dc.b  $B
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b  $A
		dc.b  $B
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $C
		dc.b  $B
		dc.b  $B
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b  $A
		dc.b  $B
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $B
		dc.b  $B
		dc.b  $A
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $B
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $B
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b  $A
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   6
		dc.b   6
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   7
		dc.b   6
		dc.b   6
		dc.b   6
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   5
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   4
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b   2
		dc.b $80 ; Ä
		dc.b   2
		dc.b $81 ; Å
		dc.b   1
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b   3
		dc.b   7
		dc.b   9
		dc.b  $A
		dc.b   8
		dc.b   9
		dc.b  $A
		dc.b  $C
		dc.b $10
		dc.b $11
		dc.b $17
		dc.b $19
		dc.b $1A
		dc.b $19
		dc.b $17
		dc.b $16
		dc.b $15
		dc.b $19
		dc.b $1B
		dc.b $21 ; !
		dc.b $22 ; "
		dc.b $21 ; !
		dc.b $1F
		dc.b $1D
		dc.b $1E
		dc.b $19
		dc.b $16
		dc.b $12
		dc.b  $E
		dc.b  $E
		dc.b  $E
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b   9
		dc.b  $A
		dc.b  $B
		dc.b  $A
		dc.b   6
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b $88 ; à
		dc.b $8C ; å
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $94 ; î
		dc.b $96 ; ñ
		dc.b $99 ; ô
		dc.b $9B ; õ
		dc.b $9C ; ú
		dc.b $9B ; õ
		dc.b $9A ; ö
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $9B ; õ
		dc.b $9D ; ù
		dc.b $9F ; ü
		dc.b $A1 ; °
		dc.b $A2 ; ¢
		dc.b $A4 ; §
		dc.b $A4 ; §
		dc.b $A4 ; §
		dc.b $A3 ; £
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $A2 ; ¢
		dc.b $A3 ; £
		dc.b $A2 ; ¢
		dc.b $A0 ; †
		dc.b $9E ; û
		dc.b $9B ; õ
		dc.b $9A ; ö
		dc.b $98 ; ò
		dc.b $96 ; ñ
		dc.b $94 ; î
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b   4
		dc.b   9
		dc.b  $D
		dc.b $12
		dc.b $17
		dc.b $1B
		dc.b $1E
		dc.b $20
		dc.b $22 ; "
		dc.b $22 ; "
		dc.b $23 ; #
		dc.b $24 ; $
		dc.b $24 ; $
		dc.b $27 ; '
		dc.b $2A ; *
		dc.b $2D ; -
		dc.b $30 ; 0
		dc.b $2F ; /
		dc.b $2D ; -
		dc.b $2B ; +
		dc.b $29 ; )
		dc.b $27 ; '
		dc.b $25 ; %
		dc.b $21 ; !
		dc.b $1D
		dc.b $19
		dc.b $15
		dc.b $13
		dc.b $12
		dc.b $14
		dc.b $18
		dc.b $1A
		dc.b $1C
		dc.b $1C
		dc.b $1C
		dc.b $1C
		dc.b $1C
		dc.b $1A
		dc.b $16
		dc.b $12
		dc.b  $F
		dc.b  $D
		dc.b  $E
		dc.b  $F
		dc.b $12
		dc.b $12
		dc.b $12
		dc.b $11
		dc.b $10
		dc.b  $E
		dc.b  $D
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b  $A
		dc.b   8
		dc.b   5
		dc.b   2
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $87 ; á
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $8E ; é
		dc.b $92 ; í
		dc.b $94 ; î
		dc.b $96 ; ñ
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $8B ; ã
		dc.b $8E ; é
		dc.b $91 ; ë
		dc.b $93 ; ì
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $94 ; î
		dc.b $98 ; ò
		dc.b $99 ; ô
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $94 ; î
		dc.b $99 ; ô
		dc.b $9E ; û
		dc.b $9F ; ü
		dc.b $A2 ; ¢
		dc.b $9E ; û
		dc.b $9E ; û
		dc.b $98 ; ò
		dc.b $97 ; ó
		dc.b $94 ; î
		dc.b $94 ; î
		dc.b $97 ; ó
		dc.b $97 ; ó
		dc.b $9A ; ö
		dc.b $96 ; ñ
		dc.b $8E ; é
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b   2
		dc.b   2
		dc.b   1
		dc.b $83 ; É
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b   4
		dc.b  $A
		dc.b $10
		dc.b $11
		dc.b $12
		dc.b $14
		dc.b $19
		dc.b $21 ; !
		dc.b $26 ; &
		dc.b $28 ; (
		dc.b $27 ; '
		dc.b $25 ; %
		dc.b $27 ; '
		dc.b $27 ; '
		dc.b $27 ; '
		dc.b $23 ; #
		dc.b $22 ; "
		dc.b $26 ; &
		dc.b $2B ; +
		dc.b $2E ; .
		dc.b $2F ; /
		dc.b $30 ; 0
		dc.b $2D ; -
		dc.b $2A ; *
		dc.b $28 ; (
		dc.b $28 ; (
		dc.b $29 ; )
		dc.b $29 ; )
		dc.b $29 ; )
		dc.b $25 ; %
		dc.b $23 ; #
		dc.b $1F
		dc.b $1A
		dc.b $15
		dc.b $12
		dc.b $11
		dc.b $12
		dc.b $14
		dc.b  $F
		dc.b  $A
		dc.b   3
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $88 ; à
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $88 ; à
		dc.b $8F ; è
		dc.b $93 ; ì
		dc.b $98 ; ò
		dc.b $9C ; ú
		dc.b $A1 ; °
		dc.b $A6 ; ¶
		dc.b $A9 ; ©
		dc.b $AA ; ™
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $AC ; ¨
		dc.b $AD ; ≠
		dc.b $AF ; Ø
		dc.b $B1 ; ±
		dc.b $B2 ; ≤
		dc.b $B2 ; ≤
		dc.b $B3 ; ≥
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B5 ; µ
		dc.b $B6 ; ∂
		dc.b $B6 ; ∂
		dc.b $B6 ; ∂
		dc.b $B5 ; µ
		dc.b $B5 ; µ
		dc.b $B4 ; ¥
		dc.b $B4 ; ¥
		dc.b $B5 ; µ
		dc.b $B6 ; ∂
		dc.b $B8 ; ∏
		dc.b $B8 ; ∏
		dc.b $B4 ; ¥
		dc.b $B0 ; ∞
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $AE ; Æ
		dc.b $B1 ; ±
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AD ; ≠
		dc.b $AB ; ´
		dc.b $A7 ; ß
		dc.b $A1 ; °
		dc.b $9D ; ù
		dc.b $9A ; ö
		dc.b $98 ; ò
		dc.b $94 ; î
		dc.b $8F ; è
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b   1
		dc.b   6
		dc.b  $B
		dc.b  $E
		dc.b  $F
		dc.b $10
		dc.b $11
		dc.b $12
		dc.b $14
		dc.b $16
		dc.b $19
		dc.b $1C
		dc.b $1E
		dc.b $21 ; !
		dc.b $26 ; &
		dc.b $2E ; .
		dc.b $37 ; 7
		dc.b $3F ; ?
		dc.b $43 ; C
		dc.b $45 ; E
		dc.b $45 ; E
		dc.b $47 ; G
		dc.b $49 ; I
		dc.b $4C ; L
		dc.b $51 ; Q
		dc.b $55 ; U
		dc.b $59 ; Y
		dc.b $5A ; Z
		dc.b $59 ; Y
		dc.b $56 ; V
		dc.b $53 ; S
		dc.b $53 ; S
		dc.b $52 ; R
		dc.b $4F ; O
		dc.b $4A ; J
		dc.b $43 ; C
		dc.b $3D ; =
		dc.b $38 ; 8
		dc.b $36 ; 6
		dc.b $35 ; 5
		dc.b $37 ; 7
		dc.b $38 ; 8
		dc.b $38 ; 8
		dc.b $38 ; 8
		dc.b $36 ; 6
		dc.b $34 ; 4
		dc.b $34 ; 4
		dc.b $32 ; 2
		dc.b $2E ; .
		dc.b $26 ; &
		dc.b $1F
		dc.b $19
		dc.b $15
		dc.b $13
		dc.b $12
		dc.b $11
		dc.b  $E
		dc.b  $B
		dc.b   7
		dc.b   3
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b $8C ; å
		dc.b $8F ; è
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $95 ; ï
		dc.b $97 ; ó
		dc.b $99 ; ô
		dc.b $9B ; õ
		dc.b $9E ; û
		dc.b $A0 ; †
		dc.b $A2 ; ¢
		dc.b $A3 ; £
		dc.b $A5 ; •
		dc.b $A6 ; ¶
		dc.b $A7 ; ß
		dc.b $A8 ; ®
		dc.b $A7 ; ß
		dc.b $A5 ; •
		dc.b $A3 ; £
		dc.b $A2 ; ¢
		dc.b $A4 ; §
		dc.b $A6 ; ¶
		dc.b $A9 ; ©
		dc.b $AB ; ´
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $AB ; ´
		dc.b $A8 ; ®
		dc.b $A5 ; •
		dc.b $A2 ; ¢
		dc.b $9F ; ü
		dc.b $9E ; û
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $9E ; û
		dc.b $9F ; ü
		dc.b $A1 ; °
		dc.b $A0 ; †
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $9B ; õ
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $96 ; ñ
		dc.b $97 ; ó
		dc.b $97 ; ó
		dc.b $99 ; ô
		dc.b $A2 ; ¢
		dc.b $A6 ; ¶
		dc.b $A7 ; ß
		dc.b $A3 ; £
		dc.b $A0 ; †
		dc.b $9A ; ö
		dc.b $9D ; ù
		dc.b $99 ; ô
		dc.b $97 ; ó
		dc.b $94 ; î
		dc.b $8F ; è
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b   1
		dc.b   2
		dc.b   6
		dc.b   7
		dc.b  $E
		dc.b  $E
		dc.b $11
		dc.b $11
		dc.b $11
		dc.b $20
		dc.b $27 ; '
		dc.b $30 ; 0
		dc.b $32 ; 2
		dc.b $35 ; 5
		dc.b $34 ; 4
		dc.b $36 ; 6
		dc.b $3A ; :
		dc.b $3E ; >
		dc.b $46 ; F
		dc.b $4C ; L
		dc.b $53 ; S
		dc.b $55 ; U
		dc.b $51 ; Q
		dc.b $4A ; J
		dc.b $43 ; C
		dc.b $45 ; E
		dc.b $49 ; I
		dc.b $4E ; N
		dc.b $52 ; R
		dc.b $50 ; P
		dc.b $4D ; M
		dc.b $45 ; E
		dc.b $3E ; >
		dc.b $36 ; 6
		dc.b $30 ; 0
		dc.b $29 ; )
		dc.b $21 ; !
		dc.b $1D
		dc.b $1C
		dc.b $1C
		dc.b $1A
		dc.b $16
		dc.b $11
		dc.b  $C
		dc.b   8
		dc.b   6
		dc.b   4
		dc.b   1
		dc.b $85 ; Ö
		dc.b $8C ; å
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $94 ; î
		dc.b $9A ; ö
		dc.b $A2 ; ¢
		dc.b $A8 ; ®
		dc.b $AB ; ´
		dc.b $AB ; ´
		dc.b $A8 ; ®
		dc.b $A7 ; ß
		dc.b $A6 ; ¶
		dc.b $A9 ; ©
		dc.b $AD ; ≠
		dc.b $B1 ; ±
		dc.b $B4 ; ¥
		dc.b $B5 ; µ
		dc.b $B3 ; ≥
		dc.b $B3 ; ≥
		dc.b $B5 ; µ
		dc.b $B8 ; ∏
		dc.b $BC ; º
		dc.b $BF ; ø
		dc.b $BF ; ø
		dc.b $C0 ; ¿
		dc.b $C2 ; ¬
		dc.b $C5 ; ≈
		dc.b $C5 ; ≈
		dc.b $C5 ; ≈
		dc.b $C4 ; ƒ
		dc.b $C5 ; ≈
		dc.b $C6 ; ∆
		dc.b $C9 ; …
		dc.b $CA ;  
		dc.b $CB ; À
		dc.b $CA ;  
		dc.b $C6 ; ∆
		dc.b $C2 ; ¬
		dc.b $C1 ; ¡
		dc.b $C1 ; ¡
		dc.b $C1 ; ¡
		dc.b $C0 ; ¿
		dc.b $BE ; æ
		dc.b $BD ; Ω
		dc.b $BB ; ª
		dc.b $B7 ; ∑
		dc.b $B5 ; µ
		dc.b $B1 ; ±
		dc.b $AE ; Æ
		dc.b $AA ; ™
		dc.b $A3 ; £
		dc.b $9A ; ö
		dc.b $91 ; ë
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b $81 ; Å
		dc.b   1
		dc.b   6
		dc.b  $B
		dc.b  $D
		dc.b  $E
		dc.b $10
		dc.b $15
		dc.b $19
		dc.b $1C
		dc.b $1E
		dc.b $23 ; #
		dc.b $29 ; )
		dc.b $31 ; 1
		dc.b $37 ; 7
		dc.b $3E ; >
		dc.b $42 ; B
		dc.b $46 ; F
		dc.b $4A ; J
		dc.b $4D ; M
		dc.b $4E ; N
		dc.b $4F ; O
		dc.b $51 ; Q
		dc.b $54 ; T
		dc.b $58 ; X
		dc.b $5D ; ]
		dc.b $62 ; b
		dc.b $67 ; g
		dc.b $69 ; i
		dc.b $68 ; h
		dc.b $63 ; c
		dc.b $5D ; ]
		dc.b $58 ; X
		dc.b $55 ; U
		dc.b $51 ; Q
		dc.b $4B ; K
		dc.b $45 ; E
		dc.b $3F ; ?
		dc.b $3A ; :
		dc.b $36 ; 6
		dc.b $35 ; 5
		dc.b $34 ; 4
		dc.b $35 ; 5
		dc.b $36 ; 6
		dc.b $38 ; 8
		dc.b $39 ; 9
		dc.b $38 ; 8
		dc.b $35 ; 5
		dc.b $30 ; 0
		dc.b $28 ; (
		dc.b $20
		dc.b $1A
		dc.b $16
		dc.b $13
		dc.b $11
		dc.b  $E
		dc.b  $A
		dc.b   6
		dc.b   2
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $91 ; ë
		dc.b $94 ; î
		dc.b $98 ; ò
		dc.b $9F ; ü
		dc.b $A6 ; ¶
		dc.b $AA ; ™
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $AA ; ™
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $AE ; Æ
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B4 ; ¥
		dc.b $B8 ; ∏
		dc.b $BA ; ∫
		dc.b $BC ; º
		dc.b $BD ; Ω
		dc.b $BB ; ª
		dc.b $B9 ; π
		dc.b $B7 ; ∑
		dc.b $B5 ; µ
		dc.b $B2 ; ≤
		dc.b $B0 ; ∞
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $AA ; ™
		dc.b $AA ; ™
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $AC ; ¨
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $AB ; ´
		dc.b $AA ; ™
		dc.b $A7 ; ß
		dc.b $A5 ; •
		dc.b $A0 ; †
		dc.b $9E ; û
		dc.b $9B ; õ
		dc.b $99 ; ô
		dc.b $9B ; õ
		dc.b $9B ; õ
		dc.b $9D ; ù
		dc.b $9C ; ú
		dc.b $9B ; õ
		dc.b $9E ; û
		dc.b $9D ; ù
		dc.b $9F ; ü
		dc.b $A2 ; ¢
		dc.b $A7 ; ß
		dc.b $A7 ; ß
		dc.b $A5 ; •
		dc.b $9E ; û
		dc.b $9B ; õ
		dc.b $94 ; î
		dc.b $91 ; ë
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b   4
		dc.b   6
		dc.b  $E
		dc.b $10
		dc.b $12
		dc.b $13
		dc.b  $F
		dc.b $10
		dc.b  $C
		dc.b  $D
		dc.b  $C
		dc.b $15
		dc.b $19
		dc.b $1E
		dc.b $1E
		dc.b $21 ; !
		dc.b $26 ; &
		dc.b $2D ; -
		dc.b $3A ; :
		dc.b $3F ; ?
		dc.b $45 ; E
		dc.b $47 ; G
		dc.b $45 ; E
		dc.b $43 ; C
		dc.b $41 ; A
		dc.b $42 ; B
		dc.b $44 ; D
		dc.b $48 ; H
		dc.b $4E ; N
		dc.b $51 ; Q
		dc.b $52 ; R
		dc.b $50 ; P
		dc.b $4C ; L
		dc.b $4A ; J
		dc.b $4C ; L
		dc.b $50 ; P
		dc.b $55 ; U
		dc.b $54 ; T
		dc.b $51 ; Q
		dc.b $4B ; K
		dc.b $47 ; G
		dc.b $40 ; @
		dc.b $37 ; 7
		dc.b $2E ; .
		dc.b $24 ; $
		dc.b $20
		dc.b $1F
		dc.b $1E
		dc.b $1C
		dc.b $18
		dc.b $13
		dc.b  $F
		dc.b  $B
		dc.b   7
		dc.b   5
		dc.b   2
		dc.b $83 ; É
		dc.b $8A ; ä
		dc.b $91 ; ë
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $92 ; í
		dc.b $95 ; ï
		dc.b $9D ; ù
		dc.b $A8 ; ®
		dc.b $B1 ; ±
		dc.b $B6 ; ∂
		dc.b $B8 ; ∏
		dc.b $B8 ; ∏
		dc.b $B9 ; π
		dc.b $BA ; ∫
		dc.b $BD ; Ω
		dc.b $C1 ; ¡
		dc.b $C5 ; ≈
		dc.b $C9 ; …
		dc.b $CB ; À
		dc.b $C9 ; …
		dc.b $C6 ; ∆
		dc.b $C5 ; ≈
		dc.b $C5 ; ≈
		dc.b $C5 ; ≈
		dc.b $C5 ; ≈
		dc.b $C4 ; ƒ
		dc.b $C4 ; ƒ
		dc.b $C6 ; ∆
		dc.b $C8 ; »
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $CA ;  
		dc.b $CB ; À
		dc.b $CB ; À
		dc.b $C8 ; »
		dc.b $C5 ; ≈
		dc.b $C1 ; ¡
		dc.b $BF ; ø
		dc.b $BF ; ø
		dc.b $C1 ; ¡
		dc.b $C2 ; ¬
		dc.b $C2 ; ¬
		dc.b $BF ; ø
		dc.b $BC ; º
		dc.b $B7 ; ∑
		dc.b $B1 ; ±
		dc.b $AC ; ¨
		dc.b $A9 ; ©
		dc.b $A4 ; §
		dc.b $9E ; û
		dc.b $97 ; ó
		dc.b $90 ; ê
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   3
		dc.b   7
		dc.b  $C
		dc.b $10
		dc.b $14
		dc.b $16
		dc.b $19
		dc.b $1A
		dc.b $1C
		dc.b $1F
		dc.b $25 ; %
		dc.b $2C ; ,
		dc.b $34 ; 4
		dc.b $3C ; <
		dc.b $43 ; C
		dc.b $4B ; K
		dc.b $52 ; R
		dc.b $56 ; V
		dc.b $57 ; W
		dc.b $56 ; V
		dc.b $56 ; V
		dc.b $58 ; X
		dc.b $5E ; ^
		dc.b $66 ; f
		dc.b $6D ; m
		dc.b $72 ; r
		dc.b $72 ; r
		dc.b $6F ; o
		dc.b $6A ; j
		dc.b $65 ; e
		dc.b $61 ; a
		dc.b $5E ; ^
		dc.b $5C ; \
		dc.b $58 ; X
		dc.b $52 ; R
		dc.b $4C ; L
		dc.b $47 ; G
		dc.b $42 ; B
		dc.b $3F ; ?
		dc.b $3F ; ?
		dc.b $40 ; @
		dc.b $41 ; A
		dc.b $41 ; A
		dc.b $41 ; A
		dc.b $40 ; @
		dc.b $3C ; <
		dc.b $36 ; 6
		dc.b $2F ; /
		dc.b $27 ; '
		dc.b $20
		dc.b $1B
		dc.b $1A
		dc.b $1A
		dc.b $1A
		dc.b $17
		dc.b $13
		dc.b  $D
		dc.b   7
		dc.b   1
		dc.b $86 ; Ü
		dc.b $8B ; ã
		dc.b $91 ; ë
		dc.b $96 ; ñ
		dc.b $9A ; ö
		dc.b $9E ; û
		dc.b $A2 ; ¢
		dc.b $A5 ; •
		dc.b $A9 ; ©
		dc.b $AC ; ¨
		dc.b $AF ; Ø
		dc.b $B1 ; ±
		dc.b $B1 ; ±
		dc.b $B0 ; ∞
		dc.b $AE ; Æ
		dc.b $AD ; ≠
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $AA ; ™
		dc.b $A9 ; ©
		dc.b $A9 ; ©
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $AE ; Æ
		dc.b $B1 ; ±
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B4 ; ¥
		dc.b $B2 ; ≤
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $AE ; Æ
		dc.b $AC ; ¨
		dc.b $A9 ; ©
		dc.b $A6 ; ¶
		dc.b $A4 ; §
		dc.b $A3 ; £
		dc.b $A3 ; £
		dc.b $A3 ; £
		dc.b $A1 ; °
		dc.b $9F ; ü
		dc.b $9C ; ú
		dc.b $98 ; ò
		dc.b $95 ; ï
		dc.b $90 ; ê
		dc.b $92 ; í
		dc.b $91 ; ë
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $8F ; è
		dc.b $92 ; í
		dc.b $93 ; ì
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $A1 ; °
		dc.b $A6 ; ¶
		dc.b $AA ; ™
		dc.b $A9 ; ©
		dc.b $A2 ; ¢
		dc.b $9B ; õ
		dc.b $97 ; ó
		dc.b $96 ; ñ
		dc.b $90 ; ê
		dc.b $8C ; å
		dc.b $84 ; Ñ
		dc.b   2
		dc.b   7
		dc.b   7
		dc.b  $C
		dc.b  $B
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b   8
		dc.b   8
		dc.b  $F
		dc.b $12
		dc.b $19
		dc.b $1B
		dc.b $1B
		dc.b $20
		dc.b $28 ; (
		dc.b $36 ; 6
		dc.b $40 ; @
		dc.b $46 ; F
		dc.b $4A ; J
		dc.b $48 ; H
		dc.b $47 ; G
		dc.b $47 ; G
		dc.b $4A ; J
		dc.b $4C ; L
		dc.b $52 ; R
		dc.b $5A ; Z
		dc.b $5F ; _
		dc.b $61 ; a
		dc.b $5B ; [
		dc.b $56 ; V
		dc.b $54 ; T
		dc.b $56 ; V
		dc.b $5B ; [
		dc.b $5E ; ^
		dc.b $5C ; \
		dc.b $57 ; W
		dc.b $51 ; Q
		dc.b $4B ; K
		dc.b $45 ; E
		dc.b $3B ; ;
		dc.b $30 ; 0
		dc.b $27 ; '
		dc.b $1E
		dc.b $1D
		dc.b $1D
		dc.b $1B
		dc.b $17
		dc.b $13
		dc.b  $B
		dc.b   5
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $95 ; ï
		dc.b $A0 ; †
		dc.b $AB ; ´
		dc.b $B3 ; ≥
		dc.b $B7 ; ∑
		dc.b $B7 ; ∑
		dc.b $B7 ; ∑
		dc.b $B7 ; ∑
		dc.b $BA ; ∫
		dc.b $BE ; æ
		dc.b $C3 ; √
		dc.b $C6 ; ∆
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $C7 ; «
		dc.b $C5 ; ≈
		dc.b $C5 ; ≈
		dc.b $C4 ; ƒ
		dc.b $C6 ; ∆
		dc.b $C8 ; »
		dc.b $C8 ; »
		dc.b $C8 ; »
		dc.b $C9 ; …
		dc.b $CA ;  
		dc.b $CA ;  
		dc.b $CA ;  
		dc.b $CB ; À
		dc.b $CC ; Ã
		dc.b $CE ; Œ
		dc.b $D0 ; –
		dc.b $D2 ; “
		dc.b $D2 ; “
		dc.b $D0 ; –
		dc.b $CC ; Ã
		dc.b $C9 ; …
		dc.b $C8 ; »
		dc.b $C7 ; «
		dc.b $C6 ; ∆
		dc.b $C6 ; ∆
		dc.b $C6 ; ∆
		dc.b $C5 ; ≈
		dc.b $C2 ; ¬
		dc.b $BE ; æ
		dc.b $B9 ; π
		dc.b $B4 ; ¥
		dc.b $B1 ; ±
		dc.b $AC ; ¨
		dc.b $A6 ; ¶
		dc.b $9E ; û
		dc.b $96 ; ñ
		dc.b $8F ; è
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   2
		dc.b   7
		dc.b  $B
		dc.b  $F
		dc.b $12
		dc.b $15
		dc.b $17
		dc.b $17
		dc.b $19
		dc.b $1E
		dc.b $25 ; %
		dc.b $2E ; .
		dc.b $37 ; 7
		dc.b $3F ; ?
		dc.b $47 ; G
		dc.b $4F ; O
		dc.b $55 ; U
		dc.b $57 ; W
		dc.b $57 ; W
		dc.b $57 ; W
		dc.b $58 ; X
		dc.b $5C ; \
		dc.b $63 ; c
		dc.b $6A ; j
		dc.b $70 ; p
		dc.b $72 ; r
		dc.b $70 ; p
		dc.b $6B ; k
		dc.b $65 ; e
		dc.b $60 ; `
		dc.b $5D ; ]
		dc.b $5A ; Z
		dc.b $58 ; X
		dc.b $54 ; T
		dc.b $4F ; O
		dc.b $49 ; I
		dc.b $44 ; D
		dc.b $41 ; A
		dc.b $3F ; ?
		dc.b $3F ; ?
		dc.b $41 ; A
		dc.b $41 ; A
		dc.b $42 ; B
		dc.b $44 ; D
		dc.b $44 ; D
		dc.b $40 ; @
		dc.b $39 ; 9
		dc.b $30 ; 0
		dc.b $27 ; '
		dc.b $21 ; !
		dc.b $1D
		dc.b $1D
		dc.b $1D
		dc.b $1B
		dc.b $19
		dc.b $15
		dc.b $10
		dc.b  $C
		dc.b   7
		dc.b   2
		dc.b $83 ; É
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $90 ; ê
		dc.b $93 ; ì
		dc.b $98 ; ò
		dc.b $A0 ; †
		dc.b $A6 ; ¶
		dc.b $AB ; ´
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $AA ; ™
		dc.b $A7 ; ß
		dc.b $A6 ; ¶
		dc.b $A7 ; ß
		dc.b $A9 ; ©
		dc.b $AB ; ´
		dc.b $AB ; ´
		dc.b $AB ; ´
		dc.b $A9 ; ©
		dc.b $AA ; ™
		dc.b $A9 ; ©
		dc.b $AA ; ™
		dc.b $AD ; ≠
		dc.b $B1 ; ±
		dc.b $B5 ; µ
		dc.b $B6 ; ∂
		dc.b $B6 ; ∂
		dc.b $B4 ; ¥
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $AE ; Æ
		dc.b $AC ; ¨
		dc.b $A9 ; ©
		dc.b $A7 ; ß
		dc.b $A6 ; ¶
		dc.b $A8 ; ®
		dc.b $AA ; ™
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $A8 ; ®
		dc.b $A4 ; §
		dc.b $A0 ; †
		dc.b $9E ; û
		dc.b $9D ; ù
		dc.b $9F ; ü
		dc.b $9E ; û
		dc.b $9E ; û
		dc.b $9B ; õ
		dc.b $9A ; ö
		dc.b $9C ; ú
		dc.b $9E ; û
		dc.b $A2 ; ¢
		dc.b $AB ; ´
		dc.b $B1 ; ±
		dc.b $B5 ; µ
		dc.b $B6 ; ∂
		dc.b $B1 ; ±
		dc.b $AB ; ´
		dc.b $A5 ; •
		dc.b $A1 ; °
		dc.b $99 ; ô
		dc.b $96 ; ñ
		dc.b $8F ; è
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b   1
		dc.b $81 ; Å
		dc.b   2
		dc.b   5
		dc.b   3
		dc.b   1
		dc.b   1
		dc.b   7
		dc.b  $A
		dc.b $14
		dc.b $13
		dc.b $15
		dc.b $1A
		dc.b $22 ; "
		dc.b $2E ; .
		dc.b $39 ; 9
		dc.b $3F ; ?
		dc.b $41 ; A
		dc.b $45 ; E
		dc.b $42 ; B
		dc.b $43 ; C
		dc.b $46 ; F
		dc.b $48 ; H
		dc.b $51 ; Q
		dc.b $58 ; X
		dc.b $5D ; ]
		dc.b $5C ; \
		dc.b $57 ; W
		dc.b $53 ; S
		dc.b $50 ; P
		dc.b $56 ; V
		dc.b $5E ; ^
		dc.b $63 ; c
		dc.b $65 ; e
		dc.b $5F ; _
		dc.b $5B ; [
		dc.b $55 ; U
		dc.b $50 ; P
		dc.b $47 ; G
		dc.b $3C ; <
		dc.b $33 ; 3
		dc.b $2B ; +
		dc.b $29 ; )
		dc.b $27 ; '
		dc.b $24 ; $
		dc.b $1D
		dc.b $18
		dc.b $11
		dc.b  $D
		dc.b  $A
		dc.b   5
		dc.b   1
		dc.b $83 ; É
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8F ; è
		dc.b $97 ; ó
		dc.b $9F ; ü
		dc.b $AA ; ™
		dc.b $B1 ; ±
		dc.b $B4 ; ¥
		dc.b $B5 ; µ
		dc.b $B5 ; µ
		dc.b $B7 ; ∑
		dc.b $BA ; ∫
		dc.b $C0 ; ¿
		dc.b $C7 ; «
		dc.b $CB ; À
		dc.b $CE ; Œ
		dc.b $CF ; œ
		dc.b $CD ; Õ
		dc.b $CB ; À
		dc.b $CA ;  
		dc.b $CB ; À
		dc.b $CC ; Ã
		dc.b $CF ; œ
		dc.b $CF ; œ
		dc.b $CF ; œ
		dc.b $D1 ; —
		dc.b $D1 ; —
		dc.b $D2 ; “
		dc.b $D2 ; “
		dc.b $D3 ; ”
		dc.b $D5 ; ’
		dc.b $D7 ; ◊
		dc.b $D9 ; Ÿ
		dc.b $DA ; ⁄
		dc.b $D9 ; Ÿ
		dc.b $D7 ; ◊
		dc.b $D4 ; ‘
		dc.b $D3 ; ”
		dc.b $D3 ; ”
		dc.b $D1 ; —
		dc.b $D0 ; –
		dc.b $CF ; œ
		dc.b $CF ; œ
		dc.b $CE ; Œ
		dc.b $CB ; À
		dc.b $C7 ; «
		dc.b $C1 ; ¡
		dc.b $BC ; º
		dc.b $B6 ; ∂
		dc.b $B1 ; ±
		dc.b $AB ; ´
		dc.b $A2 ; ¢
		dc.b $9B ; õ
		dc.b $94 ; î
		dc.b $8E ; é
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   5
		dc.b   9
		dc.b  $D
		dc.b $11
		dc.b $14
		dc.b $16
		dc.b $17
		dc.b $1A
		dc.b $20
		dc.b $28 ; (
		dc.b $31 ; 1
		dc.b $3A ; :
		dc.b $44 ; D
		dc.b $4E ; N
		dc.b $56 ; V
		dc.b $5C ; \
		dc.b $60 ; `
		dc.b $60 ; `
		dc.b $60 ; `
		dc.b $63 ; c
		dc.b $68 ; h
		dc.b $70 ; p
		dc.b $78 ; x
		dc.b $7E ; ~
		dc.b $7F ; 
		dc.b $7E ; ~
		dc.b $7A ; z
		dc.b $74 ; t
		dc.b $6F ; o
		dc.b $6C ; l
		dc.b $68 ; h
		dc.b $64 ; d
		dc.b $60 ; `
		dc.b $5A ; Z
		dc.b $54 ; T
		dc.b $4F ; O
		dc.b $4B ; K
		dc.b $4B ; K
		dc.b $4C ; L
		dc.b $4F ; O
		dc.b $52 ; R
		dc.b $54 ; T
		dc.b $57 ; W
		dc.b $56 ; V
		dc.b $51 ; Q
		dc.b $49 ; I
		dc.b $3F ; ?
		dc.b $34 ; 4
		dc.b $2C ; ,
		dc.b $28 ; (
		dc.b $27 ; '
		dc.b $25 ; %
		dc.b $22 ; "
		dc.b $1D
		dc.b $19
		dc.b $13
		dc.b  $F
		dc.b  $B
		dc.b   6
		dc.b $80 ; Ä
		dc.b $87 ; á
		dc.b $8C ; å
		dc.b $92 ; í
		dc.b $98 ; ò
		dc.b $A0 ; †
		dc.b $A7 ; ß
		dc.b $AD ; ≠
		dc.b $B1 ; ±
		dc.b $B3 ; ≥
		dc.b $B3 ; ≥
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B3 ; ≥
		dc.b $B6 ; ∂
		dc.b $B6 ; ∂
		dc.b $B5 ; µ
		dc.b $B2 ; ≤
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $B0 ; ∞
		dc.b $B4 ; ¥
		dc.b $B8 ; ∏
		dc.b $BB ; ª
		dc.b $BD ; Ω
		dc.b $BC ; º
		dc.b $BA ; ∫
		dc.b $B8 ; ∏
		dc.b $B7 ; ∑
		dc.b $B8 ; ∏
		dc.b $B9 ; π
		dc.b $B9 ; π
		dc.b $B7 ; ∑
		dc.b $B4 ; ¥
		dc.b $B3 ; ≥
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B6 ; ∂
		dc.b $B6 ; ∂
		dc.b $B7 ; ∑
		dc.b $B6 ; ∂
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AA ; ™
		dc.b $AA ; ™
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $A8 ; ®
		dc.b $A8 ; ®
		dc.b $A9 ; ©
		dc.b $A5 ; •
		dc.b $AB ; ´
		dc.b $AA ; ™
		dc.b $B1 ; ±
		dc.b $B7 ; ∑
		dc.b $BC ; º
		dc.b $C4 ; ƒ
		dc.b $BF ; ø
		dc.b $BC ; º
		dc.b $B5 ; µ
		dc.b $B2 ; ≤
		dc.b $AA ; ™
		dc.b $A2 ; ¢
		dc.b $9A ; ö
		dc.b $90 ; ê
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b $82 ; Ç
		dc.b   4
		dc.b   1
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   5
		dc.b  $C
		dc.b $10
		dc.b $15
		dc.b $15
		dc.b $1D
		dc.b $2B ; +
		dc.b $37 ; 7
		dc.b $42 ; B
		dc.b $47 ; G
		dc.b $49 ; I
		dc.b $4C ; L
		dc.b $4D ; M
		dc.b $4E ; N
		dc.b $52 ; R
		dc.b $55 ; U
		dc.b $5A ; Z
		dc.b $65 ; e
		dc.b $69 ; i
		dc.b $68 ; h
		dc.b $62 ; b
		dc.b $5D ; ]
		dc.b $5F ; _
		dc.b $67 ; g
		dc.b $72 ; r
		dc.b $78 ; x
		dc.b $78 ; x
		dc.b $71 ; q
		dc.b $69 ; i
		dc.b $63 ; c
		dc.b $5D ; ]
		dc.b $54 ; T
		dc.b $45 ; E
		dc.b $39 ; 9
		dc.b $33 ; 3
		dc.b $31 ; 1
		dc.b $33 ; 3
		dc.b $30 ; 0
		dc.b $2A ; *
		dc.b $24 ; $
		dc.b $1C
		dc.b $17
		dc.b $10
		dc.b  $C
		dc.b   9
		dc.b   4
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $91 ; ë
		dc.b $99 ; ô
		dc.b $A2 ; ¢
		dc.b $AD ; ≠
		dc.b $B3 ; ≥
		dc.b $B6 ; ∂
		dc.b $B7 ; ∑
		dc.b $B7 ; ∑
		dc.b $B9 ; π
		dc.b $BC ; º
		dc.b $C3 ; √
		dc.b $C9 ; …
		dc.b $CD ; Õ
		dc.b $D0 ; –
		dc.b $D0 ; –
		dc.b $CE ; Œ
		dc.b $CC ; Ã
		dc.b $CC ; Ã
		dc.b $CD ; Õ
		dc.b $CE ; Œ
		dc.b $D0 ; –
		dc.b $D0 ; –
		dc.b $D1 ; —
		dc.b $D3 ; ”
		dc.b $D3 ; ”
		dc.b $D4 ; ‘
		dc.b $D4 ; ‘
		dc.b $D5 ; ’
		dc.b $D7 ; ◊
		dc.b $D9 ; Ÿ
		dc.b $DB ; €
		dc.b $DB ; €
		dc.b $DB ; €
		dc.b $D8 ; ÿ
		dc.b $D6 ; ÷
		dc.b $D5 ; ’
		dc.b $D4 ; ‘
		dc.b $D3 ; ”
		dc.b $D1 ; —
		dc.b $D0 ; –
		dc.b $D1 ; —
		dc.b $CF ; œ
		dc.b $CC ; Ã
		dc.b $C7 ; «
		dc.b $C2 ; ¬
		dc.b $BC ; º
		dc.b $B7 ; ∑
		dc.b $B1 ; ±
		dc.b $AB ; ´
		dc.b $A2 ; ¢
		dc.b $9B ; õ
		dc.b $95 ; ï
		dc.b $8F ; è
		dc.b $8A ; ä
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b   4
		dc.b   8
		dc.b  $C
		dc.b $10
		dc.b $13
		dc.b $15
		dc.b $17
		dc.b $1A
		dc.b $20
		dc.b $28 ; (
		dc.b $31 ; 1
		dc.b $3B ; ;
		dc.b $45 ; E
		dc.b $4E ; N
		dc.b $56 ; V
		dc.b $5C ; \
		dc.b $5F ; _
		dc.b $5F ; _
		dc.b $60 ; `
		dc.b $62 ; b
		dc.b $68 ; h
		dc.b $70 ; p
		dc.b $78 ; x
		dc.b $7E ; ~
		dc.b $7F ; 
		dc.b $7C ; |
		dc.b $78 ; x
		dc.b $72 ; r
		dc.b $6E ; n
		dc.b $6A ; j
		dc.b $67 ; g
		dc.b $63 ; c
		dc.b $5E ; ^
		dc.b $58 ; X
		dc.b $52 ; R
		dc.b $4D ; M
		dc.b $4A ; J
		dc.b $4A ; J
		dc.b $4C ; L
		dc.b $4E ; N
		dc.b $51 ; Q
		dc.b $54 ; T
		dc.b $56 ; V
		dc.b $55 ; U
		dc.b $4F ; O
		dc.b $47 ; G
		dc.b $3C ; <
		dc.b $32 ; 2
		dc.b $2B ; +
		dc.b $27 ; '
		dc.b $25 ; %
		dc.b $24 ; $
		dc.b $20
		dc.b $1C
		dc.b $17
		dc.b $12
		dc.b  $E
		dc.b  $A
		dc.b   4
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b $8E ; é
		dc.b $94 ; î
		dc.b $9A ; ö
		dc.b $A1 ; °
		dc.b $A8 ; ®
		dc.b $AE ; Æ
		dc.b $B2 ; ≤
		dc.b $B3 ; ≥
		dc.b $B3 ; ≥
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $B0 ; ∞
		dc.b $B2 ; ≤
		dc.b $B4 ; ¥
		dc.b $B7 ; ∑
		dc.b $B7 ; ∑
		dc.b $B5 ; µ
		dc.b $B3 ; ≥
		dc.b $B1 ; ±
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B5 ; µ
		dc.b $B9 ; π
		dc.b $BC ; º
		dc.b $BD ; Ω
		dc.b $BD ; Ω
		dc.b $BA ; ∫
		dc.b $B8 ; ∏
		dc.b $B8 ; ∏
		dc.b $B9 ; π
		dc.b $B9 ; π
		dc.b $B9 ; π
		dc.b $B7 ; ∑
		dc.b $B5 ; µ
		dc.b $B3 ; ≥
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B6 ; ∂
		dc.b $B7 ; ∑
		dc.b $B7 ; ∑
		dc.b $B6 ; ∂
		dc.b $B1 ; ±
		dc.b $AE ; Æ
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $AB ; ´
		dc.b $AB ; ´
		dc.b $A8 ; ®
		dc.b $AA ; ™
		dc.b $A9 ; ©
		dc.b $A7 ; ß
		dc.b $AC ; ¨
		dc.b $AB ; ´
		dc.b $B2 ; ≤
		dc.b $B8 ; ∏
		dc.b $BE ; æ
		dc.b $C4 ; ƒ
		dc.b $BF ; ø
		dc.b $BC ; º
		dc.b $B5 ; µ
		dc.b $B2 ; ≤
		dc.b $A9 ; ©
		dc.b $A1 ; °
		dc.b $99 ; ô
		dc.b $8F ; è
		dc.b $8A ; ä
		dc.b $84 ; Ñ
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $82 ; Ç
		dc.b   4
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b   6
		dc.b  $C
		dc.b $10
		dc.b $15
		dc.b $15
		dc.b $1F
		dc.b $2C ; ,
		dc.b $38 ; 8
		dc.b $43 ; C
		dc.b $47 ; G
		dc.b $4A ; J
		dc.b $4D ; M
		dc.b $4D ; M
		dc.b $4F ; O
		dc.b $52 ; R
		dc.b $55 ; U
		dc.b $5B ; [
		dc.b $66 ; f
		dc.b $69 ; i
		dc.b $68 ; h
		dc.b $61 ; a
		dc.b $5D ; ]
		dc.b $5F ; _
		dc.b $68 ; h
		dc.b $73 ; s
		dc.b $79 ; y
		dc.b $77 ; w
		dc.b $6F ; o
		dc.b $67 ; g
		dc.b $62 ; b
		dc.b $5C ; \
		dc.b $52 ; R
		dc.b $43 ; C
		dc.b $38 ; 8
		dc.b $32 ; 2
		dc.b $32 ; 2
		dc.b $33 ; 3
		dc.b $2F ; /
		dc.b $29 ; )
		dc.b $23 ; #
		dc.b $1C
		dc.b $16
		dc.b  $F
		dc.b  $C
		dc.b   8
		dc.b   3
		dc.b $80 ; Ä
		dc.b $86 ; Ü
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $92 ; í
		dc.b $9B ; õ
		dc.b $A4 ; §
		dc.b $AE ; Æ
		dc.b $B4 ; ¥
		dc.b $B7 ; ∑
		dc.b $B7 ; ∑
		dc.b $B7 ; ∑
		dc.b $B9 ; π
		dc.b $BD ; Ω
		dc.b $C4 ; ƒ
		dc.b $C9 ; …
		dc.b $CD ; Õ
		dc.b $D0 ; –
		dc.b $D0 ; –
		dc.b $CE ; Œ
		dc.b $CC ; Ã
		dc.b $CC ; Ã
		dc.b $CD ; Õ
		dc.b $CF ; œ
		dc.b $D0 ; –
		dc.b $D0 ; –
		dc.b $D1 ; —
		dc.b $D3 ; ”
		dc.b $D3 ; ”
		dc.b $D4 ; ‘
		dc.b $D4 ; ‘
		dc.b $D5 ; ’
		dc.b $D7 ; ◊
		dc.b $D9 ; Ÿ
		dc.b $DB ; €
		dc.b $DC ; ‹
		dc.b $DA ; ⁄
		dc.b $D8 ; ÿ
		dc.b $D5 ; ’
		dc.b $D5 ; ’
		dc.b $D4 ; ‘
		dc.b $D2 ; “
		dc.b $D1 ; —
		dc.b $D0 ; –
		dc.b $D0 ; –
		dc.b $CF ; œ
		dc.b $CB ; À
		dc.b $C6 ; ∆
		dc.b $C1 ; ¡
		dc.b $BB ; ª
		dc.b $B6 ; ∂
		dc.b $B0 ; ∞
		dc.b $AA ; ™
		dc.b $A1 ; °
		dc.b $9A ; ö
		dc.b $94 ; î
		dc.b $8E ; é
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   5
		dc.b   9
		dc.b  $D
		dc.b $11
		dc.b $14
		dc.b $15
		dc.b $17
		dc.b $1A
		dc.b $20
		dc.b $29 ; )
		dc.b $32 ; 2
		dc.b $3B ; ;
		dc.b $45 ; E
		dc.b $4D ; M
		dc.b $55 ; U
		dc.b $5A ; Z
		dc.b $5C ; \
		dc.b $5C ; \
		dc.b $5D ; ]
		dc.b $5F ; _
		dc.b $65 ; e
		dc.b $6D ; m
		dc.b $74 ; t
		dc.b $7A ; z
		dc.b $7A ; z
		dc.b $77 ; w
		dc.b $73 ; s
		dc.b $6D ; m
		dc.b $69 ; i
		dc.b $66 ; f
		dc.b $63 ; c
		dc.b $5F ; _
		dc.b $5A ; Z
		dc.b $54 ; T
		dc.b $4F ; O
		dc.b $4A ; J
		dc.b $48 ; H
		dc.b $48 ; H
		dc.b $4A ; J
		dc.b $4C ; L
		dc.b $4F ; O
		dc.b $52 ; R
		dc.b $53 ; S
		dc.b $52 ; R
		dc.b $4C ; L
		dc.b $43 ; C
		dc.b $39 ; 9
		dc.b $30 ; 0
		dc.b $29 ; )
		dc.b $26 ; &
		dc.b $24 ; $
		dc.b $23 ; #
		dc.b $1F
		dc.b $1B
		dc.b $16
		dc.b $11
		dc.b  $E
		dc.b   9
		dc.b   4
		dc.b $82 ; Ç
		dc.b $88 ; à
		dc.b $8D ; ç
		dc.b $93 ; ì
		dc.b $99 ; ô
		dc.b $A0 ; †
		dc.b $A7 ; ß
		dc.b $AC ; ¨
		dc.b $AF ; Ø
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $AE ; Æ
		dc.b $B0 ; ∞
		dc.b $B2 ; ≤
		dc.b $B4 ; ¥
		dc.b $B4 ; ¥
		dc.b $B2 ; ≤
		dc.b $B0 ; ∞
		dc.b $AE ; Æ
		dc.b $AD ; ≠
		dc.b $AF ; Ø
		dc.b $B3 ; ≥
		dc.b $B6 ; ∂
		dc.b $B9 ; π
		dc.b $BA ; ∫
		dc.b $B9 ; π
		dc.b $B7 ; ∑
		dc.b $B4 ; ¥
		dc.b $B5 ; µ
		dc.b $B5 ; µ
		dc.b $B6 ; ∂
		dc.b $B6 ; ∂
		dc.b $B3 ; ≥
		dc.b $B1 ; ±
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $B2 ; ≤
		dc.b $B4 ; ¥
		dc.b $B4 ; ¥
		dc.b $B4 ; ¥
		dc.b $B2 ; ≤
		dc.b $AE ; Æ
		dc.b $AB ; ´
		dc.b $A8 ; ®
		dc.b $A9 ; ©
		dc.b $A8 ; ®
		dc.b $A9 ; ©
		dc.b $A6 ; ¶
		dc.b $A8 ; ®
		dc.b $A5 ; •
		dc.b $A5 ; •
		dc.b $AA ; ™
		dc.b $A8 ; ®
		dc.b $B1 ; ±
		dc.b $B5 ; µ
		dc.b $BC ; º
		dc.b $C0 ; ¿
		dc.b $BB ; ª
		dc.b $B7 ; ∑
		dc.b $B1 ; ±
		dc.b $AE ; Æ
		dc.b $A5 ; •
		dc.b $9E ; û
		dc.b $96 ; ñ
		dc.b $8D ; ç
		dc.b $88 ; à
		dc.b $82 ; Ç
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   4
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   8
		dc.b  $C
		dc.b $11
		dc.b $15
		dc.b $16
		dc.b $20
		dc.b $2D ; -
		dc.b $39 ; 9
		dc.b $42 ; B
		dc.b $45 ; E
		dc.b $48 ; H
		dc.b $4A ; J
		dc.b $4A ; J
		dc.b $4C ; L
		dc.b $50 ; P
		dc.b $53 ; S
		dc.b $59 ; Y
		dc.b $63 ; c
		dc.b $65 ; e
		dc.b $63 ; c
		dc.b $5C ; \
		dc.b $59 ; Y
		dc.b $5C ; \
		dc.b $66 ; f
		dc.b $6F ; o
		dc.b $75 ; u
		dc.b $72 ; r
		dc.b $6A ; j
		dc.b $63 ; c
		dc.b $5D ; ]
		dc.b $57 ; W
		dc.b $4D ; M
		dc.b $3E ; >
		dc.b $35 ; 5
		dc.b $30 ; 0
		dc.b $30 ; 0
		dc.b $31 ; 1
		dc.b $2D ; -
		dc.b $27 ; '
		dc.b $21 ; !
		dc.b $1A
		dc.b $15
		dc.b  $E
		dc.b  $B
		dc.b   7
		dc.b   3
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $92 ; í
		dc.b $9A ; ö
		dc.b $A3 ; £
		dc.b $AC ; ¨
		dc.b $B1 ; ±
		dc.b $B3 ; ≥
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B6 ; ∂
		dc.b $BA ; ∫
		dc.b $C1 ; ¡
		dc.b $C6 ; ∆
		dc.b $C9 ; …
		dc.b $CB ; À
		dc.b $CB ; À
		dc.b $C9 ; …
		dc.b $C7 ; «
		dc.b $C8 ; »
		dc.b $C9 ; …
		dc.b $CA ;  
		dc.b $CC ; Ã
		dc.b $CC ; Ã
		dc.b $CD ; Õ
		dc.b $CE ; Œ
		dc.b $CF ; œ
		dc.b $CF ; œ
		dc.b $CF ; œ
		dc.b $D1 ; —
		dc.b $D2 ; “
		dc.b $D4 ; ‘
		dc.b $D6 ; ÷
		dc.b $D6 ; ÷
		dc.b $D5 ; ’
		dc.b $D2 ; “
		dc.b $D0 ; –
		dc.b $D0 ; –
		dc.b $CF ; œ
		dc.b $CD ; Õ
		dc.b $CC ; Ã
		dc.b $CB ; À
		dc.b $CC ; Ã
		dc.b $CA ;  
		dc.b $C6 ; ∆
		dc.b $C1 ; ¡
		dc.b $BC ; º
		dc.b $B7 ; ∑
		dc.b $B2 ; ≤
		dc.b $AD ; ≠
		dc.b $A6 ; ¶
		dc.b $9E ; û
		dc.b $98 ; ò
		dc.b $92 ; í
		dc.b $8D ; ç
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b   2
		dc.b   5
		dc.b  $A
		dc.b  $D
		dc.b $11
		dc.b $14
		dc.b $15
		dc.b $17
		dc.b $1A
		dc.b $21 ; !
		dc.b $29 ; )
		dc.b $32 ; 2
		dc.b $3B ; ;
		dc.b $44 ; D
		dc.b $4D ; M
		dc.b $54 ; T
		dc.b $59 ; Y
		dc.b $5A ; Z
		dc.b $5A ; Z
		dc.b $5C ; \
		dc.b $5E ; ^
		dc.b $65 ; e
		dc.b $6D ; m
		dc.b $73 ; s
		dc.b $78 ; x
		dc.b $78 ; x
		dc.b $75 ; u
		dc.b $70 ; p
		dc.b $6B ; k
		dc.b $67 ; g
		dc.b $64 ; d
		dc.b $61 ; a
		dc.b $5D ; ]
		dc.b $58 ; X
		dc.b $52 ; R
		dc.b $4D ; M
		dc.b $49 ; I
		dc.b $47 ; G
		dc.b $47 ; G
		dc.b $49 ; I
		dc.b $4C ; L
		dc.b $4E ; N
		dc.b $51 ; Q
		dc.b $52 ; R
		dc.b $50 ; P
		dc.b $49 ; I
		dc.b $40 ; @
		dc.b $36 ; 6
		dc.b $2E ; .
		dc.b $27 ; '
		dc.b $25 ; %
		dc.b $23 ; #
		dc.b $22 ; "
		dc.b $1E
		dc.b $1A
		dc.b $15
		dc.b $10
		dc.b  $D
		dc.b   8
		dc.b   3
		dc.b $83 ; É
		dc.b $89 ; â
		dc.b $8E ; é
		dc.b $94 ; î
		dc.b $9A ; ö
		dc.b $A1 ; °
		dc.b $A7 ; ß
		dc.b $AC ; ¨
		dc.b $AF ; Ø
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $AE ; Æ
		dc.b $B0 ; ∞
		dc.b $B2 ; ≤
		dc.b $B4 ; ¥
		dc.b $B3 ; ≥
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $AD ; ≠
		dc.b $AF ; Ø
		dc.b $B3 ; ≥
		dc.b $B6 ; ∂
		dc.b $B8 ; ∏
		dc.b $B9 ; π
		dc.b $B8 ; ∏
		dc.b $B5 ; µ
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B5 ; µ
		dc.b $B5 ; µ
		dc.b $B5 ; µ
		dc.b $B2 ; ≤
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B3 ; ≥
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B1 ; ±
		dc.b $AD ; ≠
		dc.b $AA ; ™
		dc.b $A7 ; ß
		dc.b $A8 ; ®
		dc.b $A8 ; ®
		dc.b $A8 ; ®
		dc.b $A5 ; •
		dc.b $A7 ; ß
		dc.b $A3 ; £
		dc.b $A6 ; ¶
		dc.b $A8 ; ®
		dc.b $A8 ; ®
		dc.b $B1 ; ±
		dc.b $B5 ; µ
		dc.b $BB ; ª
		dc.b $BE ; æ
		dc.b $BA ; ∫
		dc.b $B5 ; µ
		dc.b $B0 ; ∞
		dc.b $AC ; ¨
		dc.b $A3 ; £
		dc.b $9D ; ù
		dc.b $94 ; î
		dc.b $8C ; å
		dc.b $88 ; à
		dc.b $81 ; Å
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b   3
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b   9
		dc.b  $C
		dc.b $12
		dc.b $14
		dc.b $16
		dc.b $21 ; !
		dc.b $2D ; -
		dc.b $39 ; 9
		dc.b $41 ; A
		dc.b $43 ; C
		dc.b $47 ; G
		dc.b $48 ; H
		dc.b $49 ; I
		dc.b $4B ; K
		dc.b $4E ; N
		dc.b $51 ; Q
		dc.b $59 ; Y
		dc.b $62 ; b
		dc.b $62 ; b
		dc.b $60 ; `
		dc.b $59 ; Y
		dc.b $58 ; X
		dc.b $5B ; [
		dc.b $65 ; e
		dc.b $6E ; n
		dc.b $72 ; r
		dc.b $6E ; n
		dc.b $66 ; f
		dc.b $60 ; `
		dc.b $5B ; [
		dc.b $55 ; U
		dc.b $4A ; J
		dc.b $3B ; ;
		dc.b $33 ; 3
		dc.b $2F ; /
		dc.b $30 ; 0
		dc.b $30 ; 0
		dc.b $2B ; +
		dc.b $26 ; &
		dc.b $1F
		dc.b $19
		dc.b $13
		dc.b  $D
		dc.b  $A
		dc.b   7
		dc.b   2
		dc.b $81 ; Å
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $93 ; ì
		dc.b $9B ; õ
		dc.b $A4 ; §
		dc.b $AD ; ≠
		dc.b $B1 ; ±
		dc.b $B3 ; ≥
		dc.b $B2 ; ≤
		dc.b $B3 ; ≥
		dc.b $B6 ; ∂
		dc.b $BA ; ∫
		dc.b $C1 ; ¡
		dc.b $C5 ; ≈
		dc.b $C9 ; …
		dc.b $CB ; À
		dc.b $CA ;  
		dc.b $C8 ; »
		dc.b $C6 ; ∆
		dc.b $C7 ; «
		dc.b $C8 ; »
		dc.b $CA ;  
		dc.b $CB ; À
		dc.b $CB ; À
		dc.b $CC ; Ã
		dc.b $CD ; Õ
		dc.b $CE ; Œ
		dc.b $CE ; Œ
		dc.b $CE ; Œ
		dc.b $D0 ; –
		dc.b $D2 ; “
		dc.b $D4 ; ‘
		dc.b $D5 ; ’
		dc.b $D5 ; ’
		dc.b $D3 ; ”
		dc.b $D0 ; –
		dc.b $CF ; œ
		dc.b $CF ; œ
		dc.b $CD ; Õ
		dc.b $CC ; Ã
		dc.b $CB ; À
		dc.b $CB ; À
		dc.b $CB ; À
		dc.b $C9 ; …
		dc.b $C5 ; ≈
		dc.b $C0 ; ¿
		dc.b $BB ; ª
		dc.b $B6 ; ∂
		dc.b $B1 ; ±
		dc.b $AC ; ¨
		dc.b $A4 ; §
		dc.b $9D ; ù
		dc.b $96 ; ñ
		dc.b $91 ; ë
		dc.b $8B ; ã
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b   3
		dc.b   6
		dc.b  $A
		dc.b  $E
		dc.b $11
		dc.b $14
		dc.b $15
		dc.b $17
		dc.b $1B
		dc.b $21 ; !
		dc.b $2A ; *
		dc.b $32 ; 2
		dc.b $3B ; ;
		dc.b $44 ; D
		dc.b $4C ; L
		dc.b $53 ; S
		dc.b $57 ; W
		dc.b $58 ; X
		dc.b $58 ; X
		dc.b $5A ; Z
		dc.b $5D ; ]
		dc.b $64 ; d
		dc.b $6B ; k
		dc.b $72 ; r
		dc.b $76 ; v
		dc.b $76 ; v
		dc.b $72 ; r
		dc.b $6D ; m
		dc.b $68 ; h
		dc.b $65 ; e
		dc.b $62 ; b
		dc.b $5E ; ^
		dc.b $5B ; [
		dc.b $56 ; V
		dc.b $50 ; P
		dc.b $4B ; K
		dc.b $47 ; G
		dc.b $45 ; E
		dc.b $46 ; F
		dc.b $48 ; H
		dc.b $4B ; K
		dc.b $4D ; M
		dc.b $4F ; O
		dc.b $50 ; P
		dc.b $4D ; M
		dc.b $47 ; G
		dc.b $3E ; >
		dc.b $34 ; 4
		dc.b $2C ; ,
		dc.b $26 ; &
		dc.b $24 ; $
		dc.b $23 ; #
		dc.b $21 ; !
		dc.b $1D
		dc.b $19
		dc.b $14
		dc.b $10
		dc.b  $C
		dc.b   8
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $89 ; â
		dc.b $8E ; é
		dc.b $94 ; î
		dc.b $9A ; ö
		dc.b $A1 ; °
		dc.b $A7 ; ß
		dc.b $AC ; ¨
		dc.b $AE ; Æ
		dc.b $AF ; Ø
		dc.b $AF ; Ø
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $AD ; ≠
		dc.b $AF ; Ø
		dc.b $B1 ; ±
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $AE ; Æ
		dc.b $B2 ; ≤
		dc.b $B5 ; µ
		dc.b $B7 ; ∑
		dc.b $B8 ; ∏
		dc.b $B6 ; ∂
		dc.b $B4 ; ¥
		dc.b $B2 ; ≤
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B4 ; ¥
		dc.b $B4 ; ¥
		dc.b $B1 ; ±
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $AF ; Ø
		dc.b $B1 ; ±
		dc.b $B2 ; ≤
		dc.b $B2 ; ≤
		dc.b $B3 ; ≥
		dc.b $AF ; Ø
		dc.b $AC ; ¨
		dc.b $A9 ; ©
		dc.b $A6 ; ¶
		dc.b $A7 ; ß
		dc.b $A7 ; ß
		dc.b $A7 ; ß
		dc.b $A4 ; §
		dc.b $A6 ; ¶
		dc.b $A2 ; ¢
		dc.b $A6 ; ¶
		dc.b $A7 ; ß
		dc.b $A9 ; ©
		dc.b $B1 ; ±
		dc.b $B4 ; ¥
		dc.b $BC ; º
		dc.b $BC ; º
		dc.b $B9 ; π
		dc.b $B3 ; ≥
		dc.b $AF ; Ø
		dc.b $AA ; ™
		dc.b $A2 ; ¢
		dc.b $9C ; ú
		dc.b $92 ; í
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b $82 ; Ç
		dc.b   3
		dc.b   3
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   2
		dc.b  $B
		dc.b  $D
		dc.b $13
		dc.b $14
		dc.b $18
		dc.b $23 ; #
		dc.b $2F ; /
		dc.b $3A ; :
		dc.b $41 ; A
		dc.b $43 ; C
		dc.b $46 ; F
		dc.b $48 ; H
		dc.b $48 ; H
		dc.b $4B ; K
		dc.b $4E ; N
		dc.b $51 ; Q
		dc.b $59 ; Y
		dc.b $62 ; b
		dc.b $61 ; a
		dc.b $5E ; ^
		dc.b $57 ; W
		dc.b $57 ; W
		dc.b $5C ; \
		dc.b $66 ; f
		dc.b $6E ; n
		dc.b $71 ; q
		dc.b $6B ; k
		dc.b $63 ; c
		dc.b $5D ; ]
		dc.b $58 ; X
		dc.b $52 ; R
		dc.b $46 ; F
		dc.b $39 ; 9
		dc.b $31 ; 1
		dc.b $2D ; -
		dc.b $2F ; /
		dc.b $2E ; .
		dc.b $29 ; )
		dc.b $24 ; $
		dc.b $1D
		dc.b $18
		dc.b $12
		dc.b  $D
		dc.b  $A
		dc.b   6
		dc.b   2
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8D ; ç
		dc.b $93 ; ì
		dc.b $9B ; õ
		dc.b $A4 ; §
		dc.b $AC ; ¨
		dc.b $B0 ; ∞
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $B2 ; ≤
		dc.b $B5 ; µ
		dc.b $BA ; ∫
		dc.b $C0 ; ¿
		dc.b $C4 ; ƒ
		dc.b $C8 ; »
		dc.b $C9 ; …
		dc.b $C8 ; »
		dc.b $C6 ; ∆
		dc.b $C5 ; ≈
		dc.b $C6 ; ∆
		dc.b $C6 ; ∆
		dc.b $C8 ; »
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $CB ; À
		dc.b $CB ; À
		dc.b $CC ; Ã
		dc.b $CC ; Ã
		dc.b $CC ; Ã
		dc.b $CE ; Œ
		dc.b $D0 ; –
		dc.b $D2 ; “
		dc.b $D3 ; ”
		dc.b $D3 ; ”
		dc.b $D1 ; —
		dc.b $CE ; Œ
		dc.b $CD ; Õ
		dc.b $CD ; Õ
		dc.b $CB ; À
		dc.b $CA ;  
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $C7 ; «
		dc.b $C3 ; √
		dc.b $BE ; æ
		dc.b $B9 ; π
		dc.b $B4 ; ¥
		dc.b $AF ; Ø
		dc.b $AA ; ™
		dc.b $A2 ; ¢
		dc.b $9B ; õ
		dc.b $95 ; ï
		dc.b $8F ; è
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b $81 ; Å
		dc.b   3
		dc.b   6
		dc.b  $B
		dc.b  $E
		dc.b $11
		dc.b $14
		dc.b $15
		dc.b $17
		dc.b $1B
		dc.b $22 ; "
		dc.b $2A ; *
		dc.b $32 ; 2
		dc.b $3C ; <
		dc.b $44 ; D
		dc.b $4C ; L
		dc.b $53 ; S
		dc.b $56 ; V
		dc.b $57 ; W
		dc.b $57 ; W
		dc.b $59 ; Y
		dc.b $5D ; ]
		dc.b $64 ; d
		dc.b $6B ; k
		dc.b $71 ; q
		dc.b $75 ; u
		dc.b $74 ; t
		dc.b $70 ; p
		dc.b $6B ; k
		dc.b $66 ; f
		dc.b $63 ; c
		dc.b $60 ; `
		dc.b $5D ; ]
		dc.b $59 ; Y
		dc.b $54 ; T
		dc.b $4E ; N
		dc.b $49 ; I
		dc.b $45 ; E
		dc.b $44 ; D
		dc.b $45 ; E
		dc.b $47 ; G
		dc.b $4A ; J
		dc.b $4C ; L
		dc.b $4F ; O
		dc.b $4F ; O
		dc.b $4C ; L
		dc.b $45 ; E
		dc.b $3C ; <
		dc.b $32 ; 2
		dc.b $2A ; *
		dc.b $25 ; %
		dc.b $24 ; $
		dc.b $22 ; "
		dc.b $20
		dc.b $1C
		dc.b $18
		dc.b $13
		dc.b  $F
		dc.b  $B
		dc.b   7
		dc.b   1
		dc.b $85 ; Ö
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b $95 ; ï
		dc.b $9B ; õ
		dc.b $A2 ; ¢
		dc.b $A8 ; ®
		dc.b $AC ; ¨
		dc.b $AE ; Æ
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $AD ; ≠
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $AF ; Ø
		dc.b $B1 ; ±
		dc.b $B1 ; ±
		dc.b $B0 ; ∞
		dc.b $AE ; Æ
		dc.b $AC ; ¨
		dc.b $AB ; ´
		dc.b $AB ; ´
		dc.b $AE ; Æ
		dc.b $B1 ; ±
		dc.b $B5 ; µ
		dc.b $B7 ; ∑
		dc.b $B7 ; ∑
		dc.b $B5 ; µ
		dc.b $B3 ; ≥
		dc.b $B2 ; ≤
		dc.b $B2 ; ≤
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B2 ; ≤
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $AE ; Æ
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B1 ; ±
		dc.b $B1 ; ±
		dc.b $AD ; ≠
		dc.b $AB ; ´
		dc.b $A7 ; ß
		dc.b $A6 ; ¶
		dc.b $A6 ; ¶
		dc.b $A6 ; ¶
		dc.b $A5 ; •
		dc.b $A4 ; §
		dc.b $A6 ; ¶
		dc.b $A1 ; °
		dc.b $A6 ; ¶
		dc.b $A6 ; ¶
		dc.b $A9 ; ©
		dc.b $B1 ; ±
		dc.b $B4 ; ¥
		dc.b $BC ; º
		dc.b $BA ; ∫
		dc.b $B7 ; ∑
		dc.b $B1 ; ±
		dc.b $AE ; Æ
		dc.b $A8 ; ®
		dc.b $A0 ; †
		dc.b $9A ; ö
		dc.b $91 ; ë
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b   1
		dc.b $81 ; Å
		dc.b   1
		dc.b $82 ; Ç
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b  $B
		dc.b  $D
		dc.b $13
		dc.b $13
		dc.b $18
		dc.b $24 ; $
		dc.b $2F ; /
		dc.b $3A ; :
		dc.b $40 ; @
		dc.b $42 ; B
		dc.b $45 ; E
		dc.b $46 ; F
		dc.b $46 ; F
		dc.b $49 ; I
		dc.b $4C ; L
		dc.b $50 ; P
		dc.b $58 ; X
		dc.b $60 ; `
		dc.b $5F ; _
		dc.b $5B ; [
		dc.b $55 ; U
		dc.b $55 ; U
		dc.b $5B ; [
		dc.b $65 ; e
		dc.b $6C ; l
		dc.b $6E ; n
		dc.b $68 ; h
		dc.b $61 ; a
		dc.b $5B ; [
		dc.b $56 ; V
		dc.b $4F ; O
		dc.b $43 ; C
		dc.b $36 ; 6
		dc.b $2F ; /
		dc.b $2D ; -
		dc.b $2E ; .
		dc.b $2D ; -
		dc.b $28 ; (
		dc.b $22 ; "
		dc.b $1C
		dc.b $17
		dc.b $10
		dc.b  $C
		dc.b   9
		dc.b   5
		dc.b   1
		dc.b $82 ; Ç
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8E ; é
		dc.b $94 ; î
		dc.b $9C ; ú
		dc.b $A5 ; •
		dc.b $AD ; ≠
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B1 ; ±
		dc.b $B2 ; ≤
		dc.b $B5 ; µ
		dc.b $BA ; ∫
		dc.b $C0 ; ¿
		dc.b $C4 ; ƒ
		dc.b $C7 ; «
		dc.b $C8 ; »
		dc.b $C7 ; «
		dc.b $C4 ; ƒ
		dc.b $C4 ; ƒ
		dc.b $C5 ; ≈
		dc.b $C6 ; ∆
		dc.b $C8 ; »
		dc.b $C8 ; »
		dc.b $C8 ; »
		dc.b $CA ;  
		dc.b $CA ;  
		dc.b $CB ; À
		dc.b $CB ; À
		dc.b $CC ; Ã
		dc.b $CD ; Õ
		dc.b $CF ; œ
		dc.b $D1 ; —
		dc.b $D2 ; “
		dc.b $D2 ; “
		dc.b $CF ; œ
		dc.b $CD ; Õ
		dc.b $CC ; Ã
		dc.b $CC ; Ã
		dc.b $CA ;  
		dc.b $C9 ; …
		dc.b $C8 ; »
		dc.b $C8 ; »
		dc.b $C8 ; »
		dc.b $C5 ; ≈
		dc.b $C1 ; ¡
		dc.b $BC ; º
		dc.b $B7 ; ∑
		dc.b $B2 ; ≤
		dc.b $AD ; ≠
		dc.b $A8 ; ®
		dc.b $A0 ; †
		dc.b $99 ; ô
		dc.b $94 ; î
		dc.b $8E ; é
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $80 ; Ä
		dc.b   3
		dc.b   7
		dc.b  $B
		dc.b  $E
		dc.b $11
		dc.b $13
		dc.b $14
		dc.b $17
		dc.b $1B
		dc.b $22 ; "
		dc.b $2A ; *
		dc.b $33 ; 3
		dc.b $3C ; <
		dc.b $44 ; D
		dc.b $4C ; L
		dc.b $52 ; R
		dc.b $55 ; U
		dc.b $55 ; U
		dc.b $56 ; V
		dc.b $58 ; X
		dc.b $5C ; \
		dc.b $63 ; c
		dc.b $6A ; j
		dc.b $70 ; p
		dc.b $73 ; s
		dc.b $71 ; q
		dc.b $6D ; m
		dc.b $68 ; h
		dc.b $64 ; d
		dc.b $60 ; `
		dc.b $5D ; ]
		dc.b $5A ; Z
		dc.b $56 ; V
		dc.b $51 ; Q
		dc.b $4B ; K
		dc.b $47 ; G
		dc.b $43 ; C
		dc.b $43 ; C
		dc.b $43 ; C
		dc.b $46 ; F
		dc.b $49 ; I
		dc.b $4B ; K
		dc.b $4D ; M
		dc.b $4D ; M
		dc.b $49 ; I
		dc.b $42 ; B
		dc.b $39 ; 9
		dc.b $30 ; 0
		dc.b $29 ; )
		dc.b $24 ; $
		dc.b $23 ; #
		dc.b $22 ; "
		dc.b $1F
		dc.b $1B
		dc.b $17
		dc.b $12
		dc.b  $E
		dc.b  $B
		dc.b   6
		dc.b   1
		dc.b $85 ; Ö
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b $95 ; ï
		dc.b $9B ; õ
		dc.b $A2 ; ¢
		dc.b $A7 ; ß
		dc.b $AB ; ´
		dc.b $AD ; ≠
		dc.b $AD ; ≠
		dc.b $AD ; ≠
		dc.b $AB ; ´
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $AD ; ≠
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $AD ; ≠
		dc.b $AB ; ´
		dc.b $AA ; ™
		dc.b $AB ; ´
		dc.b $AD ; ≠
		dc.b $B1 ; ±
		dc.b $B4 ; ¥
		dc.b $B6 ; ∂
		dc.b $B6 ; ∂
		dc.b $B4 ; ¥
		dc.b $B1 ; ±
		dc.b $B1 ; ±
		dc.b $B2 ; ≤
		dc.b $B2 ; ≤
		dc.b $B3 ; ≥
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AD ; ≠
		dc.b $AD ; ≠
		dc.b $AE ; Æ
		dc.b $AF ; Ø
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $AC ; ¨
		dc.b $AA ; ™
		dc.b $A6 ; ¶
		dc.b $A5 ; •
		dc.b $A5 ; •
		dc.b $A6 ; ¶
		dc.b $A4 ; §
		dc.b $A4 ; §
		dc.b $A5 ; •
		dc.b $A0 ; †
		dc.b $A6 ; ¶
		dc.b $A5 ; •
		dc.b $AA ; ™
		dc.b $B1 ; ±
		dc.b $B4 ; ¥
		dc.b $BB ; ª
		dc.b $B9 ; π
		dc.b $B6 ; ∂
		dc.b $B0 ; ∞
		dc.b $AD ; ≠
		dc.b $A6 ; ¶
		dc.b $9E ; û
		dc.b $98 ; ò
		dc.b $8F ; è
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b   1
		dc.b $80 ; Ä
		dc.b   1
		dc.b $82 ; Ç
		dc.b   4
		dc.b   2
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   3
		dc.b  $B
		dc.b  $E
		dc.b $13
		dc.b $13
		dc.b $19
		dc.b $25 ; %
		dc.b $30 ; 0
		dc.b $3A ; :
		dc.b $40 ; @
		dc.b $41 ; A
		dc.b $44 ; D
		dc.b $45 ; E
		dc.b $46 ; F
		dc.b $49 ; I
		dc.b $4C ; L
		dc.b $50 ; P
		dc.b $59 ; Y
		dc.b $5F ; _
		dc.b $5D ; ]
		dc.b $58 ; X
		dc.b $53 ; S
		dc.b $54 ; T
		dc.b $5A ; Z
		dc.b $64 ; d
		dc.b $6A ; j
		dc.b $6B ; k
		dc.b $65 ; e
		dc.b $5E ; ^
		dc.b $58 ; X
		dc.b $54 ; T
		dc.b $4C ; L
		dc.b $3F ; ?
		dc.b $34 ; 4
		dc.b $2E ; .
		dc.b $2C ; ,
		dc.b $2E ; .
		dc.b $2B ; +
		dc.b $26 ; &
		dc.b $21 ; !
		dc.b $1A
		dc.b $16
		dc.b  $F
		dc.b  $B
		dc.b   9
		dc.b   4
		dc.b   1
		dc.b $83 ; É
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8B ; ã
		dc.b $8E ; é
		dc.b $95 ; ï
		dc.b $9C ; ú
		dc.b $A6 ; ¶
		dc.b $AC ; ¨
		dc.b $AF ; Ø
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $B1 ; ±
		dc.b $B4 ; ¥
		dc.b $BA ; ∫
		dc.b $BF ; ø
		dc.b $C3 ; √
		dc.b $C5 ; ≈
		dc.b $C6 ; ∆
		dc.b $C5 ; ≈
		dc.b $C2 ; ¬
		dc.b $C2 ; ¬
		dc.b $C3 ; √
		dc.b $C4 ; ƒ
		dc.b $C6 ; ∆
		dc.b $C6 ; ∆
		dc.b $C8 ; »
		dc.b $C9 ; …
		dc.b $C9 ; …
		dc.b $CA ;  
		dc.b $CA ;  
		dc.b $CC ; Ã
		dc.b $CE ; Œ
		dc.b $CF ; œ
		dc.b $CF ; œ
		dc.b $D1 ; —
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b $80 ; Ä
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   3
		dc.b   4
		dc.b   5
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b  $A
		dc.b   9
		dc.b  $B
		dc.b  $C
		dc.b  $E
		dc.b $11
		dc.b $13
		dc.b $13
		dc.b $14
		dc.b $14
		dc.b $15
		dc.b $17
		dc.b $19
		dc.b $1B
		dc.b $1C
		dc.b $1C
		dc.b $1D
		dc.b $1D
		dc.b $1E
		dc.b $1D
		dc.b $1C
		dc.b $1B
		dc.b $1A
		dc.b $1A
		dc.b $1A
		dc.b $18
		dc.b $16
		dc.b $14
		dc.b $13
		dc.b $12
		dc.b $11
		dc.b  $F
		dc.b  $E
		dc.b  $C
		dc.b  $C
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $B
		dc.b   9
		dc.b   9
		dc.b   8
		dc.b  $A
		dc.b   9
		dc.b   9
		dc.b   7
		dc.b   6
		dc.b   7
		dc.b   9
		dc.b   8
		dc.b   8
		dc.b   7
		dc.b   8
		dc.b  $C
		dc.b  $D
		dc.b  $D
		dc.b  $C
		dc.b  $D
		dc.b $11
		dc.b $13
		dc.b $16
		dc.b $19
		dc.b $1C
		dc.b $22 ; "
		dc.b $31 ; 1
		dc.b $41 ; A
		dc.b $4E ; N
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $20
		dc.b $C8 ; »
		dc.b $C7 ; «
		dc.b $B7 ; ∑
		dc.b $BE ; æ
		dc.b $ED ; Ì
		dc.b $BF ; ø
		dc.b $BE ; æ
		dc.b $D8 ; ÿ
		dc.b $E2 ; ‚
		dc.b $E0 ; ‡
		dc.b $FE ; ˛
		dc.b $CE ; Œ
		dc.b $BB ; ª
		dc.b $C6 ; ∆
		dc.b $D2 ; “
		dc.b $BB ; ª
		dc.b $BF ; ø
		dc.b $B2 ; ≤
		dc.b $B2 ; ≤
		dc.b $AE ; Æ
		dc.b $AF ; Ø
		dc.b $A7 ; ß
		dc.b $9A ; ö
		dc.b $9D ; ù
		dc.b $92 ; í
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $91 ; ë
		dc.b $83 ; É
		dc.b $88 ; à
		dc.b $83 ; É
		dc.b  $C
		dc.b  $E
		dc.b  $C
		dc.b  $C
		dc.b  $C
		dc.b  $B
		dc.b $13
		dc.b $17
		dc.b $1A
		dc.b $1B
		dc.b $1D
		dc.b $19
		dc.b $17
		dc.b $1D
		dc.b $1E
		dc.b $1D
		dc.b $23 ; #
		dc.b $22 ; "
		dc.b $1C
		dc.b $1F
		dc.b $17
		dc.b $1E
		dc.b $1C
		dc.b $1F
		dc.b $1F
		dc.b $1F
		dc.b $19
		dc.b $13
		dc.b $1A
		dc.b $20
		dc.b $1A
		dc.b $15
		dc.b $1B
		dc.b $11
		dc.b $12
		dc.b $16
		dc.b  $B
		dc.b $13
		dc.b  $B
		dc.b $16
		dc.b   1
		dc.b  $D
		dc.b $81 ; Å
		dc.b  $C
		dc.b   1
		dc.b   5
		dc.b   3
		dc.b $81 ; Å
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $8C ; å
		dc.b   9
		dc.b $95 ; ï
		dc.b $89 ; â
		dc.b   1
		dc.b $99 ; ô
		dc.b $95 ; ï
		dc.b $87 ; á
		dc.b $91 ; ë
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $83 ; É
		dc.b $A2 ; ¢
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $C0 ; ¿
		dc.b $AD ; ≠
		dc.b $86 ; Ü
		dc.b $9E ; û
		dc.b $94 ; î
		dc.b $92 ; í
		dc.b $9F ; ü
		dc.b $A3 ; £
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $8E ; é
		dc.b $11
		dc.b $23 ; #
		dc.b $1B
		dc.b $34 ; 4
		dc.b $42 ; B
		dc.b $37 ; 7
		dc.b $35 ; 5
		dc.b $3B ; ;
		dc.b $3F ; ?
		dc.b $46 ; F
		dc.b $4E ; N
		dc.b $33 ; 3
		dc.b $2C ; ,
		dc.b $30 ; 0
		dc.b $1D
		dc.b $8C ; å
		dc.b $A2 ; ¢
		dc.b $A5 ; •
		dc.b $99 ; ô
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $B5 ; µ
		dc.b $C6 ; ∆
		dc.b $C6 ; ∆
		dc.b $BF ; ø
		dc.b $C4 ; ƒ
		dc.b $C4 ; ƒ
		dc.b $BA ; ∫
		dc.b $BE ; æ
		dc.b $BB ; ª
		dc.b $C0 ; ¿
		dc.b $B8 ; ∏
		dc.b $B7 ; ∑
		dc.b $BD ; Ω
		dc.b $B7 ; ∑
		dc.b $B4 ; ¥
		dc.b $AD ; ≠
		dc.b $AE ; Æ
		dc.b $AB ; ´
		dc.b $A9 ; ©
		dc.b $A7 ; ß
		dc.b $A8 ; ®
		dc.b $A2 ; ¢
		dc.b $A0 ; †
		dc.b $A1 ; °
		dc.b $9A ; ö
		dc.b $98 ; ò
		dc.b $9B ; õ
		dc.b $96 ; ñ
		dc.b $9B ; õ
		dc.b $90 ; ê
		dc.b $96 ; ñ
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $88 ; à
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b $8A ; ä
		dc.b $80 ; Ä
		dc.b $88 ; à
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b   4
		dc.b $83 ; É
		dc.b   4
		dc.b   3
		dc.b   4
		dc.b   3
		dc.b   2
		dc.b   5
		dc.b   7
		dc.b   6
		dc.b $11
		dc.b   8
		dc.b   5
		dc.b $13
		dc.b   6
		dc.b  $A
		dc.b  $F
		dc.b  $E
		dc.b  $D
		dc.b $14
		dc.b $13
		dc.b   7
		dc.b  $F
		dc.b $1D
		dc.b $80 ; Ä
		dc.b  $C
		dc.b $23 ; #
		dc.b $80 ; Ä
		dc.b   9
		dc.b $1B
		dc.b $87 ; á
		dc.b   7
		dc.b $18
		dc.b $13
		dc.b $91 ; ë
		dc.b   8
		dc.b $1E
		dc.b $89 ; â
		dc.b  $C
		dc.b $82 ; Ç
		dc.b $91 ; ë
		dc.b   4
		dc.b $11
		dc.b   7
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $8E ; é
		dc.b $93 ; ì
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b $82 ; Ç
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $8B ; ã
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   2
		dc.b  $E
		dc.b $17
		dc.b $2F ; /
		dc.b $37 ; 7
		dc.b $32 ; 2
		dc.b $41 ; A
		dc.b $46 ; F
		dc.b $4C ; L
		dc.b $45 ; E
		dc.b $50 ; P
		dc.b $4D ; M
		dc.b $5A ; Z
		dc.b $5E ; ^
		dc.b $50 ; P
		dc.b $31 ; 1
		dc.b $14
		dc.b   6
		dc.b   7
		dc.b   8
		dc.b $80 ; Ä
		dc.b $90 ; ê
		dc.b $98 ; ò
		dc.b $A7 ; ß
		dc.b $AA ; ™
		dc.b $B2 ; ≤
		dc.b $AF ; Ø
		dc.b $B5 ; µ
		dc.b $B4 ; ¥
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B2 ; ≤
		dc.b $AD ; ≠
		dc.b $B2 ; ≤
		dc.b $AD ; ≠
		dc.b $AE ; Æ
		dc.b $AC ; ¨
		dc.b $AD ; ≠
		dc.b $A5 ; •
		dc.b $A6 ; ¶
		dc.b $9D ; ù
		dc.b $A0 ; †
		dc.b $9E ; û
		dc.b $A5 ; •
		dc.b $9E ; û
		dc.b $97 ; ó
		dc.b $97 ; ó
		dc.b $99 ; ô
		dc.b $91 ; ë
		dc.b $99 ; ô
		dc.b $90 ; ê
		dc.b $96 ; ñ
		dc.b $94 ; î
		dc.b $90 ; ê
		dc.b $90 ; ê
		dc.b $91 ; ë
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $92 ; í
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b $80 ; Ä
		dc.b $83 ; É
		dc.b $89 ; â
		dc.b $12
		dc.b $8B ; ã
		dc.b   1
		dc.b  $D
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b  $D
		dc.b  $E
		dc.b   1
		dc.b  $C
		dc.b $17
		dc.b $8B ; ã
		dc.b  $F
		dc.b $18
		dc.b   2
		dc.b  $B
		dc.b $1F
		dc.b  $B
		dc.b   6
		dc.b $13
		dc.b $12
		dc.b  $C
		dc.b  $F
		dc.b $14
		dc.b   2
		dc.b  $E
		dc.b $1D
		dc.b   1
		dc.b   4
		dc.b   2
		dc.b $10
		dc.b  $C
		dc.b   7
		dc.b   7
		dc.b $86 ; Ü
		dc.b $87 ; á
		dc.b   4
		dc.b   3
		dc.b  $B
		dc.b   1
		dc.b   1
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8D ; ç
		dc.b $87 ; á
		dc.b $8C ; å
		dc.b $86 ; Ü
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $8C ; å
		dc.b $92 ; í
		dc.b $8D ; ç
		dc.b $81 ; Å
		dc.b   1
		dc.b  $E
		dc.b $13
		dc.b $21 ; !
		dc.b $28 ; (
		dc.b $3B ; ;
		dc.b $40 ; @
		dc.b $3D ; =
		dc.b $3B ; ;
		dc.b $44 ; D
		dc.b $50 ; P
		dc.b $61 ; a
		dc.b $6A ; j
		dc.b $5A ; Z
		dc.b $49 ; I
		dc.b $3B ; ;
		dc.b $20
		dc.b $21 ; !
		dc.b $17
		dc.b  $F
		dc.b  $C
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b $9C ; ú
		dc.b $A2 ; ¢
		dc.b $A3 ; £
		dc.b $AC ; ¨
		dc.b $AA ; ™
		dc.b $AC ; ¨
		dc.b $AC ; ¨
		dc.b $A9 ; ©
		dc.b $A9 ; ©
		dc.b $A8 ; ®
		dc.b $AE ; Æ
		dc.b $A5 ; •
		dc.b $AD ; ≠
		dc.b $A0 ; †
		dc.b $9F ; ü
		dc.b $A1 ; °
		dc.b $9D ; ù
		dc.b $9D ; ù
		dc.b $99 ; ô
		dc.b $9A ; ö
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $95 ; ï
		dc.b $88 ; à
		dc.b $93 ; ì
		dc.b $92 ; í
		dc.b $82 ; Ç
		dc.b $8B ; ã
		dc.b $90 ; ê
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b $90 ; ê
		dc.b $81 ; Å
		dc.b   5
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $11
		dc.b $88 ; à
		dc.b $86 ; Ü
		dc.b $13
		dc.b $82 ; Ç
		dc.b $81 ; Å
		dc.b $12
		dc.b   8
		dc.b   2
		dc.b   8
		dc.b $17
		dc.b $81 ; Å
		dc.b   8
		dc.b $15
		dc.b   4
		dc.b  $D
		dc.b $12
		dc.b  $E
		dc.b  $E
		dc.b $13
		dc.b $11
		dc.b  $A
		dc.b $10
		dc.b $1B
		dc.b $15
		dc.b  $C
		dc.b $12
		dc.b $13
		dc.b $1B
		dc.b $16
		dc.b  $F
		dc.b  $C
		dc.b  $F
		dc.b $1A
		dc.b $15
		dc.b  $C
		dc.b  $F
		dc.b   3
		dc.b  $A
		dc.b  $B
		dc.b $12
		dc.b  $D
		dc.b   4
		dc.b $81 ; Å
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   7
		dc.b   6
		dc.b   5
		dc.b $80 ; Ä
		dc.b   3
		dc.b $86 ; Ü
		dc.b $8A ; ä
		dc.b $91 ; ë
		dc.b $8A ; ä
		dc.b   4
		dc.b $88 ; à
		dc.b $85 ; Ö
		dc.b $8E ; é
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $88 ; à
		dc.b   4
		dc.b $16
		dc.b $1F
		dc.b $2B ; +
		dc.b $2D ; -
		dc.b $33 ; 3
		dc.b $2B ; +
		dc.b $3E ; >
		dc.b $47 ; G
		dc.b $57 ; W
		dc.b $5E ; ^
		dc.b $60 ; `
		dc.b $56 ; V
		dc.b $4F ; O
		dc.b $3D ; =
		dc.b $32 ; 2
		dc.b $25 ; %
		dc.b $20
		dc.b  $F
		dc.b $13
		dc.b $82 ; Ç
		dc.b $8C ; å
		dc.b $91 ; ë
		dc.b $9C ; ú
		dc.b $AE ; Æ
		dc.b $A9 ; ©
		dc.b $AB ; ´
		dc.b $B6 ; ∂
		dc.b $A8 ; ®
		dc.b $AA ; ™
		dc.b $B7 ; ∑
		dc.b $B0 ; ∞
		dc.b $AE ; Æ
		dc.b $B2 ; ≤
		dc.b $B5 ; µ
		dc.b $9D ; ù
		dc.b $AE ; Æ
		dc.b $AE ; Æ
		dc.b $9B ; õ
		dc.b $A8 ; ®
		dc.b $A9 ; ©
		dc.b $95 ; ï
		dc.b $9C ; ú
		dc.b $A2 ; ¢
		dc.b $95 ; ï
		dc.b $8D ; ç
		dc.b $9F ; ü
		dc.b $94 ; î
		dc.b $86 ; Ü
		dc.b $96 ; ñ
		dc.b $96 ; ñ
		dc.b   1
		dc.b $90 ; ê
		dc.b $92 ; í
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $87 ; á
		dc.b $86 ; Ü
		dc.b $80 ; Ä
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   9
		dc.b $84 ; Ñ
		dc.b   1
		dc.b   7
		dc.b   9
		dc.b   8
		dc.b   2
		dc.b  $E
		dc.b  $C
		dc.b   4
		dc.b   9
		dc.b   9
		dc.b $11
		dc.b $11
		dc.b  $F
		dc.b   8
		dc.b  $A
		dc.b $17
		dc.b $12
		dc.b $10
		dc.b  $C
		dc.b $15
		dc.b $14
		dc.b $18
		dc.b $14
		dc.b $13
		dc.b $12
		dc.b $10
		dc.b $13
		dc.b $20
		dc.b $17
		dc.b $12
		dc.b  $B
		dc.b  $D
		dc.b  $D
		dc.b $1A
		dc.b $17
		dc.b  $C
		dc.b  $A
		dc.b  $A
		dc.b   7
		dc.b   4
		dc.b   9
		dc.b  $A
		dc.b  $B
		dc.b $11
		dc.b   8
		dc.b $81 ; Å
		dc.b $83 ; É
		dc.b $81 ; Å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b   1
		dc.b $86 ; Ü
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $8A ; ä
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $85 ; Ö
		dc.b  $B
		dc.b $10
		dc.b $1E
		dc.b $23 ; #
		dc.b $1E
		dc.b $27 ; '
		dc.b $30 ; 0
		dc.b $36 ; 6
		dc.b $40 ; @
		dc.b $55 ; U
		dc.b $56 ; V
		dc.b $52 ; R
		dc.b $61 ; a
		dc.b $4D ; M
		dc.b $3C ; <
		dc.b $45 ; E
		dc.b $2D ; -
		dc.b $16
		dc.b $27 ; '
		dc.b $1A
		dc.b $84 ; Ñ
		dc.b   6
		dc.b $8A ; ä
		dc.b $A5 ; •
		dc.b $A6 ; ¶
		dc.b $9C ; ú
		dc.b $AE ; Æ
		dc.b $B1 ; ±
		dc.b $9D ; ù
		dc.b $B2 ; ≤
		dc.b $B9 ; π
		dc.b $A8 ; ®
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $AC ; ¨
		dc.b $A4 ; §
		dc.b $AD ; ≠
		dc.b $AD ; ≠
		dc.b $9D ; ù
		dc.b $A7 ; ß
		dc.b $A4 ; §
		dc.b $9B ; õ
		dc.b $9C ; ú
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $95 ; ï
		dc.b $8B ; ã
		dc.b $8F ; è
		dc.b $94 ; î
		dc.b $8D ; ç
		dc.b $87 ; á
		dc.b $8D ; ç
		dc.b $8B ; ã
		dc.b $87 ; á
		dc.b $83 ; É
		dc.b $86 ; Ü
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b   2
		dc.b   1
		dc.b $85 ; Ö
		dc.b   3
		dc.b   5
		dc.b  $A
		dc.b   4
		dc.b   1
		dc.b $81 ; Å
		dc.b  $B
		dc.b  $A
		dc.b   6
		dc.b   7
		dc.b   9
		dc.b   7
		dc.b  $C
		dc.b  $E
		dc.b  $B
		dc.b   6
		dc.b  $C
		dc.b  $A
		dc.b $12
		dc.b $15
		dc.b $11
		dc.b   6
		dc.b  $A
		dc.b $11
		dc.b $12
		dc.b $16
		dc.b $12
		dc.b   9
		dc.b  $B
		dc.b  $D
		dc.b  $E
		dc.b   9
		dc.b  $F
		dc.b  $D
		dc.b  $A
		dc.b  $A
		dc.b $82 ; Ç
		dc.b $82 ; Ç
		dc.b   2
		dc.b   5
		dc.b   9
		dc.b   7
		dc.b   2
		dc.b $84 ; Ñ
		dc.b   4
		dc.b $85 ; Ö
		dc.b $8A ; ä
		dc.b $86 ; Ü
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $80 ; Ä
		dc.b $81 ; Å
		dc.b $90 ; ê
		dc.b $8E ; é
		dc.b $93 ; ì
		dc.b $A0 ; †
		dc.b $8E ; é
		dc.b $86 ; Ü
		dc.b $86 ; Ü
		dc.b   3
		dc.b $12
		dc.b  $C
		dc.b  $A
		dc.b $22 ; "
		dc.b $22 ; "
		dc.b $25 ; %
		dc.b $3E ; >
		dc.b $43 ; C
		dc.b $41 ; A
		dc.b $52 ; R
		dc.b $56 ; V
		dc.b $49 ; I
		dc.b $40 ; @
		dc.b $45 ; E
		dc.b $29 ; )
		dc.b $21 ; !
		dc.b $2A ; *
		dc.b $1C
		dc.b   9
		dc.b   9
		dc.b $8F ; è
		dc.b $98 ; ò
		dc.b $A1 ; °
		dc.b $9E ; û
		dc.b $A3 ; £
		dc.b $AB ; ´
		dc.b $A9 ; ©
		dc.b $AA ; ™
		dc.b $B3 ; ≥
		dc.b $AD ; ≠
		dc.b $B0 ; ∞
		dc.b $AE ; Æ
		dc.b $AF ; Ø
		dc.b $A6 ; ¶
		dc.b $A7 ; ß
		dc.b $AC ; ¨
		dc.b $A5 ; •
		dc.b $A1 ; °
		dc.b $A2 ; ¢
		dc.b $9F ; ü
		dc.b $9C ; ú
		dc.b $9C ; ú
		dc.b $95 ; ï
		dc.b $94 ; î
		dc.b $98 ; ò
		dc.b $94 ; î
		dc.b $8F ; è
		dc.b $8F ; è
		dc.b $90 ; ê
		dc.b $8F ; è
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $88 ; à
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b   5
		dc.b   7
		dc.b $81 ; Å
		dc.b   3
		dc.b   5
		dc.b   2
		dc.b   5
		dc.b  $A
		dc.b   8
		dc.b   2
		dc.b  $B
		dc.b  $E
		dc.b  $D
		dc.b  $E
		dc.b   9
		dc.b   7
		dc.b  $C
		dc.b $17
		dc.b $16
		dc.b $12
		dc.b  $C
		dc.b  $C
		dc.b $14
		dc.b $15
		dc.b $14
		dc.b $17
		dc.b $16
		dc.b  $F
		dc.b $14
		dc.b $11
		dc.b   8
		dc.b $13
		dc.b $19
		dc.b  $F
		dc.b  $F
		dc.b $10
		dc.b   2
		dc.b   1
		dc.b  $E
		dc.b   6
		dc.b $80 ; Ä
		dc.b  $C
		dc.b   5
		dc.b $81 ; Å
		dc.b  $C
		dc.b   6
		dc.b $8C ; å
		dc.b $87 ; á
		dc.b $85 ; Ö
		dc.b $8B ; ã
		dc.b $81 ; Å
		dc.b   5
		dc.b $86 ; Ü
		dc.b $90 ; ê
		dc.b $8C ; å
		dc.b $99 ; ô
		dc.b $9C ; ú
		dc.b $8B ; ã
		dc.b $8A ; ä
		dc.b $8A ; ä
		dc.b $80 ; Ä
		dc.b   4
		dc.b   6
		dc.b   8
		dc.b $16
		dc.b $1A
		dc.b $20
		dc.b $2E ; .
		dc.b $3A ; :
		dc.b $40 ; @
		dc.b $48 ; H
		dc.b $4E ; N
		dc.b $4B ; K
		dc.b $3B ; ;
		dc.b $3C ; <
		dc.b $36 ; 6
		dc.b $2B ; +
		dc.b $2A ; *
		dc.b $24 ; $
		dc.b  $B
		dc.b   3
		dc.b $84 ; Ñ
		dc.b $92 ; í
		dc.b $9A ; ö
		dc.b $A1 ; °
		dc.b $A5 ; •
		dc.b $A9 ; ©
		dc.b $A9 ; ©
		dc.b $B1 ; ±
		dc.b $B5 ; µ
		dc.b $AE ; Æ
		dc.b $B3 ; ≥
		dc.b $B4 ; ¥
		dc.b $B3 ; ≥
		dc.b $B3 ; ≥
		dc.b $AC ; ¨
		dc.b $AA ; ™
		dc.b $AD ; ≠
		dc.b $AE ; Æ
		dc.b $A6 ; ¶
		dc.b $A2 ; ¢
		dc.b $A8 ; ®
		dc.b $A2 ; ¢
		dc.b $9C ; ú
		dc.b $9A ; ö
		dc.b $9B ; õ
		dc.b $99 ; ô
		dc.b $9C ; ú
		dc.b $9A ; ö
		dc.b $8F ; è
		dc.b $90 ; ê
		dc.b $99 ; ô
		dc.b $96 ; ñ
		dc.b $8E ; é
		dc.b $8F ; è
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b   2
		dc.b $80 ; Ä
		dc.b   3
		dc.b $81 ; Å
		dc.b $86 ; Ü
		dc.b   1
		dc.b  $B
		dc.b   9
		dc.b   8
		dc.b   6
		dc.b   2
		dc.b   4
		dc.b $10
		dc.b  $C
		dc.b  $B
		dc.b $11
		dc.b $10
		dc.b   7
		dc.b  $F
		dc.b $10
		dc.b  $C
		dc.b $15
		dc.b $18
		dc.b  $F
		dc.b  $E
		dc.b $11
		dc.b  $E
		dc.b   9
		dc.b $15
		dc.b $15
		dc.b  $C
		dc.b  $F
		dc.b  $D
		dc.b   4
		dc.b   3
		dc.b  $A
		dc.b   5
		dc.b   1
		dc.b   9
		dc.b   9
		dc.b $80 ; Ä
		dc.b   9
		dc.b   7
		dc.b $8A ; ä
		dc.b $89 ; â
		dc.b $84 ; Ñ
		dc.b $88 ; à
		dc.b $82 ; Ç
		dc.b   4
		dc.b $82 ; Ç
		dc.b $90 ; ê
		dc.b $8B ; ã
		dc.b $95 ; ï
		dc.b $9C ; ú
		dc.b $8E ; é
		dc.b $88 ; à
		dc.b $8B ; ã
		dc.b $81 ; Å
		dc.b   4
		dc.b   7
		dc.b   7
		dc.b $14
		dc.b $1A
		dc.b $1F
		dc.b $2A ; *
		dc.b $39 ; 9
		dc.b $3E ; >
		dc.b $46 ; F
		dc.b $4D ; M
		dc.b $4D ; M
		dc.b $3E ; >
		dc.b $3B ; ;
		dc.b $39 ; 9
		dc.b $2C ; ,
		dc.b $29 ; )
		dc.b $27 ; '
		dc.b $10
		dc.b   5
		dc.b $82 ; Ç
		dc.b $8E ; é
		dc.b $98 ; ò
		dc.b $9F ; ü
		dc.b $A3 ; £
		dc.b $A8 ; ®
		dc.b $A7 ; ß
		dc.b $AF ; Ø
		dc.b $B4 ; ¥
		dc.b $AE ; Æ
		dc.b $B0 ; ∞
		dc.b $B3 ; ≥
		dc.b $B2 ; ≤
		dc.b $B1 ; ±
		dc.b $AD ; ≠
		dc.b $A9 ; ©
		dc.b $AB ; ´
		dc.b $AE ; Æ
		dc.b $A7 ; ß
		dc.b $A1 ; °
		dc.b $A6 ; ¶
		dc.b $A4 ; §
		dc.b $9C ; ú
		dc.b $99 ; ô
		dc.b $9B ; õ
		dc.b $98 ; ò
		dc.b $9B ; õ
		dc.b $9B ; õ
		dc.b $90 ; ê
		dc.b $8E ; é
		dc.b $97 ; ó
		dc.b $97 ; ó
		dc.b $8F ; è
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $8D ; ç
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $89 ; â
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b   1
		dc.b   1
		dc.b   3
		dc.b   1
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b  $B
		dc.b  $A
		dc.b   8
		dc.b   8
		dc.b   3
		dc.b   3
		dc.b  $D
		dc.b  $E
		dc.b  $B
		dc.b  $F
		dc.b $12
		dc.b   7
		dc.b  $E
		dc.b $12
		dc.b  $D
		dc.b $13
		dc.b $19
		dc.b $12
		dc.b  $D
		dc.b $11
		dc.b  $F
		dc.b   9
		dc.b $13
		dc.b $17
		dc.b  $D
		dc.b  $E
		dc.b  $F
		dc.b   6
		dc.b   2
		dc.b   9
		dc.b   6
		dc.b   1
		dc.b   7
		dc.b  $C
		dc.b $80 ; Ä
		dc.b   7
		dc.b   9
		dc.b $86 ; Ü
		dc.b $8A ; ä
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $84 ; Ñ
		dc.b   4
		dc.b   2
		dc.b $8E ; é
		dc.b $8B ; ã
		dc.b $92 ; í
		dc.b $9B ; õ
		dc.b $92 ; í
		dc.b $87 ; á
		dc.b $8B ; ã
		dc.b $83 ; É
		dc.b   4
		dc.b   6
		dc.b   7
		dc.b $10
		dc.b $19
		dc.b $1D
		dc.b $26 ; &
		dc.b $36 ; 6
		dc.b $3D ; =
		dc.b $44 ; D
		dc.b $4B ; K
		dc.b $4D ; M
		dc.b $42 ; B
		dc.b $3A ; :
		dc.b $3B ; ;
		dc.b $2F ; /
		dc.b $29 ; )
		dc.b $2A ; *
		dc.b $15
		dc.b   7
		dc.b $80 ; Ä
		dc.b $8A ; ä
		dc.b $96 ; ñ
		dc.b $9C ; ú
		dc.b $A1 ; °
		dc.b $A7 ; ß
		dc.b $A6 ; ¶
		dc.b $AC ; ¨
		dc.b $B2 ; ≤
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $B2 ; ≤
		dc.b $B2 ; ≤
		dc.b $B0 ; ∞
		dc.b $AF ; Ø
		dc.b $A8 ; ®
		dc.b $A9 ; ©
		dc.b $AD ; ≠
		dc.b $A8 ; ®
		dc.b $A1 ; °
		dc.b $A3 ; £
		dc.b $A5 ; •
		dc.b $9C ; ú
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $97 ; ó
		dc.b $9A ; ö
		dc.b $9A ; ö
		dc.b $92 ; í
		dc.b $8D ; ç
		dc.b $94 ; î
		dc.b $98 ; ò
		dc.b $90 ; ê
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $89 ; â
		dc.b $8C ; å
		dc.b $8E ; é
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b   2
		dc.b   3
		dc.b   2
		dc.b $82 ; Ç
		dc.b $84 ; Ñ
		dc.b  $A
		dc.b  $B
		dc.b   8
		dc.b   9
		dc.b   4
		dc.b   3
		dc.b  $B
		dc.b $10
		dc.b  $B
		dc.b  $E
		dc.b $13
		dc.b   9
		dc.b  $C
		dc.b $12
		dc.b  $D
		dc.b $11
		dc.b $18
		dc.b $14
		dc.b  $D
		dc.b $11
		dc.b $11
		dc.b  $A
		dc.b $10
		dc.b $18
		dc.b  $F
		dc.b  $E
		dc.b $10
		dc.b   9
		dc.b   3
		dc.b   8
		dc.b   8
		dc.b   2
		dc.b   5
		dc.b  $D
		dc.b   2
		dc.b   5
		dc.b  $A
		dc.b $82 ; Ç
		dc.b $8B ; ã
		dc.b $84 ; Ñ
		dc.b $85 ; Ö
		dc.b $86 ; Ü
		dc.b   3
		dc.b   4
		dc.b $8B ; ã
		dc.b $8C ; å
		dc.b $8F ; è
		dc.b $99 ; ô
		dc.b $95 ; ï
		dc.b $87 ; á
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b   4
		dc.b   6
		dc.b   8
		dc.b  $D
		dc.b $19
		dc.b $1C
		dc.b $23 ; #
		dc.b $34 ; 4
		dc.b $3B ; ;
		dc.b $42 ; B
		dc.b $49 ; I
		dc.b $4D ; M
		dc.b $45 ; E
		dc.b $39 ; 9
		dc.b $3C ; <
		dc.b $31 ; 1
		dc.b $29 ; )
		dc.b $2A ; *
		dc.b $1B
		dc.b   8
		dc.b   2
		dc.b $87 ; á
		dc.b $94 ; î
		dc.b $9A ; ö
		dc.b $A0 ; †
		dc.b $A5 ; •
		dc.b $A6 ; ¶
		dc.b $A9 ; ©
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $AC ; ¨
		dc.b $B1 ; ±
		dc.b $B1 ; ±
		dc.b $AF ; Ø
		dc.b $AF ; Ø
		dc.b $A7 ; ß
		dc.b $A8 ; ®
		dc.b $AB ; ´
		dc.b $A9 ; ©
		dc.b $A2 ; ¢
		dc.b $A1 ; °
		dc.b $A6 ; ¶
		dc.b $9D ; ù
		dc.b $99 ; ô
		dc.b $99 ; ô
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $9A ; ö
		dc.b $94 ; î
		dc.b $8D ; ç
		dc.b $91 ; ë
		dc.b $97 ; ó
		dc.b $91 ; ë
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $89 ; â
		dc.b $8A ; ä
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $85 ; Ö
		dc.b $83 ; É
		dc.b   3
		dc.b   2
		dc.b   3
		dc.b $81 ; Å
		dc.b $85 ; Ö
		dc.b   8
		dc.b  $B
		dc.b   9
		dc.b   9
		dc.b   5
		dc.b   3
		dc.b   8
		dc.b $11
		dc.b  $B
		dc.b  $D
		dc.b $13
		dc.b  $B
		dc.b  $A
		dc.b $11
		dc.b  $F
		dc.b $10
		dc.b $18
		dc.b $17
		dc.b  $E
		dc.b $10
		dc.b $11
		dc.b  $C
		dc.b  $D
		dc.b $18
		dc.b $11
		dc.b  $D
		dc.b $10
		dc.b  $B
		dc.b   3
		dc.b   7
		dc.b   9
		dc.b   3
		dc.b   3
		dc.b  $D
		dc.b   4
		dc.b   4
		dc.b  $B
		dc.b   2
		dc.b $8A ; ä
		dc.b $85 ; Ö
		dc.b $84 ; Ñ
		dc.b $86 ; Ü
		dc.b   2
		dc.b   5
		dc.b $87 ; á
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $88 ; à
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b   3
		dc.b   5
		dc.b   8
		dc.b  $B
		dc.b $18
		dc.b $1B
		dc.b $21 ; !
		dc.b $30 ; 0
		dc.b $3A ; :
		dc.b $40 ; @
		dc.b $48 ; H
		dc.b $4C ; L
		dc.b $47 ; G
		dc.b $3A ; :
		dc.b $3C ; <
		dc.b $34 ; 4
		dc.b $2A ; *
		dc.b $2A ; *
		dc.b $20
		dc.b  $B
		dc.b   4
		dc.b $84 ; Ñ
		dc.b $92 ; í
		dc.b $98 ; ò
		dc.b $9F ; ü
		dc.b $A3 ; £
		dc.b $A6 ; ¶
		dc.b $A7 ; ß
		dc.b $AE ; Æ
		dc.b $B0 ; ∞
		dc.b $AA ; ™
		dc.b $B0 ; ∞
		dc.b $B0 ; ∞
		dc.b $AE ; Æ
		dc.b $AF ; Ø
		dc.b $A8 ; ®
		dc.b $A7 ; ß
		dc.b $A9 ; ©
		dc.b $AA ; ™
		dc.b $A2 ; ¢
		dc.b $9F ; ü
		dc.b $A5 ; •
		dc.b $9E ; û
		dc.b $99 ; ô
		dc.b $98 ; ò
		dc.b $98 ; ò
		dc.b $97 ; ó
		dc.b $9A ; ö
		dc.b $96 ; ñ
		dc.b $8D ; ç
		dc.b $8F ; è
		dc.b $97 ; ó
		dc.b $92 ; í
		dc.b $8C ; å
		dc.b $8D ; ç
		dc.b $89 ; â
		dc.b $89 ; â
		dc.b $8D ; ç
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $83 ; É
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   2
		dc.b   4
		dc.b $80 ; Ä
		dc.b $85 ; Ö
		dc.b   5
		dc.b  $C
		dc.b  $A
		dc.b   9
		dc.b   7
		dc.b   4
		dc.b   6
		dc.b $11
		dc.b  $C
		dc.b  $C
		dc.b $12
		dc.b  $E
		dc.b   9
		dc.b $10
		dc.b $10
		dc.b  $E
		dc.b $16
		dc.b $18
		dc.b  $F
		dc.b $10
		dc.b $11
		dc.b  $D
		dc.b  $C
		dc.b $17
		dc.b $14
		dc.b  $D
		dc.b $10
		dc.b  $D
		dc.b   4
		dc.b   6
		dc.b  $A
		dc.b   5
		dc.b   2
		dc.b  $C
		dc.b   7
		dc.b   2
		dc.b  $A
		dc.b   6
		dc.b $89 ; â
		dc.b $86 ; Ü
		dc.b $83 ; É
		dc.b $87 ; á
		dc.b   1
		dc.b   5
		dc.b $83 ; É
		dc.b $8D ; ç
		dc.b $8A ; ä
		dc.b $95 ; ï
		dc.b $98 ; ò
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $88 ; à
		dc.b   1
		dc.b   5
		dc.b   8
		dc.b   9
		dc.b $16
		dc.b $1A
		dc.b $20
		dc.b $2C ; ,
		dc.b $39 ; 9
		dc.b $3E ; >
		dc.b $46 ; F
		dc.b $4B ; K
		dc.b $49 ; I
		dc.b $3B ; ;
		dc.b $3A ; :
		dc.b $36 ; 6
		dc.b $2B ; +
		dc.b $29 ; )
		dc.b $24 ; $
		dc.b  $E
		dc.b   5
		dc.b $82 ; Ç
		dc.b $8E ; é
		dc.b $96 ; ñ
		dc.b $9D ; ù
		dc.b $A1 ; °
		dc.b $A5 ; •
		dc.b $A5 ; •
		dc.b $AC ; ¨
		dc.b $B0 ; ∞
		dc.b $AA ; ™
		dc.b $AE ; Æ
		dc.b $AF ; Ø
		dc.b $AE ; Æ
		dc.b $AE ; Æ
		dc.b $A9 ; ©
		dc.b $A6 ; ¶
		dc.b $A8 ; ®
		dc.b $AA ; ™
		dc.b $A3 ; £
		dc.b $9E ; û
		dc.b $A4 ; §
		dc.b $9F ; ü
		dc.b $99 ; ô
		dc.b $97 ; ó
		dc.b $98 ; ò
		dc.b $96 ; ñ
		dc.b $99 ; ô
		dc.b $97 ; ó
		dc.b $8D ; ç
		dc.b $8D ; ç
		dc.b $95 ; ï
		dc.b $93 ; ì
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $8A ; ä
		dc.b $88 ; à
		dc.b $8C ; å
		dc.b $8C ; å
		dc.b $89 ; â
		dc.b $87 ; á
		dc.b $84 ; Ñ
		dc.b $82 ; Ç
		dc.b $83 ; É
		dc.b $84 ; Ñ
		dc.b   3
		dc.b   2
		dc.b   5
		dc.b   1
		dc.b $84 ; Ñ
		dc.b   2
		dc.b  $C
		dc.b  $A
		dc.b   9
		dc.b   8
		dc.b   4
		dc.b   5
		dc.b $10
		dc.b  $D
		dc.b  $C
		dc.b $11
		dc.b $11
		dc.b   8
		dc.b  $F
		dc.b $11
		dc.b  $E
		dc.b $15
		dc.b $19
		dc.b $11
		dc.b  $F
		dc.b $11
		dc.b  $F
		dc.b  $A
		dc.b $15
		dc.b $16
		dc.b  $D
		dc.b $10
		dc.b  $E
		dc.b   6
		dc.b   4
		dc.b  $A
		dc.b   6
		dc.b   2
		dc.b  $A
		dc.b  $A
		dc.b   2
		dc.b   9
		dc.b   9
		dc.b $87 ; á
		dc.b $87 ; á
		dc.b $82 ; Ç
		dc.b $86 ; Ü
		dc.b $81 ; Å
		dc.b   5
		dc.b   1
		dc.b $8D ; ç
		dc.b $89 ; â
		dc.b $92 ; í
		dc.b $99 ; ô
		dc.b $8D ; ç
		dc.b $87 ; á
		dc.b $89 ; â
		dc.b $80 ; Ä
		dc.b   5
		dc.b   8
		dc.b   8
		dc.b $13
		dc.b $1A
		dc.b $1E
		dc.b $28 ; (
		dc.b $37 ; 7
		dc.b $3C ; <
		dc.b $44 ; D
		dc.b $4A ; J
		dc.b $4A ; J
		dc.b $3E ; >
		dc.b $39 ; 9
		dc.b $38 ; 8
		dc.b $2C ; ,
		dc.b $29 ; )
		dc.b $27 ; '
		dc.b $12
		dc.b   6
		dc.b $80 ; Ä
		dc.b $8B ; ã
		dc.b $95 ; ï
		dc.b $9C ; ú
		dc.b $9F ; ü
		dc.b $A4 ; §
		dc.b $A3 ; £
		dc.b $AB ; ´
		dc.b $AF ; Ø
		dc.b $AB ; ´
		dc.b $AC ; ¨
		dc.b $AE ; Æ
; end of 'PLAYER'

		END
