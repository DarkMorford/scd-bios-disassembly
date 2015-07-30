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
JOYTYPE_MULTITAP    equ 7

MULTI_3BUTTON   equ  0
MULTI_6BUTTON   equ  1
MULTI_MOUSE     equ  2
MULTI_NONE      equ $F

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
; a6 - JOYDATAn

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

	; Set TH bit high
	move.b  d3, (a6)
	bsr.s   sub_1174

	; Set TH bit low
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
	; Detect controller #1
	lea (JOYDATA1).l, a6
	bsr.s detectControllerType

	; Skip if no change
	cmp.b (joy1Type).w, d7
	beq.s @loc_11AE

	move.b d7, (joy1Type).w

	cmpi.b #JOYTYPE_MULTITAP, d7
	beq.s  @loc_11AA

	cmpi.b #JOYTYPE_MEGAMOUSE, d7
	bne.s  @loc_11AE

@loc_11AA:
	; Team Player or Mega Mouse
	moveq #0, d1
	bsr.s @loc_11CC

@loc_11AE:
	; Detect controller #2
	addq.w #2, a6
	bsr.s  detectControllerType

	; Skip if no change
	cmp.b (joy2Type).w, d7
	beq.s @locret_11D6

	move.b d7, (joy2Type).w

	moveq  #1, d1
	cmpi.b #JOYTYPE_MULTITAP, d7
	beq.s  @loc_11CC

	cmpi.b #JOYTYPE_MEGAMOUSE, d7
	beq.s  @loc_11CC

	rts
; ---------------------------------------------------------------------------

@loc_11CC:
	; Team Player or Mega Mouse
	moveq #0, d0
	bsr.w sub_12F4
	bcc.s @locret_11D6
	nop

@locret_11D6:
	rts
; End of function sub_118C


; =============== S U B R O U T I N E =======================================


sub_11D8:               ; CODE XREF: vblankHandler+26p
	cmpi.b #JOYTYPE_MULTITAP, (joy1Type).w
	bne.s  loc_1218

	; Port 1 has multitap
	lea    (joy1Down).w, a1
	move.l a1, -(sp)

	lea   (joy2MouseData).w, a2
	moveq #0, d1
	bsr.w readMultitap

	; Check if control pad was found
	movea.l (sp)+, a3
	cmpa.l  a3, a1
	bne.s   loc_11F8

	; Control pad not found, clear data
	clr.w (a1)

loc_11F8:
	lea (multitapControllerTypes).w, a3

	; Check if multitap has a mouse
	moveq #3, d0
	@loc_11FE:
		cmpi.b #MULTI_MOUSE, (a3)+
		dbeq   d0, @loc_11FE

	; Skip to controller port 2 if no mouse
	bne.s loc_1264

	lea   (joy2MouseData).w, a5
	lea   (joy2Down).w, a0
	bsr.w readMouseButtons
	bra.w loc_12BA
; ---------------------------------------------------------------------------

loc_1218:               ; CODE XREF: sub_11D8+6j
	cmpi.b #JOYTYPE_MEGAMOUSE, (joy1Type).w
	beq.s  loc_1250

	; Port 1 has standard controller
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
	; Port 1 has Mega Mouse
	lea (joy1MouseData).w, a5

	moveq #0, d1
	moveq #1, d0

	bsr.w sub_12F4
	bcs.s loc_12C4

	lea   (joy1Down).w, a0
	bsr.s readMouseButtons

loc_1264:               ; CODE XREF: sub_11D8+2Ej sub_11D8+76j
	cmpi.b #JOYTYPE_MEGAMOUSE, (joy2Type).w
	beq.s  loc_12A6

	cmpi.b #JOYTYPE_MULTITAP, (joy2Type).w
	bne.s  loc_1276

	; Totally ignore multitap on port 2
	bra.s  loc_12BA
; ---------------------------------------------------------------------------

loc_1276:               ; CODE XREF: sub_11D8+9Aj
	; Port 2 has standard controller
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
	; Port 2 has Mega Mouse
	lea (joy2MouseData).w, a5

	moveq #1, d1
	moveq #1, d0

	bsr.w sub_12F4
	bcs.s loc_12C8

	lea   (joy2Down).w, a0
	bsr.s readMouseButtons

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


readMouseButtons:               ; CODE XREF: sub_11D8+38p sub_11D8+8Ap ...
	move.b 1(a5), d0
	andi.w #3, d0

	bclr   #0, d0
	beq.s  @loc_12DE

	bset   #JOYBIT_BTNA, d0

@loc_12DE:
	bclr   #1, d0
	beq.s  @loc_12E8

	bset   #JOYBIT_BTNB, d0

