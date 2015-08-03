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

	addq.b #1, vblankCounter(a5)

	jsr sub_18C26(pc)
	jsr sub_18CA4(pc)
	jsr sub_18E8A(pc)
	jsr sub_18EB0(pc)
	jsr sub_18E2C(pc)
	jsr sub_18948(pc)

	move.b  byte_2(a5), $11(a4)

	movem.l (sp)+, d0-a6
	rts
; End of function playerVblank


; =============== S U B R O U T I N E =======================================


sub_18948:              ; CODE XREF: playerVblank+20p
	clr.b $E(a5)
	lea $80(a5), a3

	moveq #7, d7
	@loc_18952:
		adda.w #$80, a3
		tst.b  (a3)
		bpl.s  @loc_1895E

		jsr sub_18980(pc)

	@loc_1895E:
		dbf d7, @loc_18952

	lea $500(a5), a3
	move.b  #$80, $E(a5)


	moveq #7, d7
	@loc_1896E:
		tst.b (a3)
		bpl.s @loc_18976

		jsr sub_18980(pc)

	@loc_18976:
		adda.w #$80, a3
		dbf d7, @loc_1896E

	rts
; End of function sub_18948


; =============== S U B R O U T I N E =======================================


sub_18980:              ; CODE XREF: sub_18948+12p
					; sub_18948+2Ap
	subq.b #1, $B(a3)
	bne.s  @loc_1899A

	bclr #4, (a3)
	jsr  sub_189A2(pc)
	jsr  sub_18A98(pc)
	jsr  sub_18A66(pc)
	bra.w loc_18EF8
; ---------------------------------------------------------------------------

@loc_1899A:              ; CODE XREF: sub_18980+4j
	jsr sub_18AAC(pc)

	bra.w sub_18A52
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
	subi.b #$80, d5
	beq.w  sub_18ED8

	lea word_18FEE(pc), a0

	add.b  8(a3), d5
	andi.w #$7F, d5
	lsl.w  #1, d5
	move.w (a0, d5.w), $10(a3)
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
		lea (pcm_FF0020).l,a0
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
	lea dword_19544(pc), a0

	move.l (a0)+, d0
	beq.s  @locret_18C24
	bmi.s  @locret_18C24

	subq.w #1, d0

	@loc_18BBC:
		movea.l (a0)+, a1
		adda.l  $10(a5), a1

		tst.b   $D(a1)
		beq.s   @loc_18C20

		movea.l 0(a1), a2
		adda.l  $10(a5), a2

		move.w  $E(a1), d1

		move.w  d1, d5

		rol.w   #4, d1
		ori.b   #$80, d1

		andi.w  #$F00, d5

		move.l  4(a1), d2

		move.w  d2, d3
		rol.w   #4, d3
		andi.w  #$F, d3

		@loc_18BEC:
			move.b d1, PCM_CTRL(a4)

			move.w d2, d4
			cmpi.w #$1000, d2
			bls.s  @loc_18BFC

			move.w #$1000, d4

		@loc_18BFC:
			add.w d5, d2

			sub.w  d5, d4
			subq.w #1, d4

			lea (PCM_DATA).l, a3
			adda.w d5, a3
			adda.w d5, a3

			@loc_18C0C:
				move.b (a2)+, (a3)+
				addq.w #1, a3
				dbf d4, @loc_18C0C

			subi.w #$1000, d2
			addq.b #1, d1
			moveq  #0, d5
			dbf d3, @loc_18BEC

	@loc_18C20:
		dbf d0, @loc_18BBC

@locret_18C24:
	rts
; End of function sub_18BB0


; =============== S U B R O U T I N E =======================================


sub_18C26:              ; CODE XREF: playerVblank+Cp
	tst.l long_A(a5)
	beq.s locret_18C84

	lea long_A(a5), a1

	move.b byte_3(a5), d3
	moveq  #3, d4

loc_18C36:              ; CODE XREF: sub_18C26:loc_18C78j
	moveq   #0, d0
	move.b  (a1), d0

	move.b  d0, d1

	clr.b   (a1)+

	cmpi.b  #$81, d0
	bcs.s   loc_18C78

	cmpi.b  #$8F, d0
	bls.w   loc_18C86

	cmpi.b  #$B0, d0
	bcs.s   loc_18C78

	cmpi.b  #$BF, d0
	bls.w   loc_18C90

	cmpi.b  #$E0, d0
	bcs.s   loc_18C78

	cmpi.b  #$E4, d0
	bls.w   loc_18C9A

	bra.s   loc_18C78
