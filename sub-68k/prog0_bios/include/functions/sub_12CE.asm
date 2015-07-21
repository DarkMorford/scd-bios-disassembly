sub_12CE:               ; CODE XREF: sub_E74+42p
	; Stop the CDD if flag is set
	btst    #7, cddFlags7(a5)
	bne.w   @loc_14F4

	lea cddFlags2(a5), a0
	lea cddFlags3(a5), a1

	bclr    #3, (a0)
	bne.w   @loc_13AC

	btst    #0, (a1)
	beq.s   @loc_1306

	btst    #2, (a0)
	beq.s   @loc_1302

	move.b  (a0), d0

	andi.b  #$30, d0
	bne.s   @loc_1302

	bset    #3, cddFlags0(a5)

@loc_1302:               ; CODE XREF: sub_12CE+24j sub_12CE+2Cj
	bra.w   @loc_1518
; ---------------------------------------------------------------------------

@loc_1306:               ; CODE XREF: sub_12CE+1Ej
	bclr    #3, cddFlags0(a5)
	beq.s   @loc_1316

	andi.b  #$CF, (a0)
	bra.w   @loc_14B8
; ---------------------------------------------------------------------------

@loc_1316:               ; CODE XREF: sub_12CE+3Ej
	bclr    #5, (a0)
	bne.s   @loc_134A

	bclr    #4, (a0)
	beq.s   @loc_1334

	btst    #1, (a1)
	bne.s   @loc_132E

	btst    #0, (a1)
	beq.s   @loc_134A

@loc_132E:               ; CODE XREF: sub_12CE+58j
	subq.b  #1, byte_59F7(a5)
	bra.s   @loc_134A
; ---------------------------------------------------------------------------

@loc_1334:               ; CODE XREF: sub_12CE+52j
	btst    #4, cddFlags0(a5)
	beq.w   @loc_14D8

	btst    #1, (a1)
	bne.w   @loc_14D8

	bclr    #1, (a0)

@loc_134A:               ; CODE XREF: sub_12CE+4Cj sub_12CE+5Ej ...
	btst    #6, (a0)
	bne.w   @loc_1652

	btst    #2, (a0)
	beq.s   @loc_13BC

	bsr.w   cddGetStatusCodeWord

	ror.w   #8, d0
	cmpi.b  #$B, d0
	beq.s   @loc_1398

	bsr.w   sub_12B6
	bcs.s   @loc_13A2

	move.b  byte_5815(a5), d1
	cmpi.b  #$FF, d1
	beq.s   @loc_1380

	bclr    #7, d1
	beq.s   @loc_137C

	lsr.w   #8, d0

@loc_137C:               ; CODE XREF: sub_12CE+AAj
	cmp.b   d1, d0
	bne.s   @loc_1386

@loc_1380:               ; CODE XREF: sub_12CE+A4j
	bclr    #2, (a0)
	bra.s   @loc_13BC
; ---------------------------------------------------------------------------

@loc_1386:               ; CODE XREF: sub_12CE+B0j
	subq.w  #1, word_5816(a5)
	bcc.w   @loc_1518

	bset    #1, cddFlags7(a5)
	bra.w   @loc_14F4
; ---------------------------------------------------------------------------

@loc_1398:               ; CODE XREF: sub_12CE+94j
	bset    #6, cddFlags7(a5)
	bra.w   @loc_14F4
; ---------------------------------------------------------------------------

@loc_13A2:               ; CODE XREF: sub_12CE+9Aj
	bset    #4, cddFlags7(a5)
	bra.w   @loc_14F4
; ---------------------------------------------------------------------------

@loc_13AC:               ; CODE XREF: sub_12CE+16j
	andi.b  #9, (a0)
	andi.b  #$E7, cddFlags0(a5)
	bclr    #7, cddFlags4(a5)

@loc_13BC:               ; CODE XREF: sub_12CE+88j sub_12CE+B6j ...
	bclr    #0, (a0)
	beq.w   @loc_1518

	; Check CDD command
	cmpi.w  #$0200, cddCommandWorkArea(a5)
	bne.s   @loc_13D8

	; Getting TOC data, check subcommand
	move.b  cddCommandWorkArea+3(a5), d0
	cmpi.b  #5, d0
	beq.w   @loc_1590

