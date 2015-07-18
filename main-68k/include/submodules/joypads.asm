;   ======================================================================
;       Joypad subroutines
;   ======================================================================

JOYBIT_START    equ 7
JOYBIT_BTNA     equ 6
JOYBIT_BTNC     equ 5
JOYBIT_BTNB     equ 4
JOYBIT_RIGHT    equ 3
JOYBIT_LEFT     equ 2
JOYBIT_DOWN     equ 1
JOYBIT_UP       equ 0

JOYTYPE_MEGAMOUSE   equ 3
JOYTYPE_7           equ 7

; =============== S U B R O U T I N E =======================================


readJoypads:                ; CODE XREF: ROM:00000298j
	m_z80RequestBus
	m_z80WaitForBus

	bsr.s readJoypadsInternal

	m_z80ReleaseBus
	rts
; End of function readJoypads


; =============== S U B R O U T I N E =======================================


readJoypadsInternal:            ; CODE XREF: readJoypads+12p
	lea    (joy1Down).w, a5
	lea    (JOYDATA1).l, a6
	bsr.w  readSingleJoypad

	addq.w #2, a6

readSingleJoypad:
	; Set TH bit low to read X0SA00DU
	move.b #0, (a6)
	nop
	nop

	move.b (a6), d7
	asl.b  #2, d7

	; Set TH bit high to read X1CBRLDU
	move.b #$40, (a6)

	andi.w #$C0, d7

	move.b (a6), d6
	andi.w #$3F, d6
	or.b   d6, d7

	not.b  d7
	move.b (a5), d6

	eor.b  d7, d6
	move.b d7, (a5)+

	and.b  d7, d6
	move.b d6, (a5)+

	rts
; End of function readJoypadsInternal


; =============== S U B R O U T I N E =======================================


setupJoypads:
	moveq #$40, d7

	move.b d7, (JOYCTRL1).l
	move.b d7, (JOYCTRL2).l
	move.b d7, (JOYCTRL3).l
	rts
; End of function setupJoypads


; =============== S U B R O U T I N E =======================================

; Input parameters:
; a6 - JOYDATA1

detectControllerType:               ; CODE XREF: ROM:0000029Cj sub_118C+6p ...
	movem.l d1-d3, -(sp)

	m_saveStatusRegister
	m_disableInterrupts
	m_z80RequestBus
	m_z80WaitForBus

	; Set the I/O port to normal joypad mode
	moveq  #$40, d3
	move.b d3, 6(a6)
	
	moveq  #0, d7

	; Set TH bit high to read X1CBRLDU
	move.b  d3, (a6)
	bsr.s   sub_1174

	; Set TH bit low to read X0SA00DU
	move.b  #0, (a6)
	add.w   d7, d7
	bsr.s   sub_1174

	m_z80ReleaseBus
	m_restoreStatusRegister

	movem.l (sp)+, d1-d3
	rts
; End of function detectControllerType


; =============== S U B R O U T I N E =======================================


sub_1174:               ; CODE XREF: detectControllerType+26p detectControllerType+2Ep
	move.b (a6), d2
	move.b d2, d3

	andi.b #$0C, d2
	beq.s  @loc_1180

	addq.w #1, d7

@loc_1180:
	add.w  d7, d7

	andi.w #$03, d3
	beq.s  @locret_118A

	addq.w #1, d7

@locret_118A:
	rts
; End of function sub_1174


; =============== S U B R O U T I N E =======================================


sub_118C:               ; CODE XREF: ROM:0000069Cp
	; Test controller 1
	lea (JOYDATA1).l, a6
	bsr.s detectControllerType

	; Skip controller 1 if unchanged
	cmp.b (joy1Type).w, d7
	beq.s @loc_11AE

	move.b d7, (joy1Type).w
	cmpi.b #JOYTYPE_7, d7
	beq.s  @loc_11AA

	cmpi.b #JOYTYPE_MEGAMOUSE, d7
	bne.s  @loc_11AE

@loc_11AA:
	; If d7 is either 3 or 7
	moveq #0, d1
	bsr.s @loc_11CC

@loc_11AE:
	; Test controller 2
	addq.w #2, a6
	bsr.s  detectControllerType

	; Skip controller 2 if unchanged
	cmp.b (joy2Type).w, d7
	beq.s @locret_11D6

	move.b d7, (joy2Type).w
	moveq  #1, d1
	cmpi.b #JOYTYPE_7, d7
	beq.s  @loc_11CC

	cmpi.b #JOYTYPE_MEGAMOUSE, d7
	beq.s  @loc_11CC

	rts
; ---------------------------------------------------------------------------

