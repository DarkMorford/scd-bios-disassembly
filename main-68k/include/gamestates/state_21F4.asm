;   ======================================================================
;       State 1 ($21F4)
;   ======================================================================

; =============== S U B R O U T I N E =======================================


sub_1CFA:               ; CODE XREF: sub_21F4p
	st (byte_FFFFFE28).w

	bsr.w displayOff

	bsr.w sendE3ToZ80

	bsr.w loadDefaultVdpRegs

	move.w #$FFFF, d1
	m_loadVramWriteAddress 0, d0
	bsr.w clearVramSegment

	clr.l (dword_FFFFC106).w

	bsr.w sub_16C4

	lea vdpReg_217A(pc), a1
	jsr loadVdpRegs(pc)

	m_disableInterrupts

	lea   (palette_218A).l, a1
	bsr.w loadPalettesToBuffer

	m_loadVramWriteAddress $A660
	lea (unk_9C00).l, a1
	jsr decompressNemesis

	move.w #$2533, d0
	lea    (unk_B9DA).l, a1
	lea    (decompScratch).w, a2
	bsr.w  decompressEnigma

	moveq #$27, d1
	moveq #$15, d2
	m_loadVramWriteAddress $D380, d0
	lea (decompScratch).w, a1
	jsr writeTilemapToVram

	m_loadVramWriteAddress $D0C0
	lea (unk_BAAE).l, a1
	jsr decompressNemesis

	move.w #$4686, d0
	lea    (unk_BAC8).l, a1
	lea    (decompScratch).w, a2
	bsr.w  decompressEnigma

	moveq #$1C, d1
	moveq #2, d2
	m_loadVramWriteAddress $D492, d0
	lea (decompScratch).w, a1
	jsr writeTilemapToVram

	move.w #$4686 ,d0
	lea    (unk_BAEC).l, a1
	lea    (decompScratch).w, a2
	bsr.w  decompressEnigma

	moveq #$C, d1
	moveq #3, d2
	m_loadVramWriteAddress $D614, d0
	lea (decompScratch).w, a1
	jsr writeTilemapToVram

	move.w #$4686, d0
	lea    (unk_BB06).l, a1
	lea    (decompScratch).w, a2
	bsr.w  decompressEnigma

	moveq #$C, d1
	moveq #$A, d2
	m_loadVramWriteAddress $D802, d0
	lea (decompScratch).w, a1
	jsr writeTilemapToVram

	moveq #15, d7
	m_loadVramWriteAddress $E1E0
	@loc_1DFA:
		move.w #$3333, (VDP_DATA).l
		dbf d7, @loc_1DFA

	moveq #$27, d1
	moveq #2, d2
	m_loadVramWriteAddress $E400, d0
	move.w #$670F, d3
	jsr    fillVramTilemap

	moveq #$27, d1
	moveq #2, d2
	m_loadVramWriteAddress $F080, d0
	move.w #$670F, d3
	jsr    fillVramTilemap

	moveq #$27, d1
	moveq #2, d2
	m_loadVramWriteAddress $F200, d0
	move.w #$670F, d3
	jsr    fillVramTilemap

	moveq #$27, d1
	moveq #2, d2
	m_loadVramWriteAddress $FE80, d0
	move.w #$670F, d3
	jsr    fillVramTilemap

	m_loadVramWriteAddress $E000
	lea    (word_EB12).l, a0
	move.w #175, d6
	@loc_1E62:
		move.w (a0)+, (VDP_DATA).l
		dbf d6, @loc_1E62

	move.w #$E700, d0
	moveq  #10, d7
	m_loadVramWriteAddress $D328
	@loc_1E7C:
		move.w d0, (VDP_DATA).l
		addq.w #1, d0
		dbf d7, @loc_1E7C

	m_loadVramWriteAddress $E160
	lea    (dword_EC72).l, a0
	move.w #31,d7
	@loc_1E9C:
		move.l (a0)+, (VDP_DATA).l
		dbf d7, @loc_1E9C

	move.w #$E70B, d0
	moveq  #3, d7
	m_loadVramWriteAddress $D340
	@loc_1EB6:
		move.w d0, (VDP_DATA).l
		addq.w #1, d0
		dbf d7, @loc_1EB6

	moveq  #9, d7
	m_loadVramWriteAddress $D260, d0
	lea    (word_ECF2).l, a0
	@loc_1ED0:
		move.l  d0, (VDP_CONTROL).l

		moveq #15, d6
		@loc_1ED8:
			move.w (a0)+, (VDP_DATA).l
			dbf d6, @loc_1ED8

		addi.l #$800000, d0
		dbf d7, @loc_1ED0

	m_loadVramWriteAddress $D348
	move.w #$E693, d0
	move.w d0, (VDP_DATA).l

	m_loadVramWriteAddress $D34A
	move.w #$E693, d0
	move.w d0, (VDP_DATA).l

	bsr.w sub_238C

	clr.b (byte_FFFFC0FF).w
	clr.b (unk_FFFFFE53).w

	m_waitForWordRam2M
	m_waitForWordRamReturn

	clr.w (word_219C00).l

	; Clear Word RAM $220000-$240000 (Second 1M bank)
	lea    (WordRAM_Bank1).l, a0
	move.w #$7FFF, d7
	@loc_1F44:
		clr.l (a0)+
		dbf d7, @loc_1F44

	; Copy $BB46-$D0C6 to $200080-$201600
	lea    (dword_BB46).l, a0
	lea    (unk_200080).l, a1
	move.w #1375, d7
	@loc_1F5A:
		move.l (a0)+, (a1)+
		dbf d7, @loc_1F5A

	; Copy $D09E-$E69E to $201880-$202E80
	lea    (dword_D09E).l, a0
	lea    (unk_201880).l, a1
	move.w #1407, d7
	@loc_1F70:
		move.l (a0)+, (a1)+
		dbf d7, @loc_1F70

	lea    (dword_D046).l, a0
	lea    (unk_220C02).l, a1
	moveq  #$A,   d0
	moveq  #3,    d1
	move.w #$200, d2
	bsr.w  multipartCopy

	lea    (dword_E61E).l, a0
	lea    (unk_23F002).l, a1
	moveq  #$10,  d0
	moveq  #3,    d1
	move.w #$200, d2
	bsr.w  multipartCopy

	; Clear Word RAM $21A000-$21FF00
	lea    (unk_21A000).l,a0
	move.w #6079, d7
	@loc_1FB0:
		move.l #0, (a0)+
		dbf d7, @loc_1FB0

	move.w #0, (word_FFFFC10E).w
	move.w #0, (word_FFFFC110).w
	move.w #0, (word_FFFFC112).w
	move.w #0, (word_FFFFC114).w
	move.w #0, (word_FFFFC116).w
	move.w #0, (word_FFFFC118).w
	move.w #0, (word_FFFFC11A).w
	move.w #0, (word_FFFFC11C).w
	move.w #0, (word_FFFFC11E).w
	move.w #0, (word_FFFFC120).w

	move.w #0, (word_219C02).l
	move.w #0, (word_219C04).l
	move.w #0, (word_219C06).l
	move.w #0, (word_219C08).l
	move.w #0, (word_219C0A).l
	move.w #0, (word_219C0C).l
	move.w #0, (word_219C0E).l
	move.w #0, (word_219C10).l
	move.w #0, (word_219C12).l
	move.w #0, (word_219C14).l

	; Clear $FFC102-$FFC10C
	lea (palette2Rotation).w, a0
	moveq #4, d7
	@loc_204C:
		clr.w (a0)+
		dbf d7, @loc_204C

	; Clear $FFC122-$FFC13A
	lea (dword_FFFFC122).w, a0
	moveq #11, d7
	@loc_2058:
		clr.w (a0)+
		dbf d7, @loc_2058

	clr.w (word_219C00).l
	clr.w (word_219C16).l
	clr.w (word_219C18).l

	move.w #0, (word_FFFFC136).w

	m_giveWordRamToSubCpu

	m_enableInterrupts

	m_loadVramWriteAddress $E602, d0
	move.w #$25, d1
	move.w #4,   d2
	move.w #1,   d3
	jsr writeTransposedTilemapToVram

	m_loadVramWriteAddress $E882, d0
	move.w #$25, d1
	move.w #4,   d2
	move.w #$BF, d3
	jsr writeTransposedTilemapToVram

	m_loadVramWriteAddress $EB02, d0
	move.w #$25,  d1
	move.w #4,    d2
	move.w #$17D, d3
	jsr writeTransposedTilemapToVram

	m_loadVramWriteAddress $ED82, d0
	move.w #$25,  d1
	move.w #4,    d2
	move.w #$475, d3
	jsr writeTransposedTilemapToVram

	m_loadVramWriteAddress $F402, d0
	move.w #$25,  d1
	move.w #4,    d2
	move.w #$23B, d3
	jsr writeTransposedTilemapToVram

	m_loadVramWriteAddress $F682, d0
	move.w #$25,  d1
	move.w #4,    d2
	move.w #$2F9, d3
	jsr writeTransposedTilemapToVram

	m_loadVramWriteAddress $F902, d0
	move.w #$25,  d1
	move.w #4,    d2
	move.w #$3B7, d3
	jsr writeTransposedTilemapToVram

	m_loadVramWriteAddress $FB82, d0
	move.w #$25,  d1
	move.w #4,    d2
	move.w #$475, d3
	jsr writeTransposedTilemapToVram

	m_loadVsramWriteAddress 0
	move.w #$120, (VDP_DATA).l

	m_loadVsramWriteAddress 2
	move.w #$120, (VDP_DATA).l

	jsr displayOn

	lea (sub_2424).l, a1
	jsr setVblankUserRoutine

	clr.b (byte_FFFFFE28).w
	bsr.w sub_16D2

	move.b #Z80CMD_81, d7
	jsr    sendCommandToZ80

	jmp waitForVblank
