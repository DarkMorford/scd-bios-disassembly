;   ======================================================================
;                     SEGA CD BIOS 2.00w US Disassembly
;                            Sub-CPU BIOS Module
;   ======================================================================
;
;       Disassembly created by DarkMorford
;
;   ======================================================================

	include "constants.asm"
	include "variables.asm"
	include "macros.asm"

initialSSP:
	dc.l _CDSTAT
	dc.l _start
	dc.l _reset
	dc.l _ADRERR
	dc.l _CODERR
	dc.l _DEVERR
	dc.l _CHKERR
	dc.l _TRAPERR
	dc.l _SPVERR
	dc.l _TRACE
	dc.l _NOCOD0
	dc.l _NOCOD1
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _LEVEL1
	dc.l _LEVEL2
	dc.l _LEVEL3
	dc.l _LEVEL4
	dc.l _LEVEL5
	dc.l _LEVEL6
	dc.l _LEVEL7
	dc.l _TRAP00
	dc.l _TRAP01
	dc.l _TRAP02
	dc.l _TRAP03
	dc.l _TRAP04
	dc.l _TRAP05
	dc.l _TRAP06
	dc.l _TRAP07
	dc.l _TRAP08
	dc.l _TRAP09
	dc.l _TRAP10
	dc.l _TRAP11
	dc.l _TRAP12
	dc.l _TRAP13
	dc.l _TRAP14
	dc.l _TRAP15
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset
	dc.l _reset

ProgramHeader:
	dc.b 'SEGA CD         '
	dc.b '(C)SEGA 1993.FEB'
	dc.b 'CD-ROM BIOS CD2   2/22-1993     17:00      2.00 '
	dc.b 'CD-ROM BIOS CD2                                 '
	dc.b 'BR 000006-2.00'
	dc.w $0622
	dc.b '                '
	dc.l $00000
	dc.l $057FF
	dc.l $05800
	dc.l $7FFFF
	dc.b 'RA', $F8, $20
	dc.l $FFFE0001
	dc.l $FFFE3FFF
	dc.b '            '
	dc.b '                                        '
	dc.b 'U               '

; ---------------------------------------------------------------------------

_start:
	jmp (loc_256).l

; ---------------------------------------------------------------------------

_reset:
	jmp (loc_250).l

; ---------------------------------------------------------------------------

_nullrts:
	rts

; ---------------------------------------------------------------------------

_nullrte:
	rte

; ---------------------------------------------------------------------------
_zeroes:
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
; ---------------------------------------------------------------------------

loc_250:
	movea.l (initialSSP).l,sp

loc_256:
	clr.b   (GA_INT_MASK).w
	m_disableInterrupts
	movem.l _zeroes(pc),d0-a6
	move.l  a0,usp
	move.b  #0,(GA_CDD_CONTROL).w
	bclr    #GA_RES0,(GA_RESET).w
	move.b  #2,(GA_LED_STATUS).w
	lea (GA_MEMORY_MODE).w,a0

loc_27C:
	btst    #GA_MODE,(a0)       ; Set Word RAM to 2M mode
	beq.s   loc_288
	bclr    #GA_MODE,(a0)
	bra.s   loc_27C
; ---------------------------------------------------------------------------

loc_288:
	btst    #GA_DMNA,(a0)       ; Give Word RAM to main CPU
	beq.s   loc_292
	bset    #GA_RET,(a0)

loc_292:
	move.b  #CDC_WRITE_RESET,(GA_CDC_ADDRESS).w
	move.b  #0,(GA_CDC_REGISTER).w
	move.w  #0,(GA_STOPWATCH).w
	moveq   #0,d0
	move.b  d0,(GA_COMM_SUBFLAGS).w
	lea (GA_COMM_SUBDATA).w,a0
	move.l  d0,(a0)+
	move.l  d0,(a0)+
	move.l  d0,(a0)+
	move.l  d0,(a0)
	move.w  #0,(GA_CDD_FADER).w ; Mute CD audio
	lea ProgramHeader(pc),a1
	cmpi.l  #'SEGA',(a1)
	bne.w   _reset
	move.l  $A4(a1),d1
	addq.l  #1,d1
	lea _start(pc),a0
	sub.l   a0,d1
	lsr.l   #1,d1
	move.w  d1,d2
	subq.w  #1,d2
	swap    d1
	moveq   #0,d0

loc_2E0:
	add.w   (a0)+,d0    ; Calculate checksum
	dbf d2,loc_2E0
	dbf d1,loc_2E0
	move.w  $8E(a1),d1
	beq.s   loc_2F6
	cmp.w   d1,d0
	bne.w   _reset

loc_2F6:
	movea.l #$5800,a0
	move.l  #$6000,d1
	subi.l  #$5801,d1
	lsr.l   #4,d1       ; d1 = 0x7F
	moveq   #0,d0

loc_30C:
	move.l  d0,(a0)+    ; Clear RAM from $5800 - $5FFF
	move.l  d0,(a0)+
	move.l  d0,(a0)+
	move.l  d0,(a0)+
	dbf d1,loc_30C
	move.w  #$4EF9,d0
	lea _nullrts(pc),a0
	lea (JumpTable).w,a1 ; Set up the jump table with dummy values
	moveq   #15,d1

loc_326:
	move.w  d0,(a1)+
	move.l  a0,(a1)+
	dbf d1,loc_326
	lea _reset(pc),a0
	moveq   #8,d1

loc_334:
	move.w  d0,(a1)+
	move.l  a0,(a1)+
	dbf d1,loc_334
	lea _nullrte(pc),a0
	moveq   #22,d1

loc_342:
	move.w  d0,(a1)+
	move.l  a0,(a1)+
	dbf d1,loc_342
	bsr.w   initLeds
	bsr.w   sub_AEC
	bsr.w   initCdc
; ---------------------------------------------------------------------------
	bsr.w   initVolume
	bsr.w   initCdd
	m_enableInterrupts
	nop

; =============== S U B R O U T I N E =======================================


installJumpTable:
	m_disableInterrupts
	lea (_LEVEL1).w,a0
	lea word_378(pc),a1
	lea loc_388(pc),a6
	bra.w   loc_556
; ---------------------------------------------------------------------------
word_378:
	dc.w $2E8
	dc.w $27A
	dc.w $2E8
	dc.w $298
	dc.w $2BC
	dc.w $2D0
	dc.w $2E8
	dc.w 0
; ---------------------------------------------------------------------------

loc_388:                ; DATA XREF: installJumpTable+Co
	lea ($5F0A).w,a0
	lea word_398(pc),a1
	lea loc_39E(pc),a6
	bra.w   loc_556
; ---------------------------------------------------------------------------
word_398:
	dc.w $238
	dc.w $24A
	dc.w 0
; ---------------------------------------------------------------------------

loc_39E:                ; DATA XREF: installJumpTable+2Co
	lea (_BURAM).w,a0
	lea (word_4436).l,a1
	lea loc_3B0(pc),a6
	bra.w   loc_56A
; ---------------------------------------------------------------------------

loc_3B0:                ; DATA XREF: installJumpTable+44o
	lea (_CDBOOT).w,a0
	lea (word_3900).l,a1
	lea loc_3C2(pc),a6
	bra.w   loc_56A
; ---------------------------------------------------------------------------

loc_3C2:                ; DATA XREF: installJumpTable+56o
	lea (_CDBIOS).w,a0
	lea (word_2924).l,a1
	lea loc_3D4(pc),a6
	bra.w   loc_56A
; ---------------------------------------------------------------------------

loc_3D4:                ; CODE XREF: installJumpTable+76j
				; DATA XREF: installJumpTable+68o
	btst    #GA_RES0,(GA_RESET).w
	beq.s   loc_3D4
	ori.b   #$14,(GA_INT_MASK).w
	bclr    #2,byte_580A(a5)
	move.w  #$1E,word_5A02(a5)
	move.b  #4,(GA_CDD_CONTROL).w
	move.b  #$80,byte_580A(a5)
	m_enableInterrupts

loc_3FE:                ; CODE XREF: installJumpTable+A2j
	bsr.w   _waitForVBlank
	move.b  byte_5A04(a5),d0
	beq.s   loc_3FE
	cmpi.b  #$FF,d0
	beq.w   _reset

loc_410:                ; CODE XREF: installJumpTable:loc_51Aj
	movem.l _zeroes(pc),d0-a6
	movea.l #$6000,a1

loc_41C:                ; CODE XREF: installJumpTable+104j
	move    #$2200,sr
	lea (_USERCALL0).w,a0
	bsr.w   _setJmpTbl
	clr.w   d0

loc_42A:
	move.w  d0,(word_5EA2).w
	jsr _USERCALL0
	m_enableInterrupts

loc_436:                ; CODE XREF: installJumpTable+DEj
				; installJumpTable+E8j ...
	bsr.w   _waitForVBlank
	move.w  (word_5EA2).w,d0
	jsr _USERCALL1
	bcc.s   loc_436
	move.w  d0,(word_5EA2).w
	cmpi.w  #$FFFF,d0
	bne.s   loc_436
	cmpi.w  #4,(_BOOTSTAT).w
	beq.s   loc_45C
	cmpi.w  #6,(_BOOTSTAT).w

loc_45C:                ; CODE XREF: installJumpTable+F0j
	bne.s   loc_436
	movem.l _zeroes(pc),d0-a6
	lea asc_46A(pc),a1  ; "BOOT____SYS"
	bra.s   loc_41C
; ---------------------------------------------------------------------------
asc_46A:
	dc.b 'BOOT____SYS'
	dc.b 0
	dc.b 1
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b $EC
	dc.l $20
	dc.l 0
	dc.w $FD82
	dc.w $A
	dc.w $FD82
	dc.w $FD82
	dc.w 0
; ---------------------------------------------------------------------------

loc_494:
	movea.l #WORD_RAM_1M, a1
	lea (GA_MEMORY_MODE).w, a0
	btst #GA_MODE, (a0)
	bne.s loc_4BC
	moveq #0, d0
	movea.l #WORD_RAM_2M, a1
	btst d0, (a0)
	beq.s loc_4BC

loc_4B0:
	btst    #1,(a0)
	beq.s   loc_4B0

loc_4B6:
	bclr    d0,(a0)
	btst    d0,(a0)
	bne.s   loc_4B6

loc_4BC:
	movea.l a1,a0
	lea (bootModule).w,a0
	moveq   #CBTIPDISK,d0
	bsr.w   _CDBOOT
	bcs.s   loc_494

loc_4CA:
	bsr.w   _waitForVBlank
	bsr.w   loc_51E
	moveq   #CBTIPSTAT,d0
	bsr.w   _CDBOOT
	bcs.s   loc_4CA
	bclr    #7,(GA_COMM_SUBFLAGS).w
	lea (GA_MEMORY_MODE).w,a0
	moveq   #0,d0
	btst    #GA_MODE,(a0)
	beq.s   loc_4F8
	btst    d0,(a0)
	beq.s   loc_4F8

loc_4F0:
	bclr    d0,(a0)
	btst    d0,(a0)
	bne.s   loc_4F0
	bra.s   loc_4FE
; ---------------------------------------------------------------------------

loc_4F8:                ; CODE XREF: installJumpTable+186j
					; installJumpTable+18Aj ...
	bset    d0,(a0)
	btst    d0,(a0)
	beq.s   loc_4F8

loc_4FE:                ; CODE XREF: installJumpTable+192j
	lea (bootModule).w,a1 ; "MAINBOOTUSR"
	moveq   #CBTSPDISC,d0
	bsr.w   _CDBOOT
	bcs.s   loc_494
	bsr.w   _waitForVBlank
	bsr.w   loc_51E
	moveq   #CBTSPSTAT,d0
	bsr.w   _CDBOOT
	bra.s   loc_552
; ---------------------------------------------------------------------------

loc_51A:                ; CODE XREF: installJumpTable+1F0j
	bra.w   loc_410
; ---------------------------------------------------------------------------

loc_51E:                ; CODE XREF: installJumpTable+16Ap
					; installJumpTable+1AAp
	move.w  #CDBSTAT,d0
	jsr _CDBIOS
	moveq   #CBTINT,d0
	bsr.w   _CDBOOT
	rts
; ---------------------------------------------------------------------------

loc_52E:                ; CODE XREF: installJumpTable+1E4j
					; installJumpTable:loc_552j
	bsr.w   _waitForVBlank
	move.w  #CDBSTAT,d0
	jsr _CDBIOS
	move.w  #CBTINT,d0
	bsr.w   _CDBOOT
	btst    #7,(_CDSTAT).w
	bne.s   loc_52E
	move.w  #CBTSPSTAT,d0
	bsr.w   _CDBOOT

loc_552:                ; CODE XREF: installJumpTable+1B4j
	bcs.s   loc_52E
	bra.s   loc_51A
; ---------------------------------------------------------------------------

loc_556:                ; CODE XREF: installJumpTable+10j
				; installJumpTable+30j ...
	move.l  a1,d1
	bra.s   loc_564
; ---------------------------------------------------------------------------

loc_55A:                ; CODE XREF: installJumpTable+202j
	ext.l   d0
	add.l   d1,d0
	move.w  #$4EF9,(a0)+
	move.l  d0,(a0)+

loc_564:                ; CODE XREF: installJumpTable+1F4j
	move.w  (a1)+,d0
	bne.s   loc_55A
	jmp (a6)
; ---------------------------------------------------------------------------

loc_56A:                ; CODE XREF: installJumpTable+48j
				; installJumpTable+5Aj ...
	move.w  (a1),d0
	ext.l   d0
	add.l   a1,d0
	move.w  #$4EF9,(a0)+
	move.l  d0,(a0)+
	jmp (a6)
; End of function installJumpTable


; =============== S U B R O U T I N E =======================================


sub_578:                ; CODE XREF: _setJmpTbl+Ap
		movem.l a2/a6,-(sp)
		bra.s   loc_59E
; ---------------------------------------------------------------------------

loc_57E:                ; CODE XREF: sub_578+32j
		movea.l a1,a2
		adda.l  $18(a2),a1
		tst.b   $B(a2)
		beq.s   loc_58E
		jsr (a1)
		bcc.s   loc_594

loc_58E:                ; CODE XREF: sub_578+10j
		lea loc_594(pc),a6
		bra.s   loc_556
; ---------------------------------------------------------------------------

loc_594:                ; CODE XREF: sub_578+14j
					; DATA XREF: sub_578:loc_58Eo
		movea.l a2,a1
		move.l  $10(a1),d0
		beq.s   loc_5B0
		adda.l  d0,a1

loc_59E:                ; CODE XREF: sub_578+4j
		lea word_5B6(pc),a2
		bra.s   loc_5AC
; ---------------------------------------------------------------------------

loc_5A4:                ; CODE XREF: sub_578+36j
		move.l  (a2)+,d0
		cmp.l   (a1,d1.w),d0
		beq.s   loc_57E

loc_5AC:                ; CODE XREF: sub_578+2Aj
		move.w  (a2)+,d1
		bpl.s   loc_5A4

loc_5B0:                ; CODE XREF: sub_578+22j
		movem.l (sp)+,a2/a6
		rts
; End of function sub_578

; ---------------------------------------------------------------------------
word_5B6:
	dc.w 0
	dc.b 'MAIN'
	dc.w 8
	dc.b 'SYS',0
	dc.w 8
	dc.b 'SUB',0
	dc.w 8
	dc.b 'DAT',0
	dc.w $FFFF

; =============== S U B R O U T I N E =======================================


_setJmpTbl:             ; CODE XREF: installJumpTable+C0p
		movem.l a5,-(sp)
		movea.l #0,a5
		bsr.s   sub_578
		movem.l (sp)+,a5
		rts
; End of function _setJmpTbl


; =============== S U B R O U T I N E =======================================


_waitForVBlank:             ; CODE XREF: installJumpTable:loc_3FEp
					; installJumpTable:loc_436p ...
		bset    #0,(vBlankFlag).w

loc_5E8:                ; CODE XREF: _waitForVBlank+Cj
		btst    #0,(vBlankFlag).w
		bne.s   loc_5E8
		rts
; End of function _waitForVBlank

; ---------------------------------------------------------------------------

mdInterrupt:
		movem.l d0-a6,-(sp)
		movea.l #0,a5

		bsr.w   sub_17EE
		jsr _USERCALL2
		bclr    #0,(vBlankFlag).w

		movem.l (sp)+,d0-a6
		rte
; ---------------------------------------------------------------------------

cddInterrupt:
		movem.l d0-a6,-(sp)
		movea.l #0,a5

		bsr.w   sub_E74
		bsr.w   updateSubcode
		bsr.w   cddContinue
		bsr.w   updateVolume
		bsr.w   updateLeds

		movem.l (sp)+,d0-a6
		rte
; ---------------------------------------------------------------------------

cdcInterrupt:
		movem.l d0-a6,-(sp)
		movea.l #0,a5

		bsr.w   updateCdc

		movem.l (sp)+,d0-a6
		rte
; ---------------------------------------------------------------------------

scdInterrupt:
		movem.l d0-a6,-(sp)
		movea.l #0,a5

		tst.b   byte_5810(a5)
		beq.s   @loc_65C
		bsr.w   sub_203E

@loc_65C:
		movem.l (sp)+,d0-a6
		rte

; =============== S U B M O D U L E =========================================
	include "submodules\led.asm"

; =============== S U B R O U T I N E =======================================


sub_73C:                ; CODE XREF: initCdc+42p sub_1F1E+6p
		clr.l   4(a4)
		move.l  d0,0(a4)
		move.l  d1,8(a4)
		move.l  a0,$C(a4)
		rts
; End of function sub_73C


; =============== S U B R O U T I N E =======================================


sub_74E:                ; CODE XREF: sub_1E6Ap sub_203E+82p ...
		movem.l d2-d4,-(sp)
		move.w  4(a4),d2
		move.w  6(a4),d3
		move.w  $A(a4),d4
		lea $10(a4,d3.w),a1
		add.w   2(a4),d3
		cmp.w   d4,d3
		bcs.s   loc_76C
		sub.w   d4,d3

loc_76C:                ; CODE XREF: sub_74E+1Aj
		move.w  d3,6(a4)
		moveq   #0,d1
		move.w  d2,d0
		sub.w   d3,d0
		bcc.s   loc_77A
		add.w   d4,d0

loc_77A:                ; CODE XREF: sub_74E+28j
		cmp.w   8(a4),d0
		bcc.s   loc_790
		moveq   #1,d1
		add.w   2(a4),d2
		cmp.w   d4,d2
		bcs.s   loc_78C
		sub.w   d4,d2

loc_78C:                ; CODE XREF: sub_74E+3Aj
		move.w  d2,4(a4)

loc_790:                ; CODE XREF: sub_74E+30j
		movem.l (sp)+,d2-d4
		rts
; End of function sub_74E


; =============== S U B R O U T I N E =======================================


sub_796:                ; CODE XREF: updateSubcode+7Ap
		move.w  6(a4),d0
		sub.w   2(a4),d0
		bcc.s   loc_7A4
		add.w   $A(a4),d0

loc_7A4:                ; CODE XREF: sub_796+8j
		move.w  d0,6(a4)
		rts
; End of function sub_796


; =============== S U B R O U T I N E =======================================


sub_7AA:                ; CODE XREF: _cdcread+24p
					; _cdcread:loc_1870p ...
		movem.l d2/d4,-(sp)
		move.w  4(a4),d2
		move.w  $A(a4),d4
		lea $10(a4,d2.w),a0
		add.w   0(a4),d2
		cmp.w   d4,d2
		bcs.s   loc_7C4
		sub.w   d4,d2

loc_7C4:                ; CODE XREF: sub_7AA+16j
		move.w  d2,4(a4)
		cmp.w   6(a4),d2
		movem.l (sp)+,d2/d4
		rts
; End of function sub_7AA


; =============== S U B R O U T I N E =======================================


convertFromBcd:             ; CODE XREF: sub_7EE+8p
					; sub_7EE:loc_800p ...
		move.w  d1,-(sp)
		andi.w  #$FF,d0
		ror.w   #4,d0
		lsl.b   #1,d0
		move.b  d0,d1
		lsl.b   #2,d0
		add.b   d0,d1
		rol.w   #4,d0
		andi.w  #$F,d0
		add.b   d1,d0
		move.w  (sp)+,d1
		rts
; End of function convertFromBcd


; =============== S U B R O U T I N E =======================================


sub_7EE:                ; CODE XREF: sub_1D52+4p sub_1DB0+4p ...
		move.l  d1,-(sp)
		move.l  d0,-(sp)
		move.b  2(sp),d0
		bsr.s   convertFromBcd
		moveq   #0,d1
		move.w  d0,d1
		move.b  1(sp),d0

loc_800:                ; DATA XREF: PLAYER:off_19304o
		bsr.s   convertFromBcd
		mulu.w  #$4B,d0 ; 'K'
		add.l   d0,d1
		move.b  0(sp),d0
		bsr.s   convertFromBcd
		mulu.w  #$1194,d0
		add.l   d1,d0
		move.l  (sp)+,d1
		move.l  (sp)+,d1
		rts
; End of function sub_7EE


; =============== S U B R O U T I N E =======================================


convertToBcd:               ; CODE XREF: sub_82E+Ep sub_82E+1Ep ...
		andi.l  #$FF,d0
		divu.w  #$A,d0
		swap    d0
		ror.w   #4,d0
		lsl.l   #4,d0
		swap    d0
		rts
; End of function convertToBcd


; =============== S U B R O U T I N E =======================================


sub_82E:                ; CODE XREF: BIOS:00003696p
					; BIOS:00003700p
		move.l  d1,-(sp)
		moveq   #0,d1
		move.l  d1,-(sp)
		divu.w  #$4B,d0 ; 'K'
		move.w  d0,d1
		swap    d0
		bsr.s   convertToBcd
		move.b  d0,2(sp)
		move.l  d1,d0
		divu.w  #$3C,d0 ; '<'
		move.w  d0,d1
		swap    d0
		bsr.s   convertToBcd
		move.b  d0,1(sp)
		move.l  d1,d0
		bsr.s   convertToBcd
		move.b  d0,0(sp)
		move.l  (sp)+,d0
		move.l  (sp)+,d1
		rts
; End of function sub_82E


; =============== S U B R O U T I N E =======================================


sub_860:                ; CODE XREF: sub_210E+4p
		movem.l d2/a1/a6,-(sp)
		lea word_8EC(pc),a0
		clr.w   d1
		bsr.s   sub_878
		bsr.s   sub_8A8
		not.w   d1
		sub.w   d1,(a1)+
		movem.l (sp)+,d2/a1/a6
		rts
; End of function sub_860


; =============== S U B R O U T I N E =======================================


sub_878:                ; CODE XREF: sub_860+Ap sub_8CE+Cp ...
		move.b  (a1)+,d0
		lea sub_880(pc),a6
		bra.s   loc_8BA
; End of function sub_878


; =============== S U B R O U T I N E =======================================


sub_880:                ; DATA XREF: sub_878+2o
		move.b  (a1)+,d0
		lea sub_888(pc),a6
		bra.s   loc_8BA
; End of function sub_880


; =============== S U B R O U T I N E =======================================


sub_888:                ; DATA XREF: sub_880+2o
		move.b  (a1)+,d0
		lea sub_890(pc),a6
		bra.s   loc_8BA
; End of function sub_888


; =============== S U B R O U T I N E =======================================


sub_890:                ; DATA XREF: sub_888+2o
		move.b  (a1)+,d0
		lea sub_898(pc),a6
		bra.s   loc_8BA
; End of function sub_890


; =============== S U B R O U T I N E =======================================


sub_898:                ; DATA XREF: sub_890+2o
		move.b  (a1)+,d0
		lea sub_8A0(pc),a6
		bra.s   loc_8BA
; End of function sub_898


; =============== S U B R O U T I N E =======================================


sub_8A0:                ; DATA XREF: sub_898+2o
		move.b  (a1)+,d0
		lea sub_8A8(pc),a6
		bra.s   loc_8BA
; End of function sub_8A0


; =============== S U B R O U T I N E =======================================


sub_8A8:                ; CODE XREF: sub_860+Cp
					; DATA XREF: sub_8A0+2o
		move.b  (a1)+,d0
		lea loc_8B0(pc),a6
		bra.s   loc_8BA
; ---------------------------------------------------------------------------

loc_8B0:                ; DATA XREF: sub_8A8+2o
		move.b  (a1)+,d0
		lea locret_8B8(pc),a6
		bra.s   loc_8BA
; ---------------------------------------------------------------------------

locret_8B8:             ; DATA XREF: sub_8A8+Ao
		rts
; ---------------------------------------------------------------------------

loc_8BA:                ; CODE XREF: sub_878+6j sub_880+6j ...
		rol.w   #8,d1
		clr.w   d2
		move.b  d0,d2
		eor.b   d1,d2
		clr.b   d1
		add.w   d2,d2
		move.w  (a0,d2.w),d2
		eor.w   d2,d1
		jmp (a6)
; End of function sub_8A8


; =============== S U B R O U T I N E =======================================


sub_8CE:                ; CODE XREF: sub_4E74+C6p sub_4FE2+9Cp
		movem.l d7/a2/a6,-(sp)
		movea.l a0,a1
		lea word_8EC(pc),a0
		clr.w   d1
		bsr.s   sub_878
		bsr.s   sub_878
		bsr.s   sub_878
		bsr.s   sub_878
		move.w  d1,d2
		not.w   d2
		movem.l (sp)+,d7/a2/a6
		rts
; End of function sub_8CE

; ---------------------------------------------------------------------------
word_8EC:
	incbin "unk_8EC.bin"

; =============== S U B R O U T I N E =======================================


sub_AEC:                ; CODE XREF: BIOS:0000034Ep
		move.w  #$8000,d0
		bsr.w   sub_B0C
		rts
; End of function sub_AEC


; =============== S U B R O U T I N E =======================================


sub_AF6:                ; CODE XREF: BIOS:00002C62p
					; BIOS:00002CD0p ...
		move.b  byte_5811(a5),d0
		move.b  byte_580C(a5),d1
		andi.w  #$F,d1
		beq.s   locret_B0A
		move.b  d1,d0
		move    #1,ccr

locret_B0A:             ; CODE XREF: sub_AF6+Cj
		rts
; End of function sub_AF6


; =============== S U B R O U T I N E =======================================


sub_B0C:                ; CODE XREF: sub_AEC+4p sub_2BBC+1Ep ...
		btst    #$F,d0
		bne.s   loc_B20
		btst    #0,byte_580C(a5)
		beq.s   loc_B2C
		move    #1,ccr
		rts
; ---------------------------------------------------------------------------

loc_B20:                ; CODE XREF: sub_B0C+4j
		bclr    #0,byte_580C(a5)
		bset    #3,byte_580C(a5)

loc_B2C:                ; CODE XREF: sub_B0C+Cj
		movea.l d1,a0
		move.b  byte_580C(a5),d1
		andi.w  #6,d1
		bne.s   loc_B44
		move.b  byte_5811(a5),d1
		or.b    d1,byte_5812(a5)
		clr.b   byte_5811(a5)

loc_B44:                ; CODE XREF: sub_B0C+2Aj
		lea word_582A(a5),a1
		andi.w  #$FF,d0
		lsl.w   #4,d0
		lsr.b   #4,d0
		move.w  d0,(a1)+
		tst.b   d0
		beq.s   loc_B58
		moveq   #0,d0

loc_B58:                ; CODE XREF: sub_B0C+48j
		lsr.w   #6,d0
		jsr loc_B60(pc,d0.w)
		rts
; End of function sub_B0C

; ---------------------------------------------------------------------------

loc_B60:
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BD6
; ---------------------------------------------------------------------------
	bra.w   sub_C28
; ---------------------------------------------------------------------------
	bra.w   sub_C28
; ---------------------------------------------------------------------------
	bra.w   sub_BA0
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_C6A
; ---------------------------------------------------------------------------
	bra.w   sub_C6E
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BA0
; ---------------------------------------------------------------------------
	bra.w   sub_BC8

; =============== S U B R O U T I N E =======================================


sub_BA0:                ; CODE XREF: BIOS:00000B74j
					; BIOS:00000B98j
		move.l  a0,d0
		swap    d0
		andi.w  #$FF,d0
		bsr.w   sub_C62
		move.w  a0,d0
		lsr.w   #8,d0
		bsr.w   sub_C62
		move.w  a0,d0
		andi.w  #$FF,d0
		bsr.w   sub_C62
		bset    #0,byte_580C(a5)
		or.w    d1,d1
		rts
; End of function sub_BA0


; =============== S U B R O U T I N E =======================================


sub_BC8:                ; CODE XREF: BIOS:loc_B60j
					; BIOS:00000B64j ...
		clr.l   (a1)+
		clr.w   (a1)
		bset    #0,byte_580C(a5)
		or.w    d1,d1
		rts
; End of function sub_BC8


; =============== S U B R O U T I N E =======================================


sub_BD6:                ; CODE XREF: BIOS:00000B68j
		move.l  a0,d0
		swap    d0
		andi.w  #$F,d0
		move.w  d0,(a1)+
		cmpi.b  #5,d0
		beq.s   loc_BF2
		clr.l   (a1)
		bset    #0,byte_580C(a5)
		or.w    d1,d1
		rts
; ---------------------------------------------------------------------------

loc_BF2:                ; CODE XREF: sub_BD6+Ej
		move.w  a0,d0
		lsr.w   #8,d0
		bclr    #7,d0
		beq.s   loc_C06
		bsr.w   convertToBcd
		bset    #7,d0
		bra.s   loc_C0A
; ---------------------------------------------------------------------------

loc_C06:                ; CODE XREF: sub_BD6+24j
		bsr.w   convertToBcd

loc_C0A:                ; CODE XREF: sub_BD6+2Ej
		bsr.s   sub_C62
		move.w  a0,d0
		andi.w  #$FF,d0
		cmpi.w  #$FF,d0
		beq.s   loc_C1C
		bsr.w   convertToBcd

loc_C1C:                ; CODE XREF: sub_BD6+40j
		bsr.s   sub_C62
		bset    #0,byte_580C(a5)
		or.w    d1,d1
		rts
; End of function sub_BD6


; =============== S U B R O U T I N E =======================================


sub_C28:                ; CODE XREF: BIOS:00000B6Cj
					; BIOS:00000B70j
		bsr.s   sub_C34
		bset    #0,byte_580C(a5)
		or.w    d1,d1
		rts
; End of function sub_C28


; =============== S U B R O U T I N E =======================================


sub_C34:                ; CODE XREF: sub_C28p sub_12CE+4D8p
		move.l  a0,d0
		cmpi.l  #$17000,d0
		bcc.s   loc_C44
		move.l  #$17000,d0

loc_C44:                ; CODE XREF: sub_C34+8j
		lsr.w   #4,d0
		lsr.b   #4,d0
		move.w  d0,4(a1)
		lsr.l   #4,d0
		lsr.w   #4,d0
		lsr.l   #4,d0
		lsr.w   #4,d0
		move.w  d0,2(a1)
		swap    d0
		lsl.w   #4,d0
		lsr.b   #4,d0
		move.w  d0,(a1)
		rts
; End of function sub_C34


; =============== S U B R O U T I N E =======================================


sub_C62:                ; CODE XREF: sub_BA0+8p sub_BA0+10p ...
		lsl.w   #4,d0
		lsr.b   #4,d0
		move.w  d0,(a1)+
		rts
; End of function sub_C62


; =============== S U B R O U T I N E =======================================


sub_C6A:                ; CODE XREF: BIOS:00000B88j
		or.w    d1,d1
		rts
; End of function sub_C6A


; =============== S U B R O U T I N E =======================================


sub_C6E:                ; CODE XREF: BIOS:00000B8Cj
		move.l  a0,d0
		bsr.s   sub_C62
		clr.l   (a1)
		bset    #0,byte_580C(a5)
		or.w    d1,d1
		rts
; End of function sub_C6E


; =============== S U B R O U T I N E =======================================


sub_C7E:                ; CODE XREF: sub_2946:loc_29FAp
		bset    #0,byte_580E(a5)
		move.l  (a0),d0
		movem.l a0,-(sp)
		bsr.w   convertFromBcd
		movem.l (sp)+,a0
		cmpi.w  #100,d0
		bcc.s   loc_CA4
		lea cddTocTable(a5),a1
		add.w   d0,d0
		add.w   d0,d0
		move.l  (a0)+,(a1,d0.w)

loc_CA4:                ; CODE XREF: sub_C7E+18j
		bclr    #0,byte_580E(a5)
		rts
; End of function sub_C7E


; =============== S U B R O U T I N E =======================================


sub_CAC:                ; CODE XREF: sub_12CE+4C6p
					; _cdbtocread+2p ...
		bset    #0,byte_580E(a5)
		lea cddTocTable(a5),a0
		cmpi.w  #100,d0
		bcc.s   loc_CDC
		add.w   d0,d0
		add.w   d0,d0
		adda.w  d0,a0
		move.l  (a0),d0
		tst.b   d0
		beq.s   loc_CDC

loc_CC8:                ; CODE XREF: sub_CAC+5Cj
		lea dword_59E8(a5),a0
		bclr    #$F,d0
		sne d1
		move.l  d0,(a0)
		bclr    #0,byte_580E(a5)
		rts
; ---------------------------------------------------------------------------

loc_CDC:                ; CODE XREF: sub_CAC+Ej sub_CAC+1Aj
		adda.w  #4,a0
		lea cddTocTable(a5),a1
		moveq   #0,d0
		move.b  cddLastTrack(a5),d0
		bsr.w   convertFromBcd
		add.w   d0,d0
		add.w   d0,d0
		adda.w  d0,a1

loc_CF4:                ; CODE XREF: sub_CAC+50j
		move.l  (a0)+,d0
		tst.b   d0
		bne.s   loc_D04
		cmpa.w  a1,a0
		bls.s   loc_CF4
		lea dword_D0A(pc),a0
		move.l  (a0)+,d0

loc_D04:                ; CODE XREF: sub_CAC+4Cj
		subq.w  #4,a0
		clr.b   d0
		bra.s   loc_CC8
; End of function sub_CAC

; ---------------------------------------------------------------------------
dword_D0A:  dc.l $20000     ; DATA XREF: sub_CAC+52o

; =============== S U B R O U T I N E =======================================


sub_D0E:                ; CODE XREF: sub_12CE:loc_1442p
					; sub_12CE:loc_145Ap ...
		move.b  word_584E(a5),d0
		rts
; End of function sub_D0E


; =============== S U B R O U T I N E =======================================


sub_D14:                ; CODE XREF: sub_12CE+8Ap
		move.w  word_584E(a5),d0
		rts
; End of function sub_D14


; =============== S U B R O U T I N E =======================================


setErrorAndReturn:                ; CODE XREF: getAbsFrameTime+6j getRelFrameTime+6j ...
		move    #1,ccr
		rts
; End of function setErrorAndReturn


; =============== S U B R O U T I N E =======================================


getAbsFrameTime:                ; CODE XREF: writeCddStatus+62p
		btst    #0,byte_580F(a5)
		beq.s   setErrorAndReturn

		bset    #1,byte_580E(a5)
		move.l  cddAbsFrameTime(a5),d0
		bclr    #1,byte_580E(a5)
		rts
; End of function getAbsFrameTime


; =============== S U B R O U T I N E =======================================


getRelFrameTime:                ; CODE XREF: writeCddStatus+72p
		btst    #1,byte_580F(a5)
		beq.s   setErrorAndReturn

		bset    #2,byte_580E(a5)
		move.l  cddRelFrameTime(a5),d0
		bclr    #2,byte_580E(a5)
		rts
; End of function getRelFrameTime


; =============== S U B R O U T I N E =======================================


getCurrentTrackNumber:                ; CODE XREF: writeCddStatus+4Cp
		btst    #2,byte_580F(a5)
		beq.s   setErrorAndReturn

		move.b  currentTrackNumber(a5),d0
		bsr.w   validateTrackNumber
		bsr.w   convertFromBcd
		or.w    d1,d1
		rts
; End of function getCurrentTrackNumber


; =============== S U B R O U T I N E =======================================


getDiscControlCode:                ; CODE XREF: writeCddStatus+46p
		btst    #2,byte_580F(a5)
		beq.s   setErrorAndReturn

		moveq   #0,d0
		move.b  byte_59F5(a5),d0
		rts