@loc_11CC:
	; If d7 is either 3 or 7
	moveq #0, d0
	bsr.w sub_12F4
	bcc.s @locret_11D6
	nop

@locret_11D6:
	rts
; End of function sub_118C


; =============== S U B R O U T I N E =======================================


sub_11D8:               ; CODE XREF: vblankHandler+26p
	cmpi.b #JOYTYPE_7, (joy1Type).w
	bne.s  loc_1218

	lea     (joy1Down).w, a1
	move.l  a1, -(sp)

	lea     (unk_FFFFFE0C).w, a2
	moveq   #0, d1
	bsr.w   sub_1484

	movea.l (sp)+, a3
	cmpa.l  a3, a1
	bne.s   loc_11F8

	clr.w   (a1)

loc_11F8:
	lea   (unk_FFFFFE1A).w, a3

	moveq #3, d0
	@loc_11FE:
		cmpi.b #2, (a3)+
		dbeq   d0, @loc_11FE

	bne.s loc_1264

	lea     (unk_FFFFFE0C).w, a5
	lea     (joy2Down).w, a0
	bsr.w   sub_12CC
	bra.w   loc_12BA
; ---------------------------------------------------------------------------

loc_1218:               ; CODE XREF: sub_11D8+6j
	cmpi.b #JOYTYPE_MEGAMOUSE, (joy1Type).w
	beq.s  loc_1250

	lea (joy1Down).w, a5
	lea (JOYDATA1).l, a6

	m_z80RequestBus
	m_z80WaitForBus

	move.b #$40, 6(a6)
	bsr.w  readSingleJoypad

	m_z80ReleaseBus

	bra.s loc_1264
; ---------------------------------------------------------------------------

loc_1250:               ; CODE XREF: sub_11D8+46j
	lea (unk_FFFFFE00).w, a5

	moveq #0,d1
	moveq #1,d0

	bsr.w sub_12F4
	bcs.s loc_12C4

	lea   (joy1Down).w,a0
	bsr.s sub_12CC

loc_1264:               ; CODE XREF: sub_11D8+2Ej sub_11D8+76j
	cmpi.b #JOYTYPE_MEGAMOUSE, (joy2Type).w
	beq.s  loc_12A6

	cmpi.b #JOYTYPE_7, (joy2Type).w
	bne.s  loc_1276
	bra.s  loc_12BA
; ---------------------------------------------------------------------------

loc_1276:               ; CODE XREF: sub_11D8+9Aj
	lea (joy2Down).w, a5
	lea (JOYDATA2).l, a6

	m_z80RequestBus
	m_z80WaitForBus

	move.b #$40, 6(a6)
	bsr.w  readSingleJoypad

	m_z80ReleaseBus

	bra.s loc_12BA
; ---------------------------------------------------------------------------

loc_12A6:               ; CODE XREF: sub_11D8+92j
	lea (unk_FFFFFE0C).w, a5

	moveq #1, d1
	moveq #1, d0

	bsr.w sub_12F4
	bcs.s loc_12C8

	lea   (joy2Down).w, a0
	bsr.s sub_12CC

loc_12BA:               ; CODE XREF: sub_11D8+3Cj sub_11D8+9Cj ...
	m_z80ReleaseBus
	rts
; ---------------------------------------------------------------------------

loc_12C4:               ; CODE XREF: sub_11D8+84j
	moveq   #0, d1
	bra.s   locret_12CA
; ---------------------------------------------------------------------------

loc_12C8:               ; CODE XREF: sub_11D8+DAj
	moveq   #1, d1

locret_12CA:                ; CODE XREF: sub_11D8+EEj
	rts
; End of function sub_11D8


; =============== S U B R O U T I N E =======================================


sub_12CC:               ; CODE XREF: sub_11D8+38p sub_11D8+8Ap ...
	move.b 1(a5), d0
	andi.w #3, d0

	bclr   #0, d0
	beq.s  @loc_12DE

	bset   #6, d0

@loc_12DE:
	bclr   #1, d0
	beq.s  @loc_12E8

	bset   #4, d0

@loc_12E8:
	move.b (a0), d1

	eor.b  d0, d1
	move.b d0, (a0)+

	and.b  d0, d1
	move.b d1, (a0)+
	rts
; End of function sub_12CC


; =============== S U B R O U T I N E =======================================


sub_12F4:               ; CODE XREF: loc_11CC+2p sub_11D8+80p ...
	movem.l d1-a6, -(sp)
	add.w   d1, d1
	lea     (JOYDATA1).l, a6
	adda.w  d1, a6

	andi.w #7, d0
	add.w  d0, d0

	lea    word_1318(pc), a0
	adda.w (a0, d0.w), a0
	jsr    (a0)

	movem.l (sp)+, d1-a6
	rts