; End of function sub_1CFA

; ---------------------------------------------------------------------------
vdpReg_217A:
	dc.w $8238 ; Reg #02: Scroll A pattern table $E000
	dc.w $8300 ; Reg #03: Window pattern table $0000
	dc.w $8406 ; Reg #04: Scroll B pattern table $C000
	dc.w $8500 ; Reg #05: Sprite attribute table $0000
	dc.w $8B00 ; Reg #11: Ext. Int off, H/V full scroll mode
	dc.w $8D00 ; Reg #13: H-scroll data table $0000
	dc.w $9011 ; Reg #16: Scroll plane size 64x64 cells
	dc.w 0

palette_218A:
	dc.b 0
	dc.b 51

palette_218C:
	dc.w $000
	dc.w $0EE
	dc.w $0AE
	dc.w $06E
	dc.w $00E
	dc.w $E0C
	dc.w $E60
	dc.w $CE0
	dc.w $0E0
	dc.w $000
	dc.w $EEC
	dc.w $C00
	dc.w $C20
	dc.w $C40
	dc.w $C60
	dc.w $C80

palette_21AC:
	dc.w $000
	dc.w $000
	dc.w $8AA
	dc.w $246
	dc.w $864
	dc.w $ACC
	dc.w $224
	dc.w $466
	dc.w $444
	dc.w $666
	dc.w $888
	dc.w $68A
	dc.w $268
	dc.w $AAA
	dc.w $442
	dc.w $000

palette_21CC:
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $246
	dc.w $864
	dc.w $ACC
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $888
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000

palette_21EC:
	dc.w $000
	dc.w $EEE
	dc.w $888
	dc.w $000

; =============== S U B R O U T I N E =======================================


sub_21F4:               ; CODE XREF: ROM:000005DAj
	; Load assets for this state
	bsr.w sub_1CFA

@loc_21F8:
	; Set a countdown for 600 frames (10 seconds)
	move.w #600, (word_FFFFC100).w

@loc_21FE:
	bsr.w sub_26E8

	jsr waitForVblank

	movem.l d0-d1/a1, -(sp)

	moveq #0, d0

	; Check controller #1 type
	cmpi.b #JOYTYPE_MULTITAP, (joy1Type).w
	bne.s  @loc_2224

	lea (multitapControllerTypes).w, a1

	moveq #3, d1
	@loc_221A:
		cmpi.b #2, (a1)+
		dbeq   d1, @loc_221A

	beq.s @loc_222C

@loc_2224:
	cmpi.b #JOYTYPE_MEGAMOUSE, (joy2Type).w
	bne.s  @loc_2236

@loc_222C:
	move.b (joy2Triggered).w, d0
	andi.w #$50, d0
	add.w  d0, d0

@loc_2236:
	cmpi.b #JOYTYPE_MEGAMOUSE, (joy1Type).w
	bne.s  @loc_224A

	move.b (joy1Triggered).w, d1
	andi.w #$50, d1
	add.w  d1, d1
	or.w   d1, d0

@loc_224A:
	or.b d0, (joy1Triggered).w

	movem.l (sp)+, d0-d1/a1

	jsr   sub_1856
	bcc.s @loc_2264

	moveq #3, d2
	bsr.w sub_2310

	clr.b (byte_FFFFC0FF).w
	bra.s @loc_21F8
; ---------------------------------------------------------------------------

@loc_2264:
	bsr.w  getDiscType

	tst.b  d0
	bmi.s  @loc_2298    ; CD drive not ready

	tst.b  (byte_FFFFFE3A).w
	bmi.s  @loc_21FE

	tst.b  (byte_FFFFC0FF).w
	bne.w  @loc_22D4

	move.b (joy1Triggered).w, d0
	
	; Check START button
	bmi.s  @loc_228E

	; Check ABC buttons
	andi.b #$70, d0
	beq.s  @loc_2294

	move.b #2, (byte_FFFFC0FF).w
	bra.s  @loc_2294
; ---------------------------------------------------------------------------

@loc_228E:
	move.b #1, (byte_FFFFC0FF).w

@loc_2294:
	moveq #2, d2
	bra.s @loc_22BE
; ---------------------------------------------------------------------------

@loc_2298:
	tst.b  (byte_FFFFC0FF).w
	bne.s  @loc_22BC

	move.b (joy1Triggered).w, d0
	
	; Check START button
	bmi.s  @loc_22AE

	; Check ABC buttons
	andi.b #$70, d0
	bne.s  @loc_22B6

	moveq  #0, d2
	bra.s  @loc_22BE
; ---------------------------------------------------------------------------

@loc_22AE:
	move.b #1, (byte_FFFFC0FF).w
	bra.s  @loc_22BC
; ---------------------------------------------------------------------------

@loc_22B6:
	move.b #2, (byte_FFFFC0FF).w

@loc_22BC:
	moveq #1, d2

@loc_22BE:
	bsr.w  sub_2310

	tst.w  (word_FFFFC100).w
	beq.w  @loc_21FE

	subq.w #1, (word_FFFFC100).w
	beq.s  @loc_2306
	bra.w  @loc_21FE
; ---------------------------------------------------------------------------

@loc_22D4:
	cmpi.b #2, (byte_FFFFC0FF).w
	beq.s  @loc_22E2

	bsr.w  checkDiscBootable
	beq.s  @loc_22F8

@loc_22E2:
	move.b #Z80CMD_E0, d7
	jsr    sendCommandToZ80

	moveq #1, d0
	moveq #8, d1
	jsr sub_1800(pc)

	moveq #STATE_3040, d0
	jmp   setNextState
; ---------------------------------------------------------------------------

@loc_22F8:
	; Bootable disc loaded, go to launch state
	move.b #Z80CMD_E1, d7
	jsr    sendCommandToZ80

	moveq #STATE_LOAD, d0
	jmp   setNextState
; ---------------------------------------------------------------------------

@loc_2306:
	jsr   checkDiscBootable
	beq.s @loc_22F8
	bra.w @loc_21FE
; End of function sub_21F4


; =============== S U B R O U T I N E =======================================


sub_2310:               ; CODE XREF: sub_21F4+66p
					; sub_21F4:loc_22BEp
	lsl.w #2, d2

	movea.l off_2326(pc, d2.w), a0
	m_loadVramWriteAddress $E460, d1
	move.w #55, d6
	bsr.w  sub_2336

	rts
; End of function sub_2310

; ---------------------------------------------------------------------------
off_2326:
	dc.l unk_FFFFC13A   ; No buttons pressed
	dc.l unk_FFFFC83A   ; At least one of SABC pressed
	dc.l unk_FFFFCF3A
	dc.l unk_FFFFD63A

; =============== S U B R O U T I N E =======================================


sub_2336:               ; CODE XREF: sub_2310+10p
	move.l d1, (VDP_CONTROL).l

	moveq #15, d7
	@loc_233E:
		move.w (a0)+, (VDP_DATA).l
		dbf d7, @loc_233E

	addi.l #$800000, d1     ; Add $80 to VDP address
	dbf d6, sub_2336

	rts
; End of function sub_2336


; =============== S U B R O U T I N E =======================================


; Inputs:
;   a0: Data source
;   a1: Data destination
;   d1:

