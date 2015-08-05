;   ======================================================================
;       Inter-CPU communication subroutines
;   ======================================================================

; =============== S U B R O U T I N E =======================================


clearCommRegisters:         ; CODE XREF: ROM:00000340j finishHardwareInit+14p ...
	moveq #0, d0

	lea (GA_COMM_MAINFLAGS).l, a6
	move.b d0, (a6)
	addq.w #2, a6
	move.l d0, (a6)+
	move.l d0, (a6)+
	move.l d0, (a6)+
	move.l d0, (a6)+

	lea (mainCommFlagBuffer).w, a6
	move.w d0, (a6)+
	move.l d0, (a6)+
	move.l d0, (a6)+
	move.l d0, (a6)+
	move.l d0, (a6)+

	rts
; End of function clearCommRegisters


; =============== S U B R O U T I N E =======================================


sub_15E2:
	; Wait for sub-CPU to set flag 0
	btst  #GA_SUBBUSY, (GA_COMM_SUBFLAGS).l
	beq.s sub_15E2
	rts
; End of function sub_15E2


; =============== S U B R O U T I N E =======================================


sub_15EE:               ; CODE XREF: ROM:00000344j
					; vblankHandler+4p ...
	lea (GA_COMM_MAINFLAGS).l, a4
	bset #GA_MAINBUSY, (a4)

	lea (mainCommFlagBuffer).w, a6
	bclr #GA_MAINACK, (a6)

	; Return if sub-CPU is in RESET
	lea (GA_RESET_HALT).l, a5
	btst  #GA_SRES, (a5)
	beq.s @locret_1656

	; Return if we're holding the sub-CPU bus
	btst  #GA_SBRQ, (a5)
	bne.s @locret_1656

	addq.w #1, a4
	btst   #GA_SUBBUSY, (a4)
	beq.s  @loc_1648

	bset  #GA_MAINACK, (a6)
	bchg  #GA_MAINBUSY, (a6)+
	beq.s @loc_162C

	; Wait for sub-CPU to clear flag 1
	@loc_1624:
		btst  #GA_SUBACK, (a4)
		bne.s @loc_1624

	bra.s   @loc_1632
; ---------------------------------------------------------------------------

	; Wait for sub-CPU to set bit 1
	@loc_162C:
		btst  #GA_SUBACK, (a4)
		beq.s @loc_162C

@loc_1632:
	; Copy sub comm flags from registers to cache
	move.b (a4), (a6)+
	addq.w #1, a4

	; Copy main comm data from buffer to registers
	moveq #3, d0
	@loc_1638:
		move.l (a6), (a4)+
		clr.l  (a6)+
		dbf d0, @loc_1638

	; Copy sub comm data from registers to cache
	move.l (a4)+, (a6)+
	move.l (a4)+, (a6)+
	move.l (a4)+, (a6)+
	move.l (a4)+, (a6)+

@loc_1648:
	; Send INT2 to sub-CPU
	bset #GA_IFL2, -1(a5)

	bset #GA_MAINACK, (GA_COMM_MAINFLAGS).l

@locret_1656:
	rts
; End of function sub_15EE


; =============== S U B R O U T I N E =======================================


sub_1658:               ; CODE XREF: ROM:00000348j
					; vblankHandler+2Ep
	bclr #GA_MAINACK, (GA_COMM_MAINFLAGS).l

	lea (mainCommFlagBuffer).w, a4

	btst  #GA_MAINACK, (a4)
	beq.s @locret_16C2

	btst  #GA_SUBRAMREQ, 1(a4)
	beq.s @locret_16C2

	bset #GA_MAINRAMREQ, (a4)

	lea  (subCommDataCache+4).w, a0

	move.w (a0)+, d0
	move.w d0, (cdBiosStatus).w

	andi.w #$A000, d0
	bne.s  @locret_16C2

	move.b 5(a0), (unk_FFFFFE57).w

	btst  #GA_SUBSYNC, 1(a4)
	beq.s @loc_16B0

	btst  #GA_MAINFLAG5, (a4)
	beq.s @locret_16C2

	move.w (a0)+, (unk_FFFFFE3C).w

	addq.w #4, a0
	move.w (a0)+, (unk_FFFFFE3E).w

	move.b (a0)+, d0
	move.b d0, (byte_FFFFFE43).w

	bset #GA_MAINFLAG6, (a4)
	rts
; ---------------------------------------------------------------------------