; ---------------------------------------------------------------------------

loc_18C6A:              ; CODE XREF: sub_18C26+68j
					; sub_18C26+72j ...
	move.b (a0, d0.w), d2

	cmp.b  d3, d2
	bcs.s  loc_18C78

	move.b d2, d3
	move.b d1, byte_9(a5)

loc_18C78:              ; CODE XREF: sub_18C26+1Cj
					; sub_18C26+2Aj ...
	dbf d4, loc_18C36

	tst.b d3
	bmi.s locret_18C84

	move.b d3, byte_3(a5)

locret_18C84:               ; CODE XREF: sub_18C26+4j
	rts
; ---------------------------------------------------------------------------

loc_18C86:              ; CODE XREF: sub_18C26+22j
	subi.b #$81, d0
	lea    unk_192F8(pc), a0
	bra.s  loc_18C6A
; ---------------------------------------------------------------------------

loc_18C90:              ; CODE XREF: sub_18C26+30j
	subi.b #$B0, d0
	lea    unk_192FA(pc), a0
	bra.s  loc_18C6A
; ---------------------------------------------------------------------------

loc_18C9A:              ; CODE XREF: sub_18C26+3Ej
	subi.b #$E0, d0
	lea    unk_192FA(pc), a0
	bra.s  loc_18C6A
; End of function sub_18C26


; =============== S U B R O U T I N E =======================================


sub_18CA4:              ; CODE XREF: playerVblank+10p
	moveq   #0, d7

	move.b  9(a5), d7
	beq.w   playerMain
	bpl.w   loc_18F7C

	move.b  #$80, 9(a5)
	cmpi.b  #$81, d7
	bcs.s   @locret_18CE2

	cmpi.b  #$8F, d7
	bls.w   loc_18CE4

	cmpi.b  #$B0, d7
	bcs.s   @locret_18CE2

	cmpi.b  #$BF, d7
	bls.w   loc_18D90

	cmpi.b  #$E0, d7
	bcs.s   @locret_18CE2

	cmpi.b  #$E4, d7
	bls.w   loc_18F08

@locret_18CE2:
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
	moveq   #0, d0

	move.b  $14(a5), d0
	beq.s   @locret_18E3E

	move.b  $17(a5), d0
	beq.s   @loc_18E40

	subq.b  #1, $17(a5)

@locret_18E3E:
	rts
; ---------------------------------------------------------------------------

@loc_18E40:
	subq.b #1, $14(a5)
	beq.w  sub_18F54

	move.b $16(a5), $17(a5)

	lea $80(a5), a3

	moveq  #8, d7
	move.b $15(a5), d6
	add.b  d6, $18(a5)

	@loc_18E5C:
		tst.b (a3)
		bpl.s @loc_18E80

		sub.b d6, 9(a3)
		bcc.s @loc_18E6E

		clr.b 9(a3)
		bclr  #7, (a3)

	@loc_18E6E:
		move.b 1(a3), d0
		ori.b  #$C0, d0
		move.b d0, $F(a4)
		move.b 9(a3), 1(a4)

	@loc_18E80:
		adda.w #$80, a3
		dbf d7, @loc_18E5C

	rts
; End of function sub_18E2C


; =============== S U B R O U T I N E =======================================


sub_18E8A:              ; CODE XREF: playerVblank+14p
	tst.b  $F(a5)
	beq.s  @locret_18EA8
	bmi.s  @loc_18EAA

	cmpi.b #2, $F(a5)
	beq.s  @loc_18EA6

	move.b #$FF, $11(a4)
	move.b #2, $F(a5)

@loc_18EA6:
	addq.w #4, sp

@locret_18EA8:
	rts
; ---------------------------------------------------------------------------

@loc_18EAA:
	clr.b $F(a5)
	rts
; End of function sub_18E8A


; =============== S U B R O U T I N E =======================================


sub_18EB0:              ; CODE XREF: playerVblank+18p
	tst.b  0(a5)
	beq.s  @locret_18ED6

	subq.b #1, 1(a5)
	bne.s  @locret_18ED6

	move.b 0(a5), 1(a5)

	lea $80(a5), a0
	move.w #$80, d1

	moveq #8, d0
	@loc_18ECC:
		addq.b #1, $B(a0)
		adda.w d1, a0
		dbf d0, @loc_18ECC

@locret_18ED6:
	rts
; End of function sub_18EB0