sub_2354:               ; CODE XREF: sub_238C+18p sub_238C+32p ...
	movea.l a1, a2

	; Clear $700 bytes
	move.w #$1BF, d7
	@loc_235A:
		move.l #0, (a2)+
		dbf d7, @loc_235A

	movea.l a1, a2

	moveq #$1C, d7
	sub.w d1,   d7
	lsr.w #1,   d7
	lsl.w #5,   d7

	adda.w  d7, a2
	movea.l a2, a1

	move.w d1, d7
	lsl.w  #4, d7
	subq.w #1, d7
	move.w d7, d0

	@loc_237A:
		move.w (a0)+, (a2)+
		dbf d7, @loc_237A

	adda.w #$380, a1

	@loc_2384:
		move.w (a0)+, (a1)+
		dbf d0, @loc_2384

	rts
; End of function sub_2354


; =============== S U B R O U T I N E =======================================


sub_238C:               ; CODE XREF: sub_1CFA+21Ap
	lea   (decompScratch).w, a2
	lea   (unk_E6A6).l, a1
	bsr.w decompressNemesisToRam

	moveq #$F, d1
	lea   (decompScratch).w, a0
	lea   (unk_FFFFC13A).w, a1
	bsr.s sub_2354

	lea   (decompScratch).w, a2
	lea   (unk_E7A8).l, a1
	bsr.w decompressNemesisToRam

	moveq #$D, d1
	lea   (decompScratch).w, a0
	lea   (unk_FFFFC83A).w, a1
	bsr.s sub_2354

	lea   (decompScratch).w, a2
	lea   (unk_E882).l, a1
	bsr.w decompressNemesisToRam

	moveq #$1A, d1
	lea   (decompScratch).w, a0
	lea   (unk_FFFFCF3A).w, a1
	bsr.w sub_2354

	lea   (decompScratch).w, a2
	lea   (unk_E9F2).l, a1
	bsr.w decompressNemesisToRam

	moveq #$14, d1
	lea   (decompScratch).w, a0
	lea   (unk_FFFFD63A).w, a1
	bsr.w sub_2354

	moveq  #1, d6
	move.w #$E723, d0
	m_loadVramWriteAddress $DE8C, d1

	@loc_2404:
		moveq #27, d7
		move.l d1, (VDP_CONTROL).l

		@loc_240C:
			move.w d0, (VDP_DATA).l
			addq.w #4, d0
			dbf d7, @loc_240C

		addi.l #$800000, d1
		dbf d6, @loc_2404

	rts
; End of function sub_238C


; =============== S U B R O U T I N E =======================================


; V-blank handler for state_21F4
sub_2424:               ; DATA XREF: sub_1CFA+462o
	bsr.w  checkDiscReady

	jsr    displayOff

	; Return if sub-CPU has Word RAM
	btst   #GA_RET, (GA_MEM_MODE).l
	beq.w  @loc_24DC

	move.w (word_219C00).l, d3
	cmpi.w #3, d3
	bne.s  @loc_2458

	m_loadVsramWriteAddress 0
	move.w #$40, (VDP_DATA).l

	bra.s  @loc_2470
; ---------------------------------------------------------------------------

@loc_2458:
	cmpi.w #7, d3
	bne.s  @loc_2478

	m_loadVsramWriteAddress 0
	move.w #$120, (VDP_DATA).l

@loc_2470:
	bsr.w rotatePalette2
	bsr.w rotatePalette0

@loc_2478:
	move.w (word_219C00).l, d3

	; Get VRAM address for DMA
	lsl.w  #1, d3
	moveq  #0, d0
	move.w word_24E2(pc, d3.w), d0

	; Convert address to VDP format
	lsl.l  #2, d0
	lsr.w  #2, d0
	swap   d0
	ori.l  #$40000000, d0

	; Get DMA word count
	move.w word_24F2(pc, d3.w), d2

	; Get DMA source address
	lsl.w  #1, d3
	move.l off_2502(pc, d3.w), d1

	jsr dmaTransferToVramWithRewrite

	move.w (word_219C00).l, (word_FFFFC10A).w
	move.b (byte_FFFFC138).w, (word_219C18).l

	tst.b (word_219C16).l
	beq.s @loc_24C0

	move.b (word_219C16).l, (byte_FFFFC10C).w

@loc_24C0:
	moveq #9, d7
	lea (word_FFFFC10E).w, a0
	lea (word_219C02).l, a1

	@loc_24CC:
		move.w (a0)+, (a1)+
		dbf d7, @loc_24CC

	m_giveWordRamToSubCpu

@loc_24DC:
	jsr displayOn
	rts
; End of function sub_2424

; ---------------------------------------------------------------------------
word_24E2:
	dc.w $0020
	dc.w $17E0
	dc.w $2FA0
	dc.w $8EA0
	dc.w $4760
	dc.w $5F20
	dc.w $76E0
	dc.w $8EA0

word_24F2:
	dc.w $BE0
	dc.w $BE0
	dc.w $BE0
	dc.w $BE0
	dc.w $BE0
	dc.w $BE0
	dc.w $BE0
	dc.w $BE0

off_2502:
	dc.l unk_21A000
	dc.l unk_21B7C0
	dc.l unk_21CF80
	dc.l unk_21E740
	dc.l unk_21A000
	dc.l unk_21B7C0
	dc.l unk_21CF80
	dc.l unk_21E740

; =============== S U B R O U T I N E =======================================

; Inputs:
;   a0: Data source
;   a1: Data destination (initial)
;   d0: Word count per part
;   d1: Number of parts
;   d2: Address step between parts

multipartCopy:               ; CODE XREF: sub_1CFA+290p
					; sub_1CFA+2A8p ...
	@loc_2522:
		movea.l a1, a2
		move.w  d0, d3

		@loc_2526:
			move.w  (a0)+, (a2)+
			dbf d3, @loc_2526

		adda.w  d2, a1
		dbf d1, @loc_2522

	rts
; End of function multipartCopy


; =============== S U B R O U T I N E =======================================


sub_2534:
	movem.l d0-d7/a5, -(sp)

	lea (VDP_DATA).l, a5

	move.w #0, -(sp)
	move.w (vdpLineIncrement).w, -(sp)

	@loc_2546:
		move.l d0, 4(a5)
		move.w d1, d4

		@loc_254C:
			move.w (a1)+, d5
			add.w  d3, d5
			move.w d5, (a5)
			dbf d4, @loc_254C

		add.l (sp), d0
		dbf d2, @loc_2546

	addq.w #4, sp

	movem.l (sp)+, d0-d7/a5
	rts
; End of function sub_2534


; =============== S U B R O U T I N E =======================================


sub_2564:               ; CODE XREF: sub_2CDC+12p sub_2E0E+12p ...
	addi.w #$80, d7

loc_2568:               ; CODE XREF: sub_2802+8p sub_2834+8p ...
	move.l d6, -(sp)
	andi.w #$1FF, d7
	move.w d7, d6

	btst   #7, d7
	beq.s  @loc_2578

	not.w  d6

@loc_2578:
	andi.w #$7F, d6
	lsl.w  #1, d6
	move.w word_2590(pc, d6.w), d6

	btst   #8, d7
	beq.s  @loc_258A

	neg.w  d6

@loc_258A:
	move.w d6, d7
	move.l (sp)+, d6
	rts
; End of function sub_2564

; ---------------------------------------------------------------------------
word_2590:
	dc.w 0
	dc.w 3
	dc.w 6
	dc.w 9
	dc.w $C
	dc.w $F
	dc.w $12
	dc.w $16
	dc.w $19
	dc.w $1C
	dc.w $1F
	dc.w $22
	dc.w $25
	dc.w $28
	dc.w $2B
	dc.w $2F
	dc.w $32
	dc.w $35
	dc.w $38
	dc.w $3B
	dc.w $3E
	dc.w $41
	dc.w $44
	dc.w $47
	dc.w $4A
	dc.w $4D
	dc.w $50
	dc.w $53
	dc.w $56
	dc.w $59
	dc.w $5C
	dc.w $5F
	dc.w $62
	dc.w $65
	dc.w $68
	dc.w $6A
	dc.w $6D
	dc.w $70
	dc.w $73
	dc.w $76
	dc.w $79
	dc.w $7B
	dc.w $7E
	dc.w $81
	dc.w $84
	dc.w $86
	dc.w $89
	dc.w $8C
	dc.w $8E
	dc.w $91
	dc.w $93
	dc.w $96
	dc.w $99
	dc.w $9B
	dc.w $9E
	dc.w $A0
	dc.w $A2
	dc.w $A5
	dc.w $A7
	dc.w $AA
	dc.w $AC
	dc.w $AE
	dc.w $B1
	dc.w $B3
	dc.w $B5
	dc.w $B7
	dc.w $B9
	dc.w $BC
	dc.w $BE
	dc.w $C0
	dc.w $C2
	dc.w $C4
	dc.w $C6
	dc.w $C8
	dc.w $CA
	dc.w $CC
	dc.w $CE
	dc.w $D0
	dc.w $D1
	dc.w $D3
	dc.w $D5
	dc.w $D7
	dc.w $D8
	dc.w $DA
	dc.w $DC
	dc.w $DD
	dc.w $DF
	dc.w $E0
	dc.w $E2
	dc.w $E3
	dc.w $E5
	dc.w $E6
	dc.w $E7
	dc.w $E9
	dc.w $EA
	dc.w $EB
	dc.w $EC
	dc.w $EE
	dc.w $EF
	dc.w $F0
	dc.w $F1
	dc.w $F2
	dc.w $F3
	dc.w $F4
	dc.w $F5
	dc.w $F6
	dc.w $F7
	dc.w $F7
	dc.w $F8
	dc.w $F9
	dc.w $FA
	dc.w $FA
	dc.w $FB
	dc.w $FB
	dc.w $FC
	dc.w $FC
	dc.w $FD
	dc.w $FD
	dc.w $FE
	dc.w $FE
	dc.w $FE
	dc.w $FF
	dc.w $FF
	dc.w $FF
	dc.w $FF
	dc.w $FF
	dc.w $FF
	dc.w $100