; End of function sub_12F4

; ---------------------------------------------------------------------------
word_1318:
	dc.w 8      ; $1320
	dc.w $4C    ; readMegaMouse
	dc.w $166   ; $147E     ; bchg d0, -(a6)
	dc.w $166   ; $147E     ; bchg d0, -(a6)

; =============== S U B R O U T I N E =======================================


sub_1320:
	move.w #$FF, d7

	m_z80RequestBus
	m_z80WaitForBus

	move.b #$60, 6(a6)
	bsr.w  loc_1452
	bcs.s  @loc_1356

	move.b #$40, (a6)
	bsr.w  loc_1452
	bcs.s  @loc_1356

	m_z80ReleaseBus
	rts
; ---------------------------------------------------------------------------

@loc_1356:
	m_z80ReleaseBus
	ori #1,ccr
	rts
; End of function sub_1320


; =============== S U B R O U T I N E =======================================


readMegaMouse:
	move.w #$FF, d7
	lea (a5), a4

	m_z80RequestBus
	m_z80WaitForBus

	move.b #$20,  (a6)
	move.b #$60, 6(a6)
	move.b #$60,  (a6)

	bsr.w loc_1452
	bcs.s @loc_13E6

	move.b #$20, (a6)
	bsr.w  loc_1452
	bcs.s  @loc_13E6

	btst  #JOYDATA_PD2, d0
	bne.s @loc_13E6

	bsr.w sub_1466
	bcs.s @loc_13E6

	bsr.w sub_144E
	bcs.s @loc_13E6

	moveq #2, d6
	@loc_13AE:
		bsr.w sub_1466
		bcs.s @loc_13E6

		move.b (a6), (a4)+
		bsr.w  sub_144E
		bcs.s  @loc_13E6

		move.b (a6), (a4)+
		dbf d6, @loc_13AE

	moveq #2, d6
	@loc_13C4:
		bsr.w sub_1466
		bcs.s @loc_13E6

		bsr.w sub_144E
		bcs.s @loc_13E6

		dbf d6, @loc_13C4

	move.b #$60, (a6)
	bsr.w  loc_1452

	m_z80ReleaseBus

	bra.s sub_13FC
; ---------------------------------------------------------------------------

@loc_13E6:
	move.b #$60, (a6)
	m_z80ReleaseBus
	clr.l 6(a5)

	ori #1, ccr
	rts
; End of function readMegaMouse


; =============== S U B R O U T I N E =======================================


sub_13FC:               ; CODE XREF: sub_136A+7Aj sub_157C+1Ap
	lea (a5), a4

	moveq   #0, d0
	moveq   #0, d1

	movep.w 2(a4), d0
	movep.w 3(a4), d1

	andi.w  #$F0F, d0
	andi.w  #$F0F, d1

	lsl.w   #4, d0
	or.w    d1, d0
	move.w  d0, d1
	andi.w  #$FF, d1
	lsr.w   #8, d0

	btst  #1, (a4)
	beq.s @loc_1428

	subi.w #$100, d1

@loc_1428:
	btst  #3, (a4)
	beq.s @loc_1430
	clr.b d1

@loc_1430:
	neg.w  d1
	move.w d1, 8(a4)
	btst   #0, (a4)
	beq.s  @loc_1440
	subi.w #$100, d0

@loc_1440:
	btst  #2, (a4)
	beq.s @loc_1448

	clr.b d0

@loc_1448:
	move.w d0, 6(a4)
	rts
; End of function sub_13FC


; =============== S U B R O U T I N E =======================================


sub_144E:               ; CODE XREF: sub_136A+3Cp sub_136A+4Cp ...
	move.b #$20, (a6)

loc_1452:               ; CODE XREF: sub_1324+18p sub_1324+22p ...
	andi #$FE, ccr

	@loc_1456:
		move.b (a6), d0
		btst   #JOYDATA_TL, d0
		dbne   d7, @loc_1456

	beq.s loc_147E

	move.b (a6), d0
	rts
; End of function sub_144E


; =============== S U B R O U T I N E =======================================


sub_1466:               ; CODE XREF: sub_136A+36p
					; sub_136A:loc_13AEp ...
	move.b #0, (a6)
	andi   #$FE, ccr

	@loc_146E:
		move.b (a6), d0
		btst   #JOYDATA_TL, d0
		dbeq   d7, @loc_146E

	bne.s loc_147E

	move.b (a6), d0
	rts
; ---------------------------------------------------------------------------