@loc_16B0:
	move.w (a0)+, (word_FFFFFE44).w

	addq.w #4, a0
	move.w (a0)+, (word_FFFFFE40).w

	move.b (a0)+, (byte_FFFFFE42).w

	bset #GA_MAINFLAG5, (a4)

@locret_16C2:
	rts
; End of function sub_1658


; =============== S U B R O U T I N E =======================================


sub_16C4:               ; CODE XREF: ROM:000006B6p sub_1730+Cp ...
	bclr #GA_MAINFLAG6, (mainCommFlagBuffer).w
	bclr #GA_MAINFLAG5, (mainCommFlagBuffer).w
	rts
; End of function sub_16C4


; =============== S U B R O U T I N E =======================================


; Corresponds to sub_61CA on sub CPU
sub_16D2:               ; CODE XREF: ROM:0000034Cj sub_16D2+8j ...
	; Wait for sub-CPU to set flag 6
	btst  #GA_SUBFLAG6, (GA_COMM_SUBFLAGS).l
	beq.s sub_16D2

	bclr  #GA_MAINRAMREQ, (GA_COMM_MAINFLAGS).l
	rts
; End of function sub_16D2


; =============== S U B R O U T I N E =======================================


sub_16E6:               ; CODE XREF: loadPrgFromWordRam+24p
	bclr #0, (byte_FFFFFDDD).w
	bset #GA_MAINFLAG7, (GA_COMM_MAINFLAGS).l

	; Give Word RAM to sub-CPU
	bset #GA_DMNA, (GA_MEM_MODE).l
	rts
; End of function sub_16E6


; =============== S U B R O U T I N E =======================================


sub_16FE:               ; CODE XREF: loadPrgFromWordRam+30p
	btst  #0, (byte_FFFFFDDD).w
	beq.s @loc_171A

	btst  #GA_SUBFLAG7, (GA_COMM_SUBFLAGS).l
	bne.s @loc_172A

	bclr  #0, (byte_FFFFFDDD).w
	or.w  d0, d0
	rts
; ---------------------------------------------------------------------------

@loc_171A:
	btst  #GA_SUBFLAG7, (GA_COMM_SUBFLAGS).l
	beq.s @loc_172A

	bset  #0, (byte_FFFFFDDD).w

@loc_172A:
	ori #1, ccr
	rts
; End of function sub_16FE


; =============== S U B R O U T I N E =======================================


sub_1730:               ; CODE XREF: ROM:00000378j
					; DATA XREF: sub_4400+4o ...
	cmpi.w #0, d0
	beq.s  @loc_1742

	cmpi.w #$12, d0
	bne.s  @loc_1748

	bsr.w  sub_16C4
	bra.s  @loc_1748
; ---------------------------------------------------------------------------

@loc_1742:
	moveq  #$FFFFFFFF, d1
	bsr.w  setDiscType

@loc_1748:
	moveq  #0, d3
	move.b byte_178C(pc, d0.w), d3
	move.b byte_178D(pc, d0.w), d0
	bmi.s  @loc_1778
	bne.s  @loc_175C

	move.w d3, (mainCommDataBuffer).w
	rts
; ---------------------------------------------------------------------------

@loc_175C:
	cmpi.b #1, d0
	beq.s  @loc_1782

	move.w d2,  d0
	andi.l #$F, d0
	swap   d0

	lsr.l  #4, d0
	or.w   d0, d1

	andi.w #$FF0, d2
	lsl.w  #4, d2
	or.w   d2, d3

@loc_1778:
	swap   d3
	move.w d1, d3
	move.l d3, (mainCommDataBuffer).w
	rts
; ---------------------------------------------------------------------------

@loc_1782:
	move.b d3, d1
	swap   d1
	move.l d1, (mainCommDataBuffer).w
	rts
; End of function sub_1730

; ---------------------------------------------------------------------------
byte_178C:
	dc.b $A