; =============== S U B R O U T I N E =======================================


sub_2690:               ; CODE XREF: sub_27CCp sub_2994p ...
	move.w #0, (word_FFFFC10E).w
	move.w #0, (word_FFFFC110).w
	move.w #0, (word_FFFFC112).w
	move.w #0, (word_FFFFC114).w
	move.w #0, (word_FFFFC116).w

	clr.w (word_FFFFC132).w
	clr.l (dword_FFFFC122).w
	clr.l (dword_FFFFC126).w
	rts
; End of function sub_2690


; =============== S U B R O U T I N E =======================================


sub_26BC:               ; CODE XREF: sub_286Ap sub_2A82p ...
	move.w #0, (word_FFFFC118).w
	move.w #0, (word_FFFFC11A).w
	move.w #0, (word_FFFFC11C).w
	move.w #0, (word_FFFFC11E).w
	move.w #0, (word_FFFFC120).w

	clr.w (word_FFFFC134).w
	clr.l (dword_FFFFC12A).w
	clr.l (dword_FFFFC12E).w
	rts
; End of function sub_26BC


; =============== S U B R O U T I N E =======================================


sub_26E8:               ; CODE XREF: sub_21F4:loc_21FEp
	move.w (word_FFFFC10A).w, d0
	andi.w #3, d0
	cmpi.w #3, d0
	bne.s  @locret_2704

	tst.b  (byte_FFFFC10C).w
	beq.s  @locret_2704

	bsr.w  sub_2706
	bsr.w  sub_2722

@locret_2704:
	rts
; End of function sub_26E8


; =============== S U B R O U T I N E =======================================


sub_2706:               ; CODE XREF: sub_26E8+14p
	move.w (word_FFFFC136).w, d0
	lsl.w  #2, d0

	jsr loc_2712(pc, d0.w)
	rts
; End of function sub_2706

; ---------------------------------------------------------------------------

loc_2712:
	bra.w sub_2756
; ---------------------------------------------------------------------------
	bra.w sub_2878
; ---------------------------------------------------------------------------
	bra.w sub_2A90
; ---------------------------------------------------------------------------
	bra.w sub_2C60

; =============== S U B R O U T I N E =======================================


sub_2722:               ; CODE XREF: sub_26E8+18p
	move.w (word_FFFFC136).w, d0
	lsl.w  #2, d0

	jsr loc_272E(pc, d0.w)
	rts
; End of function sub_2722

; ---------------------------------------------------------------------------

loc_272E:
	bra.w sub_277E
; ---------------------------------------------------------------------------
	bra.w sub_28A4
; ---------------------------------------------------------------------------
	bra.w sub_2AC8
; ---------------------------------------------------------------------------
	bra.w sub_2C94

; =============== S U B R O U T I N E =======================================


sub_273E:               ; CODE XREF: ROM:00002766j
					; ROM:00002776j ...
	subq.w #1, (dword_FFFFC122).w
	bne.s  @locret_2748

	addq.w #1, (word_FFFFC132).w

@locret_2748:
	rts
; End of function sub_273E


; =============== S U B R O U T I N E =======================================


sub_274A:               ; CODE XREF: ROM:0000278Ej
					; ROM:000028BCj ...
	subq.w #1, (dword_FFFFC12A).w
	bne.s  @locret_2754

	addq.w #1, (word_FFFFC134).w

@locret_2754:
	rts
; End of function sub_274A


; =============== S U B R O U T I N E =======================================


sub_2756:               ; CODE XREF: ROM:loc_2712j
	move.w (word_FFFFC132).w, d0
	lsl.w  #2, d0

	jsr loc_2762(pc, d0.w)
	rts
; End of function sub_2756

; ---------------------------------------------------------------------------

loc_2762:
	bra.w sub_27A2
; ---------------------------------------------------------------------------
	bra.w sub_273E
; ---------------------------------------------------------------------------
	bra.w sub_27AE
; ---------------------------------------------------------------------------
	bra.w sub_27AE
; ---------------------------------------------------------------------------
	bra.w sub_27C0
; ---------------------------------------------------------------------------
	bra.w sub_273E
; ---------------------------------------------------------------------------
	bra.w sub_27CC

; =============== S U B R O U T I N E =======================================


sub_277E:               ; CODE XREF: ROM:loc_272Ej
	move.w (word_FFFFC134).w, d0
	lsl.w  #2, d0

	jsr loc_278A(pc, d0.w)
	rts
; End of function sub_277E

; ---------------------------------------------------------------------------

loc_278A:
	bra.w sub_27D2
; ---------------------------------------------------------------------------
	bra.w sub_274A
; ---------------------------------------------------------------------------
	bra.w sub_27DE
; ---------------------------------------------------------------------------
	bra.w sub_2802
; ---------------------------------------------------------------------------
	bra.w sub_2834
; ---------------------------------------------------------------------------
	bra.w sub_286A

; =============== S U B R O U T I N E =======================================


sub_27A2:               ; CODE XREF: ROM:loc_2762j
	move.w #$40, (dword_FFFFC122).w
	addq.w #1, (word_FFFFC132).w
	rts
; End of function sub_27A2


; =============== S U B R O U T I N E =======================================


sub_27AE:               ; CODE XREF: ROM:0000276Aj
					; ROM:0000276Ej
	subq.w #4, (word_FFFFC116).w
	andi.w #$1FF, (word_FFFFC116).w
	bne.s  @locret_27BE

	addq.w #1, (word_FFFFC132).w

@locret_27BE:
	rts
; End of function sub_27AE


; =============== S U B R O U T I N E =======================================


sub_27C0:               ; CODE XREF: ROM:00002772j
	move.w #$7F, (dword_FFFFC122).w
	addq.w #1, (word_FFFFC132).w
	rts
; End of function sub_27C0


; =============== S U B R O U T I N E =======================================


sub_27CC:               ; CODE XREF: ROM:0000277Aj
	bsr.w sub_2690
	rts
; End of function sub_27CC


; =============== S U B R O U T I N E =======================================


sub_27D2:               ; CODE XREF: ROM:loc_278Aj
	move.w #$40, (dword_FFFFC12A).w
	addq.w #1, (word_FFFFC134).w
	rts
; End of function sub_27D2


; =============== S U B R O U T I N E =======================================


sub_27DE:               ; CODE XREF: ROM:00002792j
	addq.w  #1,(dword_FFFFC12A).w
	move.w  (dword_FFFFC12A).w,d0
	lsr.w   #2,d0
	add.w   d0,(word_FFFFC11E).w
	cmpi.w  #$100,(dword_FFFFC12A).w
	bne.s   locret_2800
	addq.w  #1,(word_FFFFC134).w
	clr.w   (dword_FFFFC12A).w
	clr.w   (word_FFFFC11E).w

locret_2800:                ; CODE XREF: sub_27DE+14j
	rts
; End of function sub_27DE


; =============== S U B R O U T I N E =======================================


sub_2802:               ; CODE XREF: ROM:00002796j
	addq.w  #4,(dword_FFFFC12A).w
	move.w  (dword_FFFFC12A).w,d7
	bsr.w   loc_2568
	lsr.w   #2,d7
	neg.w   d7
	move.w  d7,(word_FFFFC11A).w
	move.w  (dword_FFFFC12A).w,(word_FFFFC11C).w
	addi.w  #$10,(word_FFFFC11E).w
	cmpi.w  #$100,(dword_FFFFC12A).w
	bne.s   locret_2832
	addq.w  #1,(word_FFFFC134).w
	clr.w   (dword_FFFFC12A).w