; End of function getDiscControlCode


; =============== S U B R O U T I N E =======================================


sub_D7C:                ; CODE XREF: BIOS:00003136p
					; BIOS:loc_3244p ...
		moveq   #0,d0
		move.b  byte_59F6(a5),d0
		rts
; End of function sub_D7C


; =============== S U B R O U T I N E =======================================


getFirstTrack:              ; CODE XREF: BIOS:00002D36p
		btst    #6,byte_580E(a5)
		beq.s   setErrorAndReturn

		move.b  cddFirstTrack(a5),d0
		bsr.w   convertFromBcd
		or.w    d1,d1
		rts
; End of function getFirstTrack


; =============== S U B R O U T I N E =======================================


getLastTrack:
		btst    #6,byte_580E(a5)
		beq.w   setErrorAndReturn

		move.b  cddLastTrack(a5),d0
		bsr.w   convertFromBcd
		or.w    d1,d1
		rts
; End of function getLastTrack


; =============== S U B R O U T I N E =======================================


writeCddStatus:             ; CODE XREF: sub_2946+98p
		movem.l a2,-(sp)
		movea.l a0,a2
		move.w  word_584E(a5),d0
		move.w  d0,(a2)+
		lsr.w   #8,d0
		cmpi.b  #4,d0
		beq.s   loc_DC8
		cmpi.b  #$C,d0
		bne.s   loc_DEA

loc_DC8:                ; CODE XREF: writeCddStatus+12j
		move.b  word_5A00+1(a5),(a2)+
		move.b  word_5A00(a5),d0
		cmpi.b  #$FF,d0
		beq.s   loc_DDE
		bsr.w   validateTrackNumber
		bsr.w   convertFromBcd

loc_DDE:                ; CODE XREF: writeCddStatus+26j
		move.b  d0,(a2)+
		move.l  dword_59F8(a5),(a2)+
		move.l  dword_59FC(a5),(a2)+
		bra.s   loc_E26
; ---------------------------------------------------------------------------

loc_DEA:                ; CODE XREF: writeCddStatus+18j
		moveq   #$FFFFFFFF,d0
		btst    #2,byte_580F(a5)
		beq.s   loc_E04
		bsr.w   getDiscControlCode
		move.w  d0,-(sp)
		bsr.w   getCurrentTrackNumber
		ror.l   #8,d0
		move.w  (sp)+,d0
		rol.l   #8,d0

loc_E04:                ; CODE XREF: writeCddStatus+44j
		move.w  d0,(a2)+
		moveq   #$FFFFFFFF,d0
		btst    #0,byte_580F(a5)
		beq.s   loc_E14
		bsr.w   getAbsFrameTime

loc_E14:                ; CODE XREF: writeCddStatus+60j
		move.l  d0,(a2)+
		moveq   #$FFFFFFFF,d0
		btst    #1,byte_580F(a5)
		beq.s   loc_E24
		bsr.w   getRelFrameTime

loc_E24:                ; CODE XREF: writeCddStatus+70j
		move.l  d0,(a2)+

loc_E26:                ; CODE XREF: writeCddStatus+3Aj
		btst    #6,byte_580E(a5)
		beq.s   loc_E48
		move.b  cddFirstTrack(a5),d0
		bsr.w   convertFromBcd
		move.b  d0,(a2)+
		move.b  cddLastTrack(a5),d0
		bsr.w   convertFromBcd
		move.b  d0,(a2)+
		move.w  cddVersion(a5),(a2)+
		bra.s   loc_E4E
; ---------------------------------------------------------------------------

loc_E48:                ; CODE XREF: writeCddStatus+7Ej
		move.l  #$FFFFFFFF,(a2)+

loc_E4E:                ; CODE XREF: writeCddStatus+98j
		moveq   #$FFFFFFFF,d0
		btst    #5,byte_580E(a5)
		beq.s   loc_E5C
		move.l  cddLeadOutTime(a5),d0

loc_E5C:                ; CODE XREF: writeCddStatus+A8j
		move.l  d0,(a2)+
		movea.l a2,a0
		movem.l (sp)+,a2
		or.w    d1,d1
		rts
; End of function writeCddStatus


; =============== S U B R O U T I N E =======================================


validateTrackNumber:            ; CODE XREF: getCurrentTrackNumber+Cp
					; writeCddStatus+28p
		cmpi.b  #$AA,d0
		bcs.s   locret_E72
		move.b  cddLastTrack(a5),d0

locret_E72:             ; CODE XREF: validateTrackNumber+4j
		rts
; End of function validateTrackNumber


; =============== S U B R O U T I N E =======================================


sub_E74:                ; CODE XREF: BIOS:0000061Ap
	; Return if updater flag is already set
	bset    #0,byte_580A(a5)
	bne.w   locret_ECE

	; Return if bit 7 is cleared
	btst    #7,byte_580A(a5)
	beq.w   loc_EC8

	movem.l d7/a4,-(sp)

	bsr.w   sub_1084
	bsr.w   sub_ED0
	bcs.s   loc_EBE
	lea cddStatusCache(a5),a0
	clr.b   d0
	moveq   #4,d1

loc_E9E:                ; CODE XREF: sub_E74+2Ej
	add.b   (a0)+,d0
	add.b   (a0)+,d0
	dbf d1,loc_E9E
	not.b   d0
	andi.b  #$F,d0
	bne.s   loc_EBE
	bsr.w   sub_F4E
	bsr.w   sub_1084
	bsr.w   sub_12CE
	bsr.w   sendCddCommand

loc_EBE:                ; CODE XREF: sub_E74+20j sub_E74+38j
	movem.l (sp)+,d7/a4
	move.w  #$1E,word_5A02(a5)

loc_EC8:                ; CODE XREF: sub_E74+10j
	bclr    #0,byte_580A(a5)

locret_ECE:             ; CODE XREF: sub_E74+6j
	rts
; End of function sub_E74


; =============== S U B R O U T I N E =======================================


sub_ED0:                ; CODE XREF: sub_E74+1Cp
		bclr    #4,byte_580D(a5)
		bclr    #4,byte_580E(a5)
		move.w  #$100,d0

loc_EE0:                ; CODE XREF: sub_ED0+16j
		btst    #1,(GA_CDD_CONTROL).w
		dbeq    d0,loc_EE0
		bne.s   sub_F32
		lea cddStatusCache(a5),a0
		lea (GA_CDD_STATUS).w,a1
		move.l  (a1)+,(a0)+
		move.l  (a1)+,(a0)+
		move.w  (a1)+,(a0)+
		bset    #4,byte_580D(a5)
		bset    #4,byte_580E(a5)
		or.w    d1,d1
; End of function sub_ED0

loc_F08:                ; CODE XREF: sub_F32+Aj
		m_saveStatusRegister
		bclr    #4,byte_580A(a5)
		bclr    #2,byte_580A(a5)
		bne.s   loc_F2E
		btst    #0,(GA_CDD_CONTROL).w
		beq.s   loc_F28
		move.b  #4,(GA_CDD_CONTROL).w
		bra.s   loc_F2E
; ---------------------------------------------------------------------------

loc_F28:                ; CODE XREF: sub_F32-14j
		bset    #4,byte_580A(a5)

loc_F2E:                ; CODE XREF: sub_F32-1Cj sub_F32-Cj
		m_restoreConditionBits
		rts

; =============== S U B R O U T I N E =======================================


sub_F32:                ; CODE XREF: sub_ED0+1Aj

		move.b  #4,(GA_CDD_CONTROL).w
		move    #1,ccr
		bra.s   loc_F08
; End of function sub_F32


; =============== S U B R O U T I N E =======================================


sendCddCommand:             ; CODE XREF: sub_E74+46p
		lea cddCommandBuffer(a5),a0
		lea (GA_CDD_COMMAND).w,a1
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.w  (a0)+,(a1)+
		rts
; End of function sendCddCommand


; =============== S U B R O U T I N E =======================================


sub_F4E:                ; CODE XREF: sub_E74+3Ap
		btst    #4,byte_580D(a5)
		beq.s   locret_FB4
		andi.b  #$D0,byte_580D(a5)
		clr.b   byte_5810(a5)
		move.b  cddStatusCache(a5),d0
		move.b  d0,word_584E(a5)
		andi.w  #$F,d0
		add.w   d0,d0
		add.w   d0,d0
		jmp loc_F74(pc,d0.w)
; ---------------------------------------------------------------------------

loc_F74:
	bra.w   sub_FDC
; ---------------------------------------------------------------------------
	bra.w   sub_1010
; ---------------------------------------------------------------------------
	bra.w   sub_1000
; ---------------------------------------------------------------------------
	bra.w   loc_1014
; ---------------------------------------------------------------------------
	bra.w   sub_101C
; ---------------------------------------------------------------------------
	bra.w   loc_FB6
; ---------------------------------------------------------------------------
	bra.w   sub_1024
; ---------------------------------------------------------------------------
	bra.w   loc_103A
; ---------------------------------------------------------------------------
	bra.w   sub_1036
; ---------------------------------------------------------------------------
	bra.w   sub_1048
; ---------------------------------------------------------------------------
	bra.w   sub_1054
; ---------------------------------------------------------------------------
	bra.w   sub_105E
; ---------------------------------------------------------------------------
	bra.w   sub_106C
; ---------------------------------------------------------------------------
	bra.w   sub_1024
; ---------------------------------------------------------------------------
	bra.w   loc_FB6
; ---------------------------------------------------------------------------
	bra.w   sub_1024
; ---------------------------------------------------------------------------

locret_FB4:             ; CODE XREF: sub_F4E+6j
	rts
; ---------------------------------------------------------------------------

loc_FB6:                ; CODE XREF: sub_F4E+3Aj sub_F4E+5Ej
		clr.b   byte_5A05(a5)
		bclr    #6,byte_580D(a5)
		bset    #5,byte_580D(a5)
		clr.b   cddFirstTrack(a5)
		clr.b   cddLastTrack(a5)
		clr.l   cddLeadOutTime(a5)
		andi.b  #$9F,byte_580E(a5)
		bsr.w   sub_1074
; End of function sub_F4E


; =============== S U B R O U T I N E =======================================


sub_FDC:                ; CODE XREF: sub_F4E:loc_F74j
					; sub_105E+6p
		clr.l   cddAbsFrameTime(a5)
		bset    #0,byte_580F(a5)
		clr.l   cddRelFrameTime(a5)
		bset    #1,byte_580F(a5)
		clr.b   currentTrackNumber(a5)
		clr.b   byte_59F5(a5)
		bset    #2,byte_580F(a5)
		rts
; End of function sub_FDC


; =============== S U B R O U T I N E =======================================


sub_1000:               ; CODE XREF: sub_F4E+2Ej
		bsr.w   sub_1074
		st  byte_5810(a5)
		bset    #2,byte_580D(a5)
		rts
; End of function sub_1000


; =============== S U B R O U T I N E =======================================


sub_1010:               ; CODE XREF: sub_F4E+2Aj
		st  byte_5810(a5)

loc_1014:               ; CODE XREF: sub_F4E+32j
		bset    #2,byte_580D(a5)
		rts
; End of function sub_1010


; =============== S U B R O U T I N E =======================================


sub_101C:               ; CODE XREF: sub_F4E+36j
		bset    #2,byte_580D(a5)
		rts
; End of function sub_101C


; =============== S U B R O U T I N E =======================================


sub_1024:               ; CODE XREF: sub_F4E+3Ej sub_F4E+5Aj ...
		bset    #1,byte_580D(a5)
		andi.b  #$F8,byte_580F(a5)
		st  byte_5810(a5)
		rts
; End of function sub_1024


; =============== S U B R O U T I N E =======================================


sub_1036:               ; CODE XREF: sub_F4E+46j
		st  byte_5810(a5)

loc_103A:               ; CODE XREF: sub_F4E+42j
		bset    #0,byte_580D(a5)
		andi.b  #$F8,byte_580F(a5)
		rts
; End of function sub_1036


; =============== S U B R O U T I N E =======================================


sub_1048:               ; CODE XREF: sub_F4E+4Aj
		ori.b   #$48,byte_580D(a5) ; 'H'
		st  byte_5810(a5)
		rts
; End of function sub_1048


; =============== S U B R O U T I N E =======================================


sub_1054:               ; CODE XREF: sub_F4E+4Ej
		bset    #2,byte_580D(a5)
		bsr.s   sub_1074
		rts
; End of function sub_1054


; =============== S U B R O U T I N E =======================================


sub_105E:               ; CODE XREF: sub_F4E+52j
		bset    #5,byte_580D(a5)
		bsr.w   sub_FDC
		bsr.s   sub_1074
		rts
; End of function sub_105E


; =============== S U B R O U T I N E =======================================


sub_106C:               ; CODE XREF: sub_F4E+56j
		bset    #2,byte_580D(a5)
		rts
; End of function sub_106C


; =============== S U B R O U T I N E =======================================


sub_1074:               ; CODE XREF: sub_F4E+8Ap sub_1000p ...
		moveq   #$FFFFFFFF,d0
		move.l  d0,dword_59F8(a5)
		move.l  d0,dword_59FC(a5)
		move.w  d0,word_5A00(a5)
		rts
; End of function sub_1074


; =============== S U B R O U T I N E =======================================


sub_1084:               ; CODE XREF: sub_E74+18p sub_E74+3Ep
		btst    #4,byte_580E(a5)
		beq.s   locret_10E4
		lea cddStatusCache(a5),a4
		move.b  1(a4),d0
		andi.w  #$F,d0
		move.b  d0,word_584E+1(a5)
		add.w   d0,d0
		add.w   d0,d0
		jmp loc_10A4(pc,d0.w)
; ---------------------------------------------------------------------------

loc_10A4:
		bra.w   loc_113E
; ---------------------------------------------------------------------------
		bra.w   loc_118C
; ---------------------------------------------------------------------------
		bra.w   loc_11B8
; ---------------------------------------------------------------------------
		bra.w   sub_11F2
; ---------------------------------------------------------------------------
		bra.w   sub_1214
; ---------------------------------------------------------------------------
		bra.w   sub_1238
; ---------------------------------------------------------------------------
		bra.w   sub_1286
; ---------------------------------------------------------------------------
		bra.w   locret_10E4
; ---------------------------------------------------------------------------
		bra.w   locret_10E4
; ---------------------------------------------------------------------------
		bra.w   locret_10E4
; ---------------------------------------------------------------------------
		bra.w   locret_10E4
; ---------------------------------------------------------------------------
		bra.w   locret_10E4
; ---------------------------------------------------------------------------
		bra.w   locret_10E4
; ---------------------------------------------------------------------------
		bra.w   locret_10E4
; ---------------------------------------------------------------------------
		bra.w   locret_10E4
; ---------------------------------------------------------------------------
		bra.w   sub_12AE
; ---------------------------------------------------------------------------

locret_10E4:                ; CODE XREF: sub_1084+6j sub_1084+3Cj ...
		rts
; End of function sub_1084


; =============== S U B R O U T I N E =======================================


sub_10E6:               ; CODE XREF: BIOS:00001180p
					; BIOS:000011ACp
		move.b  0(a4),d1
		cmpi.b  #1,d1
		beq.s   loc_110A
		cmpi.b  #3,d1
		beq.s   loc_110A
		cmpi.b  #4,d1
		beq.s   loc_1102
		cmpi.b  #$C,d1
		bne.s   locret_110C

loc_1102:               ; CODE XREF: sub_10E6+14j
		cmpi.l  #$FFFFFFFF,(a1)
		bne.s   locret_110C

loc_110A:               ; CODE XREF: sub_10E6+8j sub_10E6+Ej
		move.l  d0,(a1)

locret_110C:                ; CODE XREF: sub_10E6+1Aj sub_10E6+22j
		rts
; End of function sub_10E6


; =============== S U B R O U T I N E =======================================


sub_110E:               ; CODE XREF: BIOS:000011C8p
		move.b  0(a4),d1
		cmpi.b  #1,d1
		beq.s   loc_1132
		cmpi.b  #3,d1
		beq.s   loc_1132
		cmpi.b  #4,d1
		beq.s   loc_112A
		cmpi.b  #$C,d1
		bne.s   locret_113C

loc_112A:               ; CODE XREF: sub_110E+14j
		cmpi.b  #$FF,word_5A00(a5)
		bne.s   locret_113C

loc_1132:               ; CODE XREF: sub_110E+8j sub_110E+Ej
		move.b  d0,word_5A00(a5)
		move.b  6(a4),word_5A00+1(a5)

locret_113C:                ; CODE XREF: sub_110E+1Aj sub_110E+22j
		rts
; End of function sub_110E

; ---------------------------------------------------------------------------

loc_113E:               ; CODE XREF: sub_1084:loc_10A4j
		btst    #1,byte_580E(a5)
		bne.s   locret_118A
		bclr    #4,byte_580E(a5)
		lea 2(a4),a0
		bsr.w   sub_11DA
		lsl.l   #8,d0
		move.b  (a0),d0
		move.l  d0,cddAbsFrameTime(a5)
		eor.b   d0,byte_580B(a5)
		btst    #1,byte_580B(a5)
		beq.s   loc_117C
		move.b  d0,byte_580B(a5)
		btst    #1,d0
		beq.s   loc_1178
		bsr.w   cddEnableDeemphasis
		bra.s   loc_117C
; ---------------------------------------------------------------------------

loc_1178:               ; CODE XREF: BIOS:00001170j
		bsr.w   cddDisableDeemphasis

loc_117C:               ; CODE XREF: BIOS:00001166j
					; BIOS:00001176j
		lea dword_59F8(a5),a1
		bsr.w   sub_10E6
		bset    #0,byte_580F(a5)

locret_118A:                ; CODE XREF: BIOS:00001144j
		rts
; ---------------------------------------------------------------------------

loc_118C:               ; CODE XREF: sub_1084+24j
		btst    #2,byte_580E(a5)
		bne.s   locret_11B6
		bclr    #4,byte_580E(a5)
		lea 2(a4),a0
		bsr.s   sub_11DA
		lsl.l   #8,d0
		move.b  (a0),d0
		move.l  d0,cddRelFrameTime(a5)
		lea dword_59FC(a5),a1
		bsr.w   sub_10E6
		bset    #1,byte_580F(a5)

locret_11B6:                ; CODE XREF: BIOS:00001192j
		rts
; ---------------------------------------------------------------------------

loc_11B8:               ; CODE XREF: sub_1084+28j
		bclr    #4,byte_580E(a5)
		lea 2(a4),a0
		bsr.s   loc_11EA
		move.b  d0,currentTrackNumber(a5)
		bsr.w   sub_110E
		move.b  6(a4),byte_59F5(a5)
		bset    #2,byte_580F(a5)
		rts

; =============== S U B R O U T I N E =======================================


sub_11DA:               ; CODE XREF: BIOS:00001150p
					; BIOS:0000119Ep ...
		move.b  (a0)+,d0
		lsl.b   #4,d0
		or.b    (a0)+,d0
		lsl.l   #8,d0
		move.b  (a0)+,d0
		lsl.b   #4,d0
		or.b    (a0)+,d0
		lsl.l   #8,d0

loc_11EA:               ; CODE XREF: BIOS:000011C2p
					; sub_1286+Ap
		move.b  (a0)+,d0
		lsl.b   #4,d0
		or.b    (a0)+,d0
		rts
; End of function sub_11DA


; =============== S U B R O U T I N E =======================================


sub_11F2:               ; CODE XREF: sub_1084+2Cj
		btst    #0,byte_580E(a5)
		bne.s   locret_1212
		bclr    #4,byte_580E(a5)
		lea 2(a4),a0
		bsr.s   sub_11DA
		lsl.l   #8,d0
		move.l  d0,cddLeadOutTime(a5)
		bset    #5,byte_580E(a5)

locret_1212:                ; CODE XREF: sub_11F2+6j
		rts
; End of function sub_11F2


; =============== S U B R O U T I N E =======================================


sub_1214:               ; CODE XREF: sub_1084+30j
		btst    #0,byte_580E(a5)
		bne.s   locret_1236
		bclr    #4,byte_580E(a5)
		lea 2(a4),a0
		bsr.s   sub_11DA
		lsl.l   #8,d0
		move.b  (a0),d0
		move.l  d0,cddFirstTrack(a5)
		bset    #6,byte_580E(a5)

locret_1236:                ; CODE XREF: sub_1214+6j
		rts
; End of function sub_1214


; =============== S U B R O U T I N E =======================================


sub_1238:               ; CODE XREF: sub_1084+34j
		btst    #0,byte_580E(a5)
		bne.s   locret_1284
		bclr    #4,byte_580E(a5)
		btst    #7,byte_580E(a5)
		beq.s   locret_1284
		move.b  byte_5819(a5),d0
		andi.w  #$F,d0
		cmp.b   8(a4),d0
		bne.s   locret_1284
		move.b  byte_5819(a5),d0
		bsr.w   convertFromBcd
		add.w   d0,d0
		add.w   d0,d0
		lea 2(a4),a0
		lea cddTocTable(a5),a1
		adda.w  d0,a1
		bsr.w   sub_11DA
		lsl.l   #8,d0
		move.b  byte_5819(a5),d0
		move.l  d0,(a1)+
		bclr    #7,byte_580E(a5)

locret_1284:                ; CODE XREF: sub_1238+6j sub_1238+14j ...
		rts
; End of function sub_1238


; =============== S U B R O U T I N E =======================================


sub_1286:               ; CODE XREF: sub_1084+38j
		bclr    #4,byte_580E(a5)
		lea 2(a4),a0
		bsr.w   loc_11EA
		move.b  d0,byte_59F6(a5)
		btst    #0,byte_580D(a5)
		beq.s   locret_12AC
		cmpi.b  #6,d0
		bcs.s   locret_12AC
		bset    #7,byte_5811(a5)

locret_12AC:                ; CODE XREF: sub_1286+18j sub_1286+1Ej
		rts
; End of function sub_1286


; =============== S U B R O U T I N E =======================================


sub_12AE:               ; CODE XREF: sub_1084+5Cj
		andi.b  #$F8,byte_580F(a5)
		rts
; End of function sub_12AE


; =============== S U B R O U T I N E =======================================


sub_12B6:               ; CODE XREF: sub_12CE+96p
		cmpi.b  #5,byte_5815(a5)
		beq.s   loc_12CA
		cmpi.b  #5,d0
		bne.s   loc_12CA
		move    #1,ccr
		bra.s   locret_12CC
; ---------------------------------------------------------------------------

loc_12CA:               ; CODE XREF: sub_12B6+6j sub_12B6+Cj
		or.w    d1,d1

locret_12CC:                ; CODE XREF: sub_12B6+12j
		rts
; End of function sub_12B6


; =============== S U B R O U T I N E =======================================


sub_12CE:               ; CODE XREF: sub_E74+42p
		btst    #7,byte_5811(a5)
		bne.w   loc_14F4
		lea byte_580C(a5),a0
		lea byte_580D(a5),a1
		bclr    #3,(a0)
		bne.w   loc_13AC
		btst    #0,(a1)
		beq.s   loc_1306
		btst    #2,(a0)
		beq.s   loc_1302
		move.b  (a0),d0
		andi.b  #$30,d0 ; '0'
		bne.s   loc_1302
		bset    #3,byte_580A(a5)

loc_1302:               ; CODE XREF: sub_12CE+24j sub_12CE+2Cj
		bra.w   loc_1518
; ---------------------------------------------------------------------------

loc_1306:               ; CODE XREF: sub_12CE+1Ej
		bclr    #3,byte_580A(a5)
		beq.s   loc_1316
		andi.b  #$CF,(a0)
		bra.w   loc_14B8
; ---------------------------------------------------------------------------

loc_1316:               ; CODE XREF: sub_12CE+3Ej
		bclr    #5,(a0)
		bne.s   loc_134A
		bclr    #4,(a0)
		beq.s   loc_1334
		btst    #1,(a1)
		bne.s   loc_132E
		btst    #0,(a1)
		beq.s   loc_134A

loc_132E:               ; CODE XREF: sub_12CE+58j
		subq.b  #1,byte_59F7(a5)
		bra.s   loc_134A
; ---------------------------------------------------------------------------

loc_1334:               ; CODE XREF: sub_12CE+52j
		btst    #4,byte_580A(a5)
		beq.w   loc_14D8
		btst    #1,(a1)
		bne.w   loc_14D8
		bclr    #1,(a0)

loc_134A:               ; CODE XREF: sub_12CE+4Cj sub_12CE+5Ej ...
		btst    #6,(a0)
		bne.w   loc_1652
		btst    #2,(a0)
		beq.s   loc_13BC
		bsr.w   sub_D14
		ror.w   #8,d0
		cmpi.b  #$B,d0
		beq.s   loc_1398
		bsr.w   sub_12B6
		bcs.s   loc_13A2
		move.b  byte_5815(a5),d1
		cmpi.b  #$FF,d1
		beq.s   loc_1380
		bclr    #7,d1
		beq.s   loc_137C
		lsr.w   #8,d0

loc_137C:               ; CODE XREF: sub_12CE+AAj
		cmp.b   d1,d0
		bne.s   loc_1386

loc_1380:               ; CODE XREF: sub_12CE+A4j
		bclr    #2,(a0)
		bra.s   loc_13BC
; ---------------------------------------------------------------------------

loc_1386:               ; CODE XREF: sub_12CE+B0j
		subq.w  #1,word_5816(a5)
		bcc.w   loc_1518
		bset    #1,byte_5811(a5)
		bra.w   loc_14F4
; ---------------------------------------------------------------------------

loc_1398:               ; CODE XREF: sub_12CE+94j
		bset    #6,byte_5811(a5)
		bra.w   loc_14F4
; ---------------------------------------------------------------------------

loc_13A2:               ; CODE XREF: sub_12CE+9Aj
		bset    #4,byte_5811(a5)
		bra.w   loc_14F4
; ---------------------------------------------------------------------------

loc_13AC:               ; CODE XREF: sub_12CE+16j
		andi.b  #9,(a0)
		andi.b  #$E7,byte_580A(a5)
		bclr    #7,byte_580E(a5)

loc_13BC:               ; CODE XREF: sub_12CE+88j sub_12CE+B6j ...
		bclr    #0,(a0)
		beq.w   loc_1518
		cmpi.w  #$200,word_582A(a5)
		bne.s   loc_13D8
		move.b  byte_582D(a5),d0
		cmpi.b  #5,d0
		beq.w   loc_1590

loc_13D8:               ; CODE XREF: sub_12CE+FCj
		lea word_582A(a5),a0
		move.b  0(a0),d0
		andi.w  #$F,d0
		move.b  byte_13F8(pc,d0.w),d1
		bpl.w   loc_146A
		andi.w  #7,d1
		add.w   d1,d1
		add.w   d1,d1
		jmp loc_1408(pc,d1.w)
; ---------------------------------------------------------------------------
byte_13F8:  dc.b $83
		dc.b 0
		dc.b $81
		dc.b 1
		dc.b 4
		dc.b $80
		dc.b 4
		dc.b $82
		dc.b 3
		dc.b 3
		dc.b $84
		dc.b 1
		dc.b 0
		dc.b 5
		dc.b $80
		dc.b $F
; ---------------------------------------------------------------------------

loc_1408:
		bra.w   loc_1442
; ---------------------------------------------------------------------------
		bra.w   loc_144A
; ---------------------------------------------------------------------------
		bra.w   loc_145A
; ---------------------------------------------------------------------------
		bra.w   loc_141E
; ---------------------------------------------------------------------------
		move.b  #4,d1
		bra.s   loc_146A
; ---------------------------------------------------------------------------

loc_141E:               ; CODE XREF: sub_12CE+146j
		move.b  #$FF,d1
		tst.l   cddStatusCache(a5)
		bne.s   loc_143C
		tst.l   cddStatusCache+4(a5)
		bne.s   loc_143C
		cmpi.w  #$F,cddStatusCache+8(a5)
		bne.s   loc_143C
		addq.b  #2,byte_5A04(a5)
		bra.s   loc_146A
; ---------------------------------------------------------------------------

loc_143C:               ; CODE XREF: sub_12CE+158j
					; sub_12CE+15Ej ...
		st  byte_5A04(a5)
		bra.s   loc_146A
; ---------------------------------------------------------------------------

loc_1442:               ; CODE XREF: sub_12CE:loc_1408j
		bsr.w   sub_D0E
		move.b  d0,d1
		bra.s   loc_146A
; ---------------------------------------------------------------------------

loc_144A:               ; CODE XREF: sub_12CE+13Ej
		move.b  3(a0),d1
		bset    #7,d1
		bset    #7,byte_580C(a5)
		bra.s   loc_146A
; ---------------------------------------------------------------------------

loc_145A:               ; CODE XREF: sub_12CE+142j
		bsr.w   sub_D0E
		move.b  #1,d1
		cmpi.b  #$C,d0
		bne.s   loc_146A
		move.b  d0,d1

loc_146A:               ; CODE XREF: sub_12CE+11Aj
					; sub_12CE+14Ej ...
		move.b  d1,byte_5815(a5)
		ori.b   #6,byte_580C(a5)
		move.w  #$2EE,word_5816(a5)
		move.b  #$4B,byte_5813(a5) ; 'K'
		move.b  #2,byte_5814(a5)
		bra.s   loc_1490
; ---------------------------------------------------------------------------

loc_1488:               ; CODE XREF: sub_12CE+212j
					; sub_12CE+246j ...
		btst    #0,byte_580D(a5)
		bne.s   loc_149A

loc_1490:               ; CODE XREF: sub_12CE+1B8j
		move.l  (a0),dword_5832(a5)
		move.l  4(a0),dword_5836(a5)

loc_149A:               ; CODE XREF: sub_12CE+1C0j
		lea cddCommandBuffer(a5),a1
		clr.b   d0
		moveq   #3,d1

loc_14A2:               ; CODE XREF: sub_12CE+1DCj
		add.b   (a0),d0
		move.b  (a0)+,(a1)+
		add.b   (a0),d0
		move.b  (a0)+,(a1)+
		dbf d1,loc_14A2
		not.b   d0
		andi.w  #$F,d0
		move.w  d0,(a1)
		rts
; ---------------------------------------------------------------------------

loc_14B8:               ; CODE XREF: sub_12CE+44j
		lea dword_5832(a5),a0
		cmpi.b  #$A,(a0)
		bne.s   loc_14D6
		movem.l d0-d1,-(sp)
		move.l  4(a0),d0
		move.b  3(a0),d1
		move.l  d0,4(a0)
		movem.l (sp)+,d0-d1

loc_14D6:               ; CODE XREF: sub_12CE+1F2j
		bra.s   loc_14DC
; ---------------------------------------------------------------------------

loc_14D8:               ; CODE XREF: sub_12CE+6Cj sub_12CE+74j
		lea cddCommandBuffer(a5),a0

loc_14DC:               ; CODE XREF: sub_12CE:loc_14D6j
		subq.b  #1,byte_5813(a5)
		bcc.s   loc_1488
		bset    #0,byte_5811(a5)
		bra.s   loc_14F4
; ---------------------------------------------------------------------------
		nop
		nop
		nop
		nop
		nop

loc_14F4:               ; CODE XREF: sub_12CE+6j sub_12CE+C6j ...
		clr.b   byte_580C(a5)
		bclr    #7,byte_580E(a5)
		andi.b  #$E7,byte_580A(a5)
		lea dword_5822(a5),a0
		move.l  #$1000000,0(a0)
		clr.l   4(a0)
		bra.w   loc_1488
; ---------------------------------------------------------------------------

loc_1518:               ; CODE XREF: sub_12CE:loc_1302j
					; sub_12CE+BCj ...
		btst    #7,byte_580C(a5)
		bne.s   loc_1576
		btst    #2,byte_580D(a5)
		beq.s   loc_1576
		tst.b   byte_580F(a5)
		beq.s   loc_1576
		addq.b  #1,byte_59F7(a5)
		moveq   #0,d0
		move.b  byte_59F7(a5),d0
		cmpi.b  #3,d0
		bcs.s   loc_1544
		moveq   #0,d0
		move.b  d0,byte_59F7(a5)

loc_1544:               ; CODE XREF: sub_12CE+26Ej
		lsl.w   #3,d0
		jmp loc_154A(pc,d0.w)
; ---------------------------------------------------------------------------

loc_154A:
		move.l  #$2000000,d0
		bra.s   loc_1560
; ---------------------------------------------------------------------------
		move.l  #$2000001,d0
		bra.s   loc_1560
; ---------------------------------------------------------------------------
		move.l  #$2000002,d0

loc_1560:               ; CODE XREF: sub_12CE+282j
					; sub_12CE+28Aj
		bset    #4,byte_580C(a5)
		lea dword_5822(a5),a0
		move.l  d0,0(a0)
		clr.l   4(a0)
		bra.w   loc_1488
; ---------------------------------------------------------------------------

loc_1576:               ; CODE XREF: sub_12CE+250j
					; sub_12CE+258j ...
		bset    #5,byte_580C(a5)
		lea dword_5822(a5),a0
		move.l  #0,0(a0)
		clr.l   4(a0)
		bra.w   loc_1488
; ---------------------------------------------------------------------------

loc_1590:               ; CODE XREF: sub_12CE+106j
		bset    #6,byte_580C(a5)
		clr.b   byte_5819(a5)
		move.w  word_582E(a5),d0
		lsl.b   #4,d0
		lsr.w   #4,d0
		bclr    #7,d0
		beq.s   loc_15AE
		bset    #1,byte_580A(a5)

loc_15AE:               ; CODE XREF: sub_12CE+2D8j
		move.b  d0,byte_581A(a5)
		move.w  word_5830(a5),d0
		lsl.b   #4,d0
		lsr.w   #4,d0
		move.b  d0,byte_581B(a5)
		ori.b   #$84,byte_580C(a5)
		bclr    #0,byte_580C(a5)
		btst    #6,byte_580E(a5)
		beq.s   loc_15F0
		btst    #5,byte_580E(a5)
		beq.s   loc_15F0
		move.b  $584E(a5),d0
		cmpi.b  #1,d0
		beq.s   loc_1632
		cmpi.b  #4,d0
		beq.s   loc_1632
		cmpi.b  #$C,d0
		beq.s   loc_1632

loc_15F0:               ; CODE XREF: sub_12CE+302j
					; sub_12CE+30Aj
		andi.b  #$9F,byte_580E(a5)
		lea cddTocTable(a5),a0
		move.l  #$20000,d0
		moveq   #9,d1

loc_1602:               ; CODE XREF: sub_12CE+348j
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		dbf d1,loc_1602
		move.b  #0,byte_5818(a5)
		lea dword_5822(a5),a0
		move.l  #$2000004,0(a0)
		clr.l   4(a0)
		bra.s   loc_1636
; ---------------------------------------------------------------------------

loc_1632:               ; CODE XREF: sub_12CE+314j
					; sub_12CE+31Aj ...
		bra.w   loc_16E0
; ---------------------------------------------------------------------------

loc_1636:               ; CODE XREF: sub_12CE+362j
					; sub_12CE+3FEj ...
		move.w  #$5DC,word_581C(a5)
		move.b  #$4B,byte_5813(a5) ; 'K'
		move.b  #2,byte_5814(a5)
		bset    #1,byte_580C(a5)
		bra.w   loc_1488
; ---------------------------------------------------------------------------

loc_1652:               ; CODE XREF: sub_12CE+80j
		move.b  byte_5818(a5),d0
		andi.w  #3,d0
		add.w   d0,d0
		add.w   d0,d0
		jmp loc_1662(pc,d0.w)
; ---------------------------------------------------------------------------

loc_1662:
		bra.w   loc_16AE
; ---------------------------------------------------------------------------
		bra.w   loc_16D0
; ---------------------------------------------------------------------------
		bra.w   loc_174C
; ---------------------------------------------------------------------------
		bra.w   loc_17DA
; ---------------------------------------------------------------------------

loc_1672:               ; CODE XREF: sub_12CE+3E6j
					; sub_12CE+408j ...
		btst    #5,byte_580D(a5)
		bne.s   loc_169A
		subq.w  #1,word_581C(a5)
		bcc.w   loc_1518
		cmpi.b  #2,byte_5818(a5)
		bne.s   loc_16A4
		bset    #5,byte_5811(a5)
		bclr    #7,byte_580E(a5)
		bra.w   loc_174C