@loc_13D8:               ; CODE XREF: sub_12CE+FCj
	lea    cddCommandWorkArea(a5), a0
	move.b 0(a0), d0
	andi.w #$F, d0
	move.b @byte_13F8(pc, d0.w), d1
	bpl.w  @loc_146A

	andi.w #7, d1
	add.w  d1, d1
	add.w  d1, d1
	jmp    @loc_1408(pc, d1.w)
; ---------------------------------------------------------------------------
@byte_13F8:
	dc.b $83    ; Get CDD status
	dc.b $00    ; Stop all operations
	dc.b $81    ; Get TOC info
	dc.b $01    ; Read
	dc.b $04    ; Seek
	dc.b $80    ; Unknown
	dc.b $04    ; Stop
	dc.b $82    ; Resume
	dc.b $03    ; Fast forward
	dc.b $03    ; Fast reverse
	dc.b $84    ; Unknown
	dc.b $01    ; Unknown
	dc.b $00    ; Close CD tray
	dc.b $05    ; Open CD tray
	dc.b $80    ; Unknown
	dc.b $0F    ; Unknown
; ---------------------------------------------------------------------------

@loc_1408:
	bra.w  @loc_1442    ; Unknown
; ---------------------------------------------------------------------------
	bra.w  @loc_144A    ; Get TOC info
; ---------------------------------------------------------------------------
	bra.w  @loc_145A    ; Resume play
; ---------------------------------------------------------------------------
	bra.w  @loc_141E    ; Get CDD status
; ---------------------------------------------------------------------------
	move.b #4, d1       ; Unknown
	bra.s  @loc_146A
; ---------------------------------------------------------------------------

; Get CDD status
@loc_141E:               ; CODE XREF: sub_12CE+146j
	move.b  #$FF, d1

	tst.l   cddStatusCache(a5)
	bne.s   @loc_143C

	tst.l   cddStatusCache+4(a5)
	bne.s   @loc_143C

	cmpi.w  #$F, cddStatusCache+8(a5)
	bne.s   @loc_143C

	addq.b  #2, byte_5A04(a5)
	bra.s   @loc_146A
; ---------------------------------------------------------------------------

@loc_143C:               ; CODE XREF: sub_12CE+158j
				; sub_12CE+15Ej ...
	st    byte_5A04(a5)
	bra.s @loc_146A
; ---------------------------------------------------------------------------

; Unknown
@loc_1442:               ; CODE XREF: sub_12CE:loc_1408j
	bsr.w  cddGetStatusCodeByte

	move.b d0, d1
	bra.s  @loc_146A
; ---------------------------------------------------------------------------

; Get TOC info
@loc_144A:               ; CODE XREF: sub_12CE+13Ej
	move.b 3(a0), d1
	bset   #7, d1
	bset   #7, cddFlags2(a5)
	bra.s  @loc_146A
; ---------------------------------------------------------------------------

; Resume play
@loc_145A:               ; CODE XREF: sub_12CE+142j
	bsr.w   cddGetStatusCodeByte

	move.b  #1, d1

	cmpi.b  #$C, d0
	bne.s   @loc_146A

	move.b  d0, d1

; Unknown
@loc_146A:               ; CODE XREF: sub_12CE+11Aj
				; sub_12CE+14Ej ...
	move.b  d1,   byte_5815(a5)
	ori.b   #6,   cddFlags2(a5)
	move.w  #750, word_5816(a5)
	move.b  #75,  byte_5813(a5)
	move.b  #2,   byte_5814(a5)
	bra.s   @loc_1490
; ---------------------------------------------------------------------------

@loc_1488:               ; CODE XREF: sub_12CE+212j
				; sub_12CE+246j ...
	btst    #0, cddFlags3(a5)
	bne.s   @writeCommand

@loc_1490:               ; CODE XREF: sub_12CE+1B8j
	move.l   (a0), dword_5832(a5)
	move.l  4(a0), dword_5836(a5)