locret_2832:                ; CODE XREF: sub_2802+26j
	rts
; End of function sub_2802


; =============== S U B R O U T I N E =======================================


sub_2834:               ; CODE XREF: ROM:0000279Aj
	addq.w  #4,(dword_FFFFC12A).w
	move.w  (dword_FFFFC12A).w,d7
	bsr.w   loc_2568
	lsr.w   #2,d7
	move.w  d7,(word_FFFFC11A).w
	move.w  #$100,d0
	sub.w   (dword_FFFFC12A).w,d0
	move.w  d0,(word_FFFFC11C).w
	addi.w  #$10,(word_FFFFC11E).w
	cmpi.w  #$100,(dword_FFFFC12A).w
	bne.s   locret_2868
	addq.w  #1,(word_FFFFC134).w
	clr.w   (dword_FFFFC12A).w

locret_2868:                ; CODE XREF: sub_2834+2Aj
	rts
; End of function sub_2834


; =============== S U B R O U T I N E =======================================


sub_286A:               ; CODE XREF: ROM:0000279Ej
	bsr.w   sub_26BC
	addq.w  #1,(word_FFFFC136).w
	clr.b   (byte_FFFFC10C).w
	rts
; End of function sub_286A


; =============== S U B R O U T I N E =======================================


sub_2878:               ; CODE XREF: ROM:00002716j
	move.w  (word_FFFFC132).w,d0
	lsl.w   #2,d0
	jsr loc_2884(pc,d0.w)
	rts
; End of function sub_2878

; ---------------------------------------------------------------------------

loc_2884:
	bra.w   sub_28D4
; ---------------------------------------------------------------------------
	bra.w   sub_2902
; ---------------------------------------------------------------------------
	bra.w   sub_2916
; ---------------------------------------------------------------------------
	bra.w   sub_2934
; ---------------------------------------------------------------------------
	bra.w   sub_2948
; ---------------------------------------------------------------------------
	bra.w   sub_295C
; ---------------------------------------------------------------------------
	bra.w   sub_2978
; ---------------------------------------------------------------------------
	bra.w   sub_2994

; =============== S U B R O U T I N E =======================================


sub_28A4:               ; CODE XREF: ROM:00002732j
	move.w  (word_FFFFC134).w,d0
	lsl.w   #2,d0
	jsr loc_28B0(pc,d0.w)
	rts
; End of function sub_28A4

; ---------------------------------------------------------------------------

loc_28B0:
	bra.w   sub_299A
; ---------------------------------------------------------------------------
	bra.w   sub_29C6
; ---------------------------------------------------------------------------
	bra.w   sub_29F4
; ---------------------------------------------------------------------------
	bra.w   sub_274A
; ---------------------------------------------------------------------------
	bra.w   sub_2A22
; ---------------------------------------------------------------------------
	bra.w   sub_2A36
; ---------------------------------------------------------------------------
	bra.w   sub_2A4A
; ---------------------------------------------------------------------------
	bra.w   sub_2A66
; ---------------------------------------------------------------------------
	bra.w   sub_2A82

; =============== S U B R O U T I N E =======================================


sub_28D4:               ; CODE XREF: ROM:loc_2884j
	addq.w  #4,(dword_FFFFC122).w
	subq.w  #5,(word_FFFFC10E).w
	addq.w  #2,(word_FFFFC110).w
	move.w  (dword_FFFFC122).w,d7
	bsr.w   loc_2568
	lsr.w   #2,d7
	neg.w   d7
	move.w  d7,(word_FFFFC112).w
	cmpi.w  #$100,(dword_FFFFC122).w
	bne.s   locret_2900
	addq.w  #1,(word_FFFFC132).w
	clr.w   (dword_FFFFC122).w

locret_2900:                ; CODE XREF: sub_28D4+22j
	rts
; End of function sub_28D4


; =============== S U B R O U T I N E =======================================


sub_2902:               ; CODE XREF: ROM:00002888j
	addq.w  #8,(word_FFFFC112).w
	subq.w  #2,(word_FFFFC110).w
	addq.w  #5,(word_FFFFC10E).w
	bne.s   locret_2914
	addq.w  #1,(word_FFFFC132).w

locret_2914:                ; CODE XREF: sub_2902+Cj
	rts
; End of function sub_2902


; =============== S U B R O U T I N E =======================================


sub_2916:               ; CODE XREF: ROM:0000288Cj
	addi.w  #$20,(word_FFFFC116).w ; ' '
	andi.w  #$1FF,(word_FFFFC116).w
	subi.w  #$10,(word_FFFFC112).w
	bne.s   locret_2932
	addq.w  #1,(word_FFFFC132).w
	clr.b   (byte_FFFFC10C).w

locret_2932:                ; CODE XREF: sub_2916+12j
	rts
; End of function sub_2916


; =============== S U B R O U T I N E =======================================


sub_2934:               ; CODE XREF: ROM:00002890j
	addi.w  #$10,(word_FFFFC116).w
	andi.w  #$1FF,(word_FFFFC116).w
	bne.s   locret_2946
	addq.w  #1,(word_FFFFC132).w

locret_2946:                ; CODE XREF: sub_2934+Cj
	rts
; End of function sub_2934


; =============== S U B R O U T I N E =======================================


sub_2948:               ; CODE XREF: ROM:00002894j
	subi.w  #$10,(word_FFFFC116).w
	andi.w  #$1FF,(word_FFFFC116).w
	bne.s   locret_295A
	addq.w  #1,(word_FFFFC132).w

locret_295A:                ; CODE XREF: sub_2948+Cj
	rts
; End of function sub_2948


; =============== S U B R O U T I N E =======================================


sub_295C:               ; CODE XREF: ROM:00002898j
	addq.w  #8,(word_FFFFC114).w
	andi.w  #$1FF,(word_FFFFC114).w
	addq.w  #8,(word_FFFFC116).w
	andi.w  #$1FF,(word_FFFFC116).w
	bne.s   locret_2976
	addq.w  #1,(word_FFFFC132).w

locret_2976:                ; CODE XREF: sub_295C+14j
	rts
; End of function sub_295C


; =============== S U B R O U T I N E =======================================


sub_2978:               ; CODE XREF: ROM:0000289Cj
	subq.w  #8,(word_FFFFC114).w
	andi.w  #$1FF,(word_FFFFC114).w
	subq.w  #8,(word_FFFFC116).w
	andi.w  #$1FF,(word_FFFFC116).w
	bne.s   locret_2992
	addq.w  #1,(word_FFFFC132).w

locret_2992:                ; CODE XREF: sub_2978+14j
	rts
; End of function sub_2978


; =============== S U B R O U T I N E =======================================


sub_2994:               ; CODE XREF: ROM:000028A0j
	bsr.w   sub_2690
	rts
; End of function sub_2994


; =============== S U B R O U T I N E =======================================


sub_299A:               ; CODE XREF: ROM:loc_28B0j
	addq.w  #1,(dword_FFFFC12A).w
	addi.w  #$10,(word_FFFFC11C).w
	addq.w  #8,(word_FFFFC118).w
	addi.w  #$20,(word_FFFFC120).w ; ' '
	andi.w  #$1FF,(word_FFFFC120).w
	cmpi.w  #$200,(word_FFFFC11C).w
	bne.s   locret_29C4
	addq.w  #1,(word_FFFFC134).w
	clr.w   (dword_FFFFC12A).w

locret_29C4:                ; CODE XREF: sub_299A+20j
	rts
; End of function sub_299A


; =============== S U B R O U T I N E =======================================


sub_29C6:               ; CODE XREF: ROM:000028B4j
	addq.w  #8,(dword_FFFFC12A).w
	move.w  (dword_FFFFC12A).w,d7
	lsr.w   #1,d7
	bsr.w   loc_2568
	move.w  d7,(word_FFFFC11C).w
	addi.w  #$200,(word_FFFFC11C).w
	addq.w  #8,(word_FFFFC118).w
	cmpi.w  #$200,(dword_FFFFC12A).w
	bne.s   locret_29F2
	addq.w  #1,(word_FFFFC134).w
	clr.w   (dword_FFFFC12A).w

locret_29F2:                ; CODE XREF: sub_29C6+22j
	rts
; End of function sub_29C6


; =============== S U B R O U T I N E =======================================