; ---------------------------------------------------------------------------

loc_169A:               ; CODE XREF: sub_12CE+3AAj
		bset    #6,byte_5811(a5)
		bra.w   loc_14F4
; ---------------------------------------------------------------------------

loc_16A4:               ; CODE XREF: sub_12CE+3BAj
		bset    #2,byte_5811(a5)
		bra.w   loc_14F4
; ---------------------------------------------------------------------------

loc_16AE:               ; CODE XREF: sub_12CE:loc_1662j
		btst    #6,byte_580E(a5)
		beq.s   loc_1672
		move.b  #1,byte_5818(a5)
		lea dword_5822(a5),a0
		move.l  #$2000003,0(a0)
		clr.l   4(a0)
		bra.w   loc_1636
; ---------------------------------------------------------------------------

loc_16D0:               ; CODE XREF: sub_12CE+398j
		btst    #5,byte_580E(a5)
		beq.s   loc_1672
		btst    #3,byte_580D(a5)
		beq.s   loc_1672

loc_16E0:               ; CODE XREF: sub_12CE:loc_1632j
		move.b  #2,byte_5818(a5)
		movem.l a0,-(sp)
		lea cddLastTrack(a5),a0
		move.b  byte_581A(a5),d0
		cmp.b   (a0),d0
		bls.s   loc_16F8
		move.b  (a0),d0

loc_16F8:               ; CODE XREF: sub_12CE+426j
		lea cddFirstTrack(a5),a0
		cmp.b   (a0),d0
		bcc.s   loc_1702
		move.b  (a0),d0

loc_1702:               ; CODE XREF: sub_12CE+430j
		move.b  d0,byte_581A(a5)
		move.b  d0,byte_5819(a5)
		move.b  byte_581B(a5),d0
		cmp.b   (a0),d0
		bcc.s   loc_1714
		move.b  (a0),d0

loc_1714:               ; CODE XREF: sub_12CE+442j
		lea cddLastTrack(a5),a0
		cmp.b   (a0),d0
		bls.s   loc_171E
		move.b  (a0),d0

loc_171E:               ; CODE XREF: sub_12CE+44Cj
		move.b  d0,byte_581B(a5)
		movem.l (sp)+,a0

loc_1726:               ; CODE XREF: sub_12CE+4B4j
		bset    #7,byte_580E(a5)
		lea dword_5822(a5),a0
		move.l  #$2000005,0(a0)
		moveq   #0,d0
		move.b  byte_5819(a5),d0
		lsl.w   #4,d0
		lsr.b   #4,d0
		swap    d0
		move.l  d0,4(a0)
		bra.w   loc_1636
; ---------------------------------------------------------------------------

loc_174C:               ; CODE XREF: sub_12CE+39Cj
					; sub_12CE+3C8j
		cmpi.b  #0,word_584E(a5)
		bne.s   loc_175E
		bset    #3,byte_5811(a5)
		bra.w   loc_14F4
; ---------------------------------------------------------------------------

loc_175E:               ; CODE XREF: sub_12CE+484j
		btst    #7,byte_580E(a5)
		bne.w   loc_1672
		move.b  byte_5819(a5),d0
		cmp.b   byte_581B(a5),d0
		bcc.s   loc_1784
		move.b  byte_5819(a5),d0
		moveq   #1,d1
		move    #4,ccr
		abcd    d1,d0
		move.b  d0,byte_5819(a5)
		bra.s   loc_1726
; ---------------------------------------------------------------------------

loc_1784:               ; CODE XREF: sub_12CE+4A2j
		move.b  #3,byte_5818(a5)
		bclr    #1,byte_580A(a5)
		bne.s   loc_17C6
		moveq   #1,d0
		bsr.w   sub_CAC
		tst.b   d0
		beq.s   loc_17B2
		move.w  #$400,dword_5822(a5)
		lea dword_5822+2(a5),a1
		bsr.w   sub_C34
		lea dword_5822(a5),a0
		bra.w   loc_1636
; ---------------------------------------------------------------------------

loc_17B2:               ; CODE XREF: sub_12CE+4CCj
		lea dword_5822(a5),a0
		move.l  #$6000000,0(a0)
		clr.l   4(a0)
		bra.w   loc_1636
; ---------------------------------------------------------------------------

loc_17C6:               ; CODE XREF: sub_12CE+4C2j
		lea dword_5822(a5),a0
		move.l  #$7000000,0(a0)
		clr.l   4(a0)
		bra.w   loc_1636
; ---------------------------------------------------------------------------

loc_17DA:               ; CODE XREF: sub_12CE+3A0j
		btst    #3,byte_580D(a5)
		bne.w   loc_1672
		andi.b  #$3B,byte_580C(a5) ; ';'
		bra.w   loc_13BC
; End of function sub_12CE


; =============== S U B R O U T I N E =======================================


sub_17EE:               ; CODE XREF: BIOS:000005FCp
	subq.w #1, word_5A02(a5)
	bcc.s @locret_1806

	; Watchdog counter hit -1, set the error flag
	bset #2, byte_580A(a5)
	move.w #$1E, word_5A02(a5)

	; HOCK on, abort CDD transfers
	move.b #4, (GA_CDD_CONTROL).w

@locret_1806:
	rts
; End of function sub_17EE


; =============== S U B R O U T I N E =======================================


sub_1808:               ; CODE XREF: BIOS:00003720p
		movem.l a4,-(sp)
		lea $5A44(a5),a4
		move.w  6(a4),4(a4)
		movem.l (sp)+,a4
		rts
; End of function sub_1808


; =============== S U B R O U T I N E =======================================


_cdcstat:               ; CODE XREF: sub_2946+36j
					; BIOS:loc_3744p
		move.w  cdcBitfield0(a5),d0
		movem.l d0/a4,-(sp)
		lea $5A44(a5),a4
		move.w  6(a4),d0
		cmp.w   4(a4),d0
		beq.s   loc_1836
		or.w    d1,d1
		bra.s   loc_183A
; ---------------------------------------------------------------------------

loc_1836:               ; CODE XREF: _cdcstat+14j
		move    #1,ccr

loc_183A:               ; CODE XREF: _cdcstat+18j
		movem.l (sp)+,d0/a4
		rts
; End of function _cdcstat


; =============== S U B R O U T I N E =======================================


sub_1840:               ; CODE XREF: sub_2946+A8p
		move.l  cdcFrameHeader(a5),d0
		rts
; End of function sub_1840


; =============== S U B R O U T I N E =======================================


_cdcread:               ; CODE XREF: sub_2946+3Aj
		movem.l a3-a4,-(sp)
		move    #1,ccr

		m_saveStatusRegister
		move    #$2500,sr

		; Return if words @ 4 and 6 are equal
		lea $5A44(a5),a4
		move.w  6(a4),d0
		cmp.w   4(a4),d0
		beq.s   loc_18CE

		btst    #5,cdcBitfield0(a5)
		bne.s   loc_1870

		bsr.w   sub_7AA
		bra.s   loc_1876
; ---------------------------------------------------------------------------

loc_1870:               ; CODE XREF: _cdcread+22j _cdcread+2Ej
		bsr.w   sub_7AA
		bne.s   loc_1870

loc_1876:               ; CODE XREF: _cdcread+28j
		move.w  4(a0),d1
		ror.w   #8,d1
		move.w  #$92F,d0

		; Check CD data mode
		btst    #3,cdcBitfield0(a5)
		bne.s   loc_18A4

; CD Mode 1
loc_1888:
		move.w  #$803,d0

		; Check CDC device destination
		btst    #2,(GA_CDC_TRANSFER).w
		beq.s   loc_1898

		; Only if a DMA mode is selected
		subq.w  #4,d0
		addq.w  #4,d1

loc_1898:               ; CODE XREF: _cdcread+4Cj
		; Check for error detection/correction data
		btst    #2,cdcBitfield0(a5)
		beq.s   loc_18A4

		; Add 288 bytes for EDC data
		addi.w  #$120,d0

; CD Mode 2
loc_18A4:               ; CODE XREF: _cdcread+40j _cdcread+58j
		; Send transfer information to the CDC
		lea (GA_CDC_REGISTER).w,a3
		move.b  #CDC_WRITE_DBCL,(GA_CDC_ADDRESS).w
		move.b  d0,(a3) ; DBCL
		lsr.w   #8,d0
		move.b  d0,(a3) ; DBCH
		move.b  d1,(a3) ; DACL
		lsr.w   #8,d1
		move.b  d1,(a3) ; DACH
		move.b  #0,(a3) ; DTTRG

		; Set transfer flag
		bset    #1,cdcBitfield0(a5)

		andi.w  #$FF00,(sp)
		move.l  (a0),d0
		move.w  6(a0),d1

loc_18CE:               ; CODE XREF: _cdcread+1Aj
		m_restoreStatusRegister
		movem.l (sp)+,a3-a4
		rts
; End of function _cdcread


; =============== S U B R O U T I N E =======================================


sub_18D6:               ; CODE XREF: sub_18D6+20j _cdctrn+2Cp ...
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		dbf d1,sub_18D6
		rts
; End of function sub_18D6


; =============== S U B R O U T I N E =======================================


_cdctrn:                ; CODE XREF: sub_2946+3Ej
		movem.l a2-a3,-(sp)

		lea (GA_CDC_DATA).w,a2
		lea (GA_CDC_TRANSFER).w,a3

		; Wait for CDC to signal data ready
		move.w  #$800,d1
		loc_190C:
			btst    #6,(a3)
			dbne    d1,loc_190C

		; Timed out, raise error condition
		beq.s   loc_197A

		; Check CD data mode
		btst    #3,cdcBitfield0(a5)
		bne.s   loc_193E

; Read Mode 1 frame
loc_191E:
		; Read 4 header bytes
		move.w  (a2),(a1)+
		nop
		move.w  (a2),(a1)+

		; Read 2048 data bytes
		move.w  #$7F,d1 ; ''
		bsr.s   sub_18D6

		; Check for error detection data
		btst    #2,cdcBitfield0(a5)
		beq.s   loc_1938

		; Read 288 error correction/detection bytes
		move.w  #$11,d1
		bsr.s   sub_18D6

loc_1938:               ; CODE XREF: _cdctrn+34j _cdctrn+6Cj
		move.w  #$800,d1
		bra.s   loc_196C
; ---------------------------------------------------------------------------

; Read Mode 2 frame
loc_193E:               ; CODE XREF: _cdctrn+20j
		; Read 4 header bytes
		move.w  (a2),d0
		move.w  d0,(a1)+
		move.w  d0,(a0)+
		move.w  (a2),d0
		move.w  d0,(a1)+
		move.w  d0,(a0)+

		; Read 12 sync(?) bytes
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+
		nop
		move.w  (a2),(a0)+

		; Read 2336 data bytes
		move.w  #$91,d1 ; '‘'
		bsr.w   sub_18D6

		bra.s   loc_1938
; ---------------------------------------------------------------------------

; Eat any extra data the CDC gives us
loc_196A:               ; CODE XREF: _cdctrn+74j
		move.w  (a2),d0

loc_196C:               ; CODE XREF: _cdctrn+40j
		btst    #7,(a3)
		dbne    d1,loc_196A

		; Timed out, raise error condition
		beq.s   loc_197A

		or.w    d1,d1
		bra.s   loc_19A2
; ---------------------------------------------------------------------------

loc_197A:               ; CODE XREF: _cdctrn+18j _cdctrn+78j
		m_saveStatusRegister
		move    #$2500,sr

		move.b  #CDC_WRITE_IFCTRL,(GA_CDC_ADDRESS).w
		move.b  #$38,(GA_CDC_REGISTER).w ; '8'

		move.b  #CDC_WRITE_IFCTRL,(GA_CDC_ADDRESS).w
		move.b  #$3A,(GA_CDC_REGISTER).w ; ':'

		m_restoreStatusRegister
		nop
		nop
		move    #1,ccr

loc_19A2:               ; CODE XREF: _cdctrn+7Cj
		movem.l (sp)+,a2-a3
		rts
; End of function _cdctrn


; =============== S U B R O U T I N E =======================================


_cdcack:                ; CODE XREF: sub_2946+42j
	m_saveStatusRegister
	move #$2500, sr

	move.b #CDC_WRITE_DTACK, (GA_CDC_ADDRESS).w
	move.b #0, (GA_CDC_REGISTER).w

	bclr #1, cdcBitfield0(a5)

	m_restoreStatusRegister
	rts
; End of function _cdcack


; =============== S U B R O U T I N E =======================================


sub_19C4:               ; CODE XREF: BIOS:loc_3832p
		bclr    #7,cdcBitfield0(a5)
		; Return if bit 7 was already clear
		beq.s   @locret_19D2

		bset    #6,cdcBitfield0(a5)

@locret_19D2:                ; CODE XREF: sub_19C4+6j
		rts
; End of function sub_19C4


; =============== S U B R O U T I N E =======================================


sub_19D4:               ; CODE XREF: BIOS:loc_3890p
		bclr    #6,cdcBitfield0(a5)
		; Return if bit 6 was already clear
		beq.s   @locret_19E2

		bset    #7,cdcBitfield0(a5)

@locret_19E2:                ; CODE XREF: sub_19D4+6j
		rts
; End of function sub_19D4


; =============== S U B R O U T I N E =======================================


_cdcsetmode:                ; CODE XREF: sub_2946+66j
		m_saveStatusRegister
		move    #$2500,sr

		andi.w  #$F,d1
		lsl.w   #2,d1
		andi.b  #$C3,cdcBitfield0(a5)
		or.b    d1,cdcBitfield0(a5)

		m_restoreStatusRegister
		rts
; End of function _cdcsetmode


; =============== S U B R O U T I N E =======================================


updateCdc:              ; CODE XREF: BIOS:0000063Ep
	; Return if updater flag is already set
	bset    #0,cdcBitfield0(a5)
	bne.s   locret_1A5C

	; Return if bit 7 is cleared
	btst    #7,cdcBitfield0(a5)
	beq.s   loc_1A56

	movem.l d5-d7/a2-a4,-(sp)

	; Copy header/status data from CDC to RAM
	lea (GA_CDC_ADDRESS).w,a2
	lea (GA_CDC_REGISTER).w,a3
	lea cdcStatus(a5),a0
	move.b #CDC_READ_IFSTAT,(a2)
	move.b (a3),(a0)+   ; IFSTAT
	addq.w #1,a0
	move.b #CDC_READ_HEAD0,(a2)
	move.b (a3),(a0)+   ; HEAD0
	move.b (a3),(a0)+   ; HEAD1
	move.b (a3),(a0)+   ; HEAD2
	move.b (a3),(a0)+   ; HEAD3
	move.b (a3),(a0)+   ; PTL
	move.b (a3),(a0)+   ; PTH
	move.b #CDC_READ_STAT0,(a2)
	move.b (a3),(a0)+   ; STAT0
	move.b (a3),(a0)+   ; STAT1
	move.b (a3),(a0)+   ; STAT2
	move.b (a3),(a0)+   ; STAT3

	movem.l cdcRegisterCache(a5),d5-a0/a2-a4
	jmp (a0)
; End of function updateCdc


; =============== S U B R O U T I N E =======================================


sub_1A4A:               ; CODE XREF: initCdc:loc_1AA4p
					; _cdcstart:loc_1B54p ...
	movea.l (sp)+,a0
	movem.l d5-a0/a2-a4,cdcRegisterCache(a5)
	movem.l (sp)+,d5-d7/a2-a4

loc_1A56:
	; Done with update, clear busy flag
	bclr #0, cdcBitfield0(a5)

locret_1A5C:
	rts
; End of function sub_1A4A


; =============== S U B R O U T I N E =======================================

; Attributes: noreturn

initCdc:                ; CODE XREF: BIOS:00000352p
		movem.l d5-d7/a2-a4,-(sp)
		lea (GA_CDC_ADDRESS).w,a2
		lea (GA_CDC_REGISTER).w,a3
		bsr.w   resetCdc
		lea cdcBitfield0(a5),a0
		moveq   #0,d0
		moveq   #6,d1

loc_1A76:               ; CODE XREF: initCdc+20j
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		dbf d1,loc_1A76
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		move.w  d0,(a0)
		move.l  #$80008,d0
		move.l  #$80030,d1
		movea.l #'CDCD',a0
		lea $5A44(a5),a4
		bsr.w   sub_73C

loc_1AA4:               ; CODE XREF: initCdc+48j
					; _cdcstart+188j
		bsr.s   sub_1A4A
		bra.w   loc_1AA4
; End of function initCdc


; =============== S U B R O U T I N E =======================================


_cdcstop:               ; CODE XREF: sub_2946+32j
					; BIOS:00002BF6p ...
		bclr    #7,cdcBitfield0(a5)
		beq.s   locret_1AE6

abortCdcTransfer:           ; CODE XREF: _cdcstart+1Ap
		bclr    #1,cdcBitfield0(a5)
		bclr    #5,(GA_INT_MASK).w

		move.b  #CDC_WRITE_IFCTRL,(GA_CDC_ADDRESS).w
		move.b  #$38,(GA_CDC_REGISTER).w

		move.b  #CDC_WRITE_IFCTRL,(GA_CDC_ADDRESS).w
		move.b  #$3A,(GA_CDC_REGISTER).w

		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop

locret_1AE6:                ; CODE XREF: _cdcstop+6j
		rts
; End of function _cdcstop


; =============== S U B R O U T I N E =======================================

; Attributes: noreturn

_cdcstart:              ; CODE XREF: sub_2946+2Aj
		move.l  #$FFFFFFF,d0
		bra.s   loc_1AFC
; ---------------------------------------------------------------------------

_cdcstartp:             ; CODE XREF: sub_2946+2Ej
		ori.l   #$FFFFFFF0,d1
		ror.w   #4,d1
		swap    d1
		move.l  d1,d0

loc_1AFC:               ; CODE XREF: _cdcstart+6j
		moveq   #$FFFFFFFF,d1

loc_1AFE:               ; CODE XREF: sub_3728+12p
		movem.l d5-d7/a2-a4,-(sp)
		bsr.s   abortCdcTransfer
		move.l  d1,dword_5A34(a5)
		rol.l   #4,d0
		move.l  d0,d1
		asr.l   #4,d0
		move.l  d0,dword_5A2C(a5)
		move.l  d0,dword_5A30(a5)
		andi.b  #$F,d1
		lsl.b   #2,d1
		ori.b   #$81,d1
		move.b  d1,cdcBitfield0(a5)
		clr.b   cdcBitfield1(a5)
		lea (GA_CDC_ADDRESS).w,a2
		lea (GA_CDC_REGISTER).w,a3
		bsr.w   resetCdc
		lea $5A44(a5),a4
		move.w  6(a4),4(a4)
		bset    #5,(GA_INT_MASK).w
		bsr.w   sub_1CE6
		move.w  #$1E,d7
		move.w  #5,d6
		move.w  #5,d5

loc_1B54:               ; CODE XREF: _cdcstart+9Cj
		bsr.w   sub_1A4A
		btst    #3,cdcBitfield0(a5)
		beq.s   loc_1B6E
		move.b  $5A41(a5),d0
		andi.b  #$C0,d0
		sne $5A39(a5)
		bra.s   loc_1B86
; ---------------------------------------------------------------------------

loc_1B6E:               ; CODE XREF: _cdcstart+76j
		bsr.w   sub_1CF4
		bcs.s   loc_1B7A
		bsr.w   sub_1D52
		bcc.s   loc_1B86

loc_1B7A:               ; CODE XREF: _cdcstart+8Aj
		btst    #7,cdcBitfield1(a5)
		bne.w   loc_1C66
		bra.s   loc_1B54
; ---------------------------------------------------------------------------

loc_1B86:               ; CODE XREF: _cdcstart+84j
					; _cdcstart+90j
		move.b  #CDC_WRITE_CTRL0,(a2)
		move.b  #$A4,(a3)
		move.b  #$D8,(a3)
		move.w  #$1E,d7

loc_1B96:               ; CODE XREF: _cdcstart+C2j
		bsr.w   sub_1A4A
		btst    #3,cdcBitfield0(a5)
		bne.s   loc_1BBA
		move.b  cdcStat0(a5),d0
		andi.b  #$68,d0 ; 'h'
		dbeq    d7,loc_1B96
		beq.s   loc_1BBA
		bset    #7,cdcBitfield1(a5)
		bra.w   loc_1C66
; ---------------------------------------------------------------------------

loc_1BBA:               ; CODE XREF: _cdcstart+B8j
					; _cdcstart+C6j
		move.w  #$1E,d7
		move.w  #5,d6
		move.w  #5,d5
		move.b  cdcBitfield0(a5),d0
		andi.b  #$C,d0
		beq.s   loc_1C26
		btst    #3,cdcBitfield0(a5)
		beq.s   loc_1C00

loc_1BD8:               ; CODE XREF: _cdcstart+112j
		clr.l   dword_5A30(a5)
		bsr.w   sub_1A4A
		bsr.w   sub_1D34
		bcs.s   loc_1BF4
		bsr.w   sub_1E44
		bcs.s   loc_1BF4
		bsr.w   sub_1E6A
		bcc.w   loc_1C66

loc_1BF4:               ; CODE XREF: _cdcstart+FCj
					; _cdcstart+102j
		btst    #7,cdcBitfield1(a5)
		beq.s   loc_1BD8
		bra.w   loc_1C66
; ---------------------------------------------------------------------------

loc_1C00:               ; CODE XREF: _cdcstart+EEj
					; _cdcstart+13Aj
		bsr.w   sub_1A4A
		bsr.w   sub_1CF4
		bcs.s   loc_1C1C
		bsr.w   sub_1DB0
		bcs.s   loc_1C1C
		bsr.w   sub_1E44
		bcs.s   loc_1C1C
		bsr.w   sub_1E6A
		bcc.s   loc_1C66

loc_1C1C:               ; CODE XREF: _cdcstart+120j
					; _cdcstart+126j ...
		btst    #7,cdcBitfield1(a5)
		beq.s   loc_1C00
		bra.s   loc_1C66
; ---------------------------------------------------------------------------

loc_1C26:               ; CODE XREF: _cdcstart+E6j
		move.b  #CDC_WRITE_CTRL0,(a2)
		move.b  #$A7,(a3)
		move.b  #$F0,(a3)

loc_1C32:               ; CODE XREF: _cdcstart+17Cj
					; _cdcstart+1CEj
		bsr.w   sub_1A4A
		bsr.w   sub_1CF4
		bcs.s   loc_1C5E
		bsr.w   sub_1DB0
		bcs.s   loc_1C5E
		bclr    #1,cdcBitfield1(a5)
		bsr.w   sub_1DF6
		bcs.s   loc_1C56
		bsr.w   sub_1E6A
		bcs.s   loc_1C5E
		bra.s   loc_1C66
; ---------------------------------------------------------------------------

loc_1C56:               ; CODE XREF: _cdcstart+164j
		btst    #1,cdcBitfield1(a5)
		bne.s   loc_1C74

loc_1C5E:               ; CODE XREF: _cdcstart+152j
					; _cdcstart+158j ...
		btst    #7,cdcBitfield1(a5)
		beq.s   loc_1C32

loc_1C66:               ; CODE XREF: _cdcstart+98j
					; _cdcstart+CEj ...
		bsr.w   sub_1CE6
		bset    #0,cdcBitfield1(a5)
		bra.w   loc_1AA4
; ---------------------------------------------------------------------------

loc_1C74:               ; CODE XREF: _cdcstart+174j
		move.b  #CDC_WRITE_CTRL0,(a2)
		move.b  #$A3,(a3)
		move.b  #$B0,(a3)
		move.w  #$1E,d7
		move.w  #5,d6
		move.w  #5,d5

loc_1C8C:               ; CODE XREF: _cdcstart+1BEj
		bsr.w   sub_1A4A
		bsr.w   sub_1CF4
		bcs.s   loc_1CB0
		move.w  #5,d5
		bsr.w   sub_1DF6
		bcs.s   loc_1CB0
		btst    #1,cdcBitfield1(a5)
		dbeq    d6,loc_1C8C

loc_1CAA:
		bsr.w   sub_1E6A
		bcc.s   loc_1C66

loc_1CB0:               ; CODE XREF: _cdcstart+1ACj
					; _cdcstart+1B6j
		btst    #7,cdcBitfield1(a5)
		beq.w   loc_1C32
		bra.s   loc_1C66
; End of function _cdcstart


; =============== S U B R O U T I N E =======================================


resetCdc:               ; CODE XREF: initCdc+Cp _cdcstart+48p
		move.b  #CDC_WRITE_RESET,(a2)
		move.b  #0,(a3)

		move.b  #CDC_WRITE_IFCTRL,(a2)
		move.b  #$3A,(a3)

		move.b  #CDC_WRITE_WAL,(a2)
		move.b  #0,(a3)
		move.b  #0,(a3)

		move.b  #CDC_WRITE_PTL,(a2)
		move.b  #0,(a3)
		move.b  #0,(a3)
		rts
; End of function resetCdc


; =============== S U B R O U T I N E =======================================


sub_1CE6:               ; CODE XREF: _cdcstart+5Cp
					; _cdcstart:loc_1C66p
		move.b  #CDC_WRITE_CTRL0,(a2)
		move.b  #$A0,(a3)
		move.b  #$F8,(a3)
		rts
; End of function sub_1CE6


; =============== S U B R O U T I N E =======================================


sub_1CF4:               ; CODE XREF: _cdcstart:loc_1B6Ep
					; _cdcstart+11Cp ...
		btst    #7,$5A43(a5)
		bne.s   loc_1D1E
		btst    #5,cdcStat0(a5)
		beq.s   loc_1D10
		subq.w  #1,d5
		bcc.s   loc_1D14
		bset    #3,cdcBitfield1(a5)
		bra.s   loc_1D28
; ---------------------------------------------------------------------------

loc_1D10:               ; CODE XREF: sub_1CF4+Ej
		move.w  #5,d5

loc_1D14:               ; CODE XREF: sub_1CF4+12j
		move.b  $5A41(a5),d0
		andi.b  #$F0,d0
		beq.s   locret_1D32

loc_1D1E:               ; CODE XREF: sub_1CF4+6j
		subq.w  #1,d7
		bcc.s   loc_1D2E
		bset    #2,cdcBitfield1(a5)

loc_1D28:               ; CODE XREF: sub_1CF4+1Aj
		bset    #7,cdcBitfield1(a5)

loc_1D2E:               ; CODE XREF: sub_1CF4+2Cj
		move    #1,ccr

locret_1D32:                ; CODE XREF: sub_1CF4+28j
		rts
; End of function sub_1CF4


; =============== S U B R O U T I N E =======================================


sub_1D34:               ; CODE XREF: _cdcstart+F8p
		btst    #7,$5A43(a5)
		beq.s   locret_1D50
		subq.w  #1,d7
		bcc.s   loc_1D4C
		bset    #2,cdcBitfield1(a5)
		bset    #7,cdcBitfield1(a5)

loc_1D4C:               ; CODE XREF: sub_1D34+Aj
		move    #1,ccr

locret_1D50:                ; CODE XREF: sub_1D34+6j
		rts
; End of function sub_1D34


; =============== S U B R O U T I N E =======================================


sub_1D52:               ; CODE XREF: _cdcstart+8Cp
		move.l  cdcFrameHeader(a5),d0
		bsr.w   sub_7EE
		move.l  d0,dword_5A28(a5)
		move.l  dword_5A2C(a5),d1
		cmpi.l  #$FFFFFFFF,d1
		beq.s   loc_1D84
		sub.l   d0,d1
		bls.s   loc_1D8E
		cmpi.l  #4,d1
		bls.s   loc_1D8A
		cmpi.l  #$4B,d1 ; 'K'
		bcc.s   loc_1D9A
		move.w  #5,d6
		bra.s   loc_1DAA
; ---------------------------------------------------------------------------

loc_1D84:               ; CODE XREF: sub_1D52+16j
		addq.l  #4,d0
		move.l  d0,dword_5A30(a5)

loc_1D8A:               ; CODE XREF: sub_1D52+22j
		or.w    d1,d1
		rts
; ---------------------------------------------------------------------------

loc_1D8E:               ; CODE XREF: sub_1D52+1Aj
		subq.w  #1,d6
		bcc.s   loc_1DAA
		bset    #5,cdcBitfield1(a5)
		bra.s   loc_1DA4
; ---------------------------------------------------------------------------

loc_1D9A:               ; CODE XREF: sub_1D52+2Aj
		subq.w  #1,d6
		bcc.s   loc_1DAA
		bset    #4,cdcBitfield1(a5)

loc_1DA4:               ; CODE XREF: sub_1D52+46j
		bset    #7,cdcBitfield1(a5)

loc_1DAA:               ; CODE XREF: sub_1D52+30j sub_1D52+3Ej ...
		move    #1,ccr
		rts
; End of function sub_1D52


; =============== S U B R O U T I N E =======================================


sub_1DB0:               ; CODE XREF: _cdcstart+122p
					; _cdcstart+154p
		move.l  cdcFrameHeader(a5),d0
		bsr.w   sub_7EE
		move.l  d0,dword_5A28(a5)
		move.l  dword_5A30(a5),d1
		sub.l   d0,d1
		beq.s   locret_1DF4
		bcs.s   loc_1DD4
		cmpi.l  #$4B,d1 ; 'K'
		bcc.s   loc_1DE0
		move.w  #5,d6
		bra.s   loc_1DF0
; ---------------------------------------------------------------------------

loc_1DD4:               ; CODE XREF: sub_1DB0+14j
		subq.w  #1,d6
		bcc.s   loc_1DF0
		bset    #5,cdcBitfield1(a5)
		bra.s   loc_1DEA
; ---------------------------------------------------------------------------

loc_1DE0:               ; CODE XREF: sub_1DB0+1Cj
		subq.w  #1,d6
		bcc.s   loc_1DF0
		bset    #4,cdcBitfield1(a5)

loc_1DEA:               ; CODE XREF: sub_1DB0+2Ej
		bset    #7,cdcBitfield1(a5)

loc_1DF0:               ; CODE XREF: sub_1DB0+22j sub_1DB0+26j ...
		move    #1,ccr

locret_1DF4:                ; CODE XREF: sub_1DB0+12j
		rts
; End of function sub_1DB0


; =============== S U B R O U T I N E =======================================


sub_1DF6:               ; CODE XREF: _cdcstart+160p
					; _cdcstart+1B2p
		move.b  cdcStat0(a5),d0
		andi.b  #$48,d0 ; 'H'
		bne.s   loc_1E2E
		move.b  cdcStat0(a5),d0
		andi.b  #3,d0
		bne.s   loc_1E1A
		btst    #7,cdcStat0(a5)
		beq.s   loc_1E1A
		move.w  #$1E,d7

loc_1E16:               ; CODE XREF: sub_1DF6+30j
		or.w    d1,d1
		rts
; ---------------------------------------------------------------------------

loc_1E1A:               ; CODE XREF: sub_1DF6+12j sub_1DF6+1Aj
		bset    #1,cdcBitfield1(a5)
		btst    #4,cdcBitfield0(a5)
		bne.s   loc_1E16
		subq.w  #1,d7
		bcc.s   loc_1E3E
		bra.s   loc_1E38
; ---------------------------------------------------------------------------

loc_1E2E:               ; CODE XREF: sub_1DF6+8j
		subq.w  #1,d7
		bcc.s   loc_1E3E
		bset    #2,cdcBitfield1(a5)

loc_1E38:               ; CODE XREF: sub_1DF6+36j
		bset    #7,cdcBitfield1(a5)

loc_1E3E:               ; CODE XREF: sub_1DF6+34j sub_1DF6+3Aj
		move    #1,ccr
		rts
; End of function sub_1DF6


; =============== S U B R O U T I N E =======================================


sub_1E44:               ; CODE XREF: _cdcstart+FEp
					; _cdcstart+128p
		move.b  cdcStat0(a5),d0
		andi.b  #$48,d0 ; 'H'
		bne.s   loc_1E54
		move.w  #$1E,d7
		rts
; ---------------------------------------------------------------------------

loc_1E54:               ; CODE XREF: sub_1E44+8j
		subq.w  #1,d7
		bcc.s   loc_1E64
		bset    #2,cdcBitfield1(a5)
		bset    #7,cdcBitfield1(a5)

loc_1E64:               ; CODE XREF: sub_1E44+12j
		move    #1,ccr
		rts
; End of function sub_1E44


; =============== S U B R O U T I N E =======================================


sub_1E6A:               ; CODE XREF: _cdcstart+104p
					; _cdcstart+12Ep ...
		bsr.w   sub_74E
		move.l  cdcFrameHeader(a5),(a1)+
		move.w  $5A3E(a5),(a1)+
		move.b  $5A39(a5),(a1)+
		tst.w   d1
		bne.s   loc_1E92
		move.b  cdcBitfield1(a5),(a1)
		move.l  dword_5A30(a5),d0
		cmp.l   dword_5A34(a5),d0
		bcc.s   locret_1EB4
		addq.l  #1,dword_5A30(a5)
		bra.s   loc_1EB0
; ---------------------------------------------------------------------------

loc_1E92:               ; CODE XREF: sub_1E6A+12j
		bset    #6,cdcBitfield1(a5)
		move.b  cdcBitfield0(a5),d0
		ori.b   #$E7,d0
		cmpi.b  #$FF,d0
		beq.s   loc_1EAC
		bset    #7,cdcBitfield1(a5)

loc_1EAC:               ; CODE XREF: sub_1E6A+3Aj
		move.b  cdcBitfield1(a5),(a1)

loc_1EB0:               ; CODE XREF: sub_1E6A+26j
		move    #1,ccr

locret_1EB4:                ; CODE XREF: sub_1E6A+20j
		rts
; End of function sub_1E6A

; ---------------------------------------------------------------------------
dword_1EB6: dc.l $180060        ; DATA XREF: _scdinit+22o
		dc.l $A803C0
		dc.l $3D0
		dc.l $180018
		dc.l $180300
		dc.l $310
		dc.l $C000C
		dc.l $C0060
		dc.l $70

; =============== S U B R O U T I N E =======================================


_scdinit:               ; CODE XREF: sub_2946+46j
		movem.l a2/a4/a6,-(sp)
		movea.l a0,a4
		bclr    #6,(GA_INT_MASK).w
		lea $5A84(a5),a0
		moveq   #0,d0
		moveq   #5,d1

loc_1EEE:               ; CODE XREF: _scdinit+16j
		move.l  d0,(a0)+
		dbf d1,loc_1EEE
		bsr.w   sub_23A6
		lea $5A90(a5),a2
		lea dword_1EB6(pc),a6
		movea.l #'PCKT',a0
		bsr.s   sub_1F1E
		movea.l #'PACK',a0
		bsr.s   sub_1F1E
		movea.l #'QCOD',a0
		bsr.s   sub_1F1E
		movem.l (sp)+,a2/a4/a6
		rts
; End of function _scdinit


; =============== S U B R O U T I N E =======================================


sub_1F1E:               ; CODE XREF: _scdinit+2Cp _scdinit+34p ...
		move.l  a4,(a2)+
		move.l  (a6)+,d0
		move.l  (a6)+,d1
		bsr.w   sub_73C
		adda.l  (a6)+,a4
		rts
; End of function sub_1F1E


; =============== S U B R O U T I N E =======================================


_scdstop:               ; CODE XREF: _scdstart+Ap sub_2946+4Ej
		clr.b   $5A84(a5)
		bclr    #GA_IEN6,(GA_INT_MASK).w
		rts
; End of function _scdstop


; =============== S U B R O U T I N E =======================================


_scdstart:              ; CODE XREF: sub_2946+4Aj
		movem.l a4,-(sp)
		m_saveStatusRegister

		move    #$2600,sr
		bsr.s   _scdstop
		move.w  #7,$5A84(a5)
		clr.l   $5A86(a5)
		clr.w   $5A8A(a5)
		lsl.w   #5,d1
		bset    #7,d1
		move.b  d1,$5A84(a5)
		move.b  #$80,d0
		move.b  d0,$5A8C(a5)
		move.b  d0,$5A8D(a5)
		clr.b   $5A8E(a5)
		move.b  #$FF,$5A8F(a5)
		movea.l $5A90(a5),a4
		move.w  6(a4),4(a4)
		movea.l $5A94(a5),a4
		move.w  6(a4),4(a4)
		movea.l $5A98(a5),a4
		move.w  6(a4),4(a4)

		bset    #GA_IEN6,(GA_INT_MASK).w
		m_restoreStatusRegister
		movem.l (sp)+,a4
		rts