; =============== S U B R O U T I N E =======================================


sub_18ED8:              ; CODE XREF: sub_189D4+4j sub_18A52+Cp ...
	move.b 1(a3), d0
	bset   d0, 2(a5)
	bset   #1, 0(a3)
	rts
; End of function sub_18ED8


; =============== S U B R O U T I N E =======================================


sub_18EE8:              ; CODE XREF: PLAYER:00018A02p
	move.b 1(a3), d0
	bset   d0, 2(a5)
	move.b 2(a5), $11(a4)
	rts
; End of function sub_18EE8

; ---------------------------------------------------------------------------

loc_18EF8:              ; CODE XREF: sub_18980+16j
	btst   #4, (a3)
	bne.s  @locret_18F06

	move.b 1(a3), d0
	bclr   d0, 2(a5)

@locret_18F06:
	rts
; ---------------------------------------------------------------------------

loc_18F08:              ; CODE XREF: sub_18CA4+3Aj
	move.b d7, d0

	subi.b #$E0, d7
	lsl.w  #2, d7
	jmp loc_18F14(pc, d7.w)
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
	move.b  #$18, $14(a5)
	move.b  #1, $16(a5)
	move.b  #1, $15(a5)
	rts
; ---------------------------------------------------------------------------

loc_18F3C:              ; CODE XREF: PLAYER:00018F1Cj
	move.b  #1, $F(a5)
	rts
; ---------------------------------------------------------------------------

loc_18F44:              ; CODE XREF: PLAYER:00018F20j
	move.b  #$80, $F(a5)
	rts
; ---------------------------------------------------------------------------

loc_18F4C:              ; CODE XREF: PLAYER:00018F24j
	move.b  #$FF, $11(a4)
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
		lea    (pcm_FF3C01).l, a0
		move.b d3, PCM_CTRL(a4)
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

	move.b #$FF, PCM_CHAN(a4)
	move.b #$80, PCM_CTRL(a4)

	lea    sub_18000(pc), a0
	suba.l $1C(a6), a0

	move.l a0, long_10(a5)
	move.b #$FF, byte_2(a5)
	move.b #$80, byte_9(a5)

	jsr sub_18F88(pc)

	bra.w sub_18BB0
; End of function playerMain


; =============== S U B R O U T I N E =======================================


initAddressRegs:                ; CODE XREF: playerVblank+4p playerMainp
	lea unk_192D0(pc), a6
	lea RAM_BASE(pc), a5
	lea (PCM_BASE).l, a4
	rts
; End of function initAddressRegs

; ---------------------------------------------------------------------------
word_18FEE:          ; DATA XREF: sub_189D4+8o
	dc.w 0
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
	dc.w $1DC
	dc.w $1FA
	dc.w $213
	dc.w $230
	dc.w $254
	dc.w $273
	dc.w $298
	dc.w $2C6
	dc.w $2F0
	dc.w $31D
	dc.w $34B
	dc.w $37A
	dc.w $3BA
	dc.w $3F1
	dc.w $42E
	dc.w $467
	dc.w $4A9
	dc.w $4F5
	dc.w $542
	dc.w $58E
	dc.w $5E3
	dc.w $63B
	dc.w $696
	dc.w $6F8
	dc.w $766
	dc.w $7DC
	dc.w $84F
	dc.w $8D2
	dc.w $956
	dc.w $9DC
	dc.w $A78
	dc.w $B19
	dc.w $BC7
	dc.w $C6F
	dc.w $D38
	dc.w $E00
	dc.w $EEA
	dc.w $FBA
	dc.w $10A6
	dc.w $1186
	dc.w $1280
	dc.w $1396
	dc.w $14CC
	dc.w $1624
	dc.w $1746
	dc.w $18DE
	dc.w $1A38
	dc.w $1BE0
	dc.w $1D94
	dc.w $1F65
	dc.w $20FF
	dc.w $2330
	dc.w $2526
	dc.w $2753
	dc.w $29B7
	dc.w $2C63
	dc.w $2F63
	dc.w $31E0
	dc.w $347B
	dc.w $377B
	dc.w $3B41
	dc.w $3EE8
	dc.w $4206
	dc.w $4684
	dc.w $4A5A
	dc.w $4EB5
	dc.w $5379
	dc.w $58E1
	dc.w $5DE0
	dc.w $63C0
	dc.w $68FF
	dc.w $6EFF
	dc.w $783C
	dc.w $7FC2
	dc.w $83FC
	dc.w $8D14
	dc.w $9780
	dc.w $9D80
	dc.w $AA5D
	dc.w $B1F9
	dc.w $BBBA
	dc.w $CC77
	dc.w $D751
	dc.w $E333