@loc_12E8:
	; Compute triggered buttons
	move.b (a0), d1

	eor.b  d0, d1
	move.b d0, (a0)+

	and.b  d0, d1
	move.b d1, (a0)+
	rts
; End of function readMouseButtons


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
	dc.w (sub_1320 - word_1318)
	dc.w (readMegaMouse - word_1318)
	dc.w $166   ; $147E     ; bchg d0, -(a6)
	dc.w $166   ; $147E     ; bchg d0, -(a6)

; =============== S U B R O U T I N E =======================================


sub_1320:
	move.w #$FF, d7

	m_z80RequestBus
	m_z80WaitForBus

	move.b #$60, 6(a6)
	bsr.w  waitForTlHigh
	bcs.s  @loc_1356

	move.b #$40, (a6)
	bsr.w  waitForTlHigh
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

	bsr.w waitForTlHigh
	bcs.s @mouseReadFailed

	move.b #$20, (a6)
	bsr.w  waitForTlHigh
	bcs.s  @mouseReadFailed

	btst  #JOYDATA_PD2, d0
	bne.s @mouseReadFailed

	bsr.w readControllerDataLow
	bcs.s @mouseReadFailed

	bsr.w readControllerDataHigh
	bcs.s @mouseReadFailed

	moveq #2, d6
	@loc_13AE:
		bsr.w readControllerDataLow
		bcs.s @mouseReadFailed
		move.b (a6), (a4)+

		bsr.w  readControllerDataHigh
		bcs.s  @mouseReadFailed
		move.b (a6), (a4)+

		dbf d6, @loc_13AE

	moveq #2, d6
	@loc_13C4:
		bsr.w readControllerDataLow
		bcs.s @mouseReadFailed

		bsr.w readControllerDataHigh
		bcs.s @mouseReadFailed

		dbf d6, @loc_13C4

	move.b #$60, (a6)
	bsr.w  waitForTlHigh

	m_z80ReleaseBus

	bra.s computeMouseMotion
; ---------------------------------------------------------------------------

@mouseReadFailed:
	move.b #$60, (a6)
	m_z80ReleaseBus
	clr.l 6(a5)

	ori #1, ccr
	rts
; End of function readMegaMouse


; =============== S U B R O U T I N E =======================================


computeMouseMotion:               ; CODE XREF: sub_136A+7Aj sub_157C+1Ap
	lea (a5), a4

	moveq   #0, d0
	moveq   #0, d1

	movep.w 2(a4), d0
	movep.w 3(a4), d1

	andi.w  #$0F0F, d0
	andi.w  #$0F0F, d1

	lsl.w   #4, d0
	or.w    d1, d0
	move.w  d0, d1
	andi.w  #$FF, d1
	lsr.w   #8, d0

	; Check for inverted Y axis
	btst  #1, (a4)
	beq.s @loc_1428

	subi.w #$100, d1

@loc_1428:
	; Check for Y overflow
	btst  #3, (a4)
	beq.s @loc_1430

	clr.b d1

@loc_1430:
	neg.w  d1
	move.w d1, 8(a4)

	; Check for inverted X axis
	btst   #0, (a4)
	beq.s  @loc_1440

	subi.w #$100, d0

@loc_1440:
	; Check for X overflow
	btst  #2, (a4)
	beq.s @loc_1448

	clr.b d0

@loc_1448:
	move.w d0, 6(a4)
	rts
; End of function computeMouseMotion


; =============== S U B R O U T I N E =======================================


readControllerDataHigh:
	; Set TR high
	move.b #$20, (a6)

waitForTlHigh:               ; CODE XREF: sub_1324+18p sub_1324+22p ...
	; Clear carry bit
	andi #$FE, ccr

	; Wait for the controller to drive TL high
	@loc_1456:
		move.b (a6), d0
		btst   #JOYDATA_TL, d0
		dbne   d7, @loc_1456

	beq.s joypadReadFailed

	move.b (a6), d0
	rts
; End of function readControllerDataHigh


; =============== S U B R O U T I N E =======================================


readControllerDataLow:
	; Set TR low
	move.b #0, (a6)

	; Clear carry bit
	andi #$FE, ccr

	; Wait for the controller to drive TL low
	@loc_146E:
		move.b (a6), d0
		btst   #JOYDATA_TL, d0
		dbeq   d7, @loc_146E

	bne.s joypadReadFailed

	move.b (a6), d0
	rts
; ---------------------------------------------------------------------------

joypadReadFailed:
	ori #1, ccr
	rts
; End of function readControllerDataLow


; =============== S U B R O U T I N E =======================================