; End of function _scdstart


; =============== S U B R O U T I N E =======================================


_scdstat:               ; CODE XREF: sub_2946+52j
		move.l  $5A86(a5),d1
		move.w  $5A8A(a5),d0
		swap    d0
		move.w  $5A84(a5),d0
		rts
; End of function _scdstat


; =============== S U B R O U T I N E =======================================


_scdpql:                ; CODE XREF: sub_2946+5Ej
		bset    #2,$5A84(a5)

_scdpq:                 ; CODE XREF: sub_2946+5Aj
		movem.l a4,-(sp)
		m_saveStatusRegister
		move    #$2600,sr
		movea.l $5A98(a5),a4
		move.w  6(a4),d0
		cmp.w   4(a4),d0
		beq.s   loc_1FEC
		movea.l a0,a1

loc_1FCE:               ; CODE XREF: _scdpql+2Cj
		bsr.w   sub_7AA
		beq.s   loc_1FDC
		btst    #2,$5A84(a5)
		bne.s   loc_1FCE

loc_1FDC:               ; CODE XREF: _scdpql+24j
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		lea -$C(a1),a0
		andi.w  #$FFFE,(sp)
		bra.s   loc_1FF0
; ---------------------------------------------------------------------------

loc_1FEC:               ; CODE XREF: _scdpql+1Cj
		ori.w   #1,(sp)

loc_1FF0:               ; CODE XREF: _scdpql+3Cj
		m_restoreStatusRegister
		movem.l (sp)+,a4
		bclr    #2,$5A84(a5)
		rts
; End of function _scdpql


; =============== S U B R O U T I N E =======================================


_scdread:               ; CODE XREF: sub_2946+56j
		movem.l a4,-(sp)
		m_saveStatusRegister
		move    #$2400,sr

		movea.l $5A94(a5),a4
		move.w  6(a4),d0
		cmp.w   4(a4),d0
		beq.s   loc_2032
		movea.l a0,a1
		bsr.w   sub_7AA
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		lea -$18(a1),a0
		andi.w  #$FFFE,(sp)
		bra.s   loc_2036
; ---------------------------------------------------------------------------

loc_2032:               ; CODE XREF: _scdread+16j
		ori.w   #1,(sp)

loc_2036:               ; CODE XREF: _scdread+32j
		m_restoreStatusRegister
		movem.l (sp)+,a4
		rts
; End of function _scdread


; =============== S U B R O U T I N E =======================================


sub_203E:               ; CODE XREF: BIOS:00000658p
		movem.l a2-a4,-(sp)

		; Return if bit 7 is cleared
		btst    #7,$5A84(a5)
		beq.w   loc_2102

		clr.w   d0
		move.b  (GA_SUBCODE_ADDRESS).w,d0
		btst    #7,d0
		bne.w   loc_2108
		bra.s   loc_205E
; ---------------------------------------------------------------------------
		bra.s   loc_20B4
; ---------------------------------------------------------------------------

loc_205E:               ; CODE XREF: sub_203E+1Cj
		move.b  d0,d1
		cmp.b   $5A8D(a5),d1
		beq.s   loc_209A
		sub.b   $5A8C(a5),d1
		andi.b  #$7F,d1 ; ''
		cmpi.b  #$62,d1 ; 'b'
		bcc.s   loc_209A
		btst    #3,$5A84(a5)
		beq.s   loc_2086
		add.b   $5A8E(a5),d1
		cmpi.b  #$62,d1 ; 'b'
		beq.s   loc_209A

loc_2086:               ; CODE XREF: sub_203E+3Cj
		move.b  d0,$5A8C(a5)
		move.b  d1,$5A8E(a5)
		bset    #3,$5A84(a5)
		addq.b  #1,$5A8F(a5)
		bra.s   loc_2102
; ---------------------------------------------------------------------------

loc_209A:               ; CODE XREF: sub_203E+26j sub_203E+34j ...
		bclr    #3,$5A84(a5)
		move.b  d0,$5A8C(a5)
		clr.b   $5A8E(a5)
		addi.b  #$62,d1 ; 'b'
		andi.b  #$7F,d1 ; ''
		move.b  d1,$5A8D(a5)

loc_20B4:               ; CODE XREF: sub_203E+1Ej
		lea (GA_SUBCODE_BUFFER).w,a0
		lea (a0,d0.w),a0
		movea.l $5A90(a5),a4
		bsr.w   sub_74E
		add.b   d1,$5A87(a5)
		move.w  #2,d1

loc_20CC:               ; CODE XREF: sub_203E+9Ej
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		dbf d1,loc_20CC
		lea -$60(a1),a0
		btst    #6,$5A84(a5)
		beq.s   loc_2102
		movea.l $5A98(a5),a4
		bsr.w   sub_74E
		add.b   d1,$5A88(a5)
		bsr.w   sub_210E
		beq.s   loc_2102
		addq.b  #1,$5A8A(a5)

loc_2102:               ; CODE XREF: sub_203E+Aj sub_203E+5Aj ...
		movem.l (sp)+,a2-a4
		rts
; ---------------------------------------------------------------------------

loc_2108:               ; CODE XREF: sub_203E+18j
		addq.b  #1,$5A86(a5)
		bra.s   loc_2102
; End of function sub_203E


; =============== S U B R O U T I N E =======================================


sub_210E:               ; CODE XREF: sub_203E+BAp
		movea.l a0,a2
		bsr.s   sub_2168
		bsr.w   sub_860
		m_saveStatusRegister
		move.b  $18(a2),d0
		or.b    $30(a2),d0
		and.b   $48(a2),d0
		btst    #7,d0
		sne d0
		move.b  0(a1),d1
		andi.b  #$F,d1
		cmpi.b  #1,d1
		beq.s   loc_2146
		cmpi.b  #2,d1
		beq.s   loc_2146
		cmpi.b  #3,d1
		beq.s   loc_2146
		bra.s   loc_2164
; ---------------------------------------------------------------------------

loc_2146:               ; CODE XREF: sub_210E+28j sub_210E+2Ej ...
		move.b  d0,6(a1)
		bra.s   loc_2164
; ---------------------------------------------------------------------------
		move.b  d0,8(a1)
		bra.s   loc_2164
; ---------------------------------------------------------------------------
		move.b  8(a1),d1
		andi.b  #$F0,d1
		andi.b  #$F,d0
		or.b    d1,d0
		move.b  d0,8(a1)

loc_2164:               ; CODE XREF: sub_210E+36j sub_210E+3Cj ...
		m_restoreConditionBits
		rts
; End of function sub_210E


; =============== S U B R O U T I N E =======================================