loc_147E:               ; CODE XREF: sub_144E+12j sub_1466+12j
	ori #1, ccr
	rts
; End of function sub_1466


; =============== S U B R O U T I N E =======================================


sub_1484:               ; CODE XREF: sub_11D8+14p
	movem.l d1-a0/a3-a6, -(sp)

	lea (unk_FFFFFE1A).w, a0

	add.w d1, d1
	lea (JOYDATA1).l, a6
	adda.w d1, a6

	m_z80RequestBus
	m_z80WaitForBus

	move.b  #$20,  (a6)
	move.b  #$60, 6(a6)
	move.w  #$FF, d7

	btst    #4, (a6)
	beq.w   loc_1510

	bsr.s   sub_1466
	bcs.s   loc_1510

	andi.b  #$F, d0
	bsr.s   sub_144E
	bcs.s   loc_1510

	andi.b  #$F, d0
	bsr.s   sub_1466
	bcs.s   loc_1510

	move.b  d0, (a0)+
	bsr.w   sub_144E
	bcs.s   loc_1510

	move.b  d0, (a0)+
	bsr.s   sub_1466
	bcs.s   loc_1510

	move.b  d0, (a0)+
	moveq   #$20, d6
	bsr.w   sub_144E
	bcs.s   loc_1510

	move.b  d0, (a0)+
	andi.l  #$0F0F0F0F, -(a0)

	bsr.s   sub_1522
	bsr.s   sub_1522
	bsr.s   sub_1522
	bsr.s   sub_1522

	move.b  #$60, (a6)
	bsr.w   loc_1452

	m_z80ReleaseBus
	movem.l (sp)+, d1-a0/a3-a6
	rts
; ---------------------------------------------------------------------------

loc_1510:
	move.b #$60, (a6)
	m_z80ReleaseBus
	movem.l (sp)+, d1-a0/a3-a6
	rts
; End of function sub_1484


; =============== S U B R O U T I N E =======================================


sub_1522:               ; CODE XREF: sub_1484+6Ep sub_1484+70p ...
	moveq  #0,    d0
	move.b (a0)+, d0

	cmpi.b #2, d0
	bhi.s  @locret_1540

	add.w  d0, d0
	add.w  d0, d0
	jmp    @loc_1534(pc, d0.w)
; ---------------------------------------------------------------------------

@loc_1534:
	bra.w   sub_154C
; ---------------------------------------------------------------------------
	bra.w   loc_1542
; ---------------------------------------------------------------------------
	bra.w   sub_157C
; ---------------------------------------------------------------------------

@locret_1540:
	rts
; ---------------------------------------------------------------------------

loc_1542:               ; CODE XREF: sub_1522+16j
	bsr.s sub_154C
	bsr.w sub_15B2
	bcs.s loc_1510
	rts
; End of function sub_1522


; =============== S U B R O U T I N E =======================================


sub_154C:               ; CODE XREF: sub_1522:loc_1534j
					; sub_1522:loc_1542p
	bsr.w  sub_15B2
	bcs.s  loc_1510

	andi.w #$F, d0
	move.w d0,  d1
	bsr.w  sub_15B2
	bcs.s  loc_1510

	andi.w #$F, d0
	asl.w  #4,  d0
	or.b   d0,  d1
	not.b  d1

	cmpa.l #$FFFFFE20, a1
	bhi.s  @locret_157A

	move.b (a1), d0

	eor.b  d1, d0
	move.b d1, (a1)+

	and.b  d1, d0
	move.b d0, (a1)+

@locret_157A:
	rts
; End of function sub_154C


; =============== S U B R O U T I N E =======================================


sub_157C:               ; CODE XREF: sub_1522+1Aj
	moveq  #5, d1
	cmpa.l #$FFFFFE0C, a2
	bhi.s  @loc_15A0

	lea (a2), a4
	@loc_1588:
		bsr.w  sub_15B2
		bcs.s  loc_1510

		move.b d0, (a4)+
		dbf d1, @loc_1588

	lea (a2), a5
	bsr.w sub_13FC

	lea $C(a2), a2
	rts
; ---------------------------------------------------------------------------

	@loc_15A0:
		bsr.w   sub_15B2
		bcs.w   loc_1510

		dbf d1, @loc_15A0

	rts
; End of function sub_157C


; =============== S U B R O U T I N E =======================================


sub_15AE:
	move.b (a6), d0
	rts
; End of function sub_15AE


; =============== S U B R O U T I N E =======================================


sub_15B2:               ; CODE XREF: sub_1522+22p sub_154Cp ...
	bchg  #5, d6
	beq.w sub_144E
	bra.w sub_1466
; End of function sub_15B2