; =============== S U B R O U T I N E =======================================


sub_190AE:              ; CODE XREF: sub_189A2+12p
	subi.w #$E0, d5
	lsl.w  #2, d5
	jmp loc_190B8(pc, d5.w)
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
	rts
; ---------------------------------------------------------------------------

loc_19136:              ; CODE XREF: PLAYER:loc_190B8j
	move.b  1(a3), d0
	ori.b   #$C0, d0
	move.b  d0, $F(a4)
	move.b  (a2), 3(a3)
	move.b  (a2)+, 3(a4)
	rts
; ---------------------------------------------------------------------------

loc_1914C:              ; CODE XREF: PLAYER:000190BCj
	move.b  (a2)+, $F(a3)
	rts
; ---------------------------------------------------------------------------

loc_19152:              ; CODE XREF: PLAYER:000190C0j
	move.b  (a2)+, 4(a5)
	rts
; ---------------------------------------------------------------------------

loc_19158:              ; CODE XREF: PLAYER:000190C4j
	move.b  #1, 5(a5)
	rts
; ---------------------------------------------------------------------------

loc_19160:              ; CODE XREF: PLAYER:000190D0j
	move.b  1(a3), d0
	ori.b   #$C0, d0
	move.b  d0, $F(a4)
	move.b  (a2)+, d0
	bmi.s   loc_1917A
	add.b   d0, 9(a3)
	bcs.s   loc_19188
	bra.w   loc_19180
; ---------------------------------------------------------------------------

loc_1917A:              ; CODE XREF: PLAYER:0001916Ej
	add.b   d0, 9(a3)
	bcc.s   loc_19188

loc_19180:              ; CODE XREF: PLAYER:00019176j
	move.b  9(a3), 1(a4)

locret_19186:               ; CODE XREF: PLAYER:0001918Cj
	rts
; ---------------------------------------------------------------------------

loc_19188:              ; CODE XREF: PLAYER:00019174j
					; PLAYER:0001917Ej
	tst.b   $14(a5)
	beq.s   locret_19186
	bclr    #7, (a3)
	move.b  #0, 1(a4)
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
		lea dword_19544(pc),a0
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
unk_192D0:      ; CODE XREF: PLAYER:00019130j
				; DATA XREF: initAddressRegso
	dc.l $192F8
	dc.l $192D4
	dc.l $19300
	dc.l $192F8
	dc.l $192E0
	dc.l $192E4
	dc.l $B0
	dc.l $18000
	dc.l $192FA
	dc.l $192FA

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

dword_19544:        ; DATA XREF: sub_18BB0o
					; PLAYER:000191BEo
	dc.l 7
	dc.l dword_19564
	dc.l dword_19574
	dc.l dword_19584
	dc.l dword_19594
	dc.l dword_195A4
	dc.l dword_195B4
	dc.l dword_195C4

dword_19564:
	dc.l unk_195D4
	dc.l $969
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   6
	dc.b   1
	dc.w   0

dword_19574:
	dc.l unk_19F3D
	dc.l $C31
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   1
	dc.w $2000

dword_19584:
	dc.l unk_1AB6E
	dc.l $47C
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   3
	dc.b   1
	dc.w $4000

dword_19594:
	dc.l unk_1AFEA
	dc.l $1FFF
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b $1B
	dc.b   1
	dc.w $6000

dword_195A4:
	dc.l unk_1CFE9
	dc.l $D1C
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   1
	dc.w $8000

dword_195B4:
	dc.l unk_1DD05
	dc.l $C77
	dc.b   0
	dc.b   0
	dc.b   5
	dc.b $BD
	dc.b   0
	dc.b   0
	dc.w $A000

dword_195C4:
	dc.l unk_1E97C
	dc.l $6AC
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b  $A
	dc.b   1
	dc.w $C000

unk_195D4:
	incbin "unk_195D4.bin"

unk_19F3D:
	incbin "unk_19F3D.bin"

unk_1AB6E:
	incbin "unk_1AB6E.bin"

unk_1AFEA:
	incbin "unk_1AFEA.bin"

unk_1CFE9:
	incbin "unk_1CFE9.bin"

unk_1DD05:
	incbin "unk_1DD05.bin"

unk_1E97C:
	incbin "unk_1E97C.bin"

	END