byte_178D:
	dc.b 0
	dc.b 2
	dc.b 0
	dc.b 3
	dc.b 0
	dc.b 4
	dc.b 0
	dc.b 5
	dc.b 0
	dc.b 6
	dc.b 0
	dc.b 7
	dc.b 0
	dc.b 8
	dc.b 0
	dc.b 9
	dc.b 0
	dc.b $10
	dc.b $FF
	dc.b $11
	dc.b $FF
	dc.b $12
	dc.b $FF
	dc.b $13
	dc.b $FF
	dc.b $14
	dc.b 1
	dc.b $15
	dc.b $FF
	dc.b $16
	dc.b 1
	dc.b $17
	dc.b 1
	dc.b $18
	dc.b 1
	dc.b $20
	dc.b $FF
	dc.b $21
	dc.b $FF
	dc.b $80
	dc.b 0
	dc.b $81
	dc.b 0
	dc.b $82
	dc.b $FF
	dc.b $83
	dc.b $FF
	dc.b $85
	dc.b 2
	dc.b $86
	dc.b 2
	dc.b $87
	dc.b 0
	dc.b $89
	dc.b 0
	dc.b $8A
	dc.b 0
	dc.b $8B
	dc.b 0
	dc.b $8C
	dc.b $FF
	dc.b $8D
	dc.b 0
	dc.b $8F
	dc.b 0
	dc.b $90
	dc.b 0
	dc.b $91
	dc.b 0
	dc.b $92
	dc.b $FF
	dc.b $93
	dc.b $FF
	dc.b 0
	dc.b $FF
	dc.b $C0
	dc.b $FF
	dc.b $C1
	dc.b $FF
	dc.b $19
	dc.b $FF
	dc.b $C2
	dc.b $FF
	dc.b $C3
	dc.b $FF

; =============== S U B R O U T I N E =======================================


sub_17E2:               ; CODE XREF: ROM:00000350j
	move.w d0, (mainCommDataBuffer).w
	move.w d1, (mainCommDataBuffer+2).w
	rts
; End of function sub_17E2


; =============== S U B R O U T I N E =======================================


sub_17EC:               ; CODE XREF: ROM:00000354j
	move.w d0, (mainCommDataBuffer+8).w
	move.w d1, (mainCommDataBuffer+$A).w
	rts
; End of function sub_17EC


; =============== S U B R O U T I N E =======================================


sub_17F6:               ; CODE XREF: ROM:00000358j
	move.w d0, (mainCommDataBuffer+$C).w
	move.w d1, (mainCommDataBuffer+$E).w
	rts
; End of function sub_17F6


; =============== S U B R O U T I N E =======================================


sub_1800:               ; CODE XREF: ROM:0000035Cj
					; ROM:000005BCp ...
	cmpi.w #1, d0
	bne.s  @loc_180E

	bset #GA_MAINRAMREQ, (GA_COMM_MAINFLAGS).l

@loc_180E:
	move.w d0, (mainCommDataBuffer+4).w
	move.w d1, (mainCommDataBuffer+6).w
	rts
; End of function sub_1800


; =============== S U B R O U T I N E =======================================


checkDiscReady:               ; CODE XREF: vblankHandler+32p
					; sub_2424p
	btst  #GA_MAINACK, (mainCommFlagBuffer).w
	beq.s @locret_1830

	move.w (subCommDataCache).w,   d0
	move.w (subCommDataCache+2).w, d1
	andi.w #$FC, d0
	jmp    loc_1832(pc, d0.w)
; ---------------------------------------------------------------------------

@locret_1830:                ; CODE XREF: checkDiscReady+6j
	rts
; End of function checkDiscReady

; ---------------------------------------------------------------------------

loc_1832:
	nop
	rts
; ---------------------------------------------------------------------------
	bra.w setDiscType

; =============== S U B R O U T I N E =======================================


setDiscType:               ; CODE XREF: ROM:00000542p
					; sub_1730+14p ...
	move.b d1, (insertedDiscType).w
	rts
; End of function setDiscType


; =============== S U B R O U T I N E =======================================


getDiscType:               ; CODE XREF: sub_21F4:loc_2264p
					; sub_329A+30p ...
	move.b (insertedDiscType).w, d0
	rts
; End of function getDiscType


; =============== S U B R O U T I N E =======================================


checkDiscBootable:               ; CODE XREF: sub_21F4+E8p
					; sub_21F4:loc_2306p ...
	cmpi.b #CD_GAMESYSTEM, (insertedDiscType).w
	beq.s  @locret_1854

	cmpi.b #CD_GAMEBOOT, (insertedDiscType).w

@locret_1854:
	rts
; End of function checkDiscBootable


; =============== S U B R O U T I N E =======================================


checkDiscTrayClosed:               ; CODE XREF: sub_21F4+5Ep sub_329A+F8p ...
	cmpi.b #$40, (cdBiosStatus).w
	beq.s  @loc_1862

	tst.w d0
	rts
; ---------------------------------------------------------------------------

@loc_1862:
	ori #1, ccr
	rts
; End of function checkDiscTrayClosed