sub_29F4:               ; CODE XREF: ROM:000028B8j
	addq.w  #1,(dword_FFFFC12A).w
	subi.w  #$10,(word_FFFFC11C).w
	subi.w  #$18,(word_FFFFC118).w
	addi.w  #$20,(word_FFFFC120).w ; ' '
	andi.w  #$1FF,(word_FFFFC120).w
	tst.w   (word_FFFFC11C).w
	bne.s   locret_2A20
	addq.w  #1,(word_FFFFC134).w
	move.w  #$20,(dword_FFFFC12A).w ; ' '

locret_2A20:                ; CODE XREF: sub_29F4+20j
	rts
; End of function sub_29F4


; =============== S U B R O U T I N E =======================================


sub_2A22:               ; CODE XREF: ROM:000028C0j
	subi.w  #$10,(word_FFFFC120).w
	andi.w  #$1FF,(word_FFFFC120).w
	bne.s   locret_2A34
	addq.w  #1,(word_FFFFC134).w

locret_2A34:                ; CODE XREF: sub_2A22+Cj
	rts
; End of function sub_2A22


; =============== S U B R O U T I N E =======================================


sub_2A36:               ; CODE XREF: ROM:000028C4j
	addi.w  #$10,(word_FFFFC120).w
	andi.w  #$1FF,(word_FFFFC120).w
	bne.s   locret_2A48
	addq.w  #1,(word_FFFFC134).w

locret_2A48:                ; CODE XREF: sub_2A36+Cj
	rts
; End of function sub_2A36


; =============== S U B R O U T I N E =======================================


sub_2A4A:               ; CODE XREF: ROM:000028C8j
	subq.w  #8,(word_FFFFC11E).w
	andi.w  #$1FF,(word_FFFFC11E).w
	subq.w  #8,(word_FFFFC120).w
	andi.w  #$1FF,(word_FFFFC120).w
	bne.s   locret_2A64
	addq.w  #1,(word_FFFFC134).w

locret_2A64:                ; CODE XREF: sub_2A4A+14j
	rts
; End of function sub_2A4A


; =============== S U B R O U T I N E =======================================


sub_2A66:               ; CODE XREF: ROM:000028CCj
	addq.w  #8,(word_FFFFC11E).w
	andi.w  #$1FF,(word_FFFFC11E).w
	addq.w  #8,(word_FFFFC120).w
	andi.w  #$1FF,(word_FFFFC120).w
	bne.s   locret_2A80
	addq.w  #1,(word_FFFFC134).w

locret_2A80:                ; CODE XREF: sub_2A66+14j
	rts
; End of function sub_2A66


; =============== S U B R O U T I N E =======================================


sub_2A82:               ; CODE XREF: ROM:000028D0j
	bsr.w   sub_26BC
	addq.w  #1,(word_FFFFC136).w
	clr.b   (byte_FFFFC10C).w
	rts
; End of function sub_2A82


; =============== S U B R O U T I N E =======================================


sub_2A90:               ; CODE XREF: ROM:0000271Aj
	move.w  (word_FFFFC132).w,d0
	lsl.w   #2,d0
	jsr loc_2A9C(pc,d0.w)
	rts
; End of function sub_2A90

; ---------------------------------------------------------------------------

loc_2A9C:
	bra.w   sub_2AF0
; ---------------------------------------------------------------------------
	bra.w   sub_273E
; ---------------------------------------------------------------------------
	bra.w   sub_2AFC
; ---------------------------------------------------------------------------
	bra.w   sub_2B08
; ---------------------------------------------------------------------------
	bra.w   sub_273E
; ---------------------------------------------------------------------------
	bra.w   sub_2B2C
; ---------------------------------------------------------------------------
	bra.w   sub_273E
; ---------------------------------------------------------------------------
	bra.w   sub_2B56
; ---------------------------------------------------------------------------
	bra.w   sub_2B84
; ---------------------------------------------------------------------------
	bra.w   sub_2BB6
; ---------------------------------------------------------------------------
	bra.w   sub_2BE4

; =============== S U B R O U T I N E =======================================


sub_2AC8:               ; CODE XREF: ROM:00002736j
	move.w (word_FFFFC134).w, d0
	lsl.w  #2, d0
	jsr    loc_2AD4(pc, d0.w)
	rts
; End of function sub_2AC8

; ---------------------------------------------------------------------------

loc_2AD4:
	bra.w   sub_2BEA
; ---------------------------------------------------------------------------
	bra.w   sub_274A
; ---------------------------------------------------------------------------
	bra.w   sub_2C10
; ---------------------------------------------------------------------------
	bra.w   sub_2C1C
; ---------------------------------------------------------------------------
	bra.w   sub_2C36
; ---------------------------------------------------------------------------
	bra.w   sub_274A
; ---------------------------------------------------------------------------
	bra.w   sub_2C52

; =============== S U B R O U T I N E =======================================


sub_2AF0:               ; CODE XREF: ROM:loc_2A9Cj
	move.w #$3F, (dword_FFFFC122).w
	addq.w #1,   (word_FFFFC132).w
	rts
; End of function sub_2AF0


; =============== S U B R O U T I N E =======================================


sub_2AFC:               ; CODE XREF: ROM:00002AA4j
	move.b #2, (byte_FFFFC138).w
	addq.w #1, (word_FFFFC132).w
	rts
; End of function sub_2AFC


; =============== S U B R O U T I N E =======================================


sub_2B08:               ; CODE XREF: ROM:00002AA8j
	addq.w #6, (word_FFFFC112).w

	addi.w #$10,  (word_FFFFC116).w
	andi.w #$1FF, (word_FFFFC116).w

	cmpi.w #$300, (word_FFFFC112).w
	bne.s  @locret_2B2A

	addq.w #1, (word_FFFFC132).w
	move.w #$5E, (dword_FFFFC122).w

@locret_2B2A:
	rts
; End of function sub_2B08


; =============== S U B R O U T I N E =======================================


sub_2B2C:               ; CODE XREF: ROM:00002AB0j
	move.w #0,   (word_FFFFC10E).w
	move.w #0,   (word_FFFFC110).w
	move.w #0,   (word_FFFFC112).w
	move.w #0,   (word_FFFFC114).w
	move.w #0,   (word_FFFFC116).w
	addq.w #1,   (word_FFFFC132).w
	move.w #$10, (dword_FFFFC122).w
	rts
; End of function sub_2B2C


; =============== S U B R O U T I N E =======================================


sub_2B56:               ; CODE XREF: ROM:00002AB8j
	addq.w #8, (dword_FFFFC122).w
	move.w (dword_FFFFC122).w, d7
	bsr.w  loc_2568

	lsr.w  #4, d7
	neg.w  d7
	move.w d7, (word_FFFFC110).w

	subq.w #4, (word_FFFFC10E).w
	subq.w #2, (word_FFFFC112).w

	cmpi.w #$100, (dword_FFFFC122).w
	bne.s  @locret_2B82

	addq.w #1, (word_FFFFC132).w
	clr.w  (dword_FFFFC122).w

@locret_2B82:
	rts
; End of function sub_2B56


; =============== S U B R O U T I N E =======================================


sub_2B84:               ; CODE XREF: ROM:00002ABCj
	addq.w #4, (dword_FFFFC122).w
	move.w (dword_FFFFC122).w, d7
	bsr.w  loc_2568

	move.w d7, d6
	lsr.w  #2, d6
	lsr.w  #1, d7
	add.w  d6, d7
	move.w d7, (word_FFFFC110).w

	addq.w #1, (word_FFFFC10E).w
	addq.w #4, (word_FFFFC112).w

	cmpi.w #$100, (dword_FFFFC122).w
	bne.s  @locret_2BB4

	addq.w #1, (word_FFFFC132).w
	clr.w  (dword_FFFFC122).w

@locret_2BB4:
	rts
; End of function sub_2B84


; =============== S U B R O U T I N E =======================================


sub_2BB6:               ; CODE XREF: ROM:00002AC0j
	addq.w #8, (dword_FFFFC122).w
	move.w (dword_FFFFC122).w, d7
	bsr.w  loc_2568

	lsr.w  #3, d7
	neg.w  d7
	move.w d7, (word_FFFFC110).w
	addq.w #2, (word_FFFFC10E).w
	subq.w #6, (word_FFFFC112).w

	cmpi.w #$100, (dword_FFFFC122).w
	bne.s  @locret_2BE2

	addq.w #1, (word_FFFFC132).w
	clr.w  (dword_FFFFC122).w

@locret_2BE2:
	rts
; End of function sub_2BB6


; =============== S U B R O U T I N E =======================================


sub_2BE4:               ; CODE XREF: ROM:00002AC4j
	bsr.w sub_2690
	rts
; End of function sub_2BE4


; =============== S U B R O U T I N E =======================================