@writeCommand:               ; CODE XREF: sub_12CE+1C0j
	; Write CDD command to buffer
	; and calculate checksum
	lea cddCommandBuffer(a5), a1
	clr.b d0

	moveq #3, d1
	@loc_14A2:
		add.b  (a0), d0
		move.b (a0)+, (a1)+
		add.b  (a0), d0
		move.b (a0)+, (a1)+
		dbf d1, @loc_14A2

	not.b   d0
	andi.w  #$F, d0
	move.w  d0, (a1)
	rts
; ---------------------------------------------------------------------------

@loc_14B8:               ; CODE XREF: sub_12CE+44j
	lea     dword_5832(a5), a0
	cmpi.b  #$A, (a0)
	bne.s   @loc_14D6

	movem.l d0-d1, -(sp)

	move.l  4(a0), d0
	move.b  3(a0), d1
	move.l  d0, 4(a0)

	movem.l (sp)+, d0-d1

@loc_14D6:               ; CODE XREF: sub_12CE+1F2j
	bra.s   @loc_14DC
; ---------------------------------------------------------------------------

@loc_14D8:               ; CODE XREF: sub_12CE+6Cj sub_12CE+74j
	lea cddCommandBuffer(a5), a0

@loc_14DC:               ; CODE XREF: sub_12CE:loc_14D6j
	subq.b  #1, byte_5813(a5)
	bcc.s   @loc_1488

	bset    #0, cddFlags7(a5)
	bra.s   @loc_14F4
; ---------------------------------------------------------------------------
	nop
	nop
	nop
	nop
	nop

@loc_14F4:               ; CODE XREF: sub_12CE+6j sub_12CE+C6j ...
	clr.b   cddFlags2(a5)
	bclr    #7, cddFlags4(a5)
	andi.b  #$E7, cddFlags0(a5)

	lea    dword_5822(a5), a0
	move.l #$01000000, 0(a0)    ; Stop all CDD operations
	clr.l  4(a0)
	bra.w  @loc_1488
; ---------------------------------------------------------------------------

@loc_1518:               ; CODE XREF: sub_12CE:loc_1302j
				; sub_12CE+BCj ...
	btst    #7, cddFlags2(a5)
	bne.s   @loc_1576

	btst    #2, cddFlags3(a5)
	beq.s   @loc_1576

	tst.b   cddFlags5(a5)
	beq.s   @loc_1576

	addq.b  #1, byte_59F7(a5)

	moveq   #0, d0
	move.b  byte_59F7(a5), d0
	cmpi.b  #3, d0
	bcs.s   @loc_1544

	moveq   #0, d0
	move.b  d0, byte_59F7(a5)

@loc_1544:               ; CODE XREF: sub_12CE+26Ej
	lsl.w #3, d0
	jmp   @loc_154A(pc, d0.w)
; ---------------------------------------------------------------------------

@loc_154A:
	move.l  #$02000000, d0      ; Get current absolute position
	bra.s   @loc_1560
; ---------------------------------------------------------------------------
	move.l  #$02000001, d0      ; Get current relative position
	bra.s   @loc_1560
; ---------------------------------------------------------------------------
	move.l  #$02000002, d0      ; Get current track number

@loc_1560:               ; CODE XREF: sub_12CE+282j
				; sub_12CE+28Aj
	bset    #4, cddFlags2(a5)

	lea     dword_5822(a5), a0
	move.l  d0, 0(a0)
	clr.l   4(a0)

	bra.w   @loc_1488
; ---------------------------------------------------------------------------

@loc_1576:               ; CODE XREF: sub_12CE+250j
				; sub_12CE+258j ...
	bset #5, cddFlags2(a5)

	lea    dword_5822(a5), a0
	move.l #0, 0(a0)            ; Get CDD status
	clr.l  4(a0)

	bra.w @loc_1488
; ---------------------------------------------------------------------------

; Fetch start position (MSF) for a given track
@loc_1590:               ; CODE XREF: sub_12CE+106j
	bset    #6, cddFlags2(a5)
	clr.b   requestedTrackNumber(a5)

	move.w  cddCommandWorkArea+4(a5), d0
	lsl.b   #4, d0
	lsr.w   #4, d0

	bclr    #7, d0
	beq.s   @loc_15AE

	bset    #1, cddFlags0(a5)

