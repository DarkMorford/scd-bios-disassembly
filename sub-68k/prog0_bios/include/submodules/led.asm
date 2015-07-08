;   ======================================================================
;       LED control subroutines
;   ======================================================================

; =============== S U B R O U T I N E =======================================


initLeds:               ; CODE XREF: BIOS:0000034Ap
	move.w  #LEDSYSTEM,userLedMode(a5)
	move.w  #LEDERROR,lastLedMode(a5)
	move.w  #LEDREADY,ledMode(a5)
	rts
; End of function initLeds


; =============== S U B R O U T I N E =======================================


updateLeds:             ; CODE XREF: BIOS:0000062Ap
		move.w  userLedMode(a5),d0
		cmpi.w  #LEDSYSTEM,d0
		beq.s   @loc_684
		move.w  d0,ledMode(a5)

@loc_684:
		move.w  ledMode(a5),d0
		cmp.w   lastLedMode(a5),d0
		beq.s   @loc_6A2
		move.w  d0,lastLedMode(a5)
		bclr    #7,ledBitfield(a5)
		clr.w   greenBlinkTimer(a5)
		clr.b   ledStatus(a5)
		bra.s   @loc_6AA
; ---------------------------------------------------------------------------

@loc_6A2:
		btst    #7,ledBitfield(a5)
		beq.s   @locret_6BA

@loc_6AA:
		andi.w  #7,d0
		add.w   d0,d0
		jsr ledJumpTable(pc,d0.w)
		move.b  ledStatus(a5),(GA_LED_STATUS).w

@locret_6BA:
		rts
; End of function updateLeds

; ---------------------------------------------------------------------------

ledJumpTable:
	bra.s   _ledready
; ---------------------------------------------------------------------------
	bra.s   _leddiscin
; ---------------------------------------------------------------------------
	bra.s   _ledaccess
; ---------------------------------------------------------------------------
	bra.s   _ledstandby
; ---------------------------------------------------------------------------
	bra.s   _lederror
; ---------------------------------------------------------------------------
	bra.s   _ledmode5
; ---------------------------------------------------------------------------
	bra.s   _ledmode6
; ---------------------------------------------------------------------------
	bra.s   _ledmode7
; ---------------------------------------------------------------------------

_leddiscin:             ; CODE XREF: BIOS:000006BEj
		bset    #GA_LEDG,ledStatus(a5)
		bclr    #GA_LEDR,ledStatus(a5)
		rts
; ---------------------------------------------------------------------------

_ledmode7:              ; CODE XREF: BIOS:000006CAj
		bclr    #GA_LEDG,ledStatus(a5)
		bra.s   loc_6E8
; ---------------------------------------------------------------------------

_ledaccess:             ; CODE XREF: BIOS:000006C0j
		bset    #GA_LEDG,ledStatus(a5)

loc_6E8:                ; CODE XREF: BIOS:000006E0j
		bset    #GA_LEDR,ledStatus(a5)
		rts
; ---------------------------------------------------------------------------

_lederror:              ; CODE XREF: BIOS:000006C4j
		bsr.s   sub_71A
		bra.s   loc_702
; ---------------------------------------------------------------------------

_ledmode6:              ; CODE XREF: BIOS:000006C8j
		bclr    #GA_LEDG,ledStatus(a5)
		bra.s   loc_702
; ---------------------------------------------------------------------------

_ledready:              ; CODE XREF: BIOS:ledJumpTablej
		bset    #GA_LEDG,ledStatus(a5)

loc_702:                ; CODE XREF: BIOS:000006F2j
					; BIOS:000006FAj
		lea redBlinkTimer(a5),a0
		move.b  #0,d0
		bra.s   loc_722
; ---------------------------------------------------------------------------

_ledstandby:                ; CODE XREF: BIOS:000006C2j
		bclr    #GA_LEDR,ledStatus(a5)
		bra.s   sub_71A
; ---------------------------------------------------------------------------

_ledmode5:              ; CODE XREF: BIOS:000006C6j
		bset    #GA_LEDR,ledStatus(a5)

; =============== S U B R O U T I N E =======================================


sub_71A:                ; CODE XREF: BIOS:_lederrorp
					; BIOS:00000712j
		lea greenBlinkTimer(a5),a0
		move.b  #1,d0

loc_722:                ; CODE XREF: BIOS:0000070Aj
		bset    #7,ledBitfield(a5)
		subq.b  #1,(a0)
		bcc.s   @locret_73A
		move.b  #$C,(a0)
		bchg    d0,ledStatus(a5)
		bne.s   @locret_73A
		addi.b  #$C,(a0)

@locret_73A:
		rts
; End of function sub_71A