readMultitap:               ; CODE XREF: sub_11D8+14p
	movem.l d1-a0/a3-a6, -(sp)

	lea (multitapControllerTypes).w, a0

	add.w d1, d1
	lea (JOYDATA1).l, a6
	adda.w d1, a6

	m_z80RequestBus
	m_z80WaitForBus

	; Set TR high, TH low
	move.b #$20, (a6)

	move.b #$60, 6(a6)
	move.w #$FF, d7

	btst  #JOYDATA_TL, (a6)
	beq.w joypadTransferFailed

	; Read two handshake bytes
	bsr.s  readControllerDataLow
	bcs.s  joypadTransferFailed
	andi.b #$F, d0

	bsr.s  readControllerDataHigh
	bcs.s  joypadTransferFailed
	andi.b #$F, d0

	; Get controller A type
	bsr.s  readControllerDataLow
	bcs.s  joypadTransferFailed
	move.b d0, (a0)+

	; Get controller B type
	bsr.w  readControllerDataHigh
	bcs.s  joypadTransferFailed
	move.b d0, (a0)+

	; Get controller C type
	bsr.s  readControllerDataLow
	bcs.s  joypadTransferFailed
	move.b d0, (a0)+

	moveq #$20, d6

	; Get controller D type
	bsr.w  readControllerDataHigh
	bcs.s  joypadTransferFailed
	move.b d0, (a0)+

	; Clear the high nybbles since they're not data
	andi.l #$0F0F0F0F, -(a0)

	; Read each attached controller (gamepad/mouse)
	bsr.s sub_1522
	bsr.s sub_1522
	bsr.s sub_1522
	bsr.s sub_1522

	; Set TH high (reset transfer)
	move.b #$60, (a6)
	bsr.w  waitForTlHigh

	m_z80ReleaseBus
	movem.l (sp)+, d1-a0/a3-a6
	rts
; ---------------------------------------------------------------------------

joypadTransferFailed:
	; Set TH high (reset transfer)
	move.b #$60, (a6)
	m_z80ReleaseBus
	movem.l (sp)+, d1-a0/a3-a6
	rts
; End of function readMultitap


; =============== S U B R O U T I N E =======================================


sub_1522:               ; CODE XREF: readMultitap+6Ep readMultitap+70p ...
	moveq  #0,    d0
	move.b (a0)+, d0

	cmpi.b #2, d0
	bhi.s  @locret_1540

	add.w d0, d0
	add.w d0, d0
	jmp   @loc_1534(pc, d0.w)
; ---------------------------------------------------------------------------

@loc_1534:
	bra.w sub_154C      ; 3-button control pad
; ---------------------------------------------------------------------------
	bra.w loc_1542      ; 6-button control pad
; ---------------------------------------------------------------------------
	bra.w sub_157C      ; Mouse
; ---------------------------------------------------------------------------

@locret_1540:
	rts
; ---------------------------------------------------------------------------

loc_1542:               ; CODE XREF: sub_1522+16j
	; Read 3-button data
	bsr.s sub_154C

	; Read ModeXYZ buttons (and throw them out)
	bsr.w readNextControllerData
	bcs.s joypadTransferFailed
	rts
; End of function sub_1522


; =============== S U B R O U T I N E =======================================


sub_154C:               ; CODE XREF: sub_1522:loc_1534j
	; Read D-pad
	bsr.w  readNextControllerData
	bcs.s  joypadTransferFailed
	andi.w #$F, d0

	move.w d0, d1

	; Read SACB buttons
	bsr.w  readNextControllerData
	bcs.s  joypadTransferFailed
	andi.w #$F, d0

	asl.w  #4, d0
	or.b   d0, d1
	not.b  d1

	; Only write data from controller A
	cmpa.l #joy1Down, a1
	bhi.s  @locret_157A

	; Compute triggered buttons
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
	moveq #5, d1

	; Throw out data if multiple mice
	cmpa.l #joy2MouseData, a2
	bhi.s  @loc_15A0

	lea (a2), a4

	; Read raw mouse data
	@loc_1588:
		bsr.w readNextControllerData
		bcs.s joypadTransferFailed

		move.b d0, (a4)+
		dbf d1, @loc_1588

	lea (a2), a5
	bsr.w computeMouseMotion

	lea $C(a2), a2
	rts
; ---------------------------------------------------------------------------

	@loc_15A0:
		bsr.w readNextControllerData
		bcs.w joypadTransferFailed

		dbf d1, @loc_15A0

	rts
; End of function sub_157C


; =============== S U B R O U T I N E =======================================


sub_15AE:
	move.b (a6), d0
	rts
; End of function sub_15AE


; =============== S U B R O U T I N E =======================================


readNextControllerData:     ; CODE XREF: sub_1522+22p sub_154Cp ...
	bchg  #JOYDATA_TR, d6
	beq.w readControllerDataHigh
	bra.w readControllerDataLow
; End of function readNextControllerData