@loc_15AE:               ; CODE XREF: sub_12CE+2D8j
	move.b  d0, byte_581A(a5)

	move.w  cddCommandWorkArea+6(a5), d0
	lsl.b   #4, d0
	lsr.w   #4, d0

	move.b  d0, byte_581B(a5)

	ori.b   #$84, cddFlags2(a5)
	bclr    #0,   cddFlags2(a5)

	btst    #6, cddFlags4(a5)
	beq.s   @loadDummyToc

	btst    #5, cddFlags4(a5)
	beq.s   @loadDummyToc

	move.b  cddStatusCode(a5), d0
	cmpi.b  #1, d0
	beq.s   @loc_1632

	cmpi.b  #4, d0
	beq.s   @loc_1632

	cmpi.b  #$C, d0
	beq.s   @loc_1632

@loadDummyToc:               ; CODE XREF: sub_12CE+302j
	; Mark the TOC and lead-out time invalid
	andi.b  #$9F, cddFlags4(a5)

	; Load the internal TOC table with dummy entries
	lea    cddTocTable(a5), a0
	move.l #$00020000, d0

	moveq #9, d1
	@loc_1602:
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		dbf d1, @loc_1602

	move.b #0, byte_5818(a5)

	lea    dword_5822(a5), a0
	move.l #$02000004, 0(a0)    ; Get first/last track numbers
	clr.l  4(a0)

	bra.s @loc_1636
; ---------------------------------------------------------------------------

@loc_1632:               ; CODE XREF: sub_12CE+314j
	bra.w   @loc_16E0
; ---------------------------------------------------------------------------

@loc_1636:               ; CODE XREF: sub_12CE+362j
	move.w #1500, word_581C(a5)
	move.b #75,   byte_5813(a5)
	move.b #2,    byte_5814(a5)
	bset   #1,    cddFlags2(a5)
	bra.w  @loc_1488
; ---------------------------------------------------------------------------

@loc_1652:               ; CODE XREF: sub_12CE+80j
	move.b  byte_5818(a5), d0
	andi.w  #3, d0
	add.w   d0, d0
	add.w   d0, d0
	jmp     @loc_1662(pc, d0.w)
; ---------------------------------------------------------------------------

@loc_1662:
	bra.w   @loc_16AE
; ---------------------------------------------------------------------------
	bra.w   @loc_16D0
; ---------------------------------------------------------------------------
	bra.w   @loc_174C
; ---------------------------------------------------------------------------
	bra.w   @loc_17DA
; ---------------------------------------------------------------------------

@loc_1672:               ; CODE XREF: sub_12CE+3E6j
				; sub_12CE+408j ...
	btst    #5, cddFlags3(a5)
	bne.s   @loc_169A

	subq.w  #1, word_581C(a5)
	bcc.w   @loc_1518

	cmpi.b  #2, byte_5818(a5)
	bne.s   @loc_16A4

	bset    #5, cddFlags7(a5)
	bclr    #7, cddFlags4(a5)
	bra.w   @loc_174C
; ---------------------------------------------------------------------------

@loc_169A:               ; CODE XREF: sub_12CE+3AAj
	bset    #6, cddFlags7(a5)
	bra.w   @loc_14F4
; ---------------------------------------------------------------------------

@loc_16A4:               ; CODE XREF: sub_12CE+3BAj
	bset    #2, cddFlags7(a5)
	bra.w   @loc_14F4
; ---------------------------------------------------------------------------

@loc_16AE:               ; CODE XREF: sub_12CE:loc_1662j
	btst  #6, cddFlags4(a5)
	beq.s @loc_1672

	move.b #1, byte_5818(a5)

	lea    dword_5822(a5), a0
	move.l #$02000003, 0(a0)    ; Get CD length (lead-out start time)
	clr.l  4(a0)

	bra.w @loc_1636
; ---------------------------------------------------------------------------

@loc_16D0:               ; CODE XREF: sub_12CE+398j
	btst    #5, cddFlags4(a5)
	beq.s   @loc_1672

	btst    #3, cddFlags3(a5)
	beq.s   @loc_1672

