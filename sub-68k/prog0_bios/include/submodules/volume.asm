;   ======================================================================
;       Volume control subroutines
;   ======================================================================

; =============== S U B R O U T I N E =======================================


initVolume:             ; CODE XREF: BIOS:00000356p
	; Clear memory from $5AB6-$5AC7
	lea volumeBitfield(a5),a0
	moveq #0, d0
	moveq #3, d1
	@clearMemory:
		move.l d0, (a0)+
		dbf d1, @clearMemory
	move.w d0, (a0)

	; Set master volume to maximum
	move.w #$400, masterVolume(a5)

	; Set flag to update volume
	bset #7, volumeBitfield(a5)
	rts
; End of function initVolume


; =============== S U B R O U T I N E =======================================


_fdrset:                ; CODE XREF: sub_2946+22j initCdd+2Cp
	; Clear volume update flag
	bclr    #7,volumeBitfield(a5)

	; Check if parameter is master/system volume
	bclr    #$F,d1
	beq.s   @loc_277C

	; Update master volume
	move.w  masterVolume(a5),d0
	move.w  d1,masterVolume(a5)
	move.w  systemVolume(a5),d1
	lsr.w   #4,d1
	mulu.w  #$400,d1
	divu.w  d0,d1

@loc_277C:
	; Update system volume
	mulu.w  masterVolume(a5),d1
	divu.w  #$400,d1
	bclr    #2,volumeBitfield(a5)
	bclr    #1,volumeBitfield(a5)
	swap    d1
	move.w  systemVolume(a5),d1
	move.w  d1,word_5AC2(a5)
	move.w  d1,word_5AC0(a5)
	ror.w   #4,d1
	lsl.l   #4,d1
	swap    d1
	move.w  d1,systemVolume(a5)

	; Set volume update flag
	bset    #7,volumeBitfield(a5)
	rts
; End of function _fdrset


; =============== S U B R O U T I N E =======================================


sub_27B0:
	bset    #2,volumeBitfield(a5)
	rts
; End of function sub_27B0


; =============== S U B R O U T I N E =======================================


sub_27B8:
	btst    #3,volumeBitfield(a5)
	bne.s   @locret_27C6
	bset    #2,volumeBitfield(a5)

@locret_27C6:                ; CODE XREF: sub_27B8+6j
	rts
; End of function sub_27B8


; =============== S U B R O U T I N E =======================================


sub_27C8:
	btst    #3,volumeBitfield(a5)
	beq.s   @locret_27D6
	bset    #2,volumeBitfield(a5)

@locret_27D6:                ; CODE XREF: sub_27C8+6j
	rts
; End of function sub_27C8


; =============== S U B R O U T I N E =======================================


sub_27D8:               ; CODE XREF: BIOS:00001172p
	move.b  #2,d0
	bset    d0,systemVolume+1(a5)
	bset    d0,word_5AC0+1(a5)
	bset    d0,word_5AC2+1(a5)
	bset    d0,word_5ABE+1(a5)
	rts
; End of function sub_27D8


; =============== S U B R O U T I N E =======================================


sub_27EE:               ; CODE XREF: BIOS:loc_1178p
	move.b  #2,d0
	bclr    d0,systemVolume+1(a5)
	bclr    d0,word_5AC0+1(a5)
	bclr    d0,word_5AC2+1(a5)
	bclr    d0,word_5ABE+1(a5)
	rts
; End of function sub_27EE


; =============== S U B R O U T I N E =======================================


_fdrchg:                ; CODE XREF: sub_2946+26j
	bclr    #1,volumeBitfield(a5)
	move.w  d1,volumeSlope(a5)
	swap    d1
	mulu.w  masterVolume(a5),d1
	divu.w  #$400,d1
	swap    d1
	move.w  systemVolume(a5),d1
	ror.w   #4,d1
	lsl.l   #4,d1
	move.w  d1,d0
	swap    d1
	move.w  d1,word_5AC2(a5)
	lsr.w   #4,d1
	lsr.w   #4,d0
	sub.w   d1,d0
	bcc.s   @loc_2836
	neg.w   volumeSlope(a5)

@loc_2836:               ; CODE XREF: _fdrchg+2Cj
	move.w  d0,word_5AC4(a5)
	bset    #1,volumeBitfield(a5)
	rts