sub_2BEA:               ; CODE XREF: ROM:loc_2AD4j
	addi.w #$10, (word_FFFFC11C).w

	addi.w #$10,  (word_FFFFC120).w
	andi.w #$1FF, (word_FFFFC120).w

	cmpi.w #$400, (word_FFFFC11C).w
	bne.s  @locret_2C0E

	addq.w #1, (word_FFFFC134).w
	move.w #$80, (dword_FFFFC12A).w

@locret_2C0E:
	rts
; End of function sub_2BEA


; =============== S U B R O U T I N E =======================================


sub_2C10:               ; CODE XREF: ROM:00002ADCj
	move.b #1, (byte_FFFFC138).w
	addq.w #1, (word_FFFFC134).w
	rts
; End of function sub_2C10


; =============== S U B R O U T I N E =======================================


sub_2C1C:               ; CODE XREF: ROM:00002AE0j
	subi.w #$10,   (word_FFFFC11C).w
	cmpi.w #$FFA0, (word_FFFFC11C).w
	bne.s  @locret_2C34

	addq.w #1, (word_FFFFC134).w
	move.b #0, (byte_FFFFC138).w

@locret_2C34:
	rts
; End of function sub_2C1C


; =============== S U B R O U T I N E =======================================


sub_2C36:               ; CODE XREF: ROM:00002AE4j
	addi.w #$15, (word_FFFFC120).w

	addq.w #4, (word_FFFFC11C).w
	bne.s  @locret_2C50

	addq.w #1, (word_FFFFC134).w
	clr.w  (word_FFFFC120).w
	move.w #$91, (dword_FFFFC12A).w

@locret_2C50:
	rts
; End of function sub_2C36


; =============== S U B R O U T I N E =======================================


sub_2C52:               ; CODE XREF: ROM:00002AECj
	bsr.w  sub_26BC

	addq.w #1, (word_FFFFC136).w

	clr.b  (byte_FFFFC10C).w
	rts
; End of function sub_2C52


; =============== S U B R O U T I N E =======================================


sub_2C60:               ; CODE XREF: ROM:0000271Ej
	move.w (word_FFFFC132).w, d0
	lsl.w  #2, d0
	jsr    loc_2C6C(pc, d0.w)
	rts
; End of function sub_2C60

; ---------------------------------------------------------------------------

loc_2C6C:
	bra.w   sub_2CC4
; ---------------------------------------------------------------------------
	bra.w   sub_2CDC
; ---------------------------------------------------------------------------
	bra.w   sub_2D20
; ---------------------------------------------------------------------------
	bra.w   sub_2D4C
; ---------------------------------------------------------------------------
	bra.w   sub_2D70
; ---------------------------------------------------------------------------
	bra.w   sub_2D9C
; ---------------------------------------------------------------------------
	bra.w   sub_273E
; ---------------------------------------------------------------------------
	bra.w   sub_2DBA
; ---------------------------------------------------------------------------
	bra.w   sub_273E
; ---------------------------------------------------------------------------
	bra.w   sub_2DF0

; =============== S U B R O U T I N E =======================================


sub_2C94:               ; CODE XREF: ROM:0000273Aj
	move.w (word_FFFFC134).w, d0
	lsl.w  #2, d0
	jsr    loc_2CA0(pc, d0.w)
	rts
; End of function sub_2C94

; ---------------------------------------------------------------------------

loc_2CA0:
	bra.w   sub_2DF6
; ---------------------------------------------------------------------------
	bra.w   sub_2E0E
; ---------------------------------------------------------------------------
	bra.w   sub_2E56
; ---------------------------------------------------------------------------
	bra.w   sub_2E8A
; ---------------------------------------------------------------------------
	bra.w   sub_274A
; ---------------------------------------------------------------------------
	bra.w   sub_2EAC
; ---------------------------------------------------------------------------
	bra.w   sub_2F06
; ---------------------------------------------------------------------------
	bra.w   sub_2F32
; ---------------------------------------------------------------------------
	bra.w   sub_2F4A

; =============== S U B R O U T I N E =======================================


sub_2CC4:               ; CODE XREF: ROM:loc_2C6Cj
	addq.w #8, (word_FFFFC110).w

	addi.w #$18,  (word_FFFFC112).w
	cmpi.w #$180, (word_FFFFC112).w
	bne.s  @locret_2CDA

	addq.w #1, (word_FFFFC132).w

@locret_2CDA:
	rts
; End of function sub_2CC4


; =============== S U B R O U T I N E =======================================


sub_2CDC:               ; CODE XREF: ROM:00002C70j
	addq.w #4, (dword_FFFFC122).w

	addq.w #8,    (word_FFFFC116).w
	andi.w #$1FF, (word_FFFFC116).w

	move.w (dword_FFFFC122).w, d7
	bsr.w  sub_2564

	asr.w  #1, d7
	neg.w  d7
	addi.w #$200, d7
	move.w d7, (word_FFFFC112).w

	move.w (dword_FFFFC122).w, d7
	bsr.w  loc_2568

	neg.w  d7
	asl.w  #1, d7
	move.w d7, (word_FFFFC10E).w

	cmpi.w #$200, (dword_FFFFC122).w
	bne.s  @locret_2D1E

	addq.w #1, (word_FFFFC132).w
	clr.w  (dword_FFFFC122).w

@locret_2D1E:
	rts
; End of function sub_2CDC


; =============== S U B R O U T I N E =======================================


sub_2D20:               ; CODE XREF: ROM:00002C74j
	addq.w #8, (dword_FFFFC122).w
	move.w (dword_FFFFC122).w, d7
	bsr.w  loc_2568

	asr.w  #1, d7
	addi.w #$80, d7
	move.w d7, (word_FFFFC110).w

	subq.w #8,   (word_FFFFC112).w
	cmpi.w #$80, (word_FFFFC112).w
	bne.s  @locret_2D4A

	addq.w #1, (word_FFFFC132).w
	clr.w  (dword_FFFFC122).w

@locret_2D4A:
	rts
; End of function sub_2D20


; =============== S U B R O U T I N E =======================================


sub_2D4C:               ; CODE XREF: ROM:00002C78j
	addi.w #$20,  (word_FFFFC116).w
	andi.w #$1FF, (word_FFFFC116).w

	subq.w #8, (word_FFFFC110).w

	subq.w #8, (word_FFFFC112).w
	bne.s  @locret_2D6E

	addq.w #1, (word_FFFFC132).w
	clr.b  (byte_FFFFC10C).w
	clr.w  (dword_FFFFC122).w

@locret_2D6E:
	rts
; End of function sub_2D4C


; =============== S U B R O U T I N E =======================================


sub_2D70:               ; CODE XREF: ROM:00002C7Cj
	addq.w #2, (dword_FFFFC122).w
	move.w (dword_FFFFC122).w, d7
	bsr.w  loc_2568

	asr.w  #1, d7
	move.w d7, (word_FFFFC110).w
	addq.w #4, (word_FFFFC10E).w
	addq.w #2, (word_FFFFC112).w

	cmpi.w #$80, (dword_FFFFC122).w
	bne.s  @locret_2D9A

	addq.w #1, (word_FFFFC132).w
	clr.w  (dword_FFFFC122).w

@locret_2D9A:
	rts
; End of function sub_2D70


; =============== S U B R O U T I N E =======================================


sub_2D9C:               ; CODE XREF: ROM:00002C80j
	subq.w #4, (word_FFFFC110).w

	subi.w #$10, (word_FFFFC10E).w
	bne.s  @locret_2DB8

	addq.w #1, (word_FFFFC132).w

	move.w #$10, (dword_FFFFC122).w
	move.w #$40, (dword_FFFFC122+2).w

@locret_2DB8:
	rts
; End of function sub_2D9C


; =============== S U B R O U T I N E =======================================


sub_2DBA:               ; CODE XREF: ROM:00002C88j
	addq.w #8, (dword_FFFFC122).w
	move.w (dword_FFFFC122).w, d7
	bsr.w  loc_2568

	asr.w  #1, d7

	subq.w #2, (dword_FFFFC122+2).w
	add.w  (dword_FFFFC122+2).w, d7

	move.w d7, (word_FFFFC110).w
	subq.w #4, (word_FFFFC112).w

	cmpi.w #$100, (dword_FFFFC122).w
	bne.s  @locret_2DEE

	addq.w #1, (word_FFFFC132).w
	move.w #$40, (dword_FFFFC122).w
	clr.w  (dword_FFFFC122+2).w

@locret_2DEE:
	rts
; End of function sub_2DBA


; =============== S U B R O U T I N E =======================================