@loc_16E0:               ; CODE XREF: sub_12CE:loc_1632j
	move.b  #2, byte_5818(a5)
	movem.l a0, -(sp)

	lea     cddLastTrack(a5), a0
	move.b  byte_581A(a5), d0
	cmp.b   (a0), d0
	bls.s   @loc_16F8

	move.b  (a0), d0

@loc_16F8:               ; CODE XREF: sub_12CE+426j
	lea     cddFirstTrack(a5), a0
	cmp.b   (a0), d0
	bcc.s   @loc_1702

	move.b  (a0), d0

@loc_1702:               ; CODE XREF: sub_12CE+430j
	move.b  d0, byte_581A(a5)
	move.b  d0, requestedTrackNumber(a5)
	move.b  byte_581B(a5), d0
	cmp.b   (a0), d0
	bcc.s   @loc_1714

	move.b  (a0), d0

@loc_1714:               ; CODE XREF: sub_12CE+442j
	lea     cddLastTrack(a5), a0
	cmp.b   (a0), d0
	bls.s   @loc_171E

	move.b  (a0), d0

@loc_171E:               ; CODE XREF: sub_12CE+44Cj
	move.b  d0, byte_581B(a5)
	movem.l (sp)+, a0

@loc_1726:               ; CODE XREF: sub_12CE+4B4j
	bset    #7, cddFlags4(a5)

	lea    dword_5822(a5), a0
	move.l #$02000005, 0(a0)    ; Get track start time

	moveq  #0, d0
	move.b requestedTrackNumber(a5), d0
	lsl.w  #4, d0
	lsr.b  #4, d0

	swap   d0
	move.l d0, 4(a0)

	bra.w  @loc_1636
; ---------------------------------------------------------------------------

@loc_174C:               ; CODE XREF: sub_12CE+39Cj
				; sub_12CE+3C8j
	cmpi.b  #0, cddStatusCode(a5)
	bne.s   @loc_175E

	bset    #3, cddFlags7(a5)
	bra.w   @loc_14F4
; ---------------------------------------------------------------------------

@loc_175E:               ; CODE XREF: sub_12CE+484j
	btst    #7, cddFlags4(a5)
	bne.w   @loc_1672

	move.b  requestedTrackNumber(a5), d0

	cmp.b   byte_581B(a5), d0
	bcc.s   @loc_1784

	move.b  requestedTrackNumber(a5), d0
	moveq   #1, d1
	move    #4, ccr
	abcd    d1, d0
	move.b  d0, requestedTrackNumber(a5)
	bra.s   @loc_1726
; ---------------------------------------------------------------------------

@loc_1784:               ; CODE XREF: sub_12CE+4A2j
	move.b #3, byte_5818(a5)

	bclr   #1, cddFlags0(a5)
	bne.s  @loc_17C6

	moveq  #1, d0
	bsr.w  getTocForTrack

	tst.b  d0
	beq.s  @loc_17B2

	move.w #$0400, dword_5822(a5)   ; Seek to time
	lea    dword_5822+2(a5), a1
	bsr.w  timecodeToCddCommand

	lea    dword_5822(a5), a0
	bra.w  @loc_1636
; ---------------------------------------------------------------------------

@loc_17B2:               ; CODE XREF: sub_12CE+4CCj
	lea    dword_5822(a5), a0
	move.l #$06000000, 0(a0)    ; Stop read
	clr.l  4(a0)

	bra.w  @loc_1636
; ---------------------------------------------------------------------------

@loc_17C6:               ; CODE XREF: sub_12CE+4C2j
	lea    dword_5822(a5), a0
	move.l #$07000000, 0(a0)    ; Resume play
	clr.l  4(a0)

	bra.w  @loc_1636
; ---------------------------------------------------------------------------

@loc_17DA:               ; CODE XREF: sub_12CE+3A0j
	btst    #3, cddFlags3(a5)
	bne.w   @loc_1672

	andi.b  #$3B, cddFlags2(a5)
	bra.w   @loc_13BC
; End of function sub_12CE