; End of function _fdrchg


; =============== S U B R O U T I N E =======================================


sub_2842:
	move.l  masterVolume(a5),d0
	lsr.w   #4,d0
	move.b  volumeBitfield(a5),d1
	lsr.b   #2,d1
	rts
; End of function sub_2842


; =============== S U B R O U T I N E =======================================


updateVolume:               ; CODE XREF: BIOS:00000626p
	bset    #0,volumeBitfield(a5)
	bne.s   @locret_28B2
	btst    #7,volumeBitfield(a5)
	beq.s   @loc_28AC
	move.w  (GA_CDD_FADER).w,d0
	btst    #$F,d0
	bne.s   @loc_28AC
	btst    #6,volumeBitfield(a5)
	beq.s   @loc_287E
	bclr    #2,volumeBitfield(a5)
	beq.s   @loc_289A
	bsr.s   sub_28B4
	bra.s   @loc_289A
; ---------------------------------------------------------------------------

@loc_287E:               ; CODE XREF: updateVolume+20j
	bclr    #2,volumeBitfield(a5)
	beq.s   @loc_2888
	bsr.s   sub_28CC

@loc_2888:               ; CODE XREF: updateVolume+34j
	btst    #3,volumeBitfield(a5)
	bne.s   @loc_289A
	btst    #1,volumeBitfield(a5)
	beq.s   @loc_289A
	bsr.s   sub_28EA

@loc_289A:               ; CODE XREF: updateVolume+28j
					; updateVolume+2Cj ...
	move.w  systemVolume(a5),d0
	cmp.w   word_5ABC(a5),d0
	beq.s   @loc_28AC
	move.w  d0,word_5ABC(a5)
	move.w  d0,(GA_CDD_FADER).w

@loc_28AC:               ; CODE XREF: updateVolume+Ej
					; updateVolume+18j ...
	bclr    #0,volumeBitfield(a5)

@locret_28B2:                ; CODE XREF: updateVolume+6j
	rts
; End of function updateVolume


; =============== S U B R O U T I N E =======================================


sub_28B4:               ; CODE XREF: updateVolume+2Ap
	bchg    #3,volumeBitfield(a5)
	bne.s   @loc_28C4
	move.w  word_5ABE(a5),word_5AC0(a5)
	rts
; ---------------------------------------------------------------------------

@loc_28C4:               ; CODE XREF: sub_28B4+6j
	move.w  word_5AC0(a5),word_5ABE(a5)
	rts
; End of function sub_28B4


; =============== S U B R O U T I N E =======================================


sub_28CC:               ; CODE XREF: updateVolume+36p
	bchg    #3,volumeBitfield(a5)
	bne.s   @loc_28E2
	move.w  systemVolume(a5),word_5AC0(a5)
	andi.w  #$F,systemVolume(a5)
	rts
; ---------------------------------------------------------------------------

@loc_28E2:               ; CODE XREF: sub_28CC+6j
	move.w  word_5AC0(a5),systemVolume(a5)
	rts
; End of function sub_28CC


; =============== S U B R O U T I N E =======================================


sub_28EA:               ; CODE XREF: updateVolume+48p
	move.w  word_5AC4(a5),d0
	bmi.s   @loc_2904
	sub.w   volumeSlope(a5),d0
	bcs.s   @loc_290A

@loc_28F6:               ; CODE XREF: sub_28EA+1Ej
	moveq   #0,d1
	move.w  word_5AC2(a5),d1
	ror.l   #4,d1
	add.w   d0,d1
	rol.l   #4,d1
	bra.s   @loc_291A
; ---------------------------------------------------------------------------

@loc_2904:               ; CODE XREF: sub_28EA+4j
	sub.w   volumeSlope(a5),d0
	bcs.s   @loc_28F6

@loc_290A:               ; CODE XREF: sub_28EA+Aj
	move.w  word_5AC2(a5),d1
	moveq   #0,d0
	clr.w   volumeSlope(a5)
	bclr    #1,volumeBitfield(a5)

@loc_291A:               ; CODE XREF: sub_28EA+18j
	move.w  d1,systemVolume(a5)
	move.w  d0,word_5AC4(a5)
	rts
; End of function sub_28EA