sub_2DF0:               ; CODE XREF: ROM:00002C90j
	bsr.w sub_2690
	rts
; End of function sub_2DF0


; =============== S U B R O U T I N E =======================================


sub_2DF6:               ; CODE XREF: ROM:loc_2CA0j
	addq.w #8, (word_FFFFC11A).w

	addi.w #$18,  (word_FFFFC11C).w
	cmpi.w #$180, (word_FFFFC11C).w
	bne.s  @locret_2E0C

	addq.w #1, (word_FFFFC134).w

@locret_2E0C:
	rts
; End of function sub_2DF6


; =============== S U B R O U T I N E =======================================


sub_2E0E:               ; CODE XREF: ROM:00002CA4j
	addq.w  #4, (dword_FFFFC12A).w

	subq.w  #8, (word_FFFFC120).w
	andi.w  #$1FF, (word_FFFFC120).w

	move.w  (dword_FFFFC12A).w, d7
	bsr.w   sub_2564

	asr.w   #1, d7
	neg.w   d7
	addi.w  #$200, d7
	move.w  d7, (word_FFFFC11C).w

	move.w  (dword_FFFFC12A).w, d7
	bsr.w   loc_2568

	asl.w   #1, d7
	move.w  d7, (word_FFFFC118).w

	cmpi.w  #$200, (dword_FFFFC12A).w
	bne.s   @locret_2E54

	addq.w  #1, (word_FFFFC134).w
	clr.w   (dword_FFFFC12A).w
	move.w  #$180, (word_FFFFC11C).w

@locret_2E54:
	rts
; End of function sub_2E0E


; =============== S U B R O U T I N E =======================================


sub_2E56:               ; CODE XREF: ROM:00002CA8j
	addq.w #8, (dword_FFFFC12A).w
	move.w (dword_FFFFC12A).w, d7
	bsr.w  loc_2568

	asr.w  #1, d7
	neg.w  d7
	addi.w #$80, d7
	move.w d7, (word_FFFFC11A).w
	subq.w #8, (word_FFFFC11C).w

	cmpi.w #$100, (dword_FFFFC12A).w
	bne.s  @locret_2E88

	addq.w #1, (word_FFFFC134).w
	clr.w  (dword_FFFFC12A).w
	move.w #$80, (word_FFFFC11C).w

@locret_2E88:
	rts
; End of function sub_2E56


; =============== S U B R O U T I N E =======================================


sub_2E8A:               ; CODE XREF: ROM:00002CACj
	subi.w #$20,  (word_FFFFC120).w
	andi.w #$1FF, (word_FFFFC120).w

	subq.w #8, (word_FFFFC11A).w
	subq.w #8, (word_FFFFC11C).w
	bne.s  @locret_2EAA

	addq.w #1,   (word_FFFFC134).w
	move.w #$20, (dword_FFFFC12A).w

@locret_2EAA:
	rts
; End of function sub_2E8A


; =============== S U B R O U T I N E =======================================


sub_2EAC:               ; CODE XREF: ROM:00002CB4j
	addq.w #8, (dword_FFFFC12A).w

	addq.w #8, (word_FFFFC120).w
	andi.w #$1FF, (word_FFFFC120).w

	addq.w #8, (word_FFFFC11E).w
	andi.w #$1FF, (word_FFFFC11E).w

	move.w (dword_FFFFC12A).w, d7
	bsr.w  loc_2568

	asr.w  #2, d7
	neg.w  d7
	move.w d7, (word_FFFFC11A).w

	move.w (dword_FFFFC12A).w, d7
	bsr.w  sub_2564

	asr.w  #2, d7
	subi.w #$40, d7
	move.w d7, (word_FFFFC118).w

	move.w (dword_FFFFC12A).w, d7
	bsr.w  loc_2568

	asr.w  #3, d7
	move.w d7, (word_FFFFC11C).w

	cmpi.w #$200, (dword_FFFFC12A).w
	bne.s  @locret_2F04

	addq.w #1, (word_FFFFC134).w
	clr.w  (dword_FFFFC12A).w

@locret_2F04:
	rts
; End of function sub_2EAC


; =============== S U B R O U T I N E =======================================


sub_2F06:               ; CODE XREF: ROM:00002CB8j
	addq.w #8, (dword_FFFFC12A).w

	move.w (dword_FFFFC12A).w, d7
	bsr.w  loc_2568

	asr.w  #1, d7
	neg.w  d7
	move.w d7, (word_FFFFC11A).w

	addi.w #$10, (word_FFFFC11C).w

	cmpi.w #$100, (dword_FFFFC12A).w
	bne.s  @locret_2F30

	addq.w #1, (word_FFFFC134).w

	clr.w  (dword_FFFFC12A).w

@locret_2F30:
	rts
; End of function sub_2F06


; =============== S U B R O U T I N E =======================================


sub_2F32:               ; CODE XREF: ROM:00002CBCj
	addi.w #$20,  (word_FFFFC120).w
	andi.w #$1FF, (word_FFFFC120).w

	subq.w #8, (word_FFFFC11C).w
	bne.s  @locret_2F48

	addq.w #1, (word_FFFFC134).w

@locret_2F48:
	rts
; End of function sub_2F32


; =============== S U B R O U T I N E =======================================


sub_2F4A:               ; CODE XREF: ROM:00002CC0j
	bsr.w sub_26BC

	clr.w (word_FFFFC136).w
	clr.b (byte_FFFFC10C).w
	rts
; End of function sub_2F4A


; =============== S U B R O U T I N E =======================================


rotatePalette0:               ; CODE XREF: sub_2424+50p
	move.w (dword_FFFFC106+2).w, d0
	lsl.w  #1, d0

	lea    palette_2F8C(pc), a0
	adda.w d0, a0

	lea (paletteBuffer0+COLOR1).w, a1

	moveq #7, d7
	@loc_2F6A:
		move.w (a0)+, (a1)+
		dbf d7, @loc_2F6A

	clr.w  (dword_FFFFC106).w

	addq.w #1, (dword_FFFFC106+2).w
	cmpi.w #8, (dword_FFFFC106+2).w
	bne.s  @loc_2F84

	clr.w (dword_FFFFC106+2).w

@loc_2F84:
	; Signal palette update
	bset #0, (vdpUpdateFlags).w
	rts
; End of function rotatePalette0

; ---------------------------------------------------------------------------
palette_2F8C:
	dc.w $0EE
	dc.w $0AE
	dc.w $06E
	dc.w $00E
	dc.w $E0C
	dc.w $E60
	dc.w $CE0
	dc.w $0E0
	dc.w $0EE
	dc.w $0AE
	dc.w $06E
	dc.w $00E
	dc.w $E0C
	dc.w $E60
	dc.w $CE0
	dc.w $0E0

; =============== S U B R O U T I N E =======================================


rotatePalette2:               ; CODE XREF: sub_2424:loc_2470p
	lea (paletteBuffer2+COLOR3).w, a0

	addq.w #1,  (palette2Rotation).w
	cmpi.w #16, (palette2Rotation).w
	bne.s  @loc_2FC0

	clr.w (palette2Rotation).w

@loc_2FC0:
	move.w (palette2Rotation).w, d0
	lsr.w  #1, d0
	lsl.w  #1, d0

	move.w palette_2FE0(pc, d0.w),  (a0)
	move.w palette_3000(pc, d0.w), 2(a0)
	move.w palette_3020(pc, d0.w), 4(a0)

	; Signal a palette update
	bset #0, (vdpUpdateFlags).w
	rts
; End of function rotatePalette2

; ---------------------------------------------------------------------------
palette_2FE0:
	dc.w $ACC
	dc.w $8AA
	dc.w $688
	dc.w $466
	dc.w $244
	dc.w $466
	dc.w $688
	dc.w $8AA
	dc.w $ACC
	dc.w $8AA
	dc.w $688
	dc.w $466
	dc.w $244
	dc.w $466
	dc.w $688
	dc.w $8AA

palette_3000:
	dc.w $688
	dc.w $466
	dc.w $244
	dc.w $466
	dc.w $688
	dc.w $8AA
	dc.w $ACC
	dc.w $8AA
	dc.w $688
	dc.w $466
	dc.w $244
	dc.w $466
	dc.w $688
	dc.w $8AA
	dc.w $ACC
	dc.w $8AA

palette_3020:
	dc.w $466
	dc.w $244
	dc.w $466
	dc.w $688
	dc.w $8AA
	dc.w $ACC
	dc.w $8AA
	dc.w $688
	dc.w $466
	dc.w $244
	dc.w $466
	dc.w $688
	dc.w $8AA
	dc.w $ACC
	dc.w $8AA
	dc.w $688