sub_2168:               ; CODE XREF: sub_210E+2p
		movem.l a0-a1/a6,-(sp)
		lea loc_2172(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_2172:               ; DATA XREF: sub_2168+4o
		lea loc_2178(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_2178:               ; DATA XREF: sub_2168:loc_2172o
		move.w  d1,(a1)+
		lea loc_2180(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_2180:               ; DATA XREF: sub_2168+12o
		lea loc_2186(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_2186:               ; DATA XREF: sub_2168:loc_2180o
		move.w  d1,(a1)+
		lea loc_218E(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_218E:               ; DATA XREF: sub_2168+20o
		lea loc_2194(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_2194:               ; DATA XREF: sub_2168:loc_218Eo
		move.w  d1,(a1)+
		lea loc_219C(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_219C:               ; DATA XREF: sub_2168+2Eo
		lea loc_21A2(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_21A2:               ; DATA XREF: sub_2168:loc_219Co
		move.w  d1,(a1)+
		lea loc_21AA(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_21AA:               ; DATA XREF: sub_2168+3Co
		lea loc_21B0(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_21B0:               ; DATA XREF: sub_2168:loc_21AAo
		move.w  d1,(a1)+
		lea loc_21B8(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_21B8:               ; DATA XREF: sub_2168+4Ao
		lea loc_21BE(pc),a6
		bra.s   loc_21C6
; ---------------------------------------------------------------------------

loc_21BE:               ; DATA XREF: sub_2168:loc_21B8o
		move.w  d1,(a1)+
		movem.l (sp)+,a0-a1/a6
		rts
; ---------------------------------------------------------------------------

loc_21C6:               ; CODE XREF: sub_2168+8j sub_2168+Ej ...
		move.b  (a0)+,d0
		lsl.b   #2,d0
		roxl.w  #1,d1
		move.b  (a0)+,d0
		lsl.b   #2,d0
		roxl.w  #1,d1
		move.b  (a0)+,d0
		lsl.b   #2,d0
		roxl.w  #1,d1
		move.b  (a0)+,d0
		lsl.b   #2,d0
		roxl.w  #1,d1
		move.b  (a0)+,d0
		lsl.b   #2,d0
		roxl.w  #1,d1
		move.b  (a0)+,d0
		lsl.b   #2,d0
		roxl.w  #1,d1
		move.b  (a0)+,d0
		lsl.b   #2,d0
		roxl.w  #1,d1
		move.b  (a0)+,d0
		lsl.b   #2,d0
		roxl.w  #1,d1
		jmp (a6)
; End of function sub_2168


; =============== S U B R O U T I N E =======================================


updateSubcode:               ; CODE XREF: BIOS:0000061Ep
	; Return if update flag already set
	bset    #1,dword_5A84(a5)
	bne.w   locret_2288

	; Return if bit 5 is cleared
	btst    #5,dword_5A84(a5)
	beq.s   loc_2282

	movem.l a3-a4,-(sp)
	movea.l dword_5A94(a5),a3
	movea.l dword_5A90(a5),a4

	move.w  6(a4),d0
	cmp.w   4(a4),d0
	beq.s   loc_227E

	m_saveStatusRegister
	move    #$2300,sr

loc_2226:               ; CODE XREF: updateSubcode:loc_227Aj
	tst.b   dword_5A84+1(a5)
	beq.s   loc_2242
	subq.b  #1,dword_5A84+1(a5)

	m_saveStatusRegister
	move    #$2600,sr

	bsr.w   sub_7AA
	seq 1(sp)

	m_restoreStatusRegister
	bra.s   loc_227A
; ---------------------------------------------------------------------------

loc_2242:               ; CODE XREF: updateSubcode+32j
	exg a3,a4
	bsr.w   sub_74E
	add.b   d1,dword_5A88+1(a5)
	exg a3,a4

	m_saveStatusRegister
	move    #$2600,sr

	bsr.w   sub_22BC
	bsr.w   sub_7AA
	seq 1(sp)

	m_restoreStatusRegister
	seq 1(sp)

	bsr.w   sub_23B8
	bcc.s   loc_2278

	addq.b  #1,dword_5A88+3(a5)
	exg a3,a4
	bsr.w   sub_796
	exg a3,a4

loc_2278:               ; CODE XREF: updateSubcode+72j
	move    (sp),ccr

loc_227A:               ; CODE XREF: updateSubcode+48j
	bne.s   loc_2226
	m_restoreStatusRegister

loc_227E:               ; CODE XREF: updateSubcode+26j
	movem.l (sp)+,a3-a4

loc_2282:
	bclr    #1,dword_5A84(a5)

locret_2288:
	rts
; End of function updateSubcode

; ---------------------------------------------------------------------------
word_228A:  dc.w $FF58      ; DATA XREF: sub_22BCo
		dc.w $FF9A
		dc.w $FFD5
		dc.w $17
		dc.w $FFBC
		dc.w $FF8A
		dc.w $FFEE
		dc.w 7
		dc.w $FF60
		dc.w $FF79
		dc.w $FF92
		dc.w $FFAB
		dc.w $FFC4
		dc.w $FFDD
		dc.w $FFF6
		dc.w $F
		dc.w $FF68
		dc.w $FF81
		dc.w $FF71
		dc.w $FFB3
		dc.w $FFCC
		dc.w $FFE5
		dc.w $FFFE
		dc.w $FFA3
		dc.w 0

; =============== S U B R O U T I N E =======================================


sub_22BC:               ; CODE XREF: updateSubcode+5Cp
		lea word_228A(pc),a0
		bra.s   loc_22DC
; ---------------------------------------------------------------------------

loc_22C2:               ; CODE XREF: sub_22BC+22j
		bmi.s   loc_22C8
		sub.w   $A(a4),d0

loc_22C8:               ; CODE XREF: sub_22BC:loc_22C2j
		add.w   4(a4),d0
		bpl.s   loc_22D2
		add.w   $A(a4),d0

loc_22D2:               ; CODE XREF: sub_22BC+10j
		move.b  $10(a4,d0.w),d0
		andi.w  #$3F,d0 ; '?'
		move.b  d0,(a1)+

loc_22DC:               ; CODE XREF: sub_22BC+4j
		move.w  (a0)+,d0
		bne.s   loc_22C2
		lea -$18(a1),a1
		rts
; End of function sub_22BC

; ---------------------------------------------------------------------------
unk_22E6:       ; DATA XREF: sub_23B8+Eo
		dc.b $7F ; 
		dc.b   0
		dc.b   1
		dc.b   6
		dc.b   2
		dc.b  $C
		dc.b   7
		dc.b $1A
		dc.b   3
		dc.b $20
		dc.b  $D
		dc.b $23 ; #
		dc.b   8
		dc.b $30 ; 0
		dc.b $1B
		dc.b $12
		dc.b   4
		dc.b $18
		dc.b $21 ; !
		dc.b $10
		dc.b  $E
		dc.b $34 ; 4
		dc.b $24 ; $
		dc.b $36 ; 6
		dc.b   9
		dc.b $2D ; -
		dc.b $31 ; 1
		dc.b $26 ; &
		dc.b $1C
		dc.b $29 ; )
		dc.b $13
		dc.b $38 ; 8
		dc.b   5
		dc.b $3E ; >
		dc.b $19
		dc.b  $B
		dc.b $22 ; "
		dc.b $1F
		dc.b $11
		dc.b $2F ; /
		dc.b  $F
		dc.b $17
		dc.b $35 ; 5
		dc.b $33 ; 3
		dc.b $25 ; %
		dc.b $2C ; ,
		dc.b $37 ; 7
		dc.b $28 ; (
		dc.b  $A
		dc.b $3D ; =
		dc.b $2E ; .
		dc.b $1E
		dc.b $32 ; 2
		dc.b $16
		dc.b $27 ; '
		dc.b $2B ; +
		dc.b $1D
		dc.b $3C ; <
		dc.b $2A ; *
		dc.b $15
		dc.b $14
		dc.b $3B ; ;
		dc.b $39 ; 9
		dc.b $3A ; :

unk_2326:        ; DATA XREF: sub_23B8+Ao
		dc.b   1
		dc.b   2
		dc.b   4
		dc.b   8
		dc.b $10
		dc.b $20
		dc.b   3
		dc.b   6
		dc.b  $C
		dc.b $18
		dc.b $30 ; 0
		dc.b $23 ; #
		dc.b   5
		dc.b  $A
		dc.b $14
		dc.b $28 ; (
		dc.b $13
		dc.b $26 ; &
		dc.b  $F
		dc.b $1E
		dc.b $3C ; <
		dc.b $3B ; ;
		dc.b $35 ; 5
		dc.b $29 ; )
		dc.b $11
		dc.b $22 ; "
		dc.b   7
		dc.b  $E
		dc.b $1C
		dc.b $38 ; 8
		dc.b $33 ; 3
		dc.b $25 ; %
		dc.b   9
		dc.b $12
		dc.b $24 ; $
		dc.b  $B
		dc.b $16
		dc.b $2C ; ,
		dc.b $1B
		dc.b $36 ; 6
		dc.b $2F ; /
		dc.b $1D
		dc.b $3A ; :
		dc.b $37 ; 7
		dc.b $2D ; -
		dc.b $19
		dc.b $32 ; 2
		dc.b $27 ; '
		dc.b  $D
		dc.b $1A
		dc.b $34 ; 4
		dc.b $2B ; +
		dc.b $15
		dc.b $2A ; *
		dc.b $17
		dc.b $2E ; .
		dc.b $1F
		dc.b $3E ; >
		dc.b $3F ; ?
		dc.b $3D ; =
		dc.b $39 ; 9
		dc.b $31 ; 1
		dc.b $21 ; !
		dc.b   1
		dc.b   2
		dc.b   4
		dc.b   8
		dc.b $10
		dc.b $20
		dc.b   3
		dc.b   6
		dc.b  $C
		dc.b $18
		dc.b $30 ; 0
		dc.b $23 ; #
		dc.b   5
		dc.b  $A
		dc.b $14
		dc.b $28 ; (
		dc.b $13
		dc.b $26 ; &
		dc.b  $F
		dc.b $1E
		dc.b $3C ; <
		dc.b $3B ; ;
		dc.b $35 ; 5
		dc.b $29 ; )
		dc.b $11
		dc.b $22 ; "
		dc.b   7
		dc.b  $E
		dc.b $1C
		dc.b $38 ; 8
		dc.b $33 ; 3
		dc.b $25 ; %
		dc.b   9
		dc.b $12
		dc.b $24 ; $
		dc.b  $B
		dc.b $16
		dc.b $2C ; ,
		dc.b $1B
		dc.b $36 ; 6
		dc.b $2F ; /
		dc.b $1D
		dc.b $3A ; :
		dc.b $37 ; 7
		dc.b $2D ; -
		dc.b $19
		dc.b $32 ; 2
		dc.b $27 ; '
		dc.b  $D
		dc.b $1A
		dc.b $34 ; 4
		dc.b $2B ; +
		dc.b $15
		dc.b $2A ; *
		dc.b $17
		dc.b $2E ; .
		dc.b $1F
		dc.b $3E ; >
		dc.b $3F ; ?
		dc.b $3D ; =
		dc.b $39 ; 9
		dc.b $31 ; 1
		dc.b $21 ; !
		dc.b   0
		dc.b   0

; =============== S U B R O U T I N E =======================================


sub_23A6:               ; CODE XREF: _scdinit+1Ap
		lea dword_5A9C(a5),a0
		moveq   #0,d0
		moveq   #5,d1

loc_23AE:               ; CODE XREF: sub_23A6+Aj
		move.l  d0,(a0)+
		dbf d1,loc_23AE
		move.w  d0,(a0)
		rts
; End of function sub_23A6


; =============== S U B R O U T I N E =======================================


sub_23B8:               ; CODE XREF: updateSubcode+6Ep
		movem.l d2-d6/a0-a4/a6,-(sp)
		movea.l a1,a2
		bsr.w   sub_24D4
		lea unk_2326(pc),a3
		lea unk_22E6(pc),a4
		lea dword_5A9C(a5),a0
		move.b  (a0)+,d0
		or.b    (a0)+,d0
		or.b    (a0)+,d0
		or.b    (a0),d0
		beq.s   loc_23F4
		bsr.w   sub_254C
		lea dword_5AA0+2(a5),a0
		move.b  (a0)+,d0
		or.b    (a0)+,d0
		or.b    (a0),d0
		bne.s   loc_23F0
		bsr.w   sub_25A8
		bra.w   loc_23F4
; ---------------------------------------------------------------------------

loc_23F0:               ; CODE XREF: sub_23B8+2Ej
		bsr.w   sub_262E

loc_23F4:               ; CODE XREF: sub_23B8+1Ej sub_23B8+34j
		nop
		nop
		m_saveStatusRegister
		bsr.w   sub_251E
		tst.w   dword_5AA0(a5)
		beq.s   loc_240C
		bsr.w   sub_25BC
		move    sr,d0
		or.w    d0,(sp)

loc_240C:               ; CODE XREF: sub_23B8+4Aj
		m_restoreConditionBits
		movem.l (sp)+,d2-d6/a0-a4/a6
		rts
; End of function sub_23B8

; ---------------------------------------------------------------------------
unk_2414:
		dc.b   0
		dc.b   2
		dc.b   4
		dc.b   6
		dc.b   8
		dc.b  $A
		dc.b  $C
		dc.b  $E
		dc.b $10
		dc.b $12
		dc.b $14
		dc.b $16
		dc.b $18
		dc.b $1A
		dc.b $1C
		dc.b $1E
		dc.b $20
		dc.b $22 ; "
		dc.b $24 ; $
		dc.b $26 ; &
		dc.b $28 ; (
		dc.b $2A ; *
		dc.b $2C ; ,
		dc.b $2E ; .
		dc.b $30 ; 0
		dc.b $32 ; 2
		dc.b $34 ; 4
		dc.b $36 ; 6
		dc.b $38 ; 8
		dc.b $3A ; :
		dc.b $3C ; <
		dc.b $3E ; >
		dc.b   3
		dc.b   1
		dc.b   7
		dc.b   5
		dc.b  $B
		dc.b   9
		dc.b  $F
		dc.b  $D
		dc.b $13
		dc.b $11
		dc.b $17
		dc.b $15
		dc.b $1B
		dc.b $19
		dc.b $1F
		dc.b $1D
		dc.b $23 ; #
		dc.b $21 ; !
		dc.b $27 ; '
		dc.b $25 ; %
		dc.b $2B ; +
		dc.b $29 ; )
		dc.b $2F ; /
		dc.b $2D ; -
		dc.b $33 ; 3
		dc.b $31 ; 1
		dc.b $37 ; 7
		dc.b $35 ; 5
		dc.b $3B ; ;
		dc.b $39 ; 9
		dc.b $3F ; ?
		dc.b $3D ; =

unk_2454:
		dc.b   0
		dc.b   4
		dc.b   8
		dc.b  $C
		dc.b $10
		dc.b $14
		dc.b $18
		dc.b $1C
		dc.b $20
		dc.b $24 ; $
		dc.b $28 ; (
		dc.b $2C ; ,
		dc.b $30 ; 0
		dc.b $34 ; 4
		dc.b $38 ; 8
		dc.b $3C ; <
		dc.b   3
		dc.b   7
		dc.b  $B
		dc.b  $F
		dc.b $13
		dc.b $17
		dc.b $1B
		dc.b $1F
		dc.b $23 ; #
		dc.b $27 ; '
		dc.b $2B ; +
		dc.b $2F ; /
		dc.b $33 ; 3
		dc.b $37 ; 7
		dc.b $3B ; ;
		dc.b $3F ; ?
		dc.b   6
		dc.b   2
		dc.b  $E
		dc.b  $A
		dc.b $16
		dc.b $12
		dc.b $1E
		dc.b $1A
		dc.b $26 ; &
		dc.b $22 ; "
		dc.b $2E ; .
		dc.b $2A ; *
		dc.b $36 ; 6
		dc.b $32 ; 2
		dc.b $3E ; >
		dc.b $3A ; :
		dc.b   5
		dc.b   1
		dc.b  $D
		dc.b   9
		dc.b $15
		dc.b $11
		dc.b $1D
		dc.b $19
		dc.b $25 ; %
		dc.b $21 ; !
		dc.b $2D ; -
		dc.b $29 ; )
		dc.b $35 ; 5
		dc.b $31 ; 1
		dc.b $3D ; =
		dc.b $39 ; 9
		dc.b   0
		dc.b   8
		dc.b $10
		dc.b $18
		dc.b $20
		dc.b $28 ; (
		dc.b $30 ; 0
		dc.b $38 ; 8
		dc.b   3
		dc.b  $B
		dc.b $13
		dc.b $1B
		dc.b $23 ; #
		dc.b $2B ; +
		dc.b $33 ; 3
		dc.b $3B ; ;
		dc.b   6
		dc.b  $E
		dc.b $16
		dc.b $1E
		dc.b $26 ; &
		dc.b $2E ; .
		dc.b $36 ; 6
		dc.b $3E ; >
		dc.b   5
		dc.b  $D
		dc.b $15
		dc.b $1D
		dc.b $25 ; %
		dc.b $2D ; -
		dc.b $35 ; 5
		dc.b $3D ; =
		dc.b  $C
		dc.b   4
		dc.b $1C
		dc.b $14
		dc.b $2C ; ,
		dc.b $24 ; $
		dc.b $3C ; <
		dc.b $34 ; 4
		dc.b  $F
		dc.b   7
		dc.b $1F
		dc.b $17
		dc.b $2F ; /
		dc.b $27 ; '
		dc.b $3F ; ?
		dc.b $37 ; 7
		dc.b  $A
		dc.b   2
		dc.b $1A
		dc.b $12
		dc.b $2A ; *
		dc.b $22 ; "
		dc.b $3A ; :
		dc.b $32 ; 2
		dc.b   9
		dc.b   1
		dc.b $19
		dc.b $11
		dc.b $29 ; )
		dc.b $21 ; !
		dc.b $39 ; 9
		dc.b $31 ; 1

; =============== S U B R O U T I N E =======================================


sub_24D4:               ; CODE XREF: sub_23B8+6p
		move.l  a2,-(sp)
		lea unk_2454(pc),a6
		lea dword_5A9C(a5),a0
		lea 1(a0),a1
		lea 2(a0),a3
		lea 3(a0),a4
		move.b  (a2)+,d0
		move.b  d0,(a0)
		move.b  d0,(a1)
		move.b  d0,(a3)
		move.b  d0,(a4)
		clr.w   d0
		move.w  #$16,d1

loc_24FA:               ; CODE XREF: sub_24D4+42j
		move.b  (a1),d0
		move.b  -$40(a6,d0.w),(a1)
		move.b  (a3),d0
		move.b  (a6,d0.w),(a3)
		move.b  (a4),d0
		move.b  $40(a6,d0.w),(a4)
		move.b  (a2)+,d0
		eor.b   d0,(a0)
		eor.b   d0,(a1)
		eor.b   d0,(a3)
		eor.b   d0,(a4)
		dbf d1,loc_24FA
		movea.l (sp)+,a2
		rts
; End of function sub_24D4


; =============== S U B R O U T I N E =======================================


sub_251E:               ; CODE XREF: sub_23B8+42p
		move.l  a2,-(sp)
		lea dword_5AA0(a5),a0
		lea dword_5AA0+1(a5),a1
		lea unk_2414(pc),a3
		move.b  (a2)+,d0
		move.b  d0,(a0)
		move.b  d0,(a1)
		moveq   #0,d0
		move.w  #2,d1

loc_2538:               ; CODE XREF: sub_251E+26j
		move.b  (a1),d0
		move.b  (a3,d0.w),(a1)
		move.b  (a2)+,d0
		eor.b   d0,(a0)
		eor.b   d0,(a1)
		dbf d1,loc_2538
		movea.l (sp)+,a2
		rts
; End of function sub_251E


; =============== S U B R O U T I N E =======================================


sub_254C:               ; CODE XREF: sub_23B8+20p
		lea dword_5A9C(a5),a0
		clr.w   d3
		move.b  (a0)+,d3
		move.b  (a4,d3.w),d0
		move.b  (a0)+,d3
		move.b  (a4,d3.w),d1
		move.b  (a0)+,d3
		move.b  (a4,d3.w),d2
		move.b  (a0),d3
		move.b  (a4,d3.w),d3
		lea volumeBitfield(a5),a0
		move.b  d3,-(a0)
		move.b  d1,-(a0)
		move.b  d2,-(a0)
		move.b  d2,-(a0)
		move.b  d3,-(a0)
		move.b  d0,-(a0)
		move.b  d2,-(a0)
		move.b  d1,-(a0)
		move.b  d2,-(a0)
		move.b  d0,-(a0)
		move.b  d1,-(a0)
		move.b  d1,-(a0)
		clr.w   d0
		lea dword_5AA0+2(a5),a1
		move.w  #2,d2

loc_2590:               ; CODE XREF: sub_254C+56j
		move.b  (a0)+,d0
		add.b   (a0)+,d0
		move.b  (a3,d0.w),d1
		move.b  (a0)+,d0
		add.b   (a0)+,d0
		move.b  (a3,d0.w),(a1)
		eor.b   d1,(a1)+
		dbf d2,loc_2590
		rts
; End of function sub_254C


; =============== S U B R O U T I N E =======================================


sub_25A8:               ; CODE XREF: sub_23B8+30p
		clr.w   d0
		clr.w   d1
		lea dword_5A9C(a5),a0
		move.b  (a0)+,d3
		move.b  (a0)+,d0
		move.b  (a0),d1
		move.w  #$17,d2
		bra.s   loc_25CE
; End of function sub_25A8


; =============== S U B R O U T I N E =======================================


sub_25BC:               ; CODE XREF: sub_23B8+4Cp
		clr.w   d0
		move.b  dword_5AA0(a5),d0
		clr.w   d1
		move.b  dword_5AA0+1(a5),d1
		move.w  #3,d2
		move.b  d0,d3

loc_25CE:               ; CODE XREF: sub_25A8+12j
		move.b  (a4,d1.w),d1
		move.b  (a4,d0.w),d0
		sub.w   d0,d1
		bcc.s   loc_25DE
		addi.w  #$3F,d1 ; '?'

loc_25DE:               ; CODE XREF: sub_25BC+1Cj
		sub.w   d1,d2
		bcs.s   loc_25E8
		eor.b   d3,(a2,d2.w)
		rts
; ---------------------------------------------------------------------------

loc_25E8:               ; CODE XREF: sub_25BC+24j
		move    #1,ccr
		rts
; End of function sub_25BC

; ---------------------------------------------------------------------------
unk_25EE:   dc.b $15        ; DATA XREF: sub_262E:loc_267Eo
		dc.b $11
		dc.b $1F
		dc.b  $E
		dc.b   5
		dc.b $FF
		dc.b $1C
		dc.b   1
		dc.b  $A
		dc.b $16
		dc.b $FF
		dc.b $FF
		dc.b $13
		dc.b $1E
		dc.b   2
		dc.b $FF
		dc.b $14
		dc.b $FF
		dc.b $25 ; %
		dc.b $27 ; '
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $26 ; &
		dc.b $FF
		dc.b $1D
		dc.b $24 ; $
		dc.b   4
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $28 ; (
		dc.b   7
		dc.b $FF
		dc.b   3
		dc.b  $B
		dc.b $FF
		dc.b  $F
		dc.b $FF
		dc.b $FF
		dc.b $33 ; 3
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $12
		dc.b $FF
		dc.b $FF
		dc.b  $D
		dc.b $10
		dc.b $FF
		dc.b $FF
		dc.b $39 ; 9
		dc.b $FF
		dc.b   9
		dc.b $FF
		dc.b   8
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF
		dc.b $FF

; =============== S U B R O U T I N E =======================================


sub_262E:               ; CODE XREF: sub_23B8:loc_23F0p
		lea dword_5AA0+2(a5),a0
		clr.w   d0
		clr.w   d1
		move.b  (a0)+,d0
		move.b  (a4,d0.w),d2
		move.b  (a0)+,d0
		move.b  (a4,d0.w),d3
		move.b  (a0),d0
		move.b  (a4,d0.w),d4
		move.b  d3,d1
		move.b  d2,d0
		sub.w   d0,d1
		bcc.s   loc_2654
		addi.w  #$3F,d1 ; '?'

loc_2654:               ; CODE XREF: sub_262E+20j
		move.b  d1,d6
		move.b  (a3,d1.w),d5
		move.b  d4,d1
		move.b  d3,d0
		sub.w   d0,d1
		bcc.s   loc_2666
		addi.w  #$3F,d1 ; '?'

loc_2666:               ; CODE XREF: sub_262E+32j
		move.b  d2,d0
		add.w   d0,d1
		cmpi.w  #$3F,d1 ; '?'
		bcs.s   loc_2674
		subi.w  #$3F,d1 ; '?'

loc_2674:               ; CODE XREF: sub_262E+40j
		move.b  d3,d0
		sub.w   d0,d1
		bcc.s   loc_267E
		addi.w  #$3F,d1 ; '?'

loc_267E:               ; CODE XREF: sub_262E+4Aj
		lea unk_25EE(pc),a0
		move.b  (a0),d1
		move.b  d6,d0
		add.w   d0,d1
		cmpi.w  #$3F,d1 ; '?'
		bcs.s   loc_2692
		subi.w  #$3F,d1 ; '?'

loc_2692:               ; CODE XREF: sub_262E+5Ej
		move.b  d1,dword_5AA4+2(a5)
		move.b  (a3,d1.w),d1
		eor.b   d5,d1
		move.b  (a4,d1.w),dword_5AA4+3(a5)
		move.b  dword_5AA4+2(a5),d1
		move.b  dword_5A9C(a5),d0
		move.b  (a4,d0.w),d0
		add.b   d0,d1
		move.b  (a3,d1.w),d1
		move.b  dword_5A9C+1(a5),d0
		eor.b   d0,d1
		move.b  (a4,d1.w),d1
		move.b  d6,d0
		sub.w   d0,d1
		bcc.s   loc_26C8
		addi.w  #$3F,d1 ; '?'

loc_26C8:               ; CODE XREF: sub_262E+94j
		move.b  (a3,d1.w),d1
		move.b  d1,dword_5AA8+1(a5)
		move.b  dword_5A9C(a5),d0
		eor.b   d0,d1
		move.b  d1,dword_5AA8(a5)
		move.b  (a4,d1.w),d1
		add.b   dword_5AA4+2(a5),d1
		move.b  (a3,d1.w),d1
		move.b  dword_5AA8+1(a5),d0
		move.b  (a4,d0.w),d0
		add.b   dword_5AA4+3(a5),d0
		move.b  (a3,d0.w),d0
		eor.b   d1,d0
		cmp.b   dword_5A9C+1(a5),d0
		bne.s   loc_272E
		move.b  dword_5AA4+2(a5),d1
		move.w  #$17,d2
		move.b  dword_5AA8(a5),d3
		bsr.s   sub_2724
		m_saveStatusRegister
		move.b  dword_5AA4+3(a5),d1
		move.w  #$17,d2
		move.b  dword_5AA8+1(a5),d3
		bsr.s   sub_2724
		move    sr,d0
		or.w    d0,(sp)
		m_restoreConditionBits
		rts
; End of function sub_262E


; =============== S U B R O U T I N E =======================================


sub_2724:               ; CODE XREF: sub_262E+DCp sub_262E+ECp
		sub.w   d1,d2
		bcs.s   loc_272E
		eor.b   d3,(a2,d2.w)
		rts
; ---------------------------------------------------------------------------

loc_272E:               ; CODE XREF: sub_262E+CEj sub_2724+2j
		move    #1,ccr
		rts
; End of function sub_2724


; =============== S U B R O U T I N E =======================================


_wonderreq:             ; CODE XREF: sub_2946+6Aj
		or.w    d1,d1
		rts
; End of function _wonderreq


; =============== S U B R O U T I N E =======================================


_wonderchk:             ; CODE XREF: sub_2946+6Ej
		move.w  #0,d0
		rts
; End of function _wonderchk

; =============== S U B M O D U L E =========================================
	include "submodules\volume.asm"

; ---------------------------------------------------------------------------
word_2924:  dc.w 4          ; DATA XREF: installJumpTable+62o
		dc.w 0

; =============== S U B R O U T I N E =======================================


_cdbios:
		movem.l a5,-(sp)
		movea.l #0,a5
		bclr    #7,d0
		beq.s   loc_293C
		bsr.s   sub_2946
		bra.s   loc_2940
; ---------------------------------------------------------------------------

loc_293C:               ; CODE XREF: _cdbios+Ej
		bsr.w   sub_2A1C

loc_2940:               ; CODE XREF: _cdbios+12j
		movem.l (sp)+,a5
		rts
; End of function _cdbios


; =============== S U B R O U T I N E =======================================


sub_2946:               ; CODE XREF: _cdbios+10p
		add.w   d0,d0
		add.w   d0,d0
		cmpi.w  #$64,d0 ; 'd'
		bcc.s   locret_29B8
		jmp loc_2954(pc,d0.w)
; ---------------------------------------------------------------------------

loc_2954:
		bra.w   _cdbchk
; ---------------------------------------------------------------------------
		bra.w   _cdbstat
; ---------------------------------------------------------------------------
		bra.w   _cdbtocwrite
; ---------------------------------------------------------------------------
		bra.w   _cdbtocread
; ---------------------------------------------------------------------------
		bra.w   _cdbpause
; ---------------------------------------------------------------------------
		bra.w   _fdrset
; ---------------------------------------------------------------------------
		bra.w   _fdrchg
; ---------------------------------------------------------------------------
		bra.w   _cdcstart
; ---------------------------------------------------------------------------
		bra.w   _cdcstartp
; ---------------------------------------------------------------------------
		bra.w   _cdcstop
; ---------------------------------------------------------------------------
		bra.w   _cdcstat
; ---------------------------------------------------------------------------
		bra.w   _cdcread
; ---------------------------------------------------------------------------
		bra.w   _cdctrn
; ---------------------------------------------------------------------------
		bra.w   _cdcack
; ---------------------------------------------------------------------------
		bra.w   _scdinit
; ---------------------------------------------------------------------------
		bra.w   _scdstart
; ---------------------------------------------------------------------------
		bra.w   _scdstop
; ---------------------------------------------------------------------------
		bra.w   _scdstat
; ---------------------------------------------------------------------------
		bra.w   _scdread
; ---------------------------------------------------------------------------
		bra.w   _scdpq
; ---------------------------------------------------------------------------
		bra.w   _scdpql
; ---------------------------------------------------------------------------
		bra.w   _ledset
; ---------------------------------------------------------------------------
		bra.w   _cdcsetmode
; ---------------------------------------------------------------------------
		bra.w   _wonderreq
; ---------------------------------------------------------------------------
		bra.w   _wonderchk
; ---------------------------------------------------------------------------

locret_29B8:                ; CODE XREF: sub_2946+8j
		rts
; ---------------------------------------------------------------------------

_cdbchk:                ; CODE XREF: sub_2946:loc_2954j
		btst    #7,cddCommand(a5)
		sne d0
		lsr.b   #1,d0
		rts
; ---------------------------------------------------------------------------

_cdbstat:               ; CODE XREF: sub_2946+12j
		lea (_CDSTAT).w,a0
		movem.l a0,-(sp)
		move.w  cddControlStatus(a5),(a0)+
		move.b  ledStatus(a5),d0
		lsl.w   #8,d0
		move.b  ledMode+1(a5),d0
		move.w  d0,(a0)+
		bsr.w   writeCddStatus
		bcc.s   loc_29E8
		adda.w  #20,a0

loc_29E8:               ; CODE XREF: sub_2946+9Cj
		move.l  masterVolume(a5),d0
		move.l  d0,(a0)+
		bsr.w   sub_1840
		move.l  d0,(a0)
		movem.l (sp)+,a0
		rts
; ---------------------------------------------------------------------------

loc_29FA:               ; CODE XREF: _cdbtocwrite+6j
		bsr.w   sub_C7E
; End of function sub_2946


; =============== S U B R O U T I N E =======================================


_cdbtocwrite:               ; CODE XREF: sub_2946+16j
		cmpi.l  #$FFFFFFFF,(a0)
		bne.s   loc_29FA
		rts
; End of function _cdbtocwrite


; =============== S U B R O U T I N E =======================================


_cdbtocread:                ; CODE XREF: sub_2946+1Aj
		move.w  d1,d0
		bsr.w   sub_CAC
		rts
; End of function _cdbtocread


; =============== S U B R O U T I N E =======================================


_ledset:                ; CODE XREF: sub_2946+62j
		move.w  d1,userLedMode(a5)
		rts
; End of function _ledset


; =============== S U B R O U T I N E =======================================


_cdbpause:              ; CODE XREF: sub_2946+1Ej
		move.w  d1,cddSpindownDelay(a5)
		rts
; End of function _cdbpause


; =============== S U B R O U T I N E =======================================


sub_2A1C:               ; CODE XREF: _cdbios:loc_293Cp
		ror.w   #4,d0
		tst.b   d0
		beq.s   loc_2A34
		cmpi.b  #1,d0
		beq.s   loc_2A2E
		lea loc_2A3C(pc),a1
		bra.s   loc_2A38
; ---------------------------------------------------------------------------

loc_2A2E:               ; CODE XREF: sub_2A1C+Aj
		lea loc_2A48(pc),a1
		bra.s   loc_2A38
; ---------------------------------------------------------------------------

loc_2A34:               ; CODE XREF: sub_2A1C+4j
		lea loc_2A52(pc),a1

loc_2A38:               ; CODE XREF: sub_2A1C+10j sub_2A1C+16j
		rol.w   #4,d0
		jmp (a1)
; ---------------------------------------------------------------------------

loc_2A3C:               ; DATA XREF: sub_2A1C+Co
		lea cddCommand(a5),a1
		move.w  d0,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		bra.s   loc_2A58
; ---------------------------------------------------------------------------

loc_2A48:               ; DATA XREF: sub_2A1C:loc_2A2Eo
		lea cddCommand(a5),a1
		move.w  d0,(a1)+
		move.l  (a0)+,(a1)+
		bra.s   loc_2A58
; ---------------------------------------------------------------------------

loc_2A52:               ; DATA XREF: sub_2A1C:loc_2A34o
		lea cddCommand(a5),a1
		move.w  d0,(a1)+

loc_2A58:               ; CODE XREF: sub_2A1C+2Aj sub_2A1C+34j
		bset    #7,cddCommand(a5)
		rts
; End of function sub_2A1C


; =============== S U B R O U T I N E =======================================


cddSetContinueAddress:               ; CODE XREF: initCdd:loc_2A96p
					; initCdd+26p ...
		move.l  (sp)+,tempJumpTarget(a5)
		rts
; End of function cddSetContinueAddress


; =============== S U B R O U T I N E =======================================


cddContinue:               ; CODE XREF: BIOS:00000622p
		tst.w   word_5B22(a5)
		beq.s   loc_2A70
		subq.w  #1,word_5B22(a5)

loc_2A70:               ; CODE XREF: cddContinue+4j
		movea.l tempJumpTarget(a5),a0
		jmp (a0)
; End of function cddContinue


; =============== S U B R O U T I N E =======================================


copyCddCommand:             ; CODE XREF: initCdd+4Ap
					; BIOS:000031A2p ...
		move.w  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		move.l  (a0)+,(a1)+
		rts
; End of function copyCddCommand


; =============== S U B R O U T I N E =======================================


initCdd:               ; CODE XREF: BIOS:0000035Ap
		move.w  #$8000,cddControlStatus(a5)
		move.w  #4500,cddSpindownDelay(a5)
		move.w  #$101,cddArg1Cache(a5)
		move.w  #$2C,cddCommandCache(a5) ; ','

loc_2A96:               ; CODE XREF: initCdd+1Ej initCdd+24j
		bsr.s   cddSetContinueAddress
		move.b  byte_5A04(a5),d0
		beq.s   loc_2A96
		cmpi.b  #$FF,d0
		beq.s   loc_2A96
		bsr.s   cddSetContinueAddress
		move.w  #$400,d1
		bsr.w   _fdrset
		cmpi.w  #$800A,cddCommand(a5)
		bne.s   loc_2ACA

loc_2AB6:               ; CODE XREF: BIOS:00002C38j
					; BIOS:00002C54j ...
		bsr.s   cddSetContinueAddress
		bclr    #7,cddCommand(a5)
		beq.s   loc_2AD0
		lea cddCommand(a5),a0
		lea cddCommandCache(a5),a1
		bsr.s   copyCddCommand

loc_2ACA:               ; CODE XREF: initCdd+36j
					; BIOS:00002C2Aj ...
		bset    #7,cddControlStatus(a5)

loc_2AD0:               ; CODE XREF: initCdd+40j
					; BIOS:loc_2D66j ...
		move.w  cddCommandCache(a5),d0
		add.w   d0,d0
		add.w   d0,d0
		cmpi.w  #$B4,d0 ; '´'
		bcc.w   loc_2C78
		jmp loc_2AE4(pc,d0.w)
; End of function initCdd

; ---------------------------------------------------------------------------

loc_2AE4:
		bra.w   loc_2DEC
; ---------------------------------------------------------------------------
		bra.w   loc_2E36
; ---------------------------------------------------------------------------
		bra.w   loc_2F06
; ---------------------------------------------------------------------------
		bra.w   loc_34A8
; ---------------------------------------------------------------------------
		bra.w   loc_34BC
; ---------------------------------------------------------------------------
		bra.w   loc_3314
; ---------------------------------------------------------------------------
		bra.w   loc_3300
; ---------------------------------------------------------------------------
		bra.w   loc_32F2
; ---------------------------------------------------------------------------
		bra.w   loc_3790
; ---------------------------------------------------------------------------
		bra.w   loc_379E
; ---------------------------------------------------------------------------
		bra.w   loc_2E44
; ---------------------------------------------------------------------------
		bra.w   loc_2EF8
; ---------------------------------------------------------------------------
		bra.w   loc_34AE
; ---------------------------------------------------------------------------
		bra.w   locret_2B98
; ---------------------------------------------------------------------------
		bra.w   locret_2B98
; ---------------------------------------------------------------------------
		bra.w   locret_2B98
; ---------------------------------------------------------------------------
		bra.w   loc_2C78
; ---------------------------------------------------------------------------
		bra.w   loc_303E
; ---------------------------------------------------------------------------
		bra.w   loc_3022
; ---------------------------------------------------------------------------
		bra.w   loc_3030
; ---------------------------------------------------------------------------
		bra.w   loc_2FD6
; ---------------------------------------------------------------------------
		bra.w   loc_3008
; ---------------------------------------------------------------------------
		bra.w   loc_2FBC
; ---------------------------------------------------------------------------
		bra.w   loc_36D6
; ---------------------------------------------------------------------------
		bra.w   loc_3686
; ---------------------------------------------------------------------------
		bra.w   loc_3002
; ---------------------------------------------------------------------------
		bra.w   locret_2B98
; ---------------------------------------------------------------------------
		bra.w   locret_2B98
; ---------------------------------------------------------------------------
		bra.w   locret_2B98
; ---------------------------------------------------------------------------
		bra.w   locret_2B98
; ---------------------------------------------------------------------------
		bra.w   locret_2B98
; ---------------------------------------------------------------------------
		bra.w   locret_2B98
; ---------------------------------------------------------------------------
		bra.w   loc_36C0
; ---------------------------------------------------------------------------
		bra.w   loc_36DE
; ---------------------------------------------------------------------------
		bra.w   loc_2D6E
; ---------------------------------------------------------------------------
		bra.w   loc_2D9C
; ---------------------------------------------------------------------------
		bra.w   loc_2F5A
; ---------------------------------------------------------------------------
		bra.w   loc_3200
; ---------------------------------------------------------------------------
		bra.w   loc_32A6
; ---------------------------------------------------------------------------
		bra.w   loc_3250
; ---------------------------------------------------------------------------
		bra.w   loc_3610
; ---------------------------------------------------------------------------
		bra.w   loc_3454
; ---------------------------------------------------------------------------
		bra.w   loc_3744
; ---------------------------------------------------------------------------
		bra.w   loc_38B8
; ---------------------------------------------------------------------------
		bra.w   loc_2BF0
; ---------------------------------------------------------------------------

locret_2B98:                ; CODE XREF: BIOS:00002B18j
					; BIOS:00002B1Cj ...
		rts

; =============== S U B R O U T I N E =======================================


sub_2B9A:               ; CODE XREF: BIOS:00002CDAp
					; BIOS:00002F56p
		move.w  #$B,word_5B1E(a5)
		bra.s   loc_2BA8
; ---------------------------------------------------------------------------

loc_2BA2:               ; CODE XREF: BIOS:000035D4p
					; BIOS:loc_35DCp ...
		move.w  #5,word_5B1E(a5)

loc_2BA8:               ; CODE XREF: sub_2B9A+6j
		move.l  (sp)+,dword_5AD8(a5)

loc_2BAC:               ; CODE XREF: sub_2B9A+1Aj
		bsr.w   cddSetContinueAddress
		subq.w  #1,word_5B1E(a5)
		bcc.s   loc_2BAC
		movea.l dword_5AD8(a5),a0
		jmp (a0)
; End of function sub_2B9A


; =============== S U B R O U T I N E =======================================


sub_2BBC:               ; CODE XREF: BIOS:000030D2p
					; BIOS:00003154p ...
		move.l  (sp)+,dword_5AD8(a5)
		bra.s   loc_2BC6
; ---------------------------------------------------------------------------

loc_2BC2:               ; CODE XREF: sub_2BBC+22j
		bsr.w   cddSetContinueAddress

loc_2BC6:               ; CODE XREF: sub_2BBC+4j
		move.w  #$20,d0 ; ' '
		move.w  word_5B0A(a5),d1
		cmpi.w  #$FFFF,d1
		bne.s   loc_2BD8
		move.w  #$8000,d0

loc_2BD8:               ; CODE XREF: sub_2BBC+16j
		swap    d1
		bsr.w   sub_B0C
		bcs.s   loc_2BC2
		movea.l dword_5AD8(a5),a0
		jmp (a0)
; End of function sub_2BBC


; =============== S U B R O U T I N E =======================================


sub_2BE6:               ; CODE XREF: BIOS:loc_2C48p
		move.w  #$80C0,d0
		bsr.w   sub_B0C
		rts
; End of function sub_2BE6

; ---------------------------------------------------------------------------

loc_2BF0:               ; CODE XREF: BIOS:00002B94j
		move.w  #LEDREADY,ledMode(a5)
		bsr.w   _cdcstop
		move.w  #1,word_5B00(a5)
		move.l  #$20000,dword_5B02(a5)
		bsr.w   cddSetContinueAddress
		bsr.w   sub_D0E
		cmpi.b  #$E,d0
		beq.w   loc_2C24
		cmpi.b  #5,d0
		beq.w   loc_2C24
		bra.w   loc_2C98
; ---------------------------------------------------------------------------

loc_2C24:               ; CODE XREF: BIOS:00002C14j
					; BIOS:00002C1Cj
		move.w  #1,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_2C2E:               ; CODE XREF: BIOS:00002C44j
					; BIOS:00002C6Aj
		bsr.w   cddSetContinueAddress
		btst    #7,cddCommand(a5)
		bne.w   loc_2AB6
		bsr.w   sub_D0E
		cmpi.b  #$E,d0
		beq.s   loc_2C2E
		bra.s   loc_2C90
; ---------------------------------------------------------------------------

loc_2C48:               ; CODE XREF: BIOS:loc_2CB4j
		bsr.s   sub_2BE6

loc_2C4A:               ; CODE XREF: BIOS:00002C66j
		bsr.w   cddSetContinueAddress
		cmpi.w  #$8010,cddCommand(a5)
		beq.w   loc_2AB6
		cmpi.w  #$800A,cddCommand(a5)
		beq.w   loc_2AB6
		bsr.w   sub_AF6
		bcs.s   loc_2C4A
		tst.b   d0
		bne.s   loc_2C2E
		bsr.w   sub_D0E
		cmpi.b  #0,d0
		bne.w   loc_2D5A

loc_2C78:               ; CODE XREF: initCdd+5Ej
					; BIOS:00002B24j
		move.w  #LEDREADY,ledMode(a5)
		bsr.w   _cdcstop
		move.w  #1,word_5B00(a5)
		move.l  #$20000,dword_5B02(a5)

loc_2C90:               ; CODE XREF: BIOS:00002C46j
					; BIOS:00002CD8j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_D0E

loc_2C98:               ; CODE XREF: BIOS:00002C20j
		cmpi.b  #0,d0
		beq.s   loc_2CDE
		cmpi.b  #1,d0
		beq.s   loc_2CDE
		cmpi.b  #4,d0
		beq.s   loc_2CDE
		cmpi.b  #$C,d0
		beq.s   loc_2CDE
		cmpi.b  #5,d0

loc_2CB4:               ; CODE XREF: BIOS:00002CC2j
		beq.s   loc_2C48
		cmpi.b  #$B,d0
		beq.w   loc_2D5A
		cmpi.b  #$E,d0
		beq.s   loc_2CB4
		move.w  #$8010,d0
		bsr.w   sub_B0C

loc_2CCC:               ; CODE XREF: BIOS:00002CD4j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_2CCC
		tst.b   d0
		bne.s   loc_2C90
		bsr.w   sub_2B9A

loc_2CDE:               ; CODE XREF: BIOS:00002C9Cj
					; BIOS:00002CA2j ...
		move.w  #$2000,cddControlStatus(a5)
		move.w  #5,d1
		swap    d1
		move.w  cddArg1Cache(a5),d1
		move.w  #$8020,d0
		bsr.w   sub_B0C

loc_2CF6:               ; CODE XREF: BIOS:00002D0Ej
		bsr.w   cddSetContinueAddress
		cmpi.w  #$800A,cddCommand(a5)
		beq.s   loc_2D6A
		cmpi.w  #$8010,cddCommand(a5)
		beq.s   loc_2D6A
		bsr.w   sub_AF6
		bcs.s   loc_2CF6
		tst.b   d0
		bne.w   loc_2D5A
		move.w  #$22,d0 ; '"'
		btst    #7,cddArg1Cache(a5)
		beq.s   loc_2D26
		move.w  #$23,d0 ; '#'

loc_2D26:               ; CODE XREF: BIOS:00002D20j
		move.w  d0,cddCommandCache(a5)
		clr.w   word_5AEA(a5)
		clr.w   word_5AF4(a5)
		clr.w   word_5B0A(a5)
		bsr.w   getFirstTrack
		andi.w  #$FF,d0
		move.w  d0,word_5B16(a5)
		move.w  d0,word_5B00(a5)
		bsr.w   sub_CAC
		move.l  d0,dword_5B02(a5)
		clr.b   byte_5B13(a5)
		move.b  #3,byte_5B12(a5)
		bra.s   loc_2D66
; ---------------------------------------------------------------------------

loc_2D5A:               ; CODE XREF: BIOS:00002C74j
					; BIOS:00002CBAj ...
		move.w  #$1000,cddControlStatus(a5)
		move.w  #0,cddCommandCache(a5)

loc_2D66:               ; CODE XREF: BIOS:00002D58j
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_2D6A:               ; CODE XREF: BIOS:00002D00j
					; BIOS:00002D08j
		bra.w   loc_2AB6
; ---------------------------------------------------------------------------

loc_2D6E:               ; CODE XREF: BIOS:00002B6Cj
		bsr.w   sub_D0E
		cmpi.b  #4,d0
		beq.s   loc_2D7C
		bra.w   loc_2DCC
; ---------------------------------------------------------------------------

loc_2D7C:               ; CODE XREF: BIOS:00002D76j
		bset    #7,byte_5B18(a5)
		clr.w   word_5B0E(a5)
		move.w  #$28,cddCommandCache(a5) ; '('
		move.w  #$500,cddControlStatus(a5)
		move.w  #LEDDISCIN,ledMode(a5)
		bra.w   loc_2DBC
; ---------------------------------------------------------------------------

loc_2D9C:               ; CODE XREF: BIOS:00002B70j
		bsr.w   sub_D0E
		cmpi.b  #1,d0
		beq.s   loc_2DAA
		bra.w   loc_2DCC
; ---------------------------------------------------------------------------

loc_2DAA:               ; CODE XREF: BIOS:00002DA4j
		move.w  #$25,cddCommandCache(a5) ; '%'
		move.w  #$100,cddControlStatus(a5)
		move.w  #LEDACCESS,ledMode(a5)

loc_2DBC:               ; CODE XREF: BIOS:00002D98j
		move.w  word_5B16(a5),word_5B00(a5)
		move.w  #$25,word_5AEA(a5) ; '%'
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_2DCC:               ; CODE XREF: BIOS:00002D78j
					; BIOS:00002DA6j
		cmpi.b  #5,d0
		beq.s   loc_2DE2
		cmpi.b  #$B,d0
		beq.s   loc_2DE2
		cmpi.b  #$E,d0
		beq.s   loc_2DE2
		bra.w   loc_2AB6
; ---------------------------------------------------------------------------

loc_2DE2:               ; CODE XREF: BIOS:00002DD0j
					; BIOS:00002DD6j ...
		move.w  #1,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_2DEC:               ; CODE XREF: BIOS:loc_2AE4j
		move.w  #LEDREADY,ledMode(a5)
		move.w  #$1000,cddControlStatus(a5)
		bsr.w   sub_D0E
		cmpi.b  #5,d0
		beq.s   loc_2E12
		cmpi.b  #$E,d0
		beq.s   loc_2E12
		cmpi.b  #9,d0
		beq.s   loc_2E12
		bra.w   loc_2AB6
; ---------------------------------------------------------------------------

loc_2E12:               ; CODE XREF: BIOS:00002E00j
					; BIOS:00002E06j ...
		move.w  #1,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_2E1C:               ; CODE XREF: BIOS:00002E32j
					; BIOS:00002EA6j
		bsr.w   cddSetContinueAddress
		btst    #7,cddCommand(a5)
		bne.w   loc_2AB6
		bsr.w   sub_D0E
		cmpi.b  #$E,d0
		beq.s   loc_2E1C
		bra.s   loc_2EAA
; ---------------------------------------------------------------------------

loc_2E36:               ; CODE XREF: BIOS:00002AE8j
		move.w  #LEDERROR,ledMode(a5)
		bset    #7,byte_5B19(a5)
		bra.s   loc_2E50
; ---------------------------------------------------------------------------

loc_2E44:               ; CODE XREF: BIOS:00002B0Cj
					; BIOS:00002E80j
		move.w  #LEDREADY,ledMode(a5)
		bclr    #7,byte_5B19(a5)

loc_2E50:               ; CODE XREF: BIOS:00002E42j
		bsr.w   sub_D0E
		cmpi.b  #0,d0
		beq.s   loc_2E82
		cmpi.b  #5,d0
		beq.s   loc_2EAA
		cmpi.b  #$B,d0
		beq.s   loc_2E82
		cmpi.b  #$E,d0
		beq.s   loc_2E82
		move.w  #$8010,d0
		bsr.w   sub_B0C

loc_2E74:               ; CODE XREF: BIOS:00002E7Cj
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_2E74
		tst.b   d0
		bne.s   loc_2E44

loc_2E82:               ; CODE XREF: BIOS:00002E58j
					; BIOS:00002E64j ...
		move.w  #$53,word_5B22(a5) ; 'S'
		move.w  #$80D0,d0
		bsr.w   sub_B0C

loc_2E90:               ; CODE XREF: BIOS:00002EA2j
		bsr.w   cddSetContinueAddress
		cmpi.w  #$8010,cddCommand(a5)
		beq.w   loc_2AB6
		bsr.w   sub_AF6
		bcs.s   loc_2E90
		tst.b   d0
		bne.w   loc_2E1C

loc_2EAA:               ; CODE XREF: BIOS:00002E34j
					; BIOS:00002E5Ej ...
		move.w  #$4000,cddControlStatus(a5)
		bsr.w   cddSetContinueAddress
		cmpi.w  #$8010,cddCommand(a5)
		beq.w   loc_2AB6
		bsr.w   sub_D0E
		cmpi.b  #5,d0
		beq.s   loc_2EAA
		cmpi.b  #6,d0
		beq.s   loc_2EAA
		cmpi.b  #8,d0
		beq.s   loc_2EAA
		cmpi.b  #7,d0
		beq.s   loc_2EAA
		move.w  #$10,cddCommandCache(a5)
		move.w  #$101,d0
		bclr    #7,byte_5B19(a5)
		beq.s   loc_2EF0
		move.w  #$1FF,d0

loc_2EF0:               ; CODE XREF: BIOS:00002EEAj
		move.w  d0,cddArg1Cache(a5)
		bra.w   loc_2AB6
; ---------------------------------------------------------------------------

loc_2EF8:               ; CODE XREF: BIOS:00002B10j
		bset    #2,byte_5B18(a5)
		move.w  #LEDSTANDBY,ledMode(a5)
		bra.s   loc_2F12
; ---------------------------------------------------------------------------

loc_2F06:               ; CODE XREF: BIOS:00002AECj
		move.w  #LEDDISCIN,ledMode(a5)
		move.w  word_5B16(a5),word_5B00(a5)

loc_2F12:               ; CODE XREF: BIOS:00002F04j
		andi.b  #$5F,byte_5B18(a5) ; '_'

loc_2F18:               ; CODE XREF: BIOS:00002F48j
		bsr.w   sub_D0E
		cmpi.b  #0,d0
		beq.s   loc_2F4A
		cmpi.b  #5,d0
		beq.s   loc_2F4A
		cmpi.b  #$B,d0
		beq.s   loc_2F4A
		cmpi.b  #$E,d0
		beq.s   loc_2F4A
		move.w  #$8010,d0
		bsr.w   sub_B0C

loc_2F3C:               ; CODE XREF: BIOS:00002F44j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_2F3C
		tst.b   d0
		bne.s   loc_2F18

loc_2F4A:               ; CODE XREF: BIOS:00002F20j
					; BIOS:00002F26j ...
		move.w  #0,cddControlStatus(a5)
		move.w  #$24,cddCommandCache(a5) ; '$'
		bsr.w   sub_2B9A

loc_2F5A:               ; CODE XREF: BIOS:00002B74j
		bsr.w   sub_D0E
		move.w  #0,cddControlStatus(a5)
		cmpi.b  #5,d0
		beq.s   loc_2F7A
		cmpi.b  #$B,d0
		beq.s   loc_2F7A
		cmpi.b  #$E,d0
		beq.s   loc_2F7A
		bra.w   loc_2AB6
; ---------------------------------------------------------------------------

loc_2F7A:               ; CODE XREF: BIOS:00002F68j
					; BIOS:00002F6Ej ...
		move.w  #1,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_2F84:               ; CODE XREF: BIOS:0000336Cj
		move.w  cddCommandCache(a5),word_5ADC(a5)
		bset    #0,byte_5B18(a5)
		andi.b  #$5D,byte_5B18(a5) ; ']'
		bset    #6,byte_5B19(a5)
		move.w  #$40,word_5AFE(a5) ; '@'
		bra.w   loc_306C
; ---------------------------------------------------------------------------

loc_2FA6:               ; CODE XREF: BIOS:00003598j
					; BIOS:000035ACj ...
		move.w  $5AEA(a5),word_5ADC(a5)
		andi.b  #$5C,byte_5B18(a5) ; '\'
		move.w  #$30,word_5AFE(a5) ; '0'
		bra.w   loc_306C
; ---------------------------------------------------------------------------

loc_2FBC:               ; CODE XREF: BIOS:00002B3Cj
		move.w  #$28,word_5ADC(a5) ; '('
		bset    #0,byte_5B18(a5)
		bclr    #1,byte_5B18(a5)
		move.w  #$40,word_5AFE(a5) ; '@'
		bra.s   loc_2FEE
; ---------------------------------------------------------------------------

loc_2FD6:               ; CODE XREF: BIOS:00002B34j
		move.w  #LEDDISCIN,ledMode(a5)
		move.w  #$25,word_5ADC(a5) ; '%'
		andi.b  #$FC,byte_5B18(a5)
		move.w  #$30,word_5AFE(a5) ; '0'

loc_2FEE:               ; CODE XREF: BIOS:00002FD4j
					; BIOS:00003682j ...
		andi.b  #$5F,byte_5B18(a5) ; '_'
		move.l  cddArg1Cache(a5),d0
		move.l  d0,dword_5B02(a5)
		clr.w   word_5B00(a5)
		bra.s   loc_306C
; ---------------------------------------------------------------------------

loc_3002:               ; CODE XREF: BIOS:00002B48j
		bset    #3,byte_5B18(a5)

loc_3008:               ; CODE XREF: BIOS:00002B38j
		move.w  #$28,word_5ADC(a5) ; '('
		bset    #0,byte_5B18(a5)
		bclr    #1,byte_5B18(a5)
		move.w  #$40,word_5AFE(a5) ; '@'
		bra.s   loc_3056
; ---------------------------------------------------------------------------

loc_3022:               ; CODE XREF: BIOS:00002B2Cj
		move.w  #LEDDISCIN,ledMode(a5)
		move.w  #$26,word_5ADC(a5) ; '&'
		bra.s   loc_304A
; ---------------------------------------------------------------------------

loc_3030:               ; CODE XREF: BIOS:00002B30j
		move.w  #LEDDISCIN,ledMode(a5)
		move.w  #$27,word_5ADC(a5) ; '''
		bra.s   loc_304A
; ---------------------------------------------------------------------------

loc_303E:               ; CODE XREF: BIOS:00002B28j
		move.w  #LEDDISCIN,ledMode(a5)
		move.w  #$25,word_5ADC(a5) ; '%'

loc_304A:               ; CODE XREF: BIOS:0000302Ej
					; BIOS:0000303Cj
		andi.b  #$FC,byte_5B18(a5)
		move.w  #$30,word_5AFE(a5) ; '0'

loc_3056:               ; CODE XREF: BIOS:00003020j
		andi.b  #$5F,byte_5B18(a5) ; '_'
		move.w  cddArg1Cache(a5),d0
		move.w  d0,word_5B00(a5)
		bsr.w   sub_CAC
		move.l  d0,dword_5B02(a5)

loc_306C:               ; CODE XREF: BIOS:00002FA2j
					; BIOS:00002FB8j ...
		cmpi.w  #$8010,cddCommand(a5)
		beq.w   loc_2AB6
		cmpi.w  #$800A,cddCommand(a5)
		beq.w   loc_2AB6
		bsr.w   sub_D0E
		cmpi.b  #1,d0
		beq.s   loc_30CC
		cmpi.b  #4,d0
		beq.s   loc_30CC
		cmpi.b  #$C,d0
		beq.s   loc_30CC
		cmpi.b  #5,d0
		beq.w   loc_31E0
		cmpi.b  #$B,d0
		beq.w   loc_31E0
		cmpi.b  #$E,d0
		beq.w   loc_31E0
		bra.s   loc_30B4
; ---------------------------------------------------------------------------

loc_30B0:               ; CODE XREF: BIOS:000030BCj
		bsr.w   cddSetContinueAddress

loc_30B4:               ; CODE XREF: BIOS:000030AEj
					; BIOS:00003104j
		move.w  #$60,d0 ; '`'
		bsr.w   sub_B0C
		bcs.s   loc_30B0

loc_30BE:               ; CODE XREF: BIOS:000030C6j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_30BE
		tst.b   d0
		bne.s   loc_306C

loc_30CC:               ; CODE XREF: BIOS:00003088j
					; BIOS:0000308Ej ...
		move.w  #0,word_5B0A(a5)
		bsr.w   sub_2BBC
		move.w  #$800,cddControlStatus(a5)
		btst    #1,byte_5B18(a5)
		beq.s   loc_30EA
		move.w  #$808,cddControlStatus(a5)

loc_30EA:               ; CODE XREF: BIOS:000030E2j
		bra.s   loc_3106
; ---------------------------------------------------------------------------

loc_30EC:               ; CODE XREF: BIOS:00003112j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_D0E
		cmpi.b  #1,d0
		beq.s   loc_3106
		cmpi.b  #4,d0
		beq.s   loc_3106
		cmpi.b  #$C,d0
		bne.s   loc_30B4

loc_3106:               ; CODE XREF: BIOS:loc_30EAj
					; BIOS:000030F8j ...
		move.l  dword_5B02(a5),d1
		move.w  #$A0,d0 ; ' '
		bsr.w   sub_B0C
		bcs.s   loc_30EC
		bra.s   loc_311A
; ---------------------------------------------------------------------------

loc_3116:               ; CODE XREF: BIOS:00003126j
		bsr.w   cddSetContinueAddress

loc_311A:               ; CODE XREF: BIOS:00003114j
		move.l  dword_5B02(a5),d1
		move.w  word_5AFE(a5),d0
		bsr.w   sub_B0C
		bcs.s   loc_3116

loc_3128:               ; CODE XREF: BIOS:00003146j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_D0E
		cmpi.b  #8,d0
		bne.s   loc_3142
		bsr.w   sub_D7C
		cmpi.b  #6,d0
		bcc.w   loc_306C

loc_3142:               ; CODE XREF: BIOS:00003134j
		bsr.w   sub_AF6
		bcs.s   loc_3128
		tst.b   d0
		bne.w   loc_306C
		move.w  #$FFFF,word_5B0A(a5)
		bsr.w   sub_2BBC
		move.w  word_5ADC(a5),cddCommandCache(a5)
		btst    #1,byte_5B18(a5)
		beq.s   loc_3192
		cmpi.w  #$2B,word_5ADC(a5) ; '+'
		bne.s   loc_3178
		bset    #6,byte_5B18(a5)
		clr.w   word_5B0E(a5)

loc_3178:               ; CODE XREF: BIOS:0000316Cj
		bsr.w   sub_3728
; ---------------------------------------------------------------------------
		btst    #0,byte_5B18(a5)
		bne.s   loc_31BE
		move.w  #$101,cddControlStatus(a5)
		move.w  #LEDACCESS,ledMode(a5)
		bra.s   loc_31BE
; ---------------------------------------------------------------------------

loc_3192:               ; CODE XREF: BIOS:00003164j
		btst    #0,byte_5B18(a5)
		bne.s   loc_31B4
		lea cddCommandCache(a5),a0
		lea word_5AEA(a5),a1
		bsr.w   copyCddCommand
		move.w  #$100,cddControlStatus(a5)
		move.w  #LEDACCESS,ledMode(a5)
		bra.s   loc_31DC
; ---------------------------------------------------------------------------

loc_31B4:               ; CODE XREF: BIOS:00003198j
		bset    #7,byte_5B18(a5)
		clr.w   word_5B0E(a5)

loc_31BE:               ; CODE XREF: BIOS:00003182j
					; BIOS:00003190j
		bclr    #6,byte_5B19(a5)
		bne.w   loc_2AD0
		move.w  #$25,d0 ; '%'
		bclr    #3,byte_5B18(a5)
		beq.s   loc_31D8
		move.w  #$26,d0 ; '&'

loc_31D8:               ; CODE XREF: BIOS:000031D2j
		move.w  d0,word_5AEA(a5)

loc_31DC:               ; CODE XREF: BIOS:000031B2j
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_31E0:               ; CODE XREF: BIOS:0000309Aj
					; BIOS:000030A2j ...
		move.w  #$FFFF,word_5B0A(a5)
		bsr.w   sub_2BBC

loc_31EA:               ; CODE XREF: BIOS:000031F2j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_31EA
		tst.b   d0
		move.w  #1,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3200:               ; CODE XREF: BIOS:00002B78j
		move.w  #$100,cddControlStatus(a5)
		bsr.w   sub_D0E
		cmpi.b  #$C,d0
		beq.s   loc_323A
		cmpi.b  #8,d0
		beq.s   loc_3244
		cmpi.b  #6,d0
		beq.s   loc_3222
		cmpi.b  #1,d0
		bne.s   loc_31E0

loc_3222:               ; CODE XREF: BIOS:0000321Aj
					; BIOS:0000324Ej
		bsr.w   getCurrentTrackNumber
		bcs.w   loc_2AB6
		cmp.w   word_5B00(a5),d0
		beq.w   loc_2AB6
		move.w  d0,word_5B00(a5)
		bra.w   loc_2AB6
; ---------------------------------------------------------------------------

loc_323A:               ; CODE XREF: BIOS:0000320Ej
		move.w  #3,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3244:               ; CODE XREF: BIOS:00003214j
		bsr.w   sub_D7C
		cmpi.b  #6,d0
		bcc.s   loc_31E0
		bra.s   loc_3222
; ---------------------------------------------------------------------------

loc_3250:               ; CODE XREF: BIOS:00002B80j
		move.w  #$100,cddControlStatus(a5)
		bsr.w   sub_D0E
		cmpi.b  #$C,d0
		beq.s   loc_3284
		cmpi.b  #8,d0
		beq.s   loc_3298
		cmpi.b  #6,d0
		beq.s   loc_3274
		cmpi.b  #1,d0
		bne.w   loc_31E0

loc_3274:               ; CODE XREF: BIOS:0000326Aj
					; BIOS:000032A4j
		bsr.w   getCurrentTrackNumber
		bcs.w   loc_2AB6
		cmp.w   word_5B00(a5),d0
		bls.w   loc_2AB6

loc_3284:               ; CODE XREF: BIOS:0000325Ej
		moveq   #0,d0
		move.w  word_5B00(a5),d0
		move.w  d0,cddArg1Cache(a5)
		move.w  #$13,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3298:               ; CODE XREF: BIOS:00003264j
		bsr.w   sub_D7C
		cmpi.b  #6,d0
		bcc.w   loc_31E0
		bra.s   loc_3274
; ---------------------------------------------------------------------------

loc_32A6:               ; CODE XREF: BIOS:00002B7Cj
		move.w  #$100,cddControlStatus(a5)
		bsr.w   sub_D0E
		cmpi.b  #$C,d0
		beq.s   loc_32DA
		cmpi.b  #8,d0
		beq.s   loc_32E4
		cmpi.b  #6,d0
		beq.s   loc_32CA
		cmpi.b  #1,d0
		bne.w   loc_31E0

loc_32CA:               ; CODE XREF: BIOS:000032C0j
					; BIOS:000032F0j
		bsr.w   getCurrentTrackNumber
		bcs.w   loc_2AB6
		cmp.w   word_5B00(a5),d0
		bls.w   loc_2AB6

loc_32DA:               ; CODE XREF: BIOS:000032B4j
		move.w  #3,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_32E4:               ; CODE XREF: BIOS:000032BAj
		bsr.w   sub_D7C
		cmpi.b  #6,d0
		bcc.w   loc_31E0
		bra.s   loc_32CA
; ---------------------------------------------------------------------------

loc_32F2:               ; CODE XREF: BIOS:00002B00j
		move.w  #LEDACCESS,ledMode(a5)
		bset    #5,byte_5B18(a5)
		bra.s   loc_332C
; ---------------------------------------------------------------------------

loc_3300:               ; CODE XREF: BIOS:00002AFCj
		move.w  #LEDACCESS,ledMode(a5)
		bclr    #5,byte_5B18(a5)
		bset    #4,byte_5B18(a5)
		bra.s   loc_332C
; ---------------------------------------------------------------------------

loc_3314:               ; CODE XREF: BIOS:00002AF8j
		move.w  #LEDACCESS,ledMode(a5)
		andi.b  #$CF,byte_5B18(a5)
		bsr.w   sub_D0E
		cmpi.b  #$C,d0
		beq.w   loc_3440

loc_332C:               ; CODE XREF: BIOS:000032FEj
					; BIOS:00003312j ...
		bsr.w   sub_D0E
		cmpi.b  #$C,d0
		beq.w   loc_33CA
		cmpi.b  #1,d0
		beq.w   loc_33CA
		cmpi.b  #4,d0
		beq.w   loc_33CA
		cmpi.b  #5,d0
		beq.w   loc_344A
		cmpi.b  #$B,d0
		beq.w   loc_344A
		cmpi.b  #$E,d0
		beq.w   loc_344A
		cmpi.b  #0,d0
		bne.s   loc_3370
		bclr    #2,byte_5B18(a5)
		bne.w   loc_2F84

loc_3370:               ; CODE XREF: BIOS:00003364j
		btst    #7,byte_5B18(a5)
		bne.s   loc_3382
		move.w  #$8070,d0
		bsr.w   sub_B0C
		bra.s   loc_33BA
; ---------------------------------------------------------------------------

loc_3382:               ; CODE XREF: BIOS:00003376j
		move.w  #0,word_5B0A(a5)
		bsr.w   sub_2BBC
		move.w  #$8060,d0
		bsr.w   sub_B0C

loc_3394:               ; CODE XREF: BIOS:0000339Cj
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_3394
		tst.b   d0
		move.w  #$FFFF,word_5B0A(a5)
		bsr.w   sub_2BBC
		move.l  dword_59F8(a5),d0
		bpl.s   loc_33B6
		move.l  #$20000,d0

loc_33B6:               ; CODE XREF: BIOS:000033AEj
		move.l  d0,dword_5B02(a5)

loc_33BA:               ; CODE XREF: BIOS:00003380j
					; BIOS:000033C2j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_33BA
		tst.b   d0
		bra.w   loc_332C
; ---------------------------------------------------------------------------

loc_33CA:               ; CODE XREF: BIOS:00003334j
					; BIOS:0000333Cj ...
		btst    #5,byte_5B18(a5)
		bne.s   loc_3412
		move.w  #$80,d0 ; '€'
		bchg    #4,byte_5B18(a5)
		beq.s   loc_33E2
		move.w  #$90,d0 ; ''

loc_33E2:               ; CODE XREF: BIOS:000033DCj
		move.w  d0,word_5B10(a5)
		bra.s   loc_33EC
; ---------------------------------------------------------------------------

loc_33E8:               ; CODE XREF: BIOS:000033F4j
		bsr.w   cddSetContinueAddress

loc_33EC:               ; CODE XREF: BIOS:000033E6j
		move.w  word_5B10(a5),d0
		bsr.w   sub_B0C
		bcs.s   loc_33E8

loc_33F6:               ; CODE XREF: BIOS:000033FEj
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_33F6
		tst.b   d0
		bne.s   loc_344A
		move.w  #$300,cddControlStatus(a5)
		bset    #5,byte_5B18(a5)
		bra.s   loc_3440
; ---------------------------------------------------------------------------

loc_3412:               ; CODE XREF: BIOS:000033D0j
		bclr    #5,byte_5B18(a5)
		btst    #7,byte_5B18(a5)
		bne.s   loc_3436
		move.w  #$100,cddControlStatus(a5)
		lea word_5AEA(a5),a0
		lea cddCommandCache(a5),a1
		bsr.w   copyCddCommand
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3436:               ; CODE XREF: BIOS:0000341Ej
		move.w  #3,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3440:               ; CODE XREF: BIOS:00003328j
					; BIOS:00003410j
		move.w  #$29,cddCommandCache(a5) ; ')'
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_344A:               ; CODE XREF: BIOS:0000334Cj
					; BIOS:00003354j ...
		move.w  #1,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3454:               ; CODE XREF: BIOS:00002B88j
		move.w  #$300,cddControlStatus(a5)
		bsr.w   sub_D0E
		cmpi.b  #2,d0
		beq.s   loc_3490
		cmpi.b  #1,d0
		beq.s   loc_3490
		cmpi.b  #$C,d0
		beq.s   loc_3490
		cmpi.b  #3,d0
		beq.w   loc_2AB6
		cmpi.b  #6,d0
		beq.w   loc_2AB6
		cmpi.b  #8,d0
		beq.s   loc_349A

loc_3486:               ; CODE XREF: BIOS:000034A2j
		move.w  #1,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3490:               ; CODE XREF: BIOS:00003462j
					; BIOS:00003468j ...
		move.w  #3,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_349A:               ; CODE XREF: BIOS:00003484j
		bsr.w   sub_D7C
		cmpi.b  #6,d0
		bcc.s   loc_3486
		bra.w   loc_2AB6
; ---------------------------------------------------------------------------

loc_34A8:               ; CODE XREF: BIOS:00002AF0j
		bclr    #2,byte_5B18(a5)

loc_34AE:               ; CODE XREF: BIOS:00002B14j
		andi.b  #$5F,byte_5B18(a5) ; '_'
		move.w  #LEDDISCIN,ledMode(a5)
		bra.s   loc_34E4
; ---------------------------------------------------------------------------

loc_34BC:               ; CODE XREF: BIOS:00002AF4j
		move.w  #LEDACCESS,ledMode(a5)
		bset    #7,byte_5B18(a5)
		bclr    #5,byte_5B18(a5)
		bra.s   loc_34E4
; ---------------------------------------------------------------------------

loc_34D0:               ; CODE XREF: BIOS:000034ECj
					; BIOS:00003522j
		move.w  #$8060,d0
		bsr.w   sub_B0C

loc_34D8:               ; CODE XREF: BIOS:000034E0j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_34D8
		tst.b   d0

loc_34E4:               ; CODE XREF: BIOS:000034BAj
					; BIOS:000034CEj
		bsr.w   sub_D0E
		cmpi.b  #$A,d0
		beq.s   loc_34D0
		cmpi.b  #5,d0
		beq.w   loc_3606
		cmpi.b  #$B,d0
		beq.w   loc_3606
		cmpi.b  #$E,d0
		beq.w   loc_3606
		btst    #7,byte_5B18(a5)
		bne.w   loc_3590
		cmpi.b  #$C,d0
		beq.w   loc_3576
		cmpi.b  #4,d0
		beq.s   loc_3576
		cmpi.b  #0,d0
		beq.s   loc_34D0
		move.w  #0,word_5B0A(a5)
		bsr.w   sub_2BBC
		move.w  #3,word_5B20(a5)
		bra.s   loc_353A
; ---------------------------------------------------------------------------

loc_3536:               ; CODE XREF: BIOS:00003542j
		bsr.w   cddSetContinueAddress

loc_353A:               ; CODE XREF: BIOS:00003534j
					; BIOS:00003556j
		move.w  #$60,d0 ; '`'
		bsr.w   sub_B0C
		bcs.s   loc_3536

loc_3544:               ; CODE XREF: BIOS:0000354Cj
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_3544
		tst.b   d0
		beq.s   loc_355C
		subq.w  #1,word_5B20(a5)
		bcc.s   loc_353A
		bra.w   loc_35FC
; ---------------------------------------------------------------------------

loc_355C:               ; CODE XREF: BIOS:00003550j
		move.w  #$FFFF,word_5B0A(a5)
		bsr.w   sub_2BBC
		move.l  dword_59F8(a5),d0
		bpl.s   loc_3572
		move.l  #$20000,d0

loc_3572:               ; CODE XREF: BIOS:0000356Aj
		move.l  d0,dword_5B02(a5)

loc_3576:               ; CODE XREF: BIOS:00003514j
					; BIOS:0000351Cj
		move.w  #$500,cddControlStatus(a5)
		bset    #7,byte_5B18(a5)
		clr.w   word_5B0E(a5)
		move.w  #$28,cddCommandCache(a5) ; '('
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_3590:               ; CODE XREF: BIOS:0000350Cj
		bclr    #2,byte_5B18(a5)
		beq.s   loc_359C
		bra.w   loc_2FA6
; ---------------------------------------------------------------------------

loc_359C:               ; CODE XREF: BIOS:00003596j
		cmpi.b  #$C,d0
		beq.s   loc_35DC
		cmpi.b  #1,d0
		beq.s   loc_35DC
		cmpi.b  #0,d0
		beq.w   loc_2FA6
		move.w  #3,word_5B20(a5)
		bra.s   loc_35BC
; ---------------------------------------------------------------------------

loc_35B8:               ; CODE XREF: BIOS:000035C4j
		bsr.w   cddSetContinueAddress

loc_35BC:               ; CODE XREF: BIOS:000035B6j
		move.w  #$70,d0 ; 'p'
		bsr.w   sub_B0C
		bcs.s   loc_35B8

loc_35C6:               ; CODE XREF: BIOS:000035CEj
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_35C6
		tst.b   d0
		beq.s   loc_35DC
		bsr.w   loc_2BA2
		bra.w   loc_2FA6
; ---------------------------------------------------------------------------

loc_35DC:               ; CODE XREF: BIOS:000035A0j
					; BIOS:000035A6j ...
		bsr.w   loc_2BA2
		move.w  #$100,cddControlStatus(a5)
		bclr    #7,byte_5B18(a5)
		lea word_5AEA(a5),a0
		lea cddCommandCache(a5),a1
		bsr.w   copyCddCommand
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_35FC:               ; CODE XREF: BIOS:00003558j
		move.w  #$FFFF,word_5B0A(a5)
		bsr.w   sub_2BBC

loc_3606:               ; CODE XREF: BIOS:000034F2j
					; BIOS:000034FAj ...
		move.w  #1,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3610:               ; CODE XREF: BIOS:00002B84j
		move.w  #$500,cddControlStatus(a5)
		bsr.w   sub_D0E
		cmpi.b  #8,d0
		beq.s   loc_3658
		cmpi.b  #6,d0
		beq.s   loc_3632
		cmpi.b  #$C,d0
		beq.s   loc_3632
		cmpi.b  #4,d0
		bne.s   loc_3606

loc_3632:               ; CODE XREF: BIOS:00003624j
					; BIOS:0000362Aj ...
		btst    #1,cdcBitfield0(a5)
		bne.s   loc_363E
		bsr.w   _cdcstop

loc_363E:               ; CODE XREF: BIOS:00003638j
		addq.w  #1,word_5B0E(a5)
		move.w  word_5B0E(a5),d0
		cmp.w   cddSpindownDelay(a5),d0
		bls.w   loc_2AB6
		move.w  #$B,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3658:               ; CODE XREF: BIOS:0000361Ej
		bsr.w   sub_D7C
		cmpi.b  #6,d0
		bcc.s   loc_3606
		bra.s   loc_3632
; ---------------------------------------------------------------------------

loc_3664:               ; CODE XREF: BIOS:00003860j
					; BIOS:0000388Cj
		andi.b  #$9E,byte_5B18(a5)
		bset    #1,byte_5B18(a5)
		move.w  word_5AF4(a5),word_5ADC(a5)
		move.w  #$30,word_5AFE(a5) ; '0'
		move.l  dword_5A30(a5),cddArg1Cache(a5)
		bra.w   loc_2FEE
; ---------------------------------------------------------------------------

loc_3686:               ; CODE XREF: BIOS:00002B44j
		move.w  #LEDDISCIN,ledMode(a5)
		move.l  cddArg1Cache(a5),d0
		addi.l  #$96,d0 ; '–'
		bsr.w   sub_82E
		move.l  d0,cddArg1Cache(a5)
		move.w  #$2B,word_5ADC(a5) ; '+'
		ori.b   #3,byte_5B18(a5)
		move.w  #$40,word_5AFE(a5) ; '@'
		lea cddCommandCache(a5),a0
		lea word_5AF4(a5),a1
		bsr.w   copyCddCommand
		bra.w   loc_2FEE
; ---------------------------------------------------------------------------

loc_36C0:               ; CODE XREF: BIOS:00002B64j
		move.l  cddArg1Cache(a5),d0
		addi.l  #$95,d0 ; '•'
		add.l   cddArg2Cache(a5),d0
		move.l  d0,cddArg2Cache(a5)
		bra.w   loc_36DE
; ---------------------------------------------------------------------------

loc_36D6:               ; CODE XREF: BIOS:00002B40j
		move.l  #$FFFFFFFF,cddArg2Cache(a5)

loc_36DE:               ; CODE XREF: BIOS:00002B68j
					; BIOS:000036D2j
		bset    #2,byte_5B18(a5)
		move.w  #LEDDISCIN,ledMode(a5)
		lea cddCommandCache(a5),a0
		lea word_5AF4(a5),a1
		bsr.w   copyCddCommand
		move.l  cddArg1Cache(a5),d0
		addi.l  #$94,d0 ; '”'
		bsr.w   sub_82E
		move.l  d0,cddArg1Cache(a5)
		move.w  #$2A,word_5ADC(a5) ; '*'
		bclr    #0,byte_5B18(a5)
		bset    #1,byte_5B18(a5)
		move.w  #$30,word_5AFE(a5) ; '0'
		bsr.w   sub_1808
		bra.w   loc_2FEE

; =============== S U B R O U T I N E =======================================

; Attributes: noreturn

sub_3728:               ; CODE XREF: BIOS:loc_3178p
		move.l  (sp)+,dword_5AD8(a5)
		move.l  cddArg1Cache(a5),d0
		bsr.w   sub_7EE
		addq.l  #2,d0
		move.l  cddArg2Cache(a5),d1
		bsr.w   loc_1AFE
; End of function sub_3728

; ---------------------------------------------------------------------------
		movea.l dword_5AD8(a5),a0
		jmp (a0)
; ---------------------------------------------------------------------------

loc_3744:               ; CODE XREF: BIOS:00002B8Cj
		bsr.w   _cdcstat
		bcc.s   loc_375A
		tst.b   d0
		beq.s   loc_375A
		cmpi.b  #1,d0
		beq.s   loc_3768
		btst    #0,d0
		bne.s   loc_3772

loc_375A:               ; CODE XREF: BIOS:00003748j
					; BIOS:0000374Cj
		bra.w   loc_2AB6
; ---------------------------------------------------------------------------

loc_375E:               ; CODE XREF: BIOS:0000377Aj
		clr.b   byte_5B13(a5)
		move.b  #3,byte_5B12(a5)

loc_3768:               ; CODE XREF: BIOS:00003752j
		move.w  #$C,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3772:               ; CODE XREF: BIOS:00003758j
		move.b  d0,byte_5B13(a5)
		subq.b  #1,byte_5B12(a5)
		bcs.s   loc_375E
		bsr.w   _cdcstop
		lea word_5AF4(a5),a0
		lea cddCommandCache(a5),a1
		bsr.w   copyCddCommand
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3790:               ; CODE XREF: BIOS:00002B04j
		andi.b  #$9F,byte_5B18(a5)
		move.w  #LEDDISCIN,ledMode(a5)
		bra.s   loc_37C6
; ---------------------------------------------------------------------------

loc_379E:               ; CODE XREF: BIOS:00002B08j
		move.w  #LEDACCESS,ledMode(a5)
		bset    #6,byte_5B18(a5)
		bclr    #5,byte_5B18(a5)
		bra.s   loc_37C6
; ---------------------------------------------------------------------------

loc_37B2:               ; CODE XREF: BIOS:000037CEj
					; BIOS:00003802j
		move.w  #$8060,d0
		bsr.w   sub_B0C

loc_37BA:               ; CODE XREF: BIOS:000037C2j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_37BA
		tst.b   d0

loc_37C6:               ; CODE XREF: BIOS:0000379Cj
					; BIOS:000037B0j
		bsr.w   sub_D0E
		cmpi.b  #$A,d0
		beq.s   loc_37B2
		cmpi.b  #5,d0
		beq.w   loc_38AE
		cmpi.b  #$B,d0
		beq.w   loc_38AE
		cmpi.b  #$E,d0
		beq.w   loc_38AE
		btst    #6,byte_5B18(a5)
		bne.s   loc_3850
		cmpi.b  #$C,d0
		beq.w   loc_3832
		cmpi.b  #4,d0
		beq.s   loc_3832
		cmpi.b  #0,d0
		beq.s   loc_37B2
		move.w  #3,word_5B20(a5)
		bra.s   loc_3810
; ---------------------------------------------------------------------------

loc_380C:               ; CODE XREF: BIOS:00003818j
		bsr.w   cddSetContinueAddress

loc_3810:               ; CODE XREF: BIOS:0000380Aj
					; BIOS:0000382Cj
		move.w  #$60,d0 ; '`'
		bsr.w   sub_B0C
		bcs.s   loc_380C

loc_381A:               ; CODE XREF: BIOS:00003822j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_381A
		tst.b   d0
		beq.s   loc_3832
		subq.w  #1,word_5B20(a5)
		bcc.s   loc_3810
		bra.w   loc_38AE
; ---------------------------------------------------------------------------

loc_3832:               ; CODE XREF: BIOS:000037F4j
					; BIOS:000037FCj ...
		bsr.w   sub_19C4
		move.w  #$505,cddControlStatus(a5)
		bset    #6,byte_5B18(a5)
		clr.w   word_5B0E(a5)
		move.w  #$2B,cddCommandCache(a5) ; '+'
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_3850:               ; CODE XREF: BIOS:000037EEj
		cmpi.b  #$C,d0
		beq.s   loc_3890
		cmpi.b  #1,d0
		beq.s   loc_3890
		cmpi.b  #0,d0
		beq.w   loc_3664
		move.w  #3,word_5B20(a5)
		bra.s   loc_3870
; ---------------------------------------------------------------------------

loc_386C:               ; CODE XREF: BIOS:00003878j
		bsr.w   cddSetContinueAddress

loc_3870:               ; CODE XREF: BIOS:0000386Aj
		move.w  #$70,d0 ; 'p'
		bsr.w   sub_B0C
		bcs.s   loc_386C

loc_387A:               ; CODE XREF: BIOS:00003882j
		bsr.w   cddSetContinueAddress
		bsr.w   sub_AF6
		bcs.s   loc_387A
		tst.b   d0
		beq.s   loc_3890
		bsr.w   loc_2BA2
		bra.w   loc_3664
; ---------------------------------------------------------------------------

loc_3890:               ; CODE XREF: BIOS:00003854j
					; BIOS:0000385Aj ...
		bsr.w   sub_19D4
		bsr.w   loc_2BA2
		move.w  #$101,cddControlStatus(a5)
		bclr    #6,byte_5B18(a5)
		move.w  #$2A,cddCommandCache(a5) ; '*'
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_38AE:               ; CODE XREF: BIOS:000037D4j
					; BIOS:000037DCj ...
		move.w  #1,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_38B8:               ; CODE XREF: BIOS:00002B90j
		move.w  #$505,cddControlStatus(a5)
		bsr.w   sub_D0E
		cmpi.b  #8,d0
		beq.s   loc_38F4
		cmpi.b  #6,d0
		beq.s   loc_38DA
		cmpi.b  #$C,d0
		beq.s   loc_38DA
		cmpi.b  #4,d0
		bne.s   loc_38AE

loc_38DA:               ; CODE XREF: BIOS:000038CCj
					; BIOS:000038D2j ...
		addq.w  #1,word_5B0E(a5)
		move.w  word_5B0E(a5),d0
		cmp.w   cddSpindownDelay(a5),d0
		bls.w   loc_2AB6
		move.w  #$B,cddCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_38F4:               ; CODE XREF: BIOS:000038C6j
		bsr.w   sub_D7C
		cmpi.b  #6,d0
		bcc.s   loc_38AE
		bra.s   loc_38DA
; ---------------------------------------------------------------------------
word_3900:  dc.w 4          ; DATA XREF: installJumpTable+50o
		dc.w 0

; =============== S U B R O U T I N E =======================================


_cdboot:
		movem.l a5,-(sp)
		movea.l #0,a5
		add.w   d0,d0
		add.w   d0,d0
		cmpi.w  #40,d0
		bcc.s   loc_391C
		jsr loc_3922(pc,d0.w)

loc_391C:               ; CODE XREF: _cdboot+12j
		movem.l (sp)+,a5
		rts
; End of function _cdboot

; ---------------------------------------------------------------------------

loc_3922:
		bra.w   _cbtinit
; ---------------------------------------------------------------------------
		bra.w   _cbtint
; ---------------------------------------------------------------------------
		bra.w   _cbtopendisc
; ---------------------------------------------------------------------------
		bra.w   _cbtopenstat
; ---------------------------------------------------------------------------
		bra.w   _cbtchkdisc
; ---------------------------------------------------------------------------
		bra.w   _cbtchkstat
; ---------------------------------------------------------------------------
		bra.w   _cbtipdisc
; ---------------------------------------------------------------------------
		bra.w   _cbtipstat
; ---------------------------------------------------------------------------
		bra.w   _cbtspdisc
; ---------------------------------------------------------------------------
		bra.w   _cbtspstat
; ---------------------------------------------------------------------------

_cbtipstat:             ; CODE XREF: BIOS:0000393Ej
		moveq   #4,d1
		bra.s   loc_3958
; ---------------------------------------------------------------------------

_cbtspstat:             ; CODE XREF: BIOS:00003946j
		moveq   #3,d1
		bra.s   loc_3958
; ---------------------------------------------------------------------------

_cbtopenstat:               ; CODE XREF: BIOS:0000392Ej
		moveq   #6,d1
		bra.s   loc_3958
; ---------------------------------------------------------------------------

_cbtchkstat:                ; CODE XREF: BIOS:00003936j
		moveq   #5,d1

loc_3958:               ; CODE XREF: BIOS:0000394Cj
					; BIOS:00003950j ...
		move.w  (_BOOTSTAT).w,d0
		btst    d1,bootBitfield(a5)
		sne d1
		lsr.w   #1,d1
		rts
; ---------------------------------------------------------------------------

_cbtopendisc:               ; CODE XREF: BIOS:0000392Aj
		bset    #0,bootBitfield(a5)
		bne.s   loc_3986
		bsr.w   sub_3A6C
; ---------------------------------------------------------------------------
		clr.b   byte_5A05(a5)
		bset    #6,bootBitfield(a5)
		bclr    #0,bootBitfield(a5)
		or.w    d1,d1
		bra.s   locret_398A
; ---------------------------------------------------------------------------

loc_3986:               ; CODE XREF: BIOS:0000396Cj
		move    #1,ccr

locret_398A:                ; CODE XREF: BIOS:00003984j
		rts
; ---------------------------------------------------------------------------

_cbtchkdisc:                ; CODE XREF: BIOS:00003932j
		bset    #0,bootBitfield(a5)
		bne.s   loc_39B4
		bset    #5,bootBitfield(a5)
		bne.s   loc_39AA
		move.l  a0,dword_5B3E(a5)
		bsr.w   sub_3A6C
; ---------------------------------------------------------------------------
		bset    #5,bootBitfield(a5)

loc_39AA:               ; CODE XREF: BIOS:0000399Aj
		bclr    #0,bootBitfield(a5)
		or.w    d1,d1
		bra.s   locret_39B8
; ---------------------------------------------------------------------------

loc_39B4:               ; CODE XREF: BIOS:00003992j
		move    #1,ccr

locret_39B8:                ; CODE XREF: BIOS:000039B2j
		rts
; ---------------------------------------------------------------------------

_cbtipdisc:             ; CODE XREF: BIOS:0000393Aj
		bset    #0,bootBitfield(a5)
		bne.s   loc_39E8
		cmpi.w  #4,(_BOOTSTAT).w
		beq.s   loc_39D0
		cmpi.w  #6,(_BOOTSTAT).w

loc_39D0:               ; CODE XREF: BIOS:000039C8j
		bne.s   loc_39E8
		move.l  a0,dword_5B3E(a5)
		move.l  a1,dword_5B42(a5)
		bsr.w   loc_3A84
; ---------------------------------------------------------------------------
		move.b  #$90,bootBitfield(a5)
		or.w    d1,d1
		bra.s   locret_39EC
; ---------------------------------------------------------------------------

loc_39E8:               ; CODE XREF: BIOS:000039C0j
					; BIOS:loc_39D0j
		move    #1,ccr

locret_39EC:                ; CODE XREF: BIOS:000039E6j
		rts
; ---------------------------------------------------------------------------

_cbtspdisc:             ; CODE XREF: BIOS:00003942j
		bset    #0,bootBitfield(a5)
		bne.s   loc_3A1A
		cmpi.w  #4,(_BOOTSTAT).w
		beq.s   loc_3A04
		cmpi.w  #6,(_BOOTSTAT).w

loc_3A04:               ; CODE XREF: BIOS:000039FCj
		bne.s   loc_3A1A
		move.l  a1,dword_5B46(a5)
		bset    #3,bootBitfield(a5)
		bclr    #0,bootBitfield(a5)
		or.w    d1,d1
		bra.s   locret_3A1E
; ---------------------------------------------------------------------------

loc_3A1A:               ; CODE XREF: BIOS:000039F4j
					; BIOS:loc_3A04j
		move    #1,ccr

locret_3A1E:                ; CODE XREF: BIOS:00003A18j
		rts
; ---------------------------------------------------------------------------

_cbtint:                ; CODE XREF: BIOS:00003926j
		movem.l d7,-(sp)

		; Return if updater flag already set
		bset    #0,bootBitfield(a5)
		bne.s   loc_3A46

		; Return if bit 7 clear
		btst    #7,bootBitfield(a5)
		beq.s   loc_3A40

		; Fetch interrupt handler address and data
		movea.l cbtInterruptHandler(a5),a0
		movem.l cbtInterruptData(a5),d7
		jsr (a0)

loc_3A40:               ; CODE XREF: BIOS:00003A32j
		bclr    #0,bootBitfield(a5)

loc_3A46:               ; CODE XREF: BIOS:00003A2Aj
		movem.l (sp)+,d7
		rts

; =============== S U B R O U T I N E =======================================


cbtSetIntData:               ; CODE XREF: sub_3CDA+54p
		movem.l d7,cbtInterruptData(a5)
; End of function cbtSetIntData


; =============== S U B R O U T I N E =======================================


cbtSetIntHandler:               ; CODE XREF: sub_3A6C:loc_3A84p
					; sub_3A6C:loc_3AECp ...
		move.l  (sp)+,cbtInterruptHandler(a5)
		rts
; End of function cbtSetIntHandler

; ---------------------------------------------------------------------------

_cbtinit:               ; CODE XREF: BIOS:loc_3922j
		lea bootBitfield(a5),a0
		moveq   #0,d0
		moveq   #5,d1

loc_3A60:               ; CODE XREF: BIOS:00003A64j
		move.l  d0,(a0)+
		move.l  d0,(a0)+
		dbf d1,loc_3A60
		clr.b   byte_5A05(a5)

; =============== S U B R O U T I N E =======================================

; Attributes: noreturn

sub_3A6C:               ; CODE XREF: BIOS:0000396Ep
					; BIOS:000039A0p
		andi.b  #$87,bootBitfield(a5)
		move.w  #$FFFF,(_BOOTSTAT).w
		bclr    #1,bootBitfield(a5)
		bset    #7,bootBitfield(a5)

loc_3A84:               ; CODE XREF: BIOS:000039DAp
					; sub_3A6C+3Aj ...
		bsr.s   cbtSetIntHandler
		btst    #5,bootBitfield(a5)
		bne.s   loc_3AE0
		btst    #4,bootBitfield(a5)
		bne.s   loc_3AE0
		btst    #3,bootBitfield(a5)
		bne.s   loc_3AE0
		btst    #6,bootBitfield(a5)
		bne.s   loc_3AA8
		bra.s   loc_3A84
; ---------------------------------------------------------------------------

loc_3AA8:               ; CODE XREF: sub_3A6C+38j
		bsr.w   sub_3DD6
		andi.b  #$C7,bootBitfield(a5)
		moveq   #DRVOPEN,d0
		bsr.w   sub_3CBE
		bclr    #6,bootBitfield(a5)
		bra.s   loc_3A84
; ---------------------------------------------------------------------------
word_3AC0:  dc.w $101       ; DATA XREF: sub_3A6C:loc_3AE0o
word_3AC2:  dc.w $2FF       ; DATA XREF: sub_3A6C:loc_3ADAo
					; sub_3A6C+1D4o
; ---------------------------------------------------------------------------

loc_3AC4:               ; CODE XREF: sub_3A6C:loc_3C06j
		move.w  #3,(_BOOTSTAT).w
		bra.s   loc_3ADA
; ---------------------------------------------------------------------------
		move.w  #2,(_BOOTSTAT).w
		bra.s   loc_3ADA
; ---------------------------------------------------------------------------

loc_3AD4:               ; CODE XREF: sub_3A6C+12Ej
		move.w  #1,(_BOOTSTAT).w

loc_3ADA:               ; CODE XREF: sub_3A6C+5Ej sub_3A6C+66j
		lea word_3AC2(pc),a0
		bra.s   loc_3AE4
; ---------------------------------------------------------------------------

loc_3AE0:               ; CODE XREF: sub_3A6C+20j sub_3A6C+28j ...
		lea word_3AC0(pc),a0

loc_3AE4:               ; CODE XREF: sub_3A6C+72j
		move.w  #DRVINIT,d0
		bsr.w   sub_3CBE

loc_3AEC:               ; CODE XREF: sub_3A6C+AAj
		bsr.w   cbtSetIntHandler
		move.w  #CDBSTAT,d0
		jsr _CDBIOS
		lea (_CDSTAT).w,a0
		move.b  0(a0),d0
		cmpi.b  #$10,d0
		beq.w   loc_3B1E
		cmpi.b  #$40,d0 ; '@'
		beq.w   loc_3B18
		andi.w  #$F0,d0 ; 'ð'
		beq.s   loc_3B78
		bra.s   loc_3AEC
; ---------------------------------------------------------------------------

loc_3B18:               ; CODE XREF: sub_3A6C+A0j
					; sub_3A6C+154j
		nop
		nop
		nop

loc_3B1E:               ; CODE XREF: sub_3A6C+98j
		move.w  #0,(_BOOTSTAT).w

loc_3B24:               ; CODE XREF: sub_3A6C+11Ej
		bsr.w   sub_3DD6
		bclr    #5,bootBitfield(a5)
		bclr    #4,bootBitfield(a5)
		bra.w   loc_3A84
; ---------------------------------------------------------------------------
asc_3B38:
	dc.b 'SEGADISC        '
	dc.b 'SEGABOOTDISC    '
	dc.b 'SEGADATADISC    '
	dc.b 'SEGADISCSYSTEM  '
; ---------------------------------------------------------------------------

loc_3B78:               ; CODE XREF: sub_3A6C+A8j
		st  byte_5A05(a5)
		cmpi.w  #$FFFF,(_BOOTSTAT).w
		beq.s   loc_3B8C
		cmpi.w  #4,(_BOOTSTAT).w
		bcs.s   loc_3B24

loc_3B8C:               ; CODE XREF: sub_3A6C+116j
		move.w  #1,d1
		move.w  #CDBTOCREAD,d0
		jsr _CDBIOS
		tst.b   d1
		beq.w   loc_3AD4
		move.l  #0,dword_5B34(a5)

loc_3BA6:               ; CODE XREF: sub_3A6C+198j
		move.l  dword_5B34(a5),d0
		lsl.l   #8,d0
		lsl.l   #3,d0
		movea.l d0,a1
		move.l  #$800,d1
		move.l  dword_5B3E(a5),dword_5B4A(a5)
		bsr.w   sub_3CDA
		bcs.w   loc_3B18
		move.l  dword_5B4E(a5),d0
		bsr.w   sub_7EE
		subi.l  #$96,d0 ; '–'
		move.w  d0,word_5B32(a5)
		movea.l dword_5B3E(a5),a0
		lea asc_3B38(pc),a1 ; "SEGADISC    "
		moveq   #3,d0

loc_3BE0:               ; CODE XREF: sub_3A6C+18Aj
		movem.l a0-a1,-(sp)
		moveq   #3,d1

loc_3BE6:               ; CODE XREF: sub_3A6C+17Cj
		cmpm.l  (a0)+,(a1)+
		dbne    d1,loc_3BE6
		movem.l (sp)+,a0-a1
		beq.s   loc_3C0A
		adda.w  #$10,a1
		dbf d0,loc_3BE0
		lea dword_5B34(a5),a0
		cmpi.l  #$F,(a0)
		bls.s   loc_3BA6

loc_3C06:               ; CODE XREF: sub_3A6C+1BAj
		bra.w   loc_3AC4
; ---------------------------------------------------------------------------

loc_3C0A:               ; CODE XREF: sub_3A6C+184j
		cmpi.w  #0,d0
		beq.s   loc_3C16
		cmpi.w  #2,d0
		bne.s   loc_3C28

loc_3C16:               ; CODE XREF: sub_3A6C+1A2j
		movem.l d0/a0,-(sp)
		lea $200(a0),a0
		bsr.w   checkDiscBootBlock
		movem.l (sp)+,d0/a0
		bcs.s   loc_3C06

loc_3C28:               ; CODE XREF: sub_3A6C+1A8j
		addq.w  #4,d0
		move.w  d0,(_BOOTSTAT).w
		bset    #1,bootBitfield(a5)
		bsr.w   sub_3DD6
		btst    #4,bootBitfield(a5)
		bne.s   loc_3C56
		lea word_3AC2(pc),a0
		move.w  #$10,d0
		bsr.w   sub_3CBE
		bclr    #5,bootBitfield(a5)
		bra.w   loc_3A84
; ---------------------------------------------------------------------------

loc_3C56:               ; CODE XREF: sub_3A6C+1D2j
		movea.l dword_5B42(a5),a0
		bsr.w   sub_3DBC
		move.l  a0,dword_5B4A(a5)
		movea.l dword_5B3E(a5),a0
		movea.l $30(a0),a1
		cmpa.l  #$200,a1
		bne.s   loc_3C80
		cmpi.l  #$600,$34(a0)
		bne.s   loc_3C80
		bra.w   loc_3C88
; ---------------------------------------------------------------------------

loc_3C80:               ; CODE XREF: sub_3A6C+204j
					; sub_3A6C+20Ej
		bsr.w   sub_3CDA
		bcs.w   loc_3A84

loc_3C88:               ; CODE XREF: sub_3A6C+210j
		bclr    #4,bootBitfield(a5)

loc_3C8E:               ; CODE XREF: sub_3A6C+22Cj
		bsr.w   cbtSetIntHandler
		btst    #3,bootBitfield(a5)
		beq.s   loc_3C8E
		movea.l dword_5B3E(a5),a0
		movea.l $40(a0),a1
		move.l  $44(a0),d1
		move.l  dword_5B46(a5),dword_5B4A(a5)
		bsr.w   sub_3CDA
		bcs.w   loc_3A84
		bclr    #3,$5B24(a5)
		bra.w   loc_3A84
; End of function sub_3A6C


; =============== S U B R O U T I N E =======================================


sub_3CBE:               ; CODE XREF: sub_3A6C+48p sub_3A6C+7Cp ...
		move.l  (sp)+,dword_5B2E(a5)
		jsr _CDBIOS

loc_3CC6:               ; CODE XREF: sub_3CBE+14j
		bsr.w   cbtSetIntHandler
		move.w  #CDBCHK,d0
		jsr _CDBIOS
		bcs.s   loc_3CC6
		movea.l dword_5B2E(a5),a0
		jmp (a0)
; End of function sub_3CBE


; =============== S U B R O U T I N E =======================================


sub_3CDA:               ; CODE XREF: sub_3A6C+150p
					; sub_3A6C:loc_3C80p ...
		move.l  (sp)+,dword_5B2E(a5)
		lea dword_5B34(a5),a0
		move.l  a1,d0
		lsr.l   #8,d0
		lsr.l   #3,d0
		move.l  d0,(a0)
		divu.w  #$4B,d0 ; 'K'
		swap    d0
		bsr.w   convertToBcd
		move.b  d0,byte_5B52(a5)
		move.l  d1,d0
		lsr.l   #8,d0
		lsr.l   #3,d0
		andi.w  #$7FF,d1
		beq.s   loc_3D06
		addq.l  #1,d0

loc_3D06:               ; CODE XREF: sub_3CDA+28j
		move.l  d0,4(a0)
		move.w  d0,word_5B3C(a5)

loc_3D0E:               ; CODE XREF: sub_3CDA+64j sub_3CDA+74j ...
		tst.b   byte_5A05(a5)
		beq.w   loc_3DAC
		lea dword_5B34(a5),a0
		move.w  #ROMREADN,d0
		jsr _CDBIOS
		move.w  #$258,d7

loc_3D26:               ; CODE XREF: sub_3CDA+60j
		tst.b   byte_5A05(a5)
		beq.w   loc_3DAC
		bsr.w   cbtSetIntData

loc_3D32:               ; CODE XREF: sub_3CDA+CCj
		move.w  #CDCSTAT,d0
		jsr _CDBIOS
		dbcc    d7,loc_3D26
		bcs.s   loc_3D0E
		move.b  #3,(GA_CDC_TRANSFER).w
		move.w  #CDCREAD,d0
		jsr _CDBIOS
		bcs.s   loc_3D0E
		lsr.w   #8,d0
		cmp.b   byte_5B52(a5),d0
		bne.s   loc_3D0E
		movea.l dword_5B4A(a5),a0
		lea dword_5B4E(a5),a1
		move.w  #CDCTRN,d0
		jsr _CDBIOS
		bcs.s   loc_3D0E
		move.l  dword_5B4E(a5),d0
		lsr.w   #8,d0
		cmp.b   byte_5B52(a5),d0
		bne.s   loc_3D0E
		moveq   #1,d1
		move    #4,ccr
		abcd    d1,d0
		cmpi.b  #$75,d0 ; 'u'
		bcs.s   loc_3D86
		moveq   #0,d0

loc_3D86:               ; CODE XREF: sub_3CDA+A8j
		move.b  d0,byte_5B52(a5)
		move.l  a0,dword_5B4A(a5)
		move.w  #CDCACK,d0
		jsr _CDBIOS
		move.w  #6,d7
		addq.l  #1,dword_5B34(a5)
		subq.l  #1,dword_5B38(a5)
		subq.w  #1,word_5B3C(a5)
		bne.s   loc_3D32
		or.w    d1,d1
		bra.s   loc_3DB6
; ---------------------------------------------------------------------------

loc_3DAC:               ; CODE XREF: sub_3CDA+38j sub_3CDA+50j
		move.w  #$FFFF,(_BOOTSTAT).w
		move    #1,ccr

loc_3DB6:               ; CODE XREF: sub_3CDA+D0j
		movea.l dword_5B2E(a5),a0
		jmp (a0)
; End of function sub_3CDA


; =============== S U B R O U T I N E =======================================


sub_3DBC:               ; CODE XREF: sub_3A6C+1EEp
		movea.l dword_5B3E(a5),a1
		adda.w  #$200,a1
		move.w  #$5F,d1 ; '_'

loc_3DC8:               ; CODE XREF: sub_3DBC+14j
		move.l  (a1)+,(a0)+
		move.l  (a1)+,(a0)+
		move.l  (a1)+,(a0)+
		move.l  (a1)+,(a0)+
		dbf d1,loc_3DC8
		rts
; End of function sub_3DBC


; =============== S U B R O U T I N E =======================================


sub_3DD6:               ; CODE XREF: sub_3A6C:loc_3AA8p
					; sub_3A6C:loc_3B24p ...
		move.l  (sp)+,dword_5B2E(a5)
		bra.s   loc_3DE0
; ---------------------------------------------------------------------------

loc_3DDC:               ; CODE XREF: sub_3DD6+2Aj
		bsr.w   cbtSetIntHandler

loc_3DE0:               ; CODE XREF: sub_3DD6+4j
		lea unk_3E36(pc),a0
		cmpi.w  #4,(_BOOTSTAT).w
		bcs.s   loc_3E14
		cmpi.w  #$FFFF,(_BOOTSTAT).w
		beq.s   loc_3E14
		lea unk_3E32(pc),a0
		move.w  #WONDERREQ,d0
		jsr _CDBIOS
		bcs.s   loc_3DDC

loc_3E02:               ; CODE XREF: sub_3DD6+38j
		bsr.w   cbtSetIntHandler
		move.w  #WONDERCHK,d0
		jsr _CDBIOS
		bcs.s   loc_3E02
		nop
		nop

loc_3E14:               ; CODE XREF: sub_3DD6+14j sub_3DD6+1Cj
		move.w  #0,d0
		cmpi.w  #4,(_BOOTSTAT).w
		bcs.s   loc_3E2C
		cmpi.w  #$FFFF,(_BOOTSTAT).w
		beq.s   loc_3E2C
		move.w  #1,d0

loc_3E2C:               ; CODE XREF: sub_3DD6+48j sub_3DD6+50j
		movea.l dword_5B2E(a5),a0
		jmp (a0)
; End of function sub_3DD6

; ---------------------------------------------------------------------------
unk_3E32:   dc.b $E0 ; à        ; DATA XREF: sub_3DD6+1Eo
		dc.b   2
		dc.b   1
		dc.b   0
unk_3E36:   dc.b $E0 ; à        ; DATA XREF: sub_3DD6:loc_3DE0o
		dc.b   2
		dc.b   0
		dc.b   0

; =============== S U B R O U T I N E =======================================


checkDiscBootBlock:             ; CODE XREF: sub_3A6C+1B2p
		movem.l d0/a0-a1,-(sp)
		lea regionBootBlock(pc),a1
		move.w  #$2C1,d0

loc_3E46:               ; CODE XREF: checkDiscBootBlock+Ej
		cmpm.w  (a0)+,(a1)+
		dbne    d0,loc_3E46
		beq.s   loc_3E52
		move    #1,ccr

loc_3E52:               ; CODE XREF: checkDiscBootBlock+12j
		movem.l (sp)+,d0/a0-a1
		rts
; End of function checkDiscBootBlock

; ---------------------------------------------------------------------------
regionBootBlock:
	incbin "us_boot_block.bin"

unk_43DC:   dc.b   0        ; DATA XREF: BIOS:0000450Co
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b   1
		dc.b   1
		dc.b   0
		dc.b   1
unk_43E4:   dc.b $57 ; W        ; DATA XREF: sub_4FE2+F2o
		dc.b $A6 ; ¦
		dc.b $71 ; q
		dc.b $4B ; K
		dc.b $C6 ; Æ
		dc.b $19
unk_43EA:   dc.b $A7 ; §        ; DATA XREF: sub_4FE2+DCo
		dc.b $72 ; r
		dc.b $4C ; L
		dc.b $C7 ; Ç
		dc.b $1A
		dc.b   1
unk_43F0:   dc.b   0        ; DATA XREF: BIOS:00004526o
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   1
		dc.b   1
unk_43F6:   dc.b $14        ; DATA XREF: sub_4FE2+C4o
		dc.b $3A ; :
		dc.b $38 ; 8
		dc.b $12
		dc.b $1A
		dc.b   6
unk_43FC:   dc.b $3B ; ;        ; DATA XREF: sub_4FE2+AEo
		dc.b $39 ; 9
		dc.b $13
		dc.b $1B
		dc.b   7
		dc.b   1
asc_4402:   dc.b '___________',0    ; DATA XREF: BIOS:00004A32o
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $40 ; @
asc_4412:   dc.b 'SEGA_CD_ROM',0    ; DATA XREF: BIOS:00004592o
					; BIOS:0000464Ao ...
		dc.l $1000000
asc_4422:   dc.b 'RAM_CARTRIDGE___' ; DATA XREF: BIOS:0000456Ao
dword_4432: dc.l $FE0000        ; DATA XREF: sub_447Er sub_448E+6r ...
word_4436:  dc.w 4      ; DATA XREF: installJumpTable+3Eo
        dc.w 0

; =============== S U B R O U T I N E =======================================


_buram:
		movem.l a2/a5,-(sp)
		movea.l #0,a5
		add.w   d0,d0
		add.w   d0,d0
		jsr loc_4452(pc,d0.w)
		movem.l (sp)+,a2/a5
		rts
; End of function _buram

; ---------------------------------------------------------------------------

loc_4452:
		bra.w   _brminit
; ---------------------------------------------------------------------------
		bra.w   _brmstat
; ---------------------------------------------------------------------------
		bra.w   _brmserch
; ---------------------------------------------------------------------------
		bra.w   _brmread
; ---------------------------------------------------------------------------
		bra.w   _brmwrite
; ---------------------------------------------------------------------------
		bra.w   _brmdel
; ---------------------------------------------------------------------------
		bra.w   _brmformat
; ---------------------------------------------------------------------------
		bra.w   _brmdir
; ---------------------------------------------------------------------------
		bra.w   _brmverify
; ---------------------------------------------------------------------------
		bra.w   sub_447E
; ---------------------------------------------------------------------------
		bra.w   sub_448E

; =============== S U B R O U T I N E =======================================


sub_447E:               ; CODE XREF: BIOS:00004476j
		movea.l dword_4432(pc),a1
		move.w  #$40,d1 ; '@'
		exg a0,a1
		bsr.w   sub_4FBC
		rts
; End of function sub_447E


; =============== S U B R O U T I N E =======================================


sub_448E:               ; CODE XREF: BIOS:0000447Aj
		movem.l a2-a3,-(sp)
		movea.l a0,a3
		movea.l dword_4432(pc),a1
		movea.l a1,a2
		move.w  #$40,d1 ; '@'
		exg a0,a1
		bsr.w   sub_511A
		movep.l 0(a2),d0
		cmp.l   (a3),d0
		beq.s   loc_44B0
		move    #1,ccr

loc_44B0:               ; CODE XREF: sub_448E+1Cj
		movem.l (sp)+,a2-a3
		rts
; End of function sub_448E

; ---------------------------------------------------------------------------

_brminit:               ; CODE XREF: BIOS:loc_4452j
		movem.l d2/a2-a4,-(sp)
		movem.l a1,-(sp)
		move.l  a0,dword_5B54(a5)
		lea $200(a0),a0
		move.l  a0,dword_5B58(a5)
		lea $40(a0),a0
		move.l  a0,dword_5B5C(a5)
		lea $100(a0),a0
		move.l  a0,dword_5B60(a5)
		lea $100(a0),a0
		move.l  a0,dword_5B64(a5)
		lea $40(a0),a0
		move.l  a0,dword_5B68(a5)
		lea $40(a0),a0
		move.l  a0,dword_5B6C(a5)
		lea $100(a0),a0
		move.l  a0,dword_5BAE(a5)
		lea $40(a0),a0
		move.l  a0,dword_5BBE(a5)
		move.l  #$80100,d2
		movea.l dword_5B6C(a5),a0
		lea unk_43DC(pc),a1
		movea.l dword_5B5C(a5),a3
		movea.l dword_5B60(a5),a4
		bsr.w   sub_4CF4
		move.l  #$60040,d2
		movea.l dword_5B6C(a5),a0
		lea unk_43F0(pc),a1
		movea.l dword_5B64(a5),a3
		movea.l dword_5B68(a5),a4
		bsr.w   sub_4CF4
		clr.l   dword_5B84(a5)
		clr.l   dword_5B88(a5)
		clr.l   dword_5BBA(a5)
		movem.l (sp)+,a1
		bsr.w   sub_5372
		bcs.w   loc_45DC
		movea.l a1,a2
		movea.l dword_5BAE(a5),a1
		movea.l dword_5B8C(a5),a0
		lea $60(a0),a0
		move.w  #$10,d1
		bsr.w   sub_4FBC
		movea.l a2,a1
		movea.l dword_5BAE(a5),a2
		lea asc_4422(pc),a0 ; "RAM_CARTRIDGE___"
		cmpm.l  (a0)+,(a2)+
		beq.s   loc_457C
		cmpm.l  (a0)+,(a2)+
		beq.s   loc_457C
		cmpm.l  (a0)+,(a2)+
		bne.w   loc_45D6

loc_457C:               ; CODE XREF: BIOS:00004570j
					; BIOS:00004574j
		movea.l a1,a2
		movea.l dword_5B8C(a5),a0
		lea $40(a0),a0
		move.w  #$C,d1
		move.w  d1,d2
		bsr.w   sub_4FBC
		movea.l a2,a1
		lea asc_4412(pc),a2 ; "SEGA_CD_ROM"
		move.w  d2,d1
		bsr.w   sub_5140
		bne.w   loc_45F6
		move.l  dword_5B84(a5),d0
		asr.l   #8,d0
		asr.l   #5,d0
		move    #0,ccr

loc_45AC:               ; CODE XREF: BIOS:000045D4j
		movem.l (sp)+,d2/a2-a4
		rts
; ---------------------------------------------------------------------------

loc_45B2:               ; CODE XREF: BIOS:000045E2j
					; BIOS:000045F2j
		movea.l a1,a2
		move.w  d1,d2
		add.w   d2,d2
		add.w   d2,d2
		lea off_460E(pc),a1
		movea.l (a1,d2.w),a1
		move.w  d1,d2
		move.w  #$D,d1
		bsr.w   sub_5176
		movea.l a2,a1
		move.w  d2,d1

loc_45D0:               ; CODE XREF: BIOS:0000460Cj
		move    #1,ccr
		bra.s   loc_45AC
; ---------------------------------------------------------------------------

loc_45D6:               ; CODE XREF: BIOS:00004578j
		bsr.w   sub_53A0
		bcc.s   loc_45E6

loc_45DC:               ; CODE XREF: BIOS:0000454Aj
		moveq   #0,d0
		move.w  #0,d1
		bra.w   loc_45B2
; ---------------------------------------------------------------------------

loc_45E6:               ; CODE XREF: BIOS:000045DAj
					; BIOS:000045FEj
		move.w  #1,d1
		move.l  dword_5B84(a5),d0
		asr.l   #8,d0
		asr.l   #5,d0
		bra.w   loc_45B2
; ---------------------------------------------------------------------------

loc_45F6:               ; CODE XREF: BIOS:0000459Cj
		move.w  #$B,d1
		bsr.w   sub_53D6
		bcs.s   loc_45E6
		move.l  dword_5B84(a5),d0
		asr.l   #8,d0
		asr.l   #5,d0
		move.w  #2,d1
		bra.s   loc_45D0
; ---------------------------------------------------------------------------
off_460E:       ; DATA XREF: BIOS:000045BAo
	dc.l $4616
	dc.l $4622
asc_4616:
	dc.b 'NOT_EXIST__',0
	dc.b 'UNFORMAT___',0
; ---------------------------------------------------------------------------

_brmstat:               ; CODE XREF: BIOS:00004456j
		movem.l d2-d3/a2,-(sp)
		moveq   #0,d0
		bsr.w   sub_531A
		bcs.s   loc_4660
		move.w  d0,d3
		bsr.w   sub_5346
		bcs.s   loc_4660
		tst.w   d0
		bge.s   loc_4648
		moveq   #0,d0

loc_4648:               ; CODE XREF: BIOS:00004644j
		movea.l a1,a2
		lea asc_4412(pc),a1 ; "SEGA_CD_ROM"
		move.w  #$C,d1
		bsr.w   sub_5176
		movea.l a2,a1
		move.w  d3,d1

loc_465A:               ; CODE XREF: BIOS:0000466Cj
		movem.l (sp)+,d2-d3/a2
		rts
; ---------------------------------------------------------------------------

loc_4660:               ; CODE XREF: BIOS:00004638j
					; BIOS:00004640j
		move.w  #$FFFF,d0
		move.w  #$FFFF,d1
		move    #1,ccr
		bra.s   loc_465A

; =============== S U B R O U T I N E =======================================


_brmserch:              ; CODE XREF: BIOS:0000445Aj
					; BIOS:000046EEp ...
		movem.l d2-d3/a2-a4/a6,-(sp)
		movea.l a0,a3
		bsr.w   sub_531A
		move.w  d0,d1
		ble.s   loc_46E2
		movea.l dword_5B8C(a5),a0
		subq.w  #1,d1

loc_4682:               ; CODE XREF: _brmserch+1Aj
		suba.l  #$40,a0 ; '@'
		dbf d1,loc_4682
		move.w  d0,d2
		subq.w  #1,d2
		movea.l dword_5BAE(a5),a2
		lea dword_5B70(a5),a6
		move.l  (a6),d3
		clr.l   (a6)

loc_469C:               ; CODE XREF: _brmserch+48j
		movea.l a2,a1
		move.w  #$20,d1 ; ' '
		bsr.w   sub_4E74
		bcs.s   loc_46B4
		move.w  #$B,d1
		movea.l a3,a1
		bsr.w   sub_5140
		beq.s   loc_46BC

loc_46B4:               ; CODE XREF: _brmserch+38j
		move.l  d3,(a6)
		dbf d2,loc_469C
		bra.s   loc_46E2
; ---------------------------------------------------------------------------

loc_46BC:               ; CODE XREF: _brmserch+44j
		movea.l dword_4432(pc),a0
		move.w  $C(a2),d2
		ble.w   loc_46E2
		subq.w  #1,d2

loc_46CA:               ; CODE XREF: _brmserch+62j
		adda.l  #$80,a0 ; '€'
		dbf d2,loc_46CA
		move.b  $B(a2),d1
		move.w  $E(a2),d0

loc_46DC:               ; CODE XREF: _brmserch+78j
		movem.l (sp)+,d2-d3/a2-a4/a6
		rts
; ---------------------------------------------------------------------------

loc_46E2:               ; CODE XREF: _brmserch+Cj
					; _brmserch+4Cj ...
		move    #1,ccr
		bra.s   loc_46DC
; End of function _brmserch

; ---------------------------------------------------------------------------

_brmverify:             ; CODE XREF: BIOS:00004472j
		movem.l d2/a3/a6,-(sp)
		movea.l a1,a2
		bsr.w   _brmserch
		bcs.w   loc_4758
		tst.b   d1
		beq.w   loc_472A
		lea dword_5B70(a5),a6
		clr.l   (a6)
		subq.w  #1,d0
		move.w  d0,d2
		movea.l dword_5BAE(a5),a3

loc_470A:               ; CODE XREF: BIOS:00004724j
		movea.l a3,a1
		move.w  #$40,d1 ; '@'
		bsr.w   sub_4E74
		movea.l a3,a1
		move.w  #$20,d1 ; ' '
		bsr.w   sub_5140
		bne.w   loc_475E
		adda.w  d1,a2
		dbf d0,loc_470A
		bra.s   loc_474E
; ---------------------------------------------------------------------------

loc_472A:               ; CODE XREF: BIOS:000046F8j
		movea.l dword_5BAE(a5),a3
		subq.w  #1,d0

loc_4730:               ; CODE XREF: BIOS:0000474Aj
		move.w  #$40,d1 ; '@'
		movea.l a3,a1
		bsr.w   sub_4FBC
		move.w  #$40,d1 ; '@'
		movea.l a3,a1
		bsr.w   sub_5140
		bne.s   loc_475E
		adda.w  #$40,a2 ; '@'
		dbf d0,loc_4730

loc_474E:               ; CODE XREF: BIOS:00004728j
		move    #0,ccr

loc_4752:               ; CODE XREF: BIOS:00004766j
		movem.l (sp)+,d2/a3/a6
		rts
; ---------------------------------------------------------------------------

loc_4758:               ; CODE XREF: BIOS:000046F2j
		move.w  #0,d0
		bra.s   loc_4762
; ---------------------------------------------------------------------------

loc_475E:               ; CODE XREF: BIOS:0000471Ej
					; BIOS:00004744j
		move.w  #$FFFF,d0

loc_4762:               ; CODE XREF: BIOS:0000475Cj
		move    #1,ccr
		bra.s   loc_4752
; ---------------------------------------------------------------------------

_brmread:               ; CODE XREF: BIOS:0000445Ej
		movem.l d2/a6,-(sp)
		movem.l a1,-(sp)
		bsr.w   _brmserch
		movem.l (sp)+,a1
		movem.w d0-d1,-(sp)
		bcs.w   loc_47C6
		tst.b   d1
		beq.w   loc_47AA
		lea dword_5B70(a5),a6
		clr.l   (a6)
		subq.w  #1,d0
		move.w  d0,d2

loc_4790:               ; CODE XREF: BIOS:00004798j
		move.w  #$40,d1 ; '@'
		bsr.w   sub_4E74
		dbf d0,loc_4790
		lea dword_5B70(a5),a0
		btst    #7,0(a0)
		beq.s   loc_47B8
		bra.s   loc_47C6
; ---------------------------------------------------------------------------

loc_47AA:               ; CODE XREF: BIOS:00004782j
		subq.w  #1,d0

loc_47AC:               ; CODE XREF: BIOS:000047B4j
		move.w  #$40,d1 ; '@'
		bsr.w   sub_4FBC
		dbf d0,loc_47AC

loc_47B8:               ; CODE XREF: BIOS:000047A6j
		move    #0,ccr

loc_47BC:               ; CODE XREF: BIOS:000047CAj
		movem.w (sp)+,d0-d1
		movem.l (sp)+,d2/a6
		rts
; ---------------------------------------------------------------------------

loc_47C6:               ; CODE XREF: BIOS:0000477Cj
					; BIOS:000047A8j
		move    #1,ccr
		bra.s   loc_47BC
; ---------------------------------------------------------------------------

_brmwrite:              ; CODE XREF: BIOS:00004462j
		movem.l d2-d7/a2-a4/a6,-(sp)
		move.l  a0,dword_5B96(a5)
		move.l  a1,dword_5B9A(a5)
		bsr.w   sub_5346
		bcs.w   loc_48FC
		move.w  d0,d5
		bsr.w   _brmserch
		bcs.s   loc_47FC
		add.w   d0,d5
		movea.l dword_5B96(a5),a0
		cmp.w   $C(a0),d5
		blt.w   loc_48FC
		bsr.w   _brmdel
		bra.s   loc_4808
; ---------------------------------------------------------------------------

loc_47FC:               ; CODE XREF: BIOS:000047E6j
		movea.l dword_5B96(a5),a0
		cmp.w   $C(a0),d5
		blt.w   loc_48FC

loc_4808:               ; CODE XREF: BIOS:000047FAj
		bsr.w   sub_531A
		bcs.w   loc_48FC
		movea.l dword_5B8C(a5),a0
		move.w  d0,d1
		bgt.s   loc_481C
		moveq   #1,d6
		bra.s   loc_4848
; ---------------------------------------------------------------------------

loc_481C:               ; CODE XREF: BIOS:00004816j
		subq.w  #1,d1

loc_481E:               ; CODE XREF: BIOS:00004824j
		suba.l  #$40,a0 ; '@'
		dbf d1,loc_481E
		movea.l dword_5BAE(a5),a1
		lea dword_5B70(a5),a6
		clr.l   (a6)
		movea.l a1,a2
		move.w  #$20,d1 ; ' '
		bsr.w   sub_4E74
		bcs.w   loc_48FC
		move.w  $C(a2),d6
		add.w   $E(a2),d6

loc_4848:               ; CODE XREF: BIOS:0000481Aj
		movea.l dword_4432(pc),a0
		move.w  d6,d2
		ble.s   loc_485C
		subq.w  #1,d2

loc_4852:               ; CODE XREF: BIOS:00004858j
		adda.l  #$80,a0 ; '€'
		dbf d2,loc_4852

loc_485C:               ; CODE XREF: BIOS:0000484Ej
		movea.l dword_5B96(a5),a2
		movea.l dword_5B9A(a5),a1
		move.w  $C(a2),d0
		ble.w   loc_48FC
		tst.b   $B(a2)
		beq.w   loc_4888
		subq.w  #1,d0
		move.w  #$40,d1 ; '@'

loc_487A:               ; CODE XREF: BIOS:00004882j
		bsr.w   sub_4FE2
		bcs.w   loc_48FC
		dbf d0,loc_487A
		bra.s   loc_4896
; ---------------------------------------------------------------------------

loc_4888:               ; CODE XREF: BIOS:00004870j
		subq.w  #1,d0

loc_488A:               ; CODE XREF: BIOS:00004892j
		move.w  #$40,d1 ; '@'
		bsr.w   sub_511A
		dbf d0,loc_488A

loc_4896:               ; CODE XREF: BIOS:00004886j
		bsr.w   sub_531A
		bcs.w   loc_48FC
		addq.w  #1,d0
		movea.l dword_5B8C(a5),a0
		move.w  d0,d1
		subq.w  #1,d1

loc_48A8:               ; CODE XREF: BIOS:000048AEj
		suba.l  #$40,a0 ; '@'
		dbf d1,loc_48A8
		movea.l dword_5B96(a5),a1
		lea unk_5B9E(a5),a2
		lea 0(a1),a1
		lea 0(a2),a2
		move.w  #$B,d1
		bsr.w   sub_5176
		movea.l dword_5B96(a5),a2
		lea unk_5B9E(a5),a1
		move.b  $B(a2),$B(a1)
		move.w  d6,$C(a1)
		move.w  $C(a2),$E(a1)
		move.w  #$20,d1 ; ' '
		bsr.w   sub_4FE2
		bcs.s   loc_48FC
		lea unk_5B9E(a5),a1
		moveq   #0,d0
		bsr.w   sub_51B2

loc_48F6:               ; CODE XREF: BIOS:00004900j
		movem.l (sp)+,d2-d7/a2-a4/a6
		rts
; ---------------------------------------------------------------------------

loc_48FC:               ; CODE XREF: BIOS:000047DCj
					; BIOS:000047F2j ...
		move    #1,ccr
		bra.s   loc_48F6

; =============== S U B R O U T I N E =======================================


_brmdel:                ; CODE XREF: BIOS:00004466j
					; BIOS:000047F6p
		movem.l d2-d4/a2-a6,-(sp)
		movea.l a0,a3
		bsr.w   sub_531A
		tst.w   d0
		ble.w   loc_4A18
		movea.l dword_5B8C(a5),a0
		move.w  d0,d1
		subq.w  #1,d1

loc_491A:               ; CODE XREF: _brmdel+1Ej
		suba.l  #$40,a0 ; '@'
		dbf d1,loc_491A
		move.w  d0,d2
		subq.w  #1,d2
		movea.l dword_5BAE(a5),a2
		lea dword_5B70(a5),a6
		clr.l   (a6)

loc_4932:               ; CODE XREF: _brmdel:loc_494Aj
		movea.l a2,a1
		move.w  #$20,d1 ; ' '
		bsr.w   sub_4E74
		bcs.s   loc_494A
		move.w  #$B,d1
		movea.l a3,a1
		bsr.w   sub_5140
		beq.s   loc_4952

loc_494A:               ; CODE XREF: _brmdel+3Aj
		dbf d2,loc_4932
		bra.w   loc_4A18
; ---------------------------------------------------------------------------

loc_4952:               ; CODE XREF: _brmdel+46j
		movea.l a2,a1
		movem.l d0/a2,-(sp)
		lea unk_5B9E(a5),a2
		move.w  #$10,d1
		bsr.w   sub_5176
		movem.l (sp)+,d0/a2
		move.w  d0,d3
		sub.w   d2,d3
		subq.w  #2,d3
		bcs.w   loc_4A06
		movea.l dword_4432(pc),a3
		move.w  $C(a2),d2
		subq.w  #1,d2

loc_497C:               ; CODE XREF: _brmdel+80j
		adda.l  #$80,a3 ; '€'
		dbf d2,loc_497C
		lea dword_5B70(a5),a6
		clr.l   (a6)

loc_498C:               ; CODE XREF: _brmdel+100j
		suba.l  #$80,a0 ; '€'
		movea.l a2,a1
		move.w  #$20,d1 ; ' '
		bsr.w   sub_4E74
		bcs.w   loc_4A18
		movea.l dword_4432(pc),a4
		move.w  $C(a2),d2
		subq.w  #1,d2

loc_49AA:               ; CODE XREF: _brmdel+AEj
		adda.l  #$80,a4 ; '€'
		dbf d2,loc_49AA
		moveq   #0,d2
		move.w  $E(a2),d2
		mulu.w  #$40,d2 ; '@'
		add.w   d2,d2
		move.l  a3,d1
		sub.l   dword_4432(pc),d1
		divu.w  #$80,d1 ; '€'
		swap    d1
		tst.w   d1
		beq.s   loc_49D6
		addi.l  #$10000,d1

loc_49D6:               ; CODE XREF: _brmdel+CCj
		swap    d1
		move.w  d1,$C(a2)
		movem.l a0,-(sp)
		movea.l a2,a1
		move.w  #$20,d1 ; ' '
		bsr.w   sub_4FE2
		bcs.s   loc_4A18
		move.w  d4,$C(a2)
		dc.w $C74A ; exg    a3,a2
		movea.l a4,a1
		move.w  d2,d1
		bsr.w   sub_5192
		dc.w $C74A ; exg    a3,a2
		adda.w  d2,a3
		movem.l (sp)+,a0
		dbf d3,loc_498C

loc_4A06:               ; CODE XREF: _brmdel+6Cj
		move.b  #1,d0
		lea unk_5B9E(a5),a1
		bsr.w   sub_51B2

loc_4A12:               ; CODE XREF: _brmdel+11Aj
		movem.l (sp)+,d2-d4/a2-a6
		rts
; ---------------------------------------------------------------------------

loc_4A18:               ; CODE XREF: _brmdel+Cj _brmdel+4Cj ...
		move    #1,ccr
		bra.s   loc_4A12
; End of function _brmdel

; ---------------------------------------------------------------------------

_brmformat:             ; CODE XREF: BIOS:0000446Aj
		movem.l a3,-(sp)
		bsr.w   sub_5372
		bcs.w   loc_4AA6
		bsr.w   sub_53A0
		bcs.w   loc_4AA6
		lea asc_4402(pc),a1 ; "___________"
		movea.l dword_5B8C(a5),a0
		move.w  #$10,d1
		bsr.w   sub_511A
		moveq   #0,d0
		movea.l dword_5B8C(a5),a0
		lea $30(a0),a0
		move.w  d0,d0
		move.w  d0,-(sp)
		swap    d0
		move.w  (sp)+,d0
		movea.l a0,a0
		movep.l d0,1(a0)
		adda.l  #8,a0
		movep.l d0,1(a0)
		move.w  word_5B82(a5),d0
		movea.l dword_5B8C(a5),a0
		lea $20(a0),a0
		move.w  d0,d0
		move.w  d0,-(sp)
		swap    d0
		move.w  (sp)+,d0
		movea.l a0,a0
		movep.l d0,1(a0)
		adda.l  #8,a0
		movep.l d0,1(a0)
		lea asc_4412(pc),a1 ; "SEGA_CD_ROM"
		movea.l dword_5B8C(a5),a0
		lea $40(a0),a0
		move.w  #$20,d1 ; ' '
		bsr.w   sub_511A
		move    #0,ccr

loc_4AA0:               ; CODE XREF: BIOS:00004AAAj
		movem.l (sp)+,a3
		rts
; ---------------------------------------------------------------------------

loc_4AA6:               ; CODE XREF: BIOS:00004A26j
					; BIOS:00004A2Ej
		move    #1,ccr
		bra.s   loc_4AA0
; ---------------------------------------------------------------------------

_brmdir:                ; CODE XREF: BIOS:0000446Ej
		movem.l d2-d5/a2-a4/a6,-(sp)
		movea.l a1,a4
		move.w  d1,d4
		swap    d1
		move.w  d1,d5
		moveq   #0,d2
		moveq   #$A,d3
		movea.l a0,a2

loc_4ABE:               ; CODE XREF: BIOS:00004AC6j
		cmpi.b  #$2A,(a2)+ ; '*'
		beq.s   loc_4ACA
		addq.w  #1,d2
		dbf d3,loc_4ABE

loc_4ACA:               ; CODE XREF: BIOS:00004AC2j
		movea.l a0,a2
		bsr.w   sub_531A
		move.w  d0,d3
		ble.w   loc_4B2C
		subq.w  #1,d3
		movea.l dword_5B8C(a5),a0
		suba.l  #$40,a0 ; '@'
		movea.l dword_5BAE(a5),a1
		lea dword_5B70(a5),a6
		clr.l   (a6)
		movea.l a1,a3

loc_4AEE:               ; CODE XREF: BIOS:00004B28j
		tst.w   d4
		ble.s   loc_4B36
		move.w  #$20,d1 ; ' '
		bsr.w   sub_4E74
		movea.l a3,a1
		move.w  d2,d1
		beq.s   loc_4B06
		bsr.w   sub_5140
		bne.s   loc_4B24

loc_4B06:               ; CODE XREF: BIOS:00004AFEj
		tst.w   d5
		ble.s   loc_4B0E
		subq.w  #1,d5
		bra.s   loc_4B1E
; ---------------------------------------------------------------------------

loc_4B0E:               ; CODE XREF: BIOS:00004B08j
		move.w  #$10,d1
		exg a2,a4
		bsr.w   sub_5176
		exg a2,a4
		adda.w  d1,a4
		subq.w  #1,d4

loc_4B1E:               ; CODE XREF: BIOS:00004B0Cj
		cmpi.w  #$B,d2
		beq.s   loc_4B2C

loc_4B24:               ; CODE XREF: BIOS:00004B04j
		suba.w  #$80,a0 ; '€'
		dbf d3,loc_4AEE

loc_4B2C:               ; CODE XREF: BIOS:00004AD2j
					; BIOS:00004B22j
		move    #0,ccr

loc_4B30:               ; CODE XREF: BIOS:00004B3Aj
		movem.l (sp)+,d2-d5/a2-a4/a6
		rts
; ---------------------------------------------------------------------------

loc_4B36:               ; CODE XREF: BIOS:00004AF0j
		move    #1,ccr
		bra.s   loc_4B30

; =============== S U B R O U T I N E =======================================


sub_4B3C:               ; CODE XREF: sub_4FE2+A6p
		movem.l d2/d7,-(sp)
		move.w  d2,-(sp)
		move.w  d1,d0
		move.w  #$10,d2
		move.w  #$1F,d7
		bsr.s   sub_4B76
		move.w  #1,d7
		movea.l sp,a0
		bsr.s   sub_4B76
		addq.w  #2,sp

loc_4B58:               ; CODE XREF: sub_4B3C+1Ej
		bsr.s   sub_4B6A
		bhi.s   loc_4B58
		clr.l   (a1)+
		clr.l   (a1)+
		clr.l   (a1)+
		clr.l   (a1)+
		movem.l (sp)+,d2/d7
		rts
; End of function sub_4B3C


; =============== S U B R O U T I N E =======================================


sub_4B6A:               ; CODE XREF: sub_4B3C:loc_4B58p
					; sub_4B76p
		move.w  d0,d1
		lsr.w   #8,d1
		move.b  d1,(a1)+
		lsl.w   #6,d0
		subq.w  #6,d2
		rts
; End of function sub_4B6A


; =============== S U B R O U T I N E =======================================


sub_4B76:               ; CODE XREF: sub_4B3C+10p sub_4B3C+18p ...
		bsr.s   sub_4B6A
		cmpi.w  #8,d2
		bcc.s   sub_4B76
		moveq   #8,d1
		sub.w   d2,d1
		lsr.w   d1,d0
		move.b  (a0)+,d0
		lsl.w   d1,d0
		addq.w  #8,d2
		subq.w  #1,d7
		bcc.s   sub_4B76
		rts
; End of function sub_4B76


; =============== S U B R O U T I N E =======================================


sub_4B90:               ; CODE XREF: sub_4E74+C0p
		movem.l d2/d7,-(sp)
		move.b  (a1)+,d0
		lsl.w   #6,d0
		move.b  (a1)+,d0
		lsl.w   #2,d0
		move.w  d0,word_5B7E(a5)
		lsl.w   #4,d0
		move.b  (a1)+,d0
		ror.w   #4,d0
		move.b  d0,word_5B7E+1(a5)
		move.w  #$2A,d7 ; '*'
		moveq   #2,d2
		bsr.s   sub_4BDA
		bsr.s   sub_4BCE
		lsr.w   #4,d0
		move.b  (a1)+,d0
		lsl.w   #4,d0
		move.w  d0,word_5B80(a5)
		lsl.w   #2,d0
		move.b  (a1)+,d0
		lsr.w   #2,d0
		move.b  d0,word_5B80+1(a5)
		movem.l (sp)+,d2/d7
		rts
; End of function sub_4B90


; =============== S U B R O U T I N E =======================================


sub_4BCE:               ; CODE XREF: sub_4B90+22p
					; sub_4BDA:loc_4BDCp
		move.w  d0,d1
		lsr.w   #8,d1
		move.b  d1,(a0)+
		lsl.w   #8,d0
		subq.w  #8,d2
		rts
; End of function sub_4BCE


; =============== S U B R O U T I N E =======================================


sub_4BDA:               ; CODE XREF: sub_4B90+20p
		bra.s   loc_4BDE
; ---------------------------------------------------------------------------

loc_4BDC:               ; CODE XREF: sub_4BDA+8j
		bsr.s   sub_4BCE

loc_4BDE:               ; CODE XREF: sub_4BDAj sub_4BDA+1Aj
		cmpi.w  #8,d2
		bhi.s   loc_4BDC
		move.w  #8,d1
		sub.w   d2,d1
		lsr.w   d1,d0
		move.b  (a1)+,d0
		lsl.w   d1,d0
		addq.w  #6,d2
		subq.w  #1,d7
		bcc.s   loc_4BDE
		rts
; End of function sub_4BDA


; =============== S U B R O U T I N E =======================================


sub_4BF8:               ; CODE XREF: sub_4E74+62p sub_4FE2+EEp
		movem.l d6-d7,-(sp)
		movea.l dword_5B58(a5),a0
		adda.w  d0,a0
		lea dword_5B74(a5),a1
		moveq   #7,d7

loc_4C08:               ; CODE XREF: sub_4BF8+2Aj
		movem.l a1,-(sp)
		move.b  (a0),d0
		moveq   #7,d6

loc_4C10:               ; CODE XREF: sub_4BF8+20j
		move.b  (a1),d1
		lsl.b   #1,d0
		roxl.b  #1,d1
		move.b  d1,(a1)+
		dbf d6,loc_4C10
		movem.l (sp)+,a1
		addq.w  #8,a0
		dbf d7,loc_4C08
		movem.l (sp)+,d6-d7
		rts
; End of function sub_4BF8


; =============== S U B R O U T I N E =======================================


sub_4C2C:               ; CODE XREF: sub_4E74+6Cp sub_4FE2+FCp
		movem.l d6-d7,-(sp)
		movea.l dword_5B58(a5),a0
		adda.w  d0,a0
		lea dword_5B74(a5),a1
		moveq   #7,d7

loc_4C3C:               ; CODE XREF: sub_4C2C+2Aj
		movem.l a0,-(sp)
		move.b  (a1)+,d0
		moveq   #7,d6

loc_4C44:               ; CODE XREF: sub_4C2C+22j
		move.b  (a0),d1
		lsl.b   #1,d0
		roxl.b  #1,d1
		move.b  d1,(a0)
		addq.w  #8,a0
		dbf d6,loc_4C44
		movem.l (sp)+,a0
		dbf d7,loc_4C3C
		movem.l (sp)+,d6-d7
		rts
; End of function sub_4C2C


; =============== S U B R O U T I N E =======================================


sub_4C60:               ; CODE XREF: sub_4E74+98p sub_4FE2+C0p
		movea.l dword_5B58(a5),a0
		lea dword_5B74(a5),a1
		movem.l d0/a0,-(sp)
		adda.w  d0,a0
		moveq   #4,d1

loc_4C70:               ; CODE XREF: sub_4C60+18j
		move.b  (a0)+,d0
		lsr.b   #2,d0
		move.b  d0,(a1)+
		addq.w  #8,a0
		dbf d1,loc_4C70
		movem.l (sp)+,d0/a0
		moveq   #0,d1
		move.b  loc_4CA0(pc,d0.w),d1
		move.b  (a0,d1.w),d1
		lsr.b   #2,d1
		move.b  d1,(a1)+
		move.b  $30(a0,d0.w),d1
		lsr.b   #2,d1
		move.b  d1,(a1)+
		move.b  $38(a0,d0.w),d1
		lsr.b   #2,d1
		move.b  d1,(a1)
		rts
; End of function sub_4C60

; ---------------------------------------------------------------------------

loc_4CA0:
		move.l  $2F08(a6),-(a6)
		move.b  (a2)+,-(a0)

loc_4CA6:               ; CODE XREF: sub_4E74+A2p
		move.l  $206D(a4),-(a1)
		subq.w  #5,(a0)+
		lea dword_5B74(a5),a1
		movem.l d0/a0,-(sp)
		adda.w  d0,a0
		moveq   #4,d1

loc_4CB8:               ; CODE XREF: BIOS:00004CC0j
		move.b  (a1)+,d0
		lsl.b   #2,d0
		move.b  d0,(a0)+
		addq.w  #8,a0
		dbf d1,loc_4CB8
		movem.l (sp)+,d0/a0
		move.w  d0,-(sp)
		moveq   #0,d1
		move.b  loc_4CA0(pc,d0.w),d1
		move.b  (a1)+,d0
		lsl.b   #2,d0
		move.b  d0,(a0,d1.w)
		move.w  (sp)+,d0

loc_4CDA:               ; CODE XREF: sub_4FE2+CEp
		movea.l dword_5B58(a5),a0
		move.b  word_5B7A(a5),d1
		lsl.b   #2,d1
		move.b  d1,$30(a0,d0.w)
		move.b  word_5B7A+1(a5),d1
		lsl.b   #2,d1
		move.b  d1,$38(a0,d0.w)
		rts

; =============== S U B R O U T I N E =======================================


sub_4CF4:               ; CODE XREF: BIOS:00004518p
					; BIOS:00004532p
		movem.l d6-d7,-(sp)
		swap    d2
		moveq   #0,d7
		move.b  d7,(a3)
		move.b  d7,(a0)
		move.b  d7,(a4)
		moveq   #1,d0
		moveq   #1,d7

loc_4D06:               ; CODE XREF: sub_4CF4+24j
		move.b  d0,(a3,d7.w)
		move.b  d0,(a0,d7.w)
		lsl.b   #1,d0
		move.b  d7,(a4,d7.w)
		addq.w  #1,d7
		cmp.w   d7,d2
		bcc.s   loc_4D06
		swap    d2

loc_4D1C:               ; CODE XREF: sub_4CF4+5Cj
		clr.b   (a3,d7.w)
		swap    d2
		moveq   #0,d6

loc_4D24:               ; CODE XREF: sub_4CF4+4Aj
		moveq   #0,d0
		tst.b   (a1,d6.w)
		beq.s   loc_4D3A
		move.w  d7,d1
		sub.w   d6,d1
		subq.w  #1,d1
		move.b  (a3,d1.w),d0
		eor.b   d0,(a3,d7.w)

loc_4D3A:               ; CODE XREF: sub_4CF4+36j
		addq.w  #1,d6
		cmp.w   d2,d6
		bcs.s   loc_4D24

loc_4D40:
		swap    d2
		move.b  (a3,d7.w),(a0,d7.w)
		move.b  d7,(a4,d7.w)
		addq.w  #1,d7
		cmp.w   d2,d7
		bcs.s   loc_4D1C
		move.w  d2,d1
		subq.w  #1,d1
		moveq   #0,d7

loc_4D58:               ; CODE XREF: sub_4CF4+94j
		move.w  d7,d6
		addq.w  #1,d6

loc_4D5C:               ; CODE XREF: sub_4CF4+8Ej
		move.b  (a0,d7.w),d0
		cmp.b   (a0,d6.w),d0
		bcs.s   loc_4D7E
		move.b  (a0,d6.w),(a0,d7.w)
		move.b  d0,(a0,d6.w)
		move.b  (a4,d7.w),d0
		move.b  (a4,d6.w),(a4,d7.w)
		move.b  d0,(a4,d6.w)

loc_4D7E:               ; CODE XREF: sub_4CF4+70j
		addq.w  #1,d6
		cmp.w   d2,d6
		bcs.s   loc_4D5C
		addq.w  #1,d7
		cmp.w   d1,d7
		bcs.s   loc_4D58
		movem.l (sp)+,d6-d7
		rts
; End of function sub_4CF4


; =============== S U B R O U T I N E =======================================


sub_4D90:               ; CODE XREF: sub_4FE2+C8p sub_4FE2+F6p
		movem.l d2/d7,-(sp)
		lea dword_5B74(a5),a0
		clr.w   word_5B7A(a5)
		subq.w  #1,d2
		moveq   #0,d7

loc_4DA0:               ; CODE XREF: sub_4D90+38j
		moveq   #0,d0
		moveq   #0,d1
		move.b  (a0,d7.w),d0
		tst.w   d0
		beq.s   loc_4DC2
		move.b  (a4,d0.w),d1
		subq.w  #1,d1
		bsr.s   sub_4DD0
		eor.b   d0,word_5B7A(a5)
		dc.w $C549 ; exg    a2,a1
		bsr.s   sub_4DD0
		eor.b   d0,word_5B7A+1(a5)
		dc.w $C549 ; exg    a2,a1

loc_4DC2:               ; CODE XREF: sub_4D90+1Aj
		addq.w  #1,d7
		cmpi.w  #6,d7
		bcs.s   loc_4DA0
		movem.l (sp)+,d2/d7
		rts
; End of function sub_4D90


; =============== S U B R O U T I N E =======================================


sub_4DD0:               ; CODE XREF: sub_4D90+22p sub_4D90+2Ap
		move.b  (a1,d7.w),d0
		add.w   d1,d0
		bra.s   loc_4DDA
; ---------------------------------------------------------------------------

loc_4DD8:               ; CODE XREF: sub_4DD0+Cj
		sub.w   d2,d0

loc_4DDA:               ; CODE XREF: sub_4DD0+6j
		cmp.w   d2,d0
		bcc.s   loc_4DD8
		addq.w  #1,d0
		move.b  (a3,d0.w),d0
		rts
; End of function sub_4DD0


; =============== S U B R O U T I N E =======================================


sub_4DE6:               ; CODE XREF: sub_4E74+66p sub_4E74+9Cp
		movem.l d2/d7,-(sp)
		lea dword_5B74(a5),a0
		subq.w  #1,d2
		clr.w   word_5B7C(a5)
		moveq   #0,d7

loc_4DF6:               ; CODE XREF: sub_4DE6+3Ej
		moveq   #0,d0
		move.b  (a0,d7.w),d0
		eor.b   d0,word_5B7C(a5)
		tst.b   d0
		beq.s   loc_4E1E
		move.b  (a4,d0.w),d0
		addq.w  #6,d0
		sub.w   d7,d0
		bra.s   loc_4E10
; ---------------------------------------------------------------------------

loc_4E0E:               ; CODE XREF: sub_4DE6+2Cj
		sub.w   d2,d0

loc_4E10:               ; CODE XREF: sub_4DE6+26j
		cmp.w   d2,d0
		bcc.s   loc_4E0E
		addq.w  #1,d0
		move.b  (a3,d0.w),d0
		eor.b   d0,word_5B7C+1(a5)

loc_4E1E:               ; CODE XREF: sub_4DE6+1Cj
		addq.w  #1,d7
		cmpi.w  #8,d7
		bcs.s   loc_4DF6
		tst.w   word_5B7C(a5)
		beq.s   loc_4E6E
		moveq   #0,d1
		move.w  d2,d0
		move.b  word_5B7C+1(a5),d1
		move.b  (a4,d1.w),d1
		add.w   d1,d0
		move.b  word_5B7C(a5),d1
		move.b  (a4,d1.w),d1
		sub.w   d1,d0
		bra.s   loc_4E48
; ---------------------------------------------------------------------------

loc_4E46:               ; CODE XREF: sub_4DE6+64j
		sub.w   d2,d0

loc_4E48:               ; CODE XREF: sub_4DE6+5Ej
		cmp.w   d2,d0
		bcc.s   loc_4E46
		cmpi.w  #8,d0
		bcc.s   loc_4E6A
		moveq   #7,d1
		sub.w   d0,d1
		move.b  word_5B7C(a5),d0
		eor.b   d0,(a0,d1.w)
		bset    #3,0(a6)
		addq.b  #1,byte_5BC3(a5)
		bra.s   loc_4E6E
; ---------------------------------------------------------------------------

loc_4E6A:               ; CODE XREF: sub_4DE6+6Aj
		bset    #4,(a6)

loc_4E6E:               ; CODE XREF: sub_4DE6+44j sub_4DE6+82j
		movem.l (sp)+,d2/d7
		rts
; End of function sub_4DE6


; =============== S U B R O U T I N E =======================================


sub_4E74:               ; CODE XREF: _brmserch+34p
					; BIOS:00004710p ...
		movem.l d0-d3/d7/a2-a4,-(sp)
		movem.l d1/a0-a1,-(sp)
		moveq   #0,d0
		move.w  a0,d0
		move.l  a0,d2
		move.w  #0,d2
		divu.w  #$80,d0 ; '€'
		mulu.w  #$80,d0 ; '€'
		add.w   d0,d2
		movea.l d2,a0
		cmpa.l  dword_5BBA(a5),a0
		beq.w   loc_4F84
		move.l  a0,dword_5BBA(a5)
		movea.l a0,a1
		movea.l dword_5BBE(a5),a0
		clr.b   byte_5BC2(a5)
		move.l  a0,-(sp)
		movea.l dword_5B58(a5),a0
		move.w  #$40,d1 ; '@'
		exg a0,a1
		bsr.w   sub_4FBC
		exg a0,a1
		movea.l (sp)+,a0
		move.l  a1,-(sp)
		move.l  a0,-(sp)
		move.w  #$100,d2
		movea.l dword_5B5C(a5),a3
		movea.l dword_5B60(a5),a4
		clr.b   byte_5BC3(a5)
		moveq   #7,d7
		moveq   #0,d3

loc_4ED4:               ; CODE XREF: sub_4E74+72j
		move.w  d3,d0
		bsr.w   sub_4BF8
		bsr.w   sub_4DE6
		move.w  d3,d0
		bsr.w   sub_4C2C
		addq.w  #1,d3
		dbf d7,loc_4ED4
		tst.b   byte_5BC3(a5)
		beq.s   loc_4EF6
		move.b  byte_5BC3(a5),1(a6)

loc_4EF6:               ; CODE XREF: sub_4E74+7Aj
		move.w  #$40,d2 ; '@'
		movea.l dword_5B64(a5),a3
		movea.l dword_5B68(a5),a4
		clr.b   byte_5BC3(a5)
		moveq   #7,d7
		moveq   #0,d3

loc_4F0A:               ; CODE XREF: sub_4E74+A8j
		move.w  d3,d0
		bsr.w   sub_4C60
		bsr.w   sub_4DE6
		move.w  d3,d0
		bsr.w   loc_4CA6+2
		addq.w  #1,d3
		dbf d7,loc_4F0A
		tst.b   byte_5BC3(a5)
		beq.s   loc_4F2C
		move.b  byte_5BC3(a5),1(a6)

loc_4F2C:               ; CODE XREF: sub_4E74+B0j
		movea.l (sp)+,a0
		move.l  a0,-(sp)
		movea.l dword_5B58(a5),a1
		bsr.w   sub_4B90
		movea.l (sp)+,a0
		bsr.w   sub_8CE
		cmp.w   word_5B7E(a5),d1
		beq.s   loc_4F50
		bset    #5,0(a6)
		bset    #5,byte_5BC2(a5)

loc_4F50:               ; CODE XREF: sub_4E74+CEj
		cmp.w   word_5B80(a5),d2
		beq.s   loc_4F62
		bset    #6,0(a6)
		bset    #6,byte_5BC2(a5)

loc_4F62:               ; CODE XREF: sub_4E74+E0j
		movea.l (sp)+,a1
		btst    #5,byte_5BC2(a5)
		beq.s   loc_4F84
		btst    #6,byte_5BC2(a5)
		beq.s   loc_4F84
		bset    #7,0(a6)
		bset    #7,byte_5BC2(a5)
		addq.w  #1,2(a6)

loc_4F84:               ; CODE XREF: sub_4E74+22j sub_4E74+F6j ...
		movem.l (sp)+,d1/a0-a1
		movea.l a1,a2
		move.w  dword_5BBA+2(a5),d3
		move.w  a0,d2
		sub.w   d3,d2
		asr.w   #2,d2
		movea.l dword_5BBE(a5),a1
		adda.w  d2,a1
		asr.w   #1,d1
		bsr.w   sub_5176
		movea.l a2,a1
		adda.w  d1,a1
		add.w   d1,d1
		adda.w  d1,a0
		adda.w  d1,a0
		btst    #7,byte_5BC2(a5)
		beq.s   loc_4FB6
		move    #1,ccr

loc_4FB6:               ; CODE XREF: sub_4E74+13Cj
		movem.l (sp)+,d0-d3/d7/a2-a4
		rts
; End of function sub_4E74


; =============== S U B R O U T I N E =======================================


sub_4FBC:               ; CODE XREF: sub_447E+Ap
					; BIOS:00004560p ...
		movem.l d2,-(sp)

loc_4FC0:               ; CODE XREF: sub_4FBC+10j
		subq.w  #4,d1
		blt.s   loc_4FCE
		movep.l 1(a0),d2
		move.l  d2,(a1)+
		addq.l  #8,a0
		bra.s   loc_4FC0
; ---------------------------------------------------------------------------

loc_4FCE:               ; CODE XREF: sub_4FBC+6j
		addq.w  #4,d1

loc_4FD0:               ; CODE XREF: sub_4FBC+1Ej
		subq.w  #1,d1
		blt.s   loc_4FDC
		move.b  1(a0),(a1)+
		addq.l  #2,a0
		bra.s   loc_4FD0
; ---------------------------------------------------------------------------

loc_4FDC:               ; CODE XREF: sub_4FBC+16j
		movem.l (sp)+,d2
		rts
; End of function sub_4FBC


; =============== S U B R O U T I N E =======================================


sub_4FE2:               ; CODE XREF: BIOS:loc_487Ap
					; BIOS:000048E6p ...
		movem.l d0-d3/d7/a2-a4,-(sp)
		movem.l d1/a0-a1,-(sp)
		cmpi.w  #$40,d1 ; '@'
		bge.w   loc_5078
		movem.l d1/a1,-(sp)
		move.l  a0,d2
		move.l  a0,d3
		moveq   #0,d0
		move.w  a0,d0
		move.w  #0,d3
		divu.w  #$80,d0 ; '€'
		mulu.w  #$80,d0 ; '€'
		add.w   d0,d3
		movea.l d3,a0
		sub.l   a0,d2
		asr.l   #2,d2
		move.w  #$40,d1 ; '@'
		movea.l dword_5BBE(a5),a1
		movea.l a1,a2
		movea.l a0,a3
		lea dword_5B70(a5),a6
		move.l  (a6),d3
		clr.l   (a6)
		moveq   #0,d0
		bsr.w   sub_531A
		tst.w   d0
		ble.s   loc_5050
		divu.w  #2,d0
		move.w  d0,d1
		swap    d0
		tst.w   d0
		beq.s   loc_503E
		addq.w  #1,d1

loc_503E:               ; CODE XREF: sub_4FE2+58j
		mulu.w  #$80,d1 ; '€'
		move.l  dword_5B8C(a5),d0
		sub.l   d1,d0
		cmp.l   a0,d0
		bgt.s   loc_5050
		bsr.w   sub_4E74

loc_5050:               ; CODE XREF: sub_4FE2+4Cj sub_4FE2+68j
		move.b  0(a6),d0
		move.l  d3,(a6)
		clr.l   dword_5BBA(a5)
		movem.l (sp)+,d1/a1
		btst    #7,d0
		bne.w   loc_5114
		adda.w  d2,a2
		add.w   d2,d2
		asr.w   #1,d1
		bsr.w   sub_5176
		add.w   d1,d1
		movea.l dword_5BBE(a5),a1
		movea.l a3,a0

loc_5078:               ; CODE XREF: sub_4FE2+Cj
		exg a0,a1
		move.l  a1,-(sp)
		move.l  a0,-(sp)
		bsr.w   sub_8CE
		movea.l (sp)+,a0
		movea.l dword_5B58(a5),a1
		bsr.w   sub_4B3C
		move.w  #$40,d2 ; '@'
		lea unk_43FC(pc),a2
		movea.l dword_5B64(a5),a3
		movea.l dword_5B68(a5),a4
		moveq   #7,d7
		moveq   #0,d3

loc_50A0:               ; CODE XREF: sub_4FE2+D4j
		move.w  d3,d0
		bsr.w   sub_4C60
		lea unk_43F6(pc),a1
		bsr.w   sub_4D90
		move.w  d3,d0
		bsr.w   loc_4CDA
		addq.w  #1,d3
		dbf d7,loc_50A0
		move.w  #$100,d2
		lea unk_43EA(pc),a2
		movea.l dword_5B5C(a5),a3
		movea.l dword_5B60(a5),a4
		moveq   #7,d7
		moveq   #0,d3

loc_50CE:               ; CODE XREF: sub_4FE2+102j
		move.w  d3,d0
		bsr.w   sub_4BF8
		lea unk_43E4(pc),a1
		bsr.w   sub_4D90
		move.w  d3,d0
		bsr.w   sub_4C2C
		addq.w  #1,d3
		dbf d7,loc_50CE
		movea.l (sp)+,a1
		movea.l dword_5B58(a5),a0
		move.w  #$40,d1 ; '@'
		exg a0,a1
		bsr.w   sub_511A
		exg a0,a1
		move    #0,ccr

loc_50FE:               ; CODE XREF: sub_4FE2+136j
		movem.l (sp)+,d1/a0-a1
		m_saveStatusRegister
		adda.w  d1,a0
		adda.w  d1,a0
		asr.w   #1,d1
		adda.w  d1,a1
		m_restoreStatusRegister
		movem.l (sp)+,d0-d3/d7/a2-a4
		rts
; ---------------------------------------------------------------------------

loc_5114:               ; CODE XREF: sub_4FE2+80j
		move    #1,ccr
		bra.s   loc_50FE
; End of function sub_4FE2


; =============== S U B R O U T I N E =======================================


sub_511A:               ; CODE XREF: sub_448E+12p
					; BIOS:0000488Ep ...
		movem.l d2,-(sp)

loc_511E:               ; CODE XREF: sub_511A+10j
		subq.w  #4,d1
		blt.s   loc_512C
		move.l  (a1)+,d2
		movep.l d2,1(a0)
		addq.l  #8,a0
		bra.s   loc_511E
; ---------------------------------------------------------------------------

loc_512C:               ; CODE XREF: sub_511A+6j
		addq.w  #4,d1

loc_512E:               ; CODE XREF: sub_511A+1Ej
		subq.w  #1,d1
		blt.s   loc_513A
		move.b  (a1)+,1(a0)
		addq.l  #2,a0
		bra.s   loc_512E
; ---------------------------------------------------------------------------

loc_513A:               ; CODE XREF: sub_511A+16j
		movem.l (sp)+,d2
		rts
; End of function sub_511A


; =============== S U B R O U T I N E =======================================


sub_5140:               ; CODE XREF: BIOS:00004598p
					; _brmserch+40p ...
		movem.l d1/a1-a2,-(sp)

loc_5144:               ; CODE XREF: sub_5140+Cj
		subq.w  #4,d1
		blt.s   loc_514E
		cmpm.l  (a1)+,(a2)+
		bne.s   loc_515E
		bra.s   loc_5144
; ---------------------------------------------------------------------------

loc_514E:               ; CODE XREF: sub_5140+6j
		addq.w  #4,d1

loc_5150:               ; CODE XREF: sub_5140+18j
		subq.w  #1,d1
		blt.s   loc_515A
		cmpm.b  (a1)+,(a2)+
		bne.s   loc_515E
		bra.s   loc_5150
; ---------------------------------------------------------------------------

loc_515A:               ; CODE XREF: sub_5140+12j
		move    #4,ccr

loc_515E:               ; CODE XREF: sub_5140+Aj sub_5140+16j
		movem.l (sp)+,d1/a1-a2
		rts
; End of function sub_5140


; =============== S U B R O U T I N E =======================================


sub_5164:
		movem.l d1/a1-a2,-(sp)
		subq.w  #1,d1

loc_516A:               ; CODE XREF: sub_5164+8j
		move.b  (a1)+,(a2)+
		dbf d1,loc_516A
		movem.l (sp)+,d1/a1-a2
		rts
; End of function sub_5164


; =============== S U B R O U T I N E =======================================


sub_5176:               ; CODE XREF: BIOS:000045C8p
					; BIOS:00004652p ...
		movem.l d1/a1-a2,-(sp)

loc_517A:               ; CODE XREF: sub_5176+Aj
		subq.w  #4,d1
		blt.s   loc_5182
		move.l  (a1)+,(a2)+
		bra.s   loc_517A
; ---------------------------------------------------------------------------

loc_5182:               ; CODE XREF: sub_5176+6j
		addq.w  #4,d1

loc_5184:               ; CODE XREF: sub_5176+14j
		subq.w  #1,d1
		blt.s   loc_518C
		move.b  (a1)+,(a2)+
		bra.s   loc_5184
; ---------------------------------------------------------------------------

loc_518C:               ; CODE XREF: sub_5176+10j
		movem.l (sp)+,d1/a1-a2
		rts
; End of function sub_5176


; =============== S U B R O U T I N E =======================================


sub_5192:               ; CODE XREF: _brmdel+F4p
		movem.l d1/a1-a2,-(sp)
		adda.l  #1,a1
		adda.l  #1,a2

loc_51A2:               ; CODE XREF: sub_5192+18j
		move.b  (a1),(a2)
		addq.w  #2,a1
		addq.w  #2,a2
		subq.w  #2,d1
		bgt.s   loc_51A2
		movem.l (sp)+,d1/a1-a2
		rts
; End of function sub_5192


; =============== S U B R O U T I N E =======================================


sub_51B2:               ; CODE XREF: BIOS:000048F2p
					; _brmdel+10Cp
		movem.l d0-d4/a0-a2,-(sp)
		tst.b   d0
		beq.w   loc_5230
		moveq   #0,d3
		bsr.w   sub_531A
		bcs.w   loc_52AC
		move.w  d0,d3
		subq.w  #1,d0
		movea.l dword_5B8C(a5),a0
		lea $30(a0),a2
		move.w  d0,d4
		bsr.w   sub_5346
		bcs.w   loc_52AC
		divu.w  #2,d3
		swap    d3
		tst.w   d3
		bne.s   loc_51E8
		addq.w  #1,d0

loc_51E8:               ; CODE XREF: sub_51B2+32j
		add.w   $E(a1),d0
		movea.l dword_5B8C(a5),a0
		lea $20(a0),a0
		m_saveStatusRegister
		m_disableInterrupts
		move.w  d0,d0
		move.w  d0,-(sp)
		swap    d0
		move.w  (sp)+,d0
		movea.l a0,a0
		movep.l d0,1(a0)
		adda.l  #8,a0
		movep.l d0,1(a0)
		move.w  d4,d0
		move.w  d4,-(sp)
		swap    d0
		move.w  (sp)+,d0
		movea.l a2,a0
		movep.l d0,1(a0)
		adda.l  #8,a0
		movep.l d0,1(a0)
		m_restoreStatusRegister
		bra.w   loc_52A2
; ---------------------------------------------------------------------------

loc_5230:               ; CODE XREF: sub_51B2+6j
		moveq   #0,d3
		bsr.w   sub_531A
		bcs.w   loc_52AC
		move.w  d0,d3
		addq.w  #1,d0
		addq.w  #1,d3
		movea.l dword_5B8C(a5),a0
		lea $30(a0),a2
		move.w  d0,d4
		bsr.w   sub_5346
		bcs.w   loc_52AC
		divu.w  #2,d3
		swap    d3
		tst.w   d3
		bne.s   loc_525E
		subq.w  #1,d0

loc_525E:               ; CODE XREF: sub_51B2+A8j
		sub.w   $E(a1),d0
		movea.l dword_5B8C(a5),a0
		lea $20(a0),a0
		m_saveStatusRegister
		m_disableInterrupts
		move.w  d0,d0
		move.w  d0,-(sp)
		swap    d0
		move.w  (sp)+,d0
		movea.l a0,a0
		movep.l d0,1(a0)
		adda.l  #8,a0
		movep.l d0,1(a0)
		move.w  d4,d0
		move.w  d4,-(sp)
		swap    d0
		move.w  (sp)+,d0
		movea.l a2,a0
		movep.l d0,1(a0)
		adda.l  #8,a0
		movep.l d0,1(a0)
		m_restoreStatusRegister

loc_52A2:               ; CODE XREF: sub_51B2+7Aj
		move    #0,ccr

loc_52A6:               ; CODE XREF: sub_51B2+FEj
		movem.l (sp)+,d0-d4/a0-a2
		rts
; ---------------------------------------------------------------------------

loc_52AC:               ; CODE XREF: sub_51B2+10j sub_51B2+26j ...
		move    #1,ccr
		bra.s   loc_52A6
; End of function sub_51B2


; =============== S U B R O U T I N E =======================================


sub_52B2:               ; CODE XREF: sub_531A+22p sub_5346+22p
		movem.l d1-d5/a1-a4,-(sp)
		moveq   #0,d2
		moveq   #1,d3
		moveq   #2,d4
		movea.l a1,a2

loc_52BE:               ; CODE XREF: sub_52B2+4Ej
		movea.l a2,a3

loc_52C0:               ; CODE XREF: sub_52B2+3Cj
		adda.l  #2,a3
		movea.l a3,a4

loc_52C8:               ; CODE XREF: sub_52B2+30j
		adda.l  #2,a4
		move.w  (a3),d0
		cmp.w   (a2),d0
		bne.s   loc_52DE
		move.w  (a4),d0
		cmp.w   (a2),d0
		bne.s   loc_52DE
		move.w  (a2),d0
		bra.s   loc_5306
; ---------------------------------------------------------------------------

loc_52DE:               ; CODE XREF: sub_52B2+20j sub_52B2+26j
		addq.w  #1,d4
		cmp.w   d4,d1
		bgt.w   loc_52C8
		addq.w  #1,d3
		move.w  d3,d5
		addq.w  #1,d5
		cmp.w   d5,d1
		bgt.w   loc_52C0
		adda.l  #2,a2
		addq.w  #1,d2
		move.w  d2,d5
		addq.w  #2,d5
		cmp.w   d5,d1
		bgt.w   loc_52BE
		bra.s   loc_5310
; ---------------------------------------------------------------------------

loc_5306:               ; CODE XREF: sub_52B2+2Aj
		move    #0,ccr

loc_530A:               ; CODE XREF: sub_52B2+66j
		movem.l (sp)+,d1-d5/a1-a4
		rts
; ---------------------------------------------------------------------------

loc_5310:               ; CODE XREF: sub_52B2+52j
		move.w  #$FFFF,d0
		move    #1,ccr
		bra.s   loc_530A
; End of function sub_52B2


; =============== S U B R O U T I N E =======================================


sub_531A:               ; CODE XREF: BIOS:00004634p
					; _brmserch+6p ...
		movem.l d1-d2/a0-a2,-(sp)
		move.w  #8,d1
		move.w  d1,d2
		movea.l dword_5B8C(a5),a0
		lea $30(a0),a0
		lea dword_5BB2(a5),a1
		movea.l a1,a2
		bsr.w   sub_4FBC
		move.w  d2,d1
		asr.w   #1,d1
		movea.l a2,a1
		bsr.w   sub_52B2
		movem.l (sp)+,d1-d2/a0-a2
		rts
; End of function sub_531A


; =============== S U B R O U T I N E =======================================


sub_5346:               ; CODE XREF: BIOS:0000463Cp
					; BIOS:000047D8p ...
		movem.l d2/a0-a2,-(sp)
		move.w  #8,d1
		move.w  d1,d2
		movea.l dword_5B8C(a5),a0
		lea $20(a0),a0
		lea dword_5BB2(a5),a1
		movea.l a1,a2
		bsr.w   sub_4FBC
		move.w  d2,d1
		asr.w   #1,d1
		movea.l a2,a1
		bsr.w   sub_52B2
		movem.l (sp)+,d2/a0-a2
		rts
; End of function sub_5346


; =============== S U B R O U T I N E =======================================


sub_5372:               ; CODE XREF: BIOS:00004546p
					; BIOS:00004A22p
		movem.l d0-d1,-(sp)
		move.l  #$FE4000,dword_5B90(a5)
		move.l  #$FE3F80,dword_5B8C(a5)
		move.l  #$4000,dword_5B84(a5)
		move.w  #$7D,word_5B82(a5) ; '}'

loc_5394:               ; CODE XREF: BIOS:0000539Ej
		movem.l (sp)+,d0-d1
		rts
; End of function sub_5372

; ---------------------------------------------------------------------------
		move    #1,ccr
		bra.s   loc_5394

; =============== S U B R O U T I N E =======================================


sub_53A0:               ; CODE XREF: BIOS:loc_45D6p
					; BIOS:00004A2Ap
		movem.l d0/a1-a2,-(sp)
		movea.l dword_4432(pc),a1
		adda.l  #1,a1
		move.b  (a1),d0
		move.b  #$5A,(a1) ; 'Z'
		cmpi.b  #$5A,(a1) ; 'Z'
		bne.s   loc_53D0
		move.b  #$A5,(a1)
		cmpi.b  #$A5,(a1)
		bne.s   loc_53D0
		move.b  d0,(a1)
		move    #0,ccr

loc_53CA:               ; CODE XREF: sub_53A0+34j
		movem.l (sp)+,d0/a1-a2
		rts
; ---------------------------------------------------------------------------

loc_53D0:               ; CODE XREF: sub_53A0+18j sub_53A0+22j
		move    #1,ccr
		bra.s   loc_53CA
; End of function sub_53A0


; =============== S U B R O U T I N E =======================================


sub_53D6:               ; CODE XREF: BIOS:000045FAp
		movem.l d0-d2/a0-a1,-(sp)
		subq.w  #1,d1

loc_53DC:               ; CODE XREF: sub_53D6:loc_53F2j
		move.b  (a1)+,d2
		lea word_5406(pc),a0
		move.w  (a0)+,d0

loc_53E4:               ; CODE XREF: sub_53D6+16j
		cmp.b   (a0)+,d2
		bcs.s   loc_5400
		cmp.b   (a0)+,d2
		bls.s   loc_53F2
		dbf d0,loc_53E4
		bra.s   loc_5400
; ---------------------------------------------------------------------------

loc_53F2:               ; CODE XREF: sub_53D6+14j
		dbf d1,loc_53DC
		move    #0,ccr

loc_53FA:               ; CODE XREF: sub_53D6+2Ej
		movem.l (sp)+,d0-d2/a0-a1
		rts
; ---------------------------------------------------------------------------

loc_5400:               ; CODE XREF: sub_53D6+10j sub_53D6+1Aj
		move    #1,ccr
		bra.s   loc_53FA
; End of function sub_53D6

; ---------------------------------------------------------------------------
word_5406:  dc.w 2          ; DATA XREF: sub_53D6+8o
		dc.w $3039
		dc.w $415A
		dc.w $5F5F

fill_540E:
		dcb.b 1010, 0

	END
