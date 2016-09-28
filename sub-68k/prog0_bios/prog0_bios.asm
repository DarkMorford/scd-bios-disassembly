;   ======================================================================
;                     SEGA CD BIOS 2.00w US Disassembly
;                            Sub-CPU BIOS Module
;   ======================================================================
;
;       Disassembly created by DarkMorford
;
;   ======================================================================

	include "constants.asm"
	include "structs.asm"
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
	movea.l (initialSSP).l, sp

loc_256:
	clr.b (GA_INT_MASK).w
	m_disableInterrupts

	movem.l _zeroes(pc), d0-a6
	move.l  a0, usp
	move.b  #0, (GA_CDD_CONTROL).w

	; Trigger peripheral reset
	bclr #GA_RES0, (GA_RESET).w

	; Green LED on
	move.b #2, (GA_LED_STATUS).w

	; Set Word RAM to 2M mode
	lea (GA_MEMORY_MODE).w, a0
	@loc_27C:
		btst  #GA_MODE, (a0)
		beq.s loc_288
		bclr  #GA_MODE, (a0)
		bra.s @loc_27C
; ---------------------------------------------------------------------------

loc_288:
	; Give Word RAM to main CPU
	btst  #GA_DMNA, (a0)
	beq.s loc_292
	bset  #GA_RET, (a0)

loc_292:
	; Reset CDC (Sanyo LC89510)
	move.b #CDC_WRITE_RESET, (GA_CDC_ADDRESS).w
	move.b #0, (GA_CDC_REGISTER).w
	move.w #0, (GA_STOPWATCH).w

	; Clear communication registers
	moveq  #0, d0
	move.b d0, (GA_COMM_SUBFLAGS).w
	lea    (GA_COMM_SUBDATA).w, a0
	move.l d0, (a0)+
	move.l d0, (a0)+
	move.l d0, (a0)+
	move.l d0, (a0)

	; Mute CD audio
	move.w #0, (GA_CDD_FADER).w

	; Test header
	lea ProgramHeader(pc), a1
	cmpi.l  #'SEGA', (a1)
	bne.w   _reset

	; Compute BIOS checksum
	move.l GENHEADER.romEnd(a1), d1
	addq.l #1, d1
	lea    _start(pc), a0

	sub.l  a0, d1
	lsr.l  #1, d1
	move.w d1, d2
	subq.w #1, d2
	swap   d1

	moveq  #0, d0

	@loc_2E0:
		add.w   (a0)+, d0
		dbf d2, @loc_2E0
		dbf d1, @loc_2E0

	; Fetch proper checksum from header
	move.w GENHEADER.checksum(a1), d1
	beq.s  loc_2F6

	; Reset system if checksum fails
	cmp.w d1, d0
	bne.w _reset

loc_2F6:
	; Clear RAM from $5800 - $5FFF (2 KiB)
	movea.l #$5800, a0
	move.l  #$6000, d1
	subi.l  #$5801, d1
	lsr.l   #4, d1
	moveq   #0, d0

	@loc_30C:
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		dbf    d1, @loc_30C

	; Set up the jump tables with dummy values
	move.w #INST_JMP, d0
	lea _nullrts(pc), a0
	lea (JumpTable).w, a1

	; "User" jump table
	moveq #15, d1
	@loc_326:
		move.w d0, (a1)+
		move.l a0, (a1)+
		dbf    d1, @loc_326

	; Error vectors
	lea _reset(pc), a0
	moveq #8, d1
	@loc_334:
		move.w d0, (a1)+
		move.l a0,( a1)+
		dbf    d1, @loc_334

	; Interrupt/trap vectors
	lea _nullrte(pc), a0
	moveq #22, d1
	@loc_342:
		move.w d0, (a1)+
		move.l a0, (a1)+
		dbf    d1, @loc_342

	; Initialize other hardware
	bsr.w initLeds
	bsr.w initCdd
	bsr.w initCdc
	bsr.w initVolume
	bsr.w initCdb

	m_enableInterrupts
	nop

installDefaultJumpTable:
	m_disableInterrupts

	; Install interrupt vectors
	lea (_LEVEL1).w, a0
	lea tbl_378(pc), a1
	lea loc_388(pc), a6
	bra.w sub_556
; ---------------------------------------------------------------------------
tbl_378:
	dc.w (locret_660   - tbl_378)
	dc.w (mdInterrupt  - tbl_378)
	dc.w (locret_660   - tbl_378)
	dc.w (cddInterrupt - tbl_378)
	dc.w (cdcInterrupt - tbl_378)
	dc.w (scdInterrupt - tbl_378)
	dc.w (locret_660   - tbl_378)
	dc.w 0
; ---------------------------------------------------------------------------

loc_388:
	; Install _setjmptbl and _waitvsync handlers
	lea (_SETJMPTBL).w, a0
	lea tbl_398(pc), a1
	lea loc_39E(pc), a6
	bra.w sub_556
; ---------------------------------------------------------------------------
tbl_398:
	dc.w (_setJmpTbl     - tbl_398)
	dc.w (_waitForVBlank - tbl_398)
	dc.w 0
; ---------------------------------------------------------------------------

loc_39E:
	; Install _buram handler
	lea (_BURAM).w, a0
	lea (word_4436).l, a1
	lea loc_3B0(pc), a6
	bra.w sub_56A
; ---------------------------------------------------------------------------

loc_3B0:
	; Install _cdboot handler
	lea (_CDBOOT).w, a0
	lea (word_3900).l, a1
	lea loc_3C2(pc), a6
	bra.w sub_56A
; ---------------------------------------------------------------------------

loc_3C2:
	; Install _cdbios handler
	lea (_CDBIOS).w, a0
	lea (word_2924).l, a1
	lea loc_3D4(pc), a6
	bra.w sub_56A
; ---------------------------------------------------------------------------

	; Wait for peripheral reset to complete
	loc_3D4:
		btst  #GA_RES0, (GA_RESET).w
		beq.s loc_3D4

	; Enable INT2 (MD) and INT4 (CDD)
	ori.b #$14, (GA_INT_MASK).w

	; Reset CDD watchdog counter
	bclr   #2, cddFlags0(a5)
	move.w #$1E, cddWatchdogCounter(a5)

	; Enable CDD communication (HOCK)
	move.b #4, (GA_CDD_CONTROL).w

	move.b #$80, cddFlags0(a5)
	m_enableInterrupts

	@loc_3FE:
		bsr.w  _waitForVBlank
		move.b byte_5A04(a5), d0
		beq.s  @loc_3FE

	cmpi.b #$FF, d0
	beq.w  _reset

loc_410:
	movem.l _zeroes(pc), d0-a6

	; Install usercall* routines from boot module
	movea.l #bootModule, a1

installUserCallbacks:
	; Disable MD interrupt temporarily
	m_maskInterrupts INT_MD

	lea (_USERCALL0).w, a0
	bsr.w _setJmpTbl

	; Reset _USERMODE to 0
	clr.w  d0
	move.w d0, (_USERMODE).w

	; Call user init routine
	jsr _USERCALL0

	m_enableInterrupts

mainLoop:
	bsr.w _waitForVBlank

	move.w (_USERMODE).w, d0

	; Call user main routine
	jsr   _USERCALL1
	bcc.s mainLoop

	move.w d0, (_USERMODE).w

	cmpi.w #$FFFF, d0
	bne.s  mainLoop

	; Check for Game System disc
	cmpi.w #CD_GAMESYSTEM, (_BOOTSTAT).w
	beq.s  @loc_45C

	; Check for Game Boot disc
	cmpi.w #CD_GAMEBOOT, (_BOOTSTAT).w

@loc_45C:
	bne.s mainLoop

	; Disc is either game system or game boot
	movem.l _zeroes(pc), d0-a6

	; Install new usercall* routines
	lea   discBootHeader(pc), a1
	bra.s installUserCallbacks

; ---------------------------------------------------------------------------
discBootHeader:
	; User header (see BIOS pg 33)
	dc.b 'BOOT____SYS'  ; Module name
	dc.b 0              ; Boot flag
	dc.w $0100          ; Version
	dc.w 0              ; Module type
	dc.l 0              ; Next module pointer
	dc.l $EC            ; Module size
	dc.l $20            ; Start address
	dc.l 0              ; Work RAM size
	dc.w $FD82          ; usercall0 ($20C [_nullrts])
	dc.w $000A          ; usercall1 ($494 [beginDiscBoot])
	dc.w $FD82          ; usercall2 ($20C [_nullrts])
	dc.w $FD82          ; usercall3 ($20C [_nullrts])
	dc.w 0
; ---------------------------------------------------------------------------

beginDiscBoot:
	movea.l #WORD_RAM_1M, a1

	lea (GA_MEMORY_MODE).w, a0
	btst #GA_MODE, (a0)
	bne.s @loc_4BC                  ; Jump if WordRAM in 1M mode

	moveq #GA_RET, d0
	movea.l #WORD_RAM_2M, a1
	btst d0, (a0)
	beq.s @loc_4BC                  ; Jump if sub-CPU has WordRAM

	; Wait for main CPU to give up WordRAM
	@loc_4B0:
		btst  #GA_DMNA, (a0)
		beq.s @loc_4B0

	; Wait until sub-CPU gets WordRAM
	@loc_4B6:
		bclr  d0, (a0)
		btst  d0, (a0)
		bne.s @loc_4B6

@loc_4BC:
	movea.l a1, a0

	; Load initial program (IP) from disc
	lea   (bootModule).w, a0
	moveq #CBTIPDISC, d0
	bsr.w _CDBOOT
	bcs.s beginDiscBoot

	@loc_4CA:
		bsr.w _waitForVBlank
		bsr.w loc_51E

		; Check if IP is done loading
		moveq #CBTIPSTAT, d0
		bsr.w _CDBOOT
		bcs.s @loc_4CA

	bclr #7, (GA_COMM_SUBFLAGS).w

	lea   (GA_MEMORY_MODE).w, a0
	moveq #GA_RET, d0

	btst  #GA_MODE, (a0)
	beq.s @loc_4F8                  ; Jump if WordRAM in 2M mode

	btst  d0, (a0)
	beq.s @loc_4F8                  ; Jump if main CPU has WordRAM0

	; Swap WordRAM so main CPU has WordRAM0
	@loc_4F0:
		bclr  d0, (a0)
		btst  d0, (a0)
		bne.s @loc_4F0

	bra.s @loc_4FE
; ---------------------------------------------------------------------------

	; Give WordRAM2M/WordRAM1 to main CPU
	@loc_4F8:
		bset  d0, (a0)
		btst  d0, (a0)
		beq.s @loc_4F8

@loc_4FE:
	lea   (bootModule).w, a1
	moveq #CBTSPDISC, d0
	bsr.w _CDBOOT
	bcs.s beginDiscBoot

	bsr.w _waitForVBlank
	bsr.w loc_51E

	moveq #CBTSPSTAT, d0
	bsr.w _CDBOOT
	bra.s loc_552
; ---------------------------------------------------------------------------

loc_51A:
	bra.w loc_410
; ---------------------------------------------------------------------------

loc_51E:
	move.w #CDBSTAT, d0
	jsr    _CDBIOS

	moveq  #CBTINT, d0
	bsr.w  _CDBOOT
	rts
; ---------------------------------------------------------------------------

loc_52E:
	bsr.w  _waitForVBlank

	move.w #CDBSTAT, d0
	jsr    _CDBIOS

	move.w #CBTINT, d0
	bsr.w  _CDBOOT

	btst  #7, (_CDSTAT).w
	bne.s loc_52E

	move.w  #CBTSPSTAT, d0
	bsr.w   _CDBOOT

loc_552:
	bcs.s loc_52E
	bra.s loc_51A


; =============== S U B R O U T I N E =======================================


sub_556:
	move.l a1, d1
	bra.s  @loc_564
; ---------------------------------------------------------------------------

@loc_55A:
	ext.l  d0
	add.l  d1, d0
	move.w #INST_JMP, (a0)+
	move.l d0, (a0)+

@loc_564:
	move.w (a1)+, d0
	bne.s  @loc_55A

	jmp (a6)
; End of function sub_556


; =============== S U B R O U T I N E =======================================


sub_56A:
	move.w (a1), d0
	ext.l  d0
	add.l  a1, d0

	move.w #INST_JMP, (a0)+
	move.l d0, (a0)+

	jmp (a6)
; End of function sub_56A


; =============== S U B R O U T I N E =======================================


sub_578:                ; CODE XREF: _setJmpTbl+Ap
	movem.l a2/a6, -(sp)
	bra.s   @loc_59E
; ---------------------------------------------------------------------------

@loc_57E:
	movea.l a1, a2
	adda.l  USERHEADER.startAddress(a2), a1

	tst.b USERHEADER.bootFlag(a2)
	beq.s @loc_58E

	jsr   (a1)
	bcc.s @loc_594

@loc_58E:
	lea @loc_594(pc), a6
	bra.s sub_556
; ---------------------------------------------------------------------------

@loc_594:
	movea.l a2, a1

	move.l USERHEADER.nextModule(a1), d0
	beq.s  @loc_5B0

	adda.l d0, a1

@loc_59E:
	lea word_5B6(pc), a2
	bra.s @loc_5AC
; ---------------------------------------------------------------------------

@loc_5A4:
	move.l (a2)+, d0

	cmp.l (a1, d1.w), d0
	beq.s @loc_57E

@loc_5AC:
	move.w (a2)+, d1
	bpl.s  @loc_5A4

@loc_5B0:
	movem.l (sp)+, a2/a6
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


_setJmpTbl:
	movem.l a5, -(sp)
	movea.l #0, a5

	bsr.s   sub_578

	movem.l (sp)+, a5
	rts
; End of function _setJmpTbl


; =============== S U B R O U T I N E =======================================


_waitForVBlank:
	bset #0, (vBlankFlag).w

	@vBlankLoop:
		btst  #0, (vBlankFlag).w
		bne.s @vBlankLoop

	rts
; End of function _waitForVBlank

; ---------------------------------------------------------------------------

mdInterrupt:
	movem.l d0-a6, -(sp)
	movea.l #0, a5

	; CD-SYSTEM processing
	bsr.w checkCddWatchdog

	; Call user V-blank routine
	jsr _USERCALL2

	bclr    #0, (vBlankFlag).w
	movem.l (sp)+, d0-a6
	rte
; ---------------------------------------------------------------------------

cddInterrupt:
	movem.l d0-a6, -(sp)
	movea.l #0, a5

	bsr.w sub_E74
	bsr.w updateSubcode
	bsr.w cdbResume

	bsr.w updateVolume
	bsr.w updateLeds

	movem.l (sp)+, d0-a6
	rte
; ---------------------------------------------------------------------------

cdcInterrupt:
	movem.l d0-a6, -(sp)
	movea.l #0, a5

	bsr.w   updateCdc

	movem.l (sp)+, d0-a6
	rte
; ---------------------------------------------------------------------------

scdInterrupt:
	movem.l d0-a6, -(sp)
	movea.l #0, a5

	tst.b   byte_5810(a5)
	beq.s   @loc_65C
	bsr.w   sub_203E

@loc_65C:
	movem.l (sp)+, d0-a6

locret_660:
	rte

; =============== S U B M O D U L E =========================================
	include "submodules\led.asm"

; =============== S U B M O D U L E =========================================
	include "submodules\ringBuffer.asm"

; =============== S U B R O U T I N E =======================================


convertFromBcd:
	move.w d1, -(sp)

	andi.w #$FF, d0
	ror.w  #4, d0
	lsl.b  #1, d0
	move.b d0, d1

	lsl.b  #2, d0
	add.b  d0, d1

	rol.w  #4, d0
	andi.w #$F, d0
	add.b  d1, d0

	move.w (sp)+, d1
	rts
; End of function convertFromBcd


; =============== S U B R O U T I N E =======================================


timecodeToFrames:
	move.l d1, -(sp)
	move.l d0, -(sp)

	move.b TIMECODE.frames(sp), d0
	bsr.s  convertFromBcd
	moveq  #0, d1
	move.w d0, d1

	move.b TIMECODE.seconds(sp), d0
	bsr.s  convertFromBcd
	mulu.w #75, d0
	add.l  d0, d1

	move.b TIMECODE.minutes(sp), d0
	bsr.s  convertFromBcd
	mulu.w #4500, d0
	add.l  d1, d0

	move.l (sp)+, d1
	move.l (sp)+, d1
	rts
; End of function timecodeToFrames


; =============== S U B R O U T I N E =======================================


convertToBcd:
	andi.l #$FF, d0
	divu.w #10, d0
	swap   d0

	ror.w  #4, d0
	lsl.l  #4, d0
	swap   d0

	rts
; End of function convertToBcd


; =============== S U B R O U T I N E =======================================


framesToTimecode:
	move.l d1, -(sp)
	moveq  #0 ,d1
	move.l d1, -(sp)

	divu.w #75, d0
	move.w d0, d1
	swap   d0
	bsr.s  convertToBcd
	move.b d0, TIMECODE.frames(sp)

	move.l d1, d0
	divu.w #60, d0
	move.w d0, d1
	swap   d0
	bsr.s  convertToBcd
	move.b d0, TIMECODE.seconds(sp)

	move.l d1, d0
	bsr.s  convertToBcd
	move.b d0, TIMECODE.minutes(sp)

	move.l (sp)+, d0
	move.l (sp)+, d1
	rts
; End of function framesToTimecode


; =============== S U B R O U T I N E =======================================


sub_860:                ; CODE XREF: sub_210E+4p
	movem.l d2/a1/a6, -(sp)

	lea word_8EC(pc), a0

	clr.w d1

	bsr.s sub_878

	bsr.s sub_8A8

	not.w d1
	sub.w d1, (a1)+

	movem.l (sp)+, d2/a1/a6
	rts
; End of function sub_860


; =============== S U B R O U T I N E =======================================


sub_878:                ; CODE XREF: sub_860+Ap sub_8CE+Cp ...
	move.b (a1)+, d0
	lea sub_880(pc), a6

	bra.s loc_8BA
; End of function sub_878


; =============== S U B R O U T I N E =======================================


sub_880:                ; DATA XREF: sub_878+2o
	move.b (a1)+, d0
	lea sub_888(pc), a6

	bra.s loc_8BA
; End of function sub_880


; =============== S U B R O U T I N E =======================================


sub_888:                ; DATA XREF: sub_880+2o
	move.b (a1)+, d0
	lea sub_890(pc), a6

	bra.s loc_8BA
; End of function sub_888


; =============== S U B R O U T I N E =======================================


sub_890:                ; DATA XREF: sub_888+2o
	move.b (a1)+, d0
	lea sub_898(pc), a6

	bra.s loc_8BA
; End of function sub_890


; =============== S U B R O U T I N E =======================================


sub_898:                ; DATA XREF: sub_890+2o
	move.b (a1)+, d0
	lea sub_8A0(pc), a6

	bra.s loc_8BA
; End of function sub_898


; =============== S U B R O U T I N E =======================================


sub_8A0:                ; DATA XREF: sub_898+2o
	move.b (a1)+, d0
	lea sub_8A8(pc), a6

	bra.s loc_8BA
; End of function sub_8A0


; =============== S U B R O U T I N E =======================================


sub_8A8:                ; CODE XREF: sub_860+Cp
					; DATA XREF: sub_8A0+2o
	move.b (a1)+, d0
	lea loc_8B0(pc), a6

	bra.s loc_8BA
; ---------------------------------------------------------------------------

loc_8B0:                ; DATA XREF: sub_8A8+2o
	move.b (a1)+,d0
	lea locret_8B8(pc),a6
	bra.s loc_8BA

; ---------------------------------------------------------------------------

locret_8B8:             ; DATA XREF: sub_8A8+Ao
	rts
; ---------------------------------------------------------------------------

loc_8BA:                ; CODE XREF: sub_878+6j sub_880+6j ...
	rol.w  #8, d1

	clr.w  d2
	move.b d0, d2
	eor.b  d1, d2

	clr.b  d1

	add.w  d2, d2
	move.w (a0, d2.w), d2

	eor.w  d2, d1

	jmp (a6)
; End of function sub_8A8


; =============== S U B R O U T I N E =======================================


sub_8CE:                ; CODE XREF: sub_4E74+C6p sub_4FE2+9Cp
	movem.l d7/a2/a6, -(sp)
	movea.l a0, a1

	lea word_8EC(pc), a0
	clr.w d1

	bsr.s sub_878
	bsr.s sub_878
	bsr.s sub_878
	bsr.s sub_878

	move.w d1, d2
	not.w  d2

	movem.l (sp)+, d7/a2/a6
	rts
; End of function sub_8CE

; ---------------------------------------------------------------------------
word_8EC:
	incbin "unk_8EC.bin"

; =============== S U B R O U T I N E =======================================


initCdd:                ; CODE XREF: BIOS:0000034Ep
	move.w #$8000, d0
	bsr.w  sub_B0C
	rts
; End of function initCdd


; =============== S U B R O U T I N E =======================================


sub_AF6:                ; CODE XREF: BIOS:00002C62p
					; BIOS:00002CD0p ...
	move.b cddFlags7(a5), d0
	move.b cddFlags2(a5), d1

	andi.w #$F, d1
	beq.s  @locret_B0A

	move.b d1, d0
	m_setErrorFlag

@locret_B0A:             ; CODE XREF: sub_AF6+Cj
	rts
; End of function sub_AF6


; =============== S U B R O U T I N E =======================================


sub_B0C:                ; CODE XREF: initCdd+4p sub_2BBC+1Ep ...
	btst  #$F, d0
	bne.s @loc_B20

	btst  #0, cddFlags2(a5)
	beq.s @loc_B2C

	m_setErrorFlag
	rts
; ---------------------------------------------------------------------------

@loc_B20:
	bclr #0, cddFlags2(a5)
	bset #3, cddFlags2(a5)

@loc_B2C:
	movea.l d1, a0

	move.b  cddFlags2(a5), d1
	andi.w  #6, d1
	bne.s   @loc_B44

	move.b  cddFlags7(a5), d1
	or.b    d1, byte_5812(a5)
	clr.b   cddFlags7(a5)

@loc_B44:
	lea cddCommandWorkArea(a5), a1

	andi.w #$FF, d0
	lsl.w  #4, d0
	lsr.b  #4, d0
	move.w d0, (a1)+

	tst.b  d0
	beq.s  @loc_B58

	moveq  #0, d0

@loc_B58:
	lsr.w #6, d0
	jsr   loc_B60(pc, d0.w)
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
	bra.w   msfToCmdBytes
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   clearCarryFlag
; ---------------------------------------------------------------------------
	bra.w   sub_C6E
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   sub_BC8
; ---------------------------------------------------------------------------
	bra.w   msfToCmdBytes
; ---------------------------------------------------------------------------
	bra.w   sub_BC8

; =============== S U B R O U T I N E =======================================


msfToCmdBytes:                ; CODE XREF: BIOS:00000B74j
	move.l a0, d0
	swap   d0
	andi.w #$FF, d0
	bsr.w  splitBcdByte

	move.w a0, d0
	lsr.w  #8, d0
	bsr.w  splitBcdByte

	move.w a0, d0
	andi.w #$FF, d0
	bsr.w  splitBcdByte

	bset #0, cddFlags2(a5)

	m_clearErrorFlag
	rts
; End of function msfToCmdBytes


; =============== S U B R O U T I N E =======================================


sub_BC8:                ; CODE XREF: BIOS:loc_B60j
					; BIOS:00000B64j ...
	clr.l (a1)+
	clr.w (a1)

	bset #0, cddFlags2(a5)

	m_clearErrorFlag
	rts
; End of function sub_BC8


; =============== S U B R O U T I N E =======================================


sub_BD6:                ; CODE XREF: BIOS:00000B68j
	move.l a0, d0

	swap   d0
	andi.w #$F, d0
	move.w d0, (a1)+

	cmpi.b #5, d0
	beq.s  @loc_BF2

	clr.l  (a1)
	bset   #0, cddFlags2(a5)

	m_clearErrorFlag
	rts
; ---------------------------------------------------------------------------

@loc_BF2:
	move.w a0, d0

	lsr.w  #8, d0

	bclr   #7, d0
	beq.s  @loc_C06

	bsr.w  convertToBcd

	bset   #7, d0
	bra.s  @loc_C0A
; ---------------------------------------------------------------------------

@loc_C06:
	bsr.w convertToBcd

@loc_C0A:
	bsr.s  splitBcdByte

	move.w a0, d0
	andi.w #$FF, d0
	cmpi.w #$FF, d0
	beq.s  @loc_C1C

	bsr.w  convertToBcd

@loc_C1C:
	bsr.s splitBcdByte

	bset  #0, cddFlags2(a5)

	m_clearErrorFlag
	rts
; End of function sub_BD6


; =============== S U B R O U T I N E =======================================


sub_C28:                ; CODE XREF: BIOS:00000B6Cj
					; BIOS:00000B70j
	bsr.s timecodeToCddCommand
	bset  #0, cddFlags2(a5)

	m_clearErrorFlag
	rts
; End of function sub_C28


; =============== S U B R O U T I N E =======================================


timecodeToCddCommand:                ; CODE XREF: sub_C28p sub_12CE+4D8p
	move.l a0, d0

	cmpi.l #$17000, d0
	bcc.s  @loc_C44

	move.l #$17000,d0

@loc_C44:
	lsr.w  #4, d0
	lsr.b  #4, d0
	move.w d0, 4(a1)

	lsr.l  #4, d0
	lsr.w  #4, d0
	lsr.l  #4, d0
	lsr.w  #4, d0
	move.w d0, 2(a1)

	swap   d0
	lsl.w  #4, d0
	lsr.b  #4, d0
	move.w d0, (a1)

	rts
; End of function timecodeToCddCommand


; =============== S U B R O U T I N E =======================================


splitBcdByte:                ; CODE XREF: msfToCmdBytes+8p msfToCmdBytes+10p ...
	lsl.w  #4, d0
	lsr.b  #4, d0
	move.w d0, (a1)+
	rts
; End of function splitBcdByte


; =============== S U B R O U T I N E =======================================


clearCarryFlag:                ; CODE XREF: BIOS:00000B88j
	m_clearErrorFlag
	rts
; End of function clearCarryFlag


; =============== S U B R O U T I N E =======================================


sub_C6E:                ; CODE XREF: BIOS:00000B8Cj
	move.l a0, d0
	bsr.s  splitBcdByte

	clr.l  (a1)
	bset   #0, cddFlags2(a5)

	m_clearErrorFlag
	rts
; End of function sub_C6E


; =============== S U B R O U T I N E =======================================


writeTocForTrack:                ; CODE XREF: executeCdbCommand:loc_29FAp
	bset    #0, cddFlags4(a5)
	move.l  (a0), d0

	movem.l a0, -(sp)
	bsr.w   convertFromBcd
	movem.l (sp)+, a0

	cmpi.w  #100, d0
	bcc.s   @loc_CA4

	lea     cddTocTable(a5), a1
	add.w   d0, d0
	add.w   d0, d0
	move.l  (a0)+, (a1, d0.w)

@loc_CA4:
	bclr #0, cddFlags4(a5)
	rts
; End of function writeTocForTrack


; =============== S U B R O U T I N E =======================================


getTocForTrack:                ; CODE XREF: sub_12CE+4C6p
					; _cdbtocread+2p ...
	bset    #0, cddFlags4(a5)

	lea     cddTocTable(a5), a0
	cmpi.w  #100, d0
	bcc.s   @loc_CDC

	add.w   d0, d0
	add.w   d0, d0
	adda.w  d0, a0
	move.l  (a0), d0

	tst.b   d0
	beq.s   @loc_CDC

@loc_CC8:
	lea     cddTocCache(a5), a0
	bclr    #$F, d0
	sne     d1
	move.l  d0, (a0)

	bclr    #0, cddFlags4(a5)
	rts
; ---------------------------------------------------------------------------

@loc_CDC:
	adda.w  #4, a0
	lea     cddTocTable(a5), a1

	moveq   #0, d0
	move.b  cddLastTrack(a5), d0
	bsr.w   convertFromBcd

	add.w   d0, d0
	add.w   d0, d0
	adda.w  d0, a1

@loc_CF4:
	move.l  (a0)+, d0
	tst.b   d0
	bne.s   @loc_D04
	cmpa.w  a1, a0
	bls.s   @loc_CF4
	lea     dword_D0A(pc), a0
	move.l  (a0)+, d0

@loc_D04:
	subq.w  #4, a0
	clr.b   d0
	bra.s   @loc_CC8
; End of function getTocForTrack

; ---------------------------------------------------------------------------
dword_D0A:  dc.l $20000     ; DATA XREF: getTocForTrack+52o

; =============== S U B R O U T I N E =======================================


cddGetStatusCodeByte:                ; CODE XREF: sub_12CE:loc_1442p
					; sub_12CE:loc_145Ap ...
	move.b cddStatusCode(a5), d0
	rts
; End of function cddGetStatusCodeByte


; =============== S U B R O U T I N E =======================================


cddGetStatusCodeWord:                ; CODE XREF: sub_12CE+8Ap
	move.w cddStatusCode(a5), d0
	rts
; End of function cddGetStatusCodeWord


; =============== S U B R O U T I N E =======================================


setCarryFlag:
	m_setErrorFlag
	rts
; End of function setCarryFlag


; =============== S U B R O U T I N E =======================================


getAbsFrameTime:                ; CODE XREF: writeCddStatus+62p
	btst   #0, cddFlags5(a5)
	beq.s  setCarryFlag

	bset   #1, cddFlags4(a5)
	move.l cddAbsFrameTime(a5),d0
	bclr   #1, cddFlags4(a5)

	rts
; End of function getAbsFrameTime


; =============== S U B R O U T I N E =======================================


getRelFrameTime:                ; CODE XREF: writeCddStatus+72p
	btst   #1, cddFlags5(a5)
	beq.s  setCarryFlag

	bset   #2, cddFlags4(a5)
	move.l cddRelFrameTime(a5), d0
	bclr   #2, cddFlags4(a5)

	rts
; End of function getRelFrameTime


; =============== S U B R O U T I N E =======================================


getCurrentTrackNumber:                ; CODE XREF: writeCddStatus+4Cp
	btst   #2, cddFlags5(a5)
	beq.s  setCarryFlag

	move.b currentTrackNumber(a5), d0
	bsr.w  validateTrackNumber
	bsr.w  convertFromBcd

	m_clearErrorFlag
	rts
; End of function getCurrentTrackNumber


; =============== S U B R O U T I N E =======================================


getDiscControlCode:                ; CODE XREF: writeCddStatus+46p
	btst   #2, cddFlags5(a5)
	beq.s  setCarryFlag

	moveq  #0, d0
	move.b discControlCode(a5), d0
	rts
; End of function getDiscControlCode


; =============== S U B R O U T I N E =======================================


sub_D7C:                ; CODE XREF: BIOS:00003136p
					; BIOS:loc_3244p ...
	moveq  #0, d0
	move.b byte_59F6(a5), d0
	rts
; End of function sub_D7C


; =============== S U B R O U T I N E =======================================


getFirstTrack:              ; CODE XREF: BIOS:00002D36p
	btst  #6, cddFlags4(a5)
	beq.s setCarryFlag

	move.b cddFirstTrack(a5), d0
	bsr.w  convertFromBcd

	m_clearErrorFlag
	rts
; End of function getFirstTrack


; =============== S U B R O U T I N E =======================================


getLastTrack:
	btst  #6, cddFlags4(a5)
	beq.w setCarryFlag

	move.b cddLastTrack(a5), d0
	bsr.w  convertFromBcd

	m_clearErrorFlag
	rts
; End of function getLastTrack


; =============== S U B R O U T I N E =======================================


writeCddStatus:             ; CODE XREF: executeCdbCommand+98p
	movem.l a2, -(sp)
	movea.l a0, a2

	move.w  cddStatusCode(a5), d0
	move.w  d0, (a2)+

	lsr.w   #8, d0

	cmpi.b  #4, d0
	beq.s   @loc_DC8

	cmpi.b  #$C, d0
	bne.s   @loc_DEA

@loc_DC8:
	move.b  word_5A00+1(a5), (a2)+

	move.b  word_5A00(a5), d0

	cmpi.b  #$FF, d0
	beq.s   @loc_DDE

	bsr.w   validateTrackNumber
	bsr.w   convertFromBcd

@loc_DDE:
	move.b  d0, (a2)+

	move.l  dword_59F8(a5), (a2)+

	move.l  dword_59FC(a5), (a2)+

	bra.s   @loc_E26
; ---------------------------------------------------------------------------

@loc_DEA:
	moveq   #$FFFFFFFF, d0

	btst    #2, cddFlags5(a5)
	beq.s   @loc_E04

	bsr.w   getDiscControlCode

	move.w  d0, -(sp)

	bsr.w   getCurrentTrackNumber

	ror.l   #8, d0
	move.w  (sp)+, d0
	rol.l   #8, d0

@loc_E04:
	move.w  d0, (a2)+

	moveq   #$FFFFFFFF, d0

	btst    #0, cddFlags5(a5)
	beq.s   @loc_E14

	bsr.w   getAbsFrameTime

@loc_E14:
	move.l  d0, (a2)+

	moveq   #$FFFFFFFF, d0

	btst    #1, cddFlags5(a5)
	beq.s   @loc_E24

	bsr.w   getRelFrameTime

@loc_E24:
	move.l  d0, (a2)+

@loc_E26:
	btst    #6, cddFlags4(a5)
	beq.s   @loc_E48

	move.b  cddFirstTrack(a5), d0
	bsr.w   convertFromBcd
	move.b  d0, (a2)+

	move.b  cddLastTrack(a5), d0
	bsr.w   convertFromBcd
	move.b  d0, (a2)+

	move.w  cddVersion(a5), (a2)+

	bra.s   @loc_E4E
; ---------------------------------------------------------------------------

@loc_E48:
	move.l  #$FFFFFFFF, (a2)+

@loc_E4E:
	moveq   #$FFFFFFFF, d0

	btst    #5, cddFlags4(a5)
	beq.s   @loc_E5C

	move.l  cddLeadOutTime(a5), d0

@loc_E5C:
	move.l  d0, (a2)+

	movea.l a2, a0

	movem.l (sp)+, a2
	m_clearErrorFlag
	rts
; End of function writeCddStatus


; =============== S U B R O U T I N E =======================================


validateTrackNumber:            ; CODE XREF: getCurrentTrackNumber+Cp
					; writeCddStatus+28p
	cmpi.b #$AA,d0
	bcs.s  @locret_E72

	move.b cddLastTrack(a5), d0

@locret_E72:
	rts
; End of function validateTrackNumber


; =============== S U B R O U T I N E =======================================


sub_E74:                ; CODE XREF: BIOS:0000061Ap
	; Return if updater flag is already set
	bset  #0, cddFlags0(a5)
	bne.w @locret_ECE

	; Return if initial setup not finished
	btst  #7, cddFlags0(a5)
	beq.w @loc_EC8

	movem.l d7/a4, -(sp)

	bsr.w handleCddStatus1

	bsr.w readCddStatus
	bcs.s @loc_EBE

	; Calculate a checksum of the status bytes
	lea cddStatusCache(a5), a0
	clr.b d0

	moveq #4, d1
	@loc_E9E:
		add.b (a0)+, d0
		add.b (a0)+, d0
		dbf d1, @loc_E9E

	not.b  d0
	andi.b #$F, d0
	bne.s  @loc_EBE

	; Checksum valid
	bsr.w handleCddStatus0
	bsr.w handleCddStatus1

	bsr.w sub_12CE
	bsr.w sendCddCommand

@loc_EBE:
	movem.l (sp)+, d7/a4
	move.w  #$1E, cddWatchdogCounter(a5)

@loc_EC8:
	bclr #0, cddFlags0(a5)

@locret_ECE:
	rts
; End of function sub_E74


; =============== S U B R O U T I N E =======================================


readCddStatus:                ; CODE XREF: sub_E74+1Cp
	bclr #4, cddFlags3(a5)
	bclr #4, cddFlags4(a5)

	; Wait for data to finish transferring from CDD
	move.w #$100, d0
	@loc_EE0:
		btst #GA_DRS, (GA_CDD_CONTROL).w
		dbeq d0, @loc_EE0

	; Signal error if transfer timed out
	bne.s @abortError

	; Copy CDD status bytes to RAM cache
	lea cddStatusCache(a5), a0
	lea (GA_CDD_STATUS).w,  a1
	move.l (a1)+, (a0)+
	move.l (a1)+, (a0)+
	move.w (a1)+, (a0)+

	bset #4, cddFlags3(a5)
	bset #4, cddFlags4(a5)
	m_clearErrorFlag

@loc_F08:
	m_saveStatusRegister

	bclr   #4, cddFlags0(a5)

	bclr   #2, cddFlags0(a5)
	bne.s  @loc_F2E

	btst   #GA_DTS, (GA_CDD_CONTROL).w
	beq.s  @loc_F28

	; Abort CDD transfers
	move.b #4, (GA_CDD_CONTROL).w
	bra.s  @loc_F2E
; ---------------------------------------------------------------------------

@loc_F28:
	bset #4, cddFlags0(a5)

@loc_F2E:
	m_restoreConditionBits
	rts
; ---------------------------------------------------------------------------

@abortError:
	; Abort CDD transfers
	move.b #4, (GA_CDD_CONTROL).w

	m_setErrorFlag
	bra.s @loc_F08
; End of function readCddStatus


; =============== S U B R O U T I N E =======================================


sendCddCommand:             ; CODE XREF: sub_E74+46p
	lea cddCommandBuffer(a5), a0
	lea (GA_CDD_COMMAND).w, a1

	move.l  (a0)+, (a1)+
	move.l  (a0)+, (a1)+
	move.w  (a0)+, (a1)+

	rts
; End of function sendCddCommand


; =============== S U B R O U T I N E =======================================


handleCddStatus0:                ; CODE XREF: sub_E74+3Ap
	; Return if flag 4 is cleared
	btst   #4, cddFlags3(a5)
	beq.s  @exitHandler

	andi.b #$D0, cddFlags3(a5)
	clr.b  byte_5810(a5)

	; Copy STAH to RAM
	move.b cddStatusCache(a5), d0
	move.b d0, cddStatusCode(a5)

	andi.w #$F, d0
	add.w  d0,  d0
	add.w  d0,  d0
	jmp    @loc_F74(pc, d0.w)
; ---------------------------------------------------------------------------

@loc_F74:
	bra.w   sub_FDC
; ---------------------------------------------------------------------------
	bra.w   sub_1010    ; Playing
; ---------------------------------------------------------------------------
	bra.w   sub_1000    ; Seeking
; ---------------------------------------------------------------------------
	bra.w   loc_1014    ; Scanning
; ---------------------------------------------------------------------------
	bra.w   sub_101C    ; Disc paused
; ---------------------------------------------------------------------------
	bra.w   loc_FB6     ; Tray open
; ---------------------------------------------------------------------------
	bra.w   sub_1024
; ---------------------------------------------------------------------------
	bra.w   loc_103A
; ---------------------------------------------------------------------------
	bra.w   sub_1036
; ---------------------------------------------------------------------------
	bra.w   sub_1048    ; Disc stopped
; ---------------------------------------------------------------------------
	bra.w   sub_1054
; ---------------------------------------------------------------------------
	bra.w   sub_105E    ; No disc
; ---------------------------------------------------------------------------
	bra.w   sub_106C    ; Reading lead-out
; ---------------------------------------------------------------------------
	bra.w   sub_1024
; ---------------------------------------------------------------------------
	bra.w   loc_FB6
; ---------------------------------------------------------------------------
	bra.w   sub_1024
; ---------------------------------------------------------------------------

@exitHandler:           ; CODE XREF: handleCddStatus0+6j
	rts
; End of function handleCddStatus0


loc_FB6:                ; CODE XREF: handleCddStatus0+3Aj handleCddStatus0+5Ej
	clr.b  byte_5A05(a5)

	bclr   #6, cddFlags3(a5)
	bset   #5, cddFlags3(a5)

	clr.b  cddFirstTrack(a5)
	clr.b  cddLastTrack(a5)
	clr.l  cddLeadOutTime(a5)

	; Mark TOC and lead-out invalid
	andi.b #$9F, cddFlags4(a5)

	bsr.w  sub_1074


; =============== S U B R O U T I N E =======================================


sub_FDC:                ; CODE XREF: handleCddStatus0:loc_F74j
					; sub_105E+6p
	clr.l cddAbsFrameTime(a5)
	bset  #0, cddFlags5(a5)

	clr.l cddRelFrameTime(a5)
	bset  #1, cddFlags5(a5)

	clr.b currentTrackNumber(a5)
	clr.b discControlCode(a5)
	bset  #2, cddFlags5(a5)

	rts
; End of function sub_FDC


; =============== S U B R O U T I N E =======================================


sub_1000:               ; CODE XREF: handleCddStatus0+2Ej
	bsr.w sub_1074

	st byte_5810(a5)

	bset #2, cddFlags3(a5)
	rts
; End of function sub_1000


; =============== S U B R O U T I N E =======================================


sub_1010:               ; CODE XREF: handleCddStatus0+2Aj
	st byte_5810(a5)

loc_1014:               ; CODE XREF: handleCddStatus0+32j
	bset #2, cddFlags3(a5)
	rts
; End of function sub_1010


; =============== S U B R O U T I N E =======================================


sub_101C:               ; CODE XREF: handleCddStatus0+36j
	bset #2, cddFlags3(a5)
	rts
; End of function sub_101C


; =============== S U B R O U T I N E =======================================


sub_1024:               ; CODE XREF: handleCddStatus0+3Ej handleCddStatus0+5Aj ...
	bset   #1, cddFlags3(a5)
	andi.b #$F8, cddFlags5(a5)

	st     byte_5810(a5)
	rts
; End of function sub_1024


; =============== S U B R O U T I N E =======================================


sub_1036:               ; CODE XREF: handleCddStatus0+46j
	st     byte_5810(a5)

loc_103A:               ; CODE XREF: handleCddStatus0+42j
	bset   #0, cddFlags3(a5)
	andi.b #$F8, cddFlags5(a5)
	rts
; End of function sub_1036


; =============== S U B R O U T I N E =======================================


sub_1048:               ; CODE XREF: handleCddStatus0+4Aj
	ori.b #$48, cddFlags3(a5)
	st    byte_5810(a5)
	rts
; End of function sub_1048


; =============== S U B R O U T I N E =======================================


sub_1054:               ; CODE XREF: handleCddStatus0+4Ej
	bset  #2, cddFlags3(a5)
	bsr.s sub_1074
	rts
; End of function sub_1054


; =============== S U B R O U T I N E =======================================


sub_105E:               ; CODE XREF: handleCddStatus0+52j
	bset  #5, cddFlags3(a5)
	bsr.w sub_FDC
	bsr.s sub_1074
	rts
; End of function sub_105E


; =============== S U B R O U T I N E =======================================


sub_106C:               ; CODE XREF: handleCddStatus0+56j
	bset #2, cddFlags3(a5)
	rts
; End of function sub_106C


; =============== S U B R O U T I N E =======================================


sub_1074:               ; CODE XREF: handleCddStatus0+8Ap sub_1000p ...
	moveq  #$FFFFFFFF, d0
	move.l d0, dword_59F8(a5)
	move.l d0, dword_59FC(a5)
	move.w d0, word_5A00(a5)
	rts
; End of function sub_1074


; =============== S U B R O U T I N E =======================================


handleCddStatus1:               ; CODE XREF: sub_E74+18p sub_E74+3Ep
	; Return if flag is clear
	btst   #4, cddFlags4(a5)
	beq.s  @exitHandler

	; Copy STAL to RAM
	lea    cddStatusCache(a5), a4
	move.b 1(a4), d0
	andi.w #$F, d0
	move.b d0, cddStatusCode+1(a5)

	add.w  d0, d0
	add.w  d0, d0
	jmp    @loc_10A4(pc, d0.w)
; ---------------------------------------------------------------------------

@loc_10A4:
	bra.w readCddAbsTime
; ---------------------------------------------------------------------------
	bra.w readCddRelTime
; ---------------------------------------------------------------------------
	bra.w readCurrentTrackNumber
; ---------------------------------------------------------------------------
	bra.w readCdTotalLength
; ---------------------------------------------------------------------------
	bra.w readFirstLastTracks
; ---------------------------------------------------------------------------
	bra.w readTrackStartTime
; ---------------------------------------------------------------------------
	bra.w sub_1286
; ---------------------------------------------------------------------------
	bra.w @exitHandler
; ---------------------------------------------------------------------------
	bra.w @exitHandler
; ---------------------------------------------------------------------------
	bra.w @exitHandler
; ---------------------------------------------------------------------------
	bra.w @exitHandler
; ---------------------------------------------------------------------------
	bra.w @exitHandler
; ---------------------------------------------------------------------------
	bra.w @exitHandler
; ---------------------------------------------------------------------------
	bra.w @exitHandler
; ---------------------------------------------------------------------------
	bra.w @exitHandler
; ---------------------------------------------------------------------------
	bra.w cddMarkCurrentLocationDirty
; ---------------------------------------------------------------------------

@exitHandler:
	rts
; End of function handleCddStatus1


; =============== S U B R O U T I N E =======================================


sub_10E6:               ; CODE XREF: BIOS:00001180p
					; BIOS:000011ACp
	move.b  0(a4), d1

	cmpi.b  #1, d1
	beq.s   @loc_110A

	cmpi.b  #3, d1
	beq.s   @loc_110A

	cmpi.b  #4, d1
	beq.s   @loc_1102

	cmpi.b  #$C, d1
	bne.s   @locret_110C

; CDDSTATUS0 is 4 or C
@loc_1102:
	cmpi.l  #$FFFFFFFF, (a1)
	bne.s   @locret_110C

; CDDSTATUS0 is 1 or 3
@loc_110A:
	move.l  d0, (a1)

; CDDSTATUS0 is something else
@locret_110C:
	rts
; End of function sub_10E6


; =============== S U B R O U T I N E =======================================


sub_110E:               ; CODE XREF: BIOS:000011C8p
	move.b  0(a4), d1

	cmpi.b  #1, d1
	beq.s   @loc_1132

	cmpi.b  #3, d1
	beq.s   @loc_1132

	cmpi.b  #4, d1
	beq.s   @loc_112A

	cmpi.b  #$C, d1
	bne.s   @locret_113C

; CDDSTATUS0 is 4 or C
@loc_112A:
	cmpi.b  #$FF, word_5A00(a5)
	bne.s   @locret_113C

; CDDSTATUS0 is 1 or 3
@loc_1132:
	move.b  d0, word_5A00(a5)
	move.b  6(a4), word_5A00+1(a5)

; CDDSTATUS0 is something else
@locret_113C:
	rts
; End of function sub_110E

; ---------------------------------------------------------------------------

readCddAbsTime:               ; CODE XREF: handleCddStatus1:loc_10A4j
	; Return if something is accessing cddAbsFrameTime
	btst    #1, cddFlags4(a5)
	bne.s   @locret_118A

	bclr    #4, cddFlags4(a5)

	lea     2(a4), a0
	bsr.w   nybblesToDword

	lsl.l   #8, d0
	move.b  (a0), d0
	move.l  d0, cddAbsFrameTime(a5)
	eor.b   d0, byte_580B(a5)

	btst    #1, byte_580B(a5)
	beq.s   @loc_117C

	move.b  d0, byte_580B(a5)
	btst    #1, d0
	beq.s   @loc_1178

	bsr.w   cddEnableDeemphasis
	bra.s   @loc_117C
; ---------------------------------------------------------------------------

@loc_1178:
	bsr.w   cddDisableDeemphasis

@loc_117C:
	lea   dword_59F8(a5), a1
	bsr.w sub_10E6

	; Mark cddAbsFrameTime valid
	bset    #0, cddFlags5(a5)

@locret_118A:
	rts
; ---------------------------------------------------------------------------

readCddRelTime:               ; CODE XREF: handleCddStatus1+24j
	btst    #2, cddFlags4(a5)
	bne.s   @locret_11B6

	bclr    #4, cddFlags4(a5)

	lea     2(a4), a0
	bsr.s   nybblesToDword

	lsl.l   #8, d0
	move.b  (a0), d0
	move.l  d0, cddRelFrameTime(a5)

	lea     dword_59FC(a5), a1
	bsr.w   sub_10E6

	bset    #1, cddFlags5(a5)

@locret_11B6:
	rts
; ---------------------------------------------------------------------------

readCurrentTrackNumber:               ; CODE XREF: handleCddStatus1+28j
	bclr    #4, cddFlags4(a5)

	lea     2(a4), a0
	bsr.s   nybblesToByte

	move.b  d0, currentTrackNumber(a5)
	bsr.w   sub_110E

	move.b  6(a4), discControlCode(a5)

	bset    #2, cddFlags5(a5)

	rts

; =============== S U B R O U T I N E =======================================


nybblesToDword:
	move.b (a0)+, d0
	lsl.b  #4, d0
	or.b   (a0)+, d0
	lsl.l  #8, d0

	move.b (a0)+, d0
	lsl.b  #4, d0
	or.b   (a0)+, d0
	lsl.l  #8, d0

nybblesToByte:
	move.b (a0)+, d0
	lsl.b  #4, d0
	or.b   (a0)+, d0

	rts
; End of function nybblesToDword


; =============== S U B R O U T I N E =======================================


readCdTotalLength:               ; CODE XREF: handleCddStatus1+2Cj
	; Return if something else is accessing the TOC
	btst   #0, cddFlags4(a5)
	bne.s  @locret_1212

	bclr   #4, cddFlags4(a5)

	lea    2(a4), a0
	bsr.s  nybblesToDword

	lsl.l  #8, d0
	move.l d0, cddLeadOutTime(a5)

	bset   #5, cddFlags4(a5)

@locret_1212:
	rts
; End of function readCdTotalLength


; =============== S U B R O U T I N E =======================================


readFirstLastTracks:               ; CODE XREF: handleCddStatus1+30j
	; Return if something else is accessing the TOC
	btst  #0, cddFlags4(a5)
	bne.s @locret_1236

	bclr   #4, cddFlags4(a5)

	lea    2(a4), a0
	bsr.s  nybblesToDword

	lsl.l  #8,   d0
	move.b (a0), d0
	move.l d0, cddFirstTrack(a5)

	bset   #6, cddFlags4(a5)

@locret_1236:
	rts
; End of function readFirstLastTracks


; =============== S U B R O U T I N E =======================================


readTrackStartTime:               ; CODE XREF: handleCddStatus1+34j
	; Return if something else is accessing the TOC
	btst   #0, cddFlags4(a5)
	bne.s  @locret_1284

	bclr   #4, cddFlags4(a5)

	; Return if not waiting
	btst   #7, cddFlags4(a5)
	beq.s  @locret_1284

	; Return if wrong track fetched
	move.b requestedTrackNumber(a5), d0
	andi.w #$F, d0
	cmp.b  8(a4), d0
	bne.s  @locret_1284

	move.b requestedTrackNumber(a5), d0
	bsr.w  convertFromBcd

	add.w  d0, d0
	add.w  d0, d0

	lea    2(a4), a0
	lea    cddTocTable(a5), a1
	adda.w d0, a1

	bsr.w  nybblesToDword
	lsl.l  #8, d0
	move.b requestedTrackNumber(a5), d0
	move.l d0, (a1)+

	; Clear waiting flag
	bclr   #7, cddFlags4(a5)

@locret_1284:
	rts
; End of function readTrackStartTime


; =============== S U B R O U T I N E =======================================


sub_1286:               ; CODE XREF: handleCddStatus1+38j
	bclr    #4, cddFlags4(a5)

	lea     2(a4), a0
	bsr.w   nybblesToByte

	move.b  d0, byte_59F6(a5)

	btst    #0, cddFlags3(a5)
	beq.s   @locret_12AC

	cmpi.b  #6, d0
	bcs.s   @locret_12AC

	bset    #7, cddFlags7(a5)

@locret_12AC:
	rts
; End of function sub_1286


; =============== S U B R O U T I N E =======================================


cddMarkCurrentLocationDirty:               ; CODE XREF: handleCddStatus1+5Cj
	andi.b #$F8, cddFlags5(a5)
	rts
; End of function cddMarkCurrentLocationDirty


; =============== S U B R O U T I N E =======================================


sub_12B6:               ; CODE XREF: sub_12CE+96p
	cmpi.b #5, byte_5815(a5)
	beq.s  @loc_12CA

	cmpi.b #5, d0
	bne.s  @loc_12CA

	m_setErrorFlag
	bra.s  @locret_12CC
; ---------------------------------------------------------------------------

@loc_12CA:
	m_clearErrorFlag

@locret_12CC:
	rts
; End of function sub_12B6


; =============== S U B R O U T I N E =======================================


	include "functions\sub_12CE.asm"


; =============== S U B R O U T I N E =======================================


checkCddWatchdog:               ; CODE XREF: BIOS:000005FCp
	subq.w #1, cddWatchdogCounter(a5)
	bcc.s @locret_1806

	; Watchdog counter hit -1, set the error flag
	bset #2, cddFlags0(a5)

	; Reset counter
	move.w #$1E, cddWatchdogCounter(a5)

	; HOCK on, abort CDD transfers
	move.b #4, (GA_CDD_CONTROL).w

@locret_1806:
	rts
; End of function checkCddWatchdog


; =============== S U B R O U T I N E =======================================


clearCdcRingBuffer:               ; CODE XREF: BIOS:00003720p
	movem.l a4, -(sp)

	lea cdcRingBuffer(a5), a4
	move.w RINGBUFFER.writePtr(a4), RINGBUFFER.readPtr(a4)

	movem.l (sp)+, a4
	rts
; End of function clearCdcRingBuffer


; =============== S U B R O U T I N E =======================================


_cdcstat:               ; CODE XREF: executeCdbCommand+36j
	move.w  cdcFlags0(a5), d0
	movem.l d0/a4, -(sp)

	lea cdcRingBuffer(a5), a4

	; Return cs if buffer empty
	move.w RINGBUFFER.writePtr(a4), d0
	cmp.w  RINGBUFFER.readPtr(a4), d0
	beq.s  @loc_1836

	m_clearErrorFlag
	bra.s @loc_183A
; ---------------------------------------------------------------------------

@loc_1836:
	m_setErrorFlag

@loc_183A:
	movem.l (sp)+, d0/a4
	rts
; End of function _cdcstat


; =============== S U B R O U T I N E =======================================


getCdcFrameHeader:               ; CODE XREF: executeCdbCommand+A8p
	move.l cdcFrameHeader(a5), d0
	rts
; End of function getCdcFrameHeader


; =============== S U B R O U T I N E =======================================


_cdcread:               ; CODE XREF: executeCdbCommand+3Aj
	movem.l a3-a4, -(sp)
	m_setErrorFlag

	m_saveStatusRegister
	m_maskInterrupts INT_CDC

	; Return error if buffer is empty
	lea    cdcRingBuffer(a5), a4
	move.w RINGBUFFER.writePtr(a4), d0
	cmp.w  RINGBUFFER.readPtr(a4), d0
	beq.s  @loc_18CE

	btst   #5, cdcFlags0(a5)
	bne.s  @loc_1870

	bsr.w  readRingBuffer
	bra.s  @loc_1876
; ---------------------------------------------------------------------------

	@loc_1870:
		bsr.w readRingBuffer
		bne.s @loc_1870

@loc_1876:
	move.w 4(a0), d1
	ror.w  #8, d1

	move.w #2351, d0

	; Check CD data mode
	btst  #3, cdcFlags0(a5)
	bne.s @loc_18A4

; CD Mode 1
@loc_1888:
	move.w #2051, d0

	; Check CDC device destination
	btst  #2, (GA_CDC_TRANSFER).w
	beq.s @loc_1898

	; Only if a DMA mode is selected
	subq.w #4, d0
	addq.w #4, d1

@loc_1898:
	; Check for error detection/correction data
	btst  #2, cdcFlags0(a5)
	beq.s @loc_18A4

	; Add 288 bytes for EDC data
	addi.w #288, d0

; CD Mode 2
@loc_18A4:
	; Send transfer information to the CDC
	lea (GA_CDC_REGISTER).w, a3
	move.b #CDC_WRITE_DBCL, (GA_CDC_ADDRESS).w

	; Number of bytes to transfer
	move.b d0, (a3) ; DBCL
	lsr.w  #8, d0
	move.b d0, (a3) ; DBCH

	; Transfer start address
	move.b d1, (a3) ; DACL
	lsr.w  #8, d1
	move.b d1, (a3) ; DACH

	; Begin data transfer
	move.b #0, (a3) ; DTTRG

	; Set transfer flag
	bset #1, cdcFlags0(a5)

	andi.w #$FF00, (sp)
	move.l (a0), d0
	move.w 6(a0), d1

@loc_18CE:
	m_restoreStatusRegister
	movem.l (sp)+, a3-a4
	rts
; End of function _cdcread


; =============== S U B R O U T I N E =======================================

; Copy 16 bytes from CDC to RAM
sub_18D6:               ; CODE XREF: _cdctrn+2Cp
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
	dbf d1, sub_18D6
	rts
; End of function sub_18D6


; =============== S U B R O U T I N E =======================================


_cdctrn:                ; CODE XREF: executeCdbCommand+3Ej
	movem.l a2-a3, -(sp)

	lea (GA_CDC_DATA).w, a2
	lea (GA_CDC_TRANSFER).w, a3

	; Wait for CDC to signal data ready
	move.w #$800, d1
	@loc_190C:
		btst #6, (a3)
		dbne d1, @loc_190C

	; Timed out, raise error condition
	beq.s  @loc_197A

	; Check CD data mode
	btst   #3, cdcFlags0(a5)
	bne.s  @loc_193E

; Read Mode 1 frame
@loc_191E:
	; Read 4 header bytes
	move.w  (a2), (a1)+
	nop
	move.w  (a2), (a1)+

	; Read 2048 data bytes
	move.w  #$7F, d1
	bsr.s   sub_18D6

	; Check for error detection data
	btst    #2, cdcFlags0(a5)
	beq.s   @loc_1938

	; Read 288 error correction/detection bytes
	move.w  #$11, d1
	bsr.s   sub_18D6

@loc_1938:
	move.w  #$800, d1
	bra.s   @loc_196C
; ---------------------------------------------------------------------------

; Read Mode 2 frame
@loc_193E:
	; Read 4 header bytes
	move.w  (a2), d0
	move.w  d0, (a1)+
	move.w  d0, (a0)+
	move.w  (a2), d0
	move.w  d0, (a1)+
	move.w  d0, (a0)+

	; Read 12 sync(?) bytes
	move.w  (a2), (a0)+
	nop
	move.w  (a2), (a0)+
	nop
	move.w  (a2), (a0)+
	nop
	move.w  (a2), (a0)+
	nop
	move.w  (a2), (a0)+
	nop
	move.w  (a2), (a0)+

	; Read 2336 data bytes
	move.w  #$91, d1
	bsr.w   sub_18D6

	bra.s   @loc_1938
; ---------------------------------------------------------------------------

	; Eat any extra data the CDC gives us
	@loc_196A:
		move.w (a2), d0

	@loc_196C:
		btst #7, (a3)
		dbne d1, @loc_196A

	; Timed out, raise error condition
	beq.s @loc_197A

	m_clearErrorFlag
	bra.s @loc_19A2
; ---------------------------------------------------------------------------

@loc_197A:
	m_saveStatusRegister
	m_maskInterrupts INT_CDC

	move.b #CDC_WRITE_IFCTRL, (GA_CDC_ADDRESS).w
	move.b #$38, (GA_CDC_REGISTER).w

	move.b #CDC_WRITE_IFCTRL, (GA_CDC_ADDRESS).w
	move.b #$3A, (GA_CDC_REGISTER).w

	m_restoreStatusRegister
	nop
	nop
	m_setErrorFlag

@loc_19A2:               ; CODE XREF: _cdctrn+7Cj
	movem.l (sp)+, a2-a3
	rts
; End of function _cdctrn


; =============== S U B R O U T I N E =======================================


_cdcack:                ; CODE XREF: executeCdbCommand+42j
	m_saveStatusRegister
	m_maskInterrupts INT_CDC

	move.b #CDC_WRITE_DTACK, (GA_CDC_ADDRESS).w
	move.b #0, (GA_CDC_REGISTER).w

	bclr #1, cdcFlags0(a5)

	m_restoreStatusRegister
	rts
; End of function _cdcack


; =============== S U B R O U T I N E =======================================


sub_19C4:               ; CODE XREF: BIOS:loc_3832p
	; Return if bit 7 was already clear
	bclr    #7, cdcFlags0(a5)
	beq.s   @locret_19D2

	bset    #6, cdcFlags0(a5)

@locret_19D2:
	rts
; End of function sub_19C4


; =============== S U B R O U T I N E =======================================


sub_19D4:               ; CODE XREF: BIOS:loc_3890p
	; Return if bit 6 was already clear
	bclr    #6, cdcFlags0(a5)
	beq.s   @locret_19E2

	bset    #7, cdcFlags0(a5)

@locret_19E2:
	rts
; End of function sub_19D4


; =============== S U B R O U T I N E =======================================


_cdcsetmode:                ; CODE XREF: executeCdbCommand+66j
	m_saveStatusRegister
	m_maskInterrupts INT_CDC

	andi.w  #$F, d1
	lsl.w   #2,  d1

	andi.b  #$C3, cdcFlags0(a5)
	or.b    d1,   cdcFlags0(a5)

	m_restoreStatusRegister
	rts
; End of function _cdcsetmode


; =============== S U B R O U T I N E =======================================


updateCdc:              ; CODE XREF: BIOS:0000063Ep
	; Return if updater flag is already set
	bset  #0, cdcFlags0(a5)
	bne.s locret_1A5C

	; Return if bit 7 is cleared
	btst  #7, cdcFlags0(a5)
	beq.s loc_1A56

	movem.l d5-d7/a2-a4, -(sp)

	; Copy header/status data from CDC to RAM
	lea (GA_CDC_ADDRESS).w,  a2
	lea (GA_CDC_REGISTER).w, a3
	lea cdcStatus(a5), a0

	move.b #CDC_READ_IFSTAT, (a2)
	move.b (a3), (a0)+   ; IFSTAT
	addq.w #1, a0

	move.b #CDC_READ_HEAD0, (a2)
	move.b (a3), (a0)+   ; HEAD0
	move.b (a3), (a0)+   ; HEAD1
	move.b (a3), (a0)+   ; HEAD2
	move.b (a3), (a0)+   ; HEAD3
	move.b (a3), (a0)+   ; PTL
	move.b (a3), (a0)+   ; PTH

	move.b #CDC_READ_STAT0, (a2)
	move.b (a3), (a0)+   ; STAT0
	move.b (a3), (a0)+   ; STAT1
	move.b (a3), (a0)+   ; STAT2
	move.b (a3), (a0)+   ; STAT3

	movem.l cdcRegisterCache(a5), d5-a0/a2-a4
	jmp (a0)
; End of function updateCdc


; =============== S U B R O U T I N E =======================================


cdcSuspendExecution:               ; CODE XREF: initCdc:loc_1AA4p
	movea.l (sp)+, a0
	movem.l d5-a0/a2-a4, cdcRegisterCache(a5)
	movem.l (sp)+, d5-d7/a2-a4

loc_1A56:
	; Done with update, clear busy flag
	bclr #0, cdcFlags0(a5)

locret_1A5C:
	rts
; End of function cdcSuspendExecution


; =============== S U B R O U T I N E =======================================


initCdc:                ; CODE XREF: BIOS:00000352p
	movem.l d5-d7/a2-a4, -(sp)

	lea (GA_CDC_ADDRESS).w, a2
	lea (GA_CDC_REGISTER).w, a3
	bsr.w resetCdc

	lea cdcFlags0(a5), a0
	moveq #0, d0

	moveq #6, d1
	@loc_1A76:
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		move.l d0, (a0)+
		dbf d1, @loc_1A76

	move.l d0, (a0)+
	move.l d0, (a0)+
	move.l d0, (a0)+
	move.w d0, (a0)

	move.l  #$80008, d0
	move.l  #$80030, d1
	movea.l #'CDCD', a0

	lea cdcRingBuffer(a5), a4
	bsr.w initRingBuffer

loc_1AA4:               ; CODE XREF: initCdc+48j
				; _cdcstart+188j
	bsr.s cdcSuspendExecution
	bra.w loc_1AA4
; End of function initCdc


; =============== S U B R O U T I N E =======================================


_cdcstop:               ; CODE XREF: executeCdbCommand+32j
					; BIOS:00002BF6p ...
	bclr    #7, cdcFlags0(a5)
	beq.s   locret_1AE6

abortCdcTransfer:           ; CODE XREF: _cdcstart+1Ap
	bclr    #1, cdcFlags0(a5)

	; Disable CDC interrupt
	bclr    #GA_IEN5, (GA_INT_MASK).w

	move.b  #CDC_WRITE_IFCTRL, (GA_CDC_ADDRESS).w
	move.b  #$38, (GA_CDC_REGISTER).w

	move.b  #CDC_WRITE_IFCTRL, (GA_CDC_ADDRESS).w
	move.b  #$3A, (GA_CDC_REGISTER).w

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

_cdcstart:              ; CODE XREF: executeCdbCommand+2Aj
	move.l  #$FFFFFFF, d0
	bra.s   loc_1AFC
; ---------------------------------------------------------------------------

_cdcstartp:             ; CODE XREF: executeCdbCommand+2Ej
	ori.l   #$FFFFFFF0, d1
	ror.w   #4, d1
	swap    d1
	move.l  d1, d0

loc_1AFC:               ; CODE XREF: _cdcstart+6j
	moveq   #$FFFFFFFF, d1

loc_1AFE:               ; CODE XREF: sub_3728+12p
	movem.l d5-d7/a2-a4, -(sp)
	bsr.s   abortCdcTransfer

	move.l  d1, dword_5A34(a5)
	rol.l   #4, d0
	move.l  d0, d1

	asr.l   #4, d0
	move.l  d0, dword_5A2C(a5)
	move.l  d0, dword_5A30(a5)

	andi.b  #$F, d1
	lsl.b   #2, d1
	ori.b   #$81, d1
	move.b  d1, cdcFlags0(a5)

	clr.b   cdcFlags1(a5)

	lea     (GA_CDC_ADDRESS).w,  a2
	lea     (GA_CDC_REGISTER).w, a3
	bsr.w   resetCdc

	lea cdcRingBuffer(a5), a4
	move.w RINGBUFFER.writePtr(a4), RINGBUFFER.readPtr(a4)

	; Enable CDC interrupt
	bset    #GA_IEN5, (GA_INT_MASK).w

	; Prepare CDC for data read
	bsr.w   sub_1CE6

	move.w  #$1E, d7
	move.w  #5,   d6
	move.w  #5,   d5

@loc_1B54:               ; CODE XREF: _cdcstart+9Cj
	bsr.w   cdcSuspendExecution

	btst    #3, cdcFlags0(a5)
	beq.s   @loc_1B6E

	move.b  byte_5A41(a5), d0
	andi.b  #$C0, d0
	sne     byte_5A39(a5)

	bra.s   @loc_1B86
; ---------------------------------------------------------------------------

@loc_1B6E:               ; CODE XREF: _cdcstart+76j
	bsr.w   sub_1CF4
	bcs.s   @loc_1B7A

	bsr.w   sub_1D52
	bcc.s   @loc_1B86

@loc_1B7A:               ; CODE XREF: _cdcstart+8Aj
	btst    #7, cdcFlags1(a5)
	bne.w   @loc_1C66
	bra.s   @loc_1B54
; ---------------------------------------------------------------------------

@loc_1B86:               ; CODE XREF: _cdcstart+84j
				; _cdcstart+90j
	move.b  #CDC_WRITE_CTRL0, (a2)
	move.b  #$A4, (a3)
	move.b  #$D8, (a3)

	move.w #30, d7
	@loc_1B96:
		bsr.w  cdcSuspendExecution

		btst   #3, cdcFlags0(a5)
		bne.s  @loc_1BBA

		move.b cdcStat0(a5), d0
		andi.b #$68, d0
		dbeq   d7, @loc_1B96

	beq.s   @loc_1BBA

	bset    #7, cdcFlags1(a5)
	bra.w   @loc_1C66
; ---------------------------------------------------------------------------

@loc_1BBA:               ; CODE XREF: _cdcstart+B8j
				; _cdcstart+C6j
	move.w  #$1E, d7
	move.w  #5,   d6
	move.w  #5,   d5

	move.b  cdcFlags0(a5), d0
	andi.b  #$C, d0
	beq.s   @loc_1C26

	btst    #3, cdcFlags0(a5)
	beq.s   @loc_1C00

@loc_1BD8:               ; CODE XREF: _cdcstart+112j
	clr.l   dword_5A30(a5)
	bsr.w   cdcSuspendExecution

	bsr.w   sub_1D34
	bcs.s   @loc_1BF4

	bsr.w   sub_1E44
	bcs.s   @loc_1BF4

	bsr.w   sub_1E6A
	bcc.w   @loc_1C66

@loc_1BF4:               ; CODE XREF: _cdcstart+FCj
				; _cdcstart+102j
	btst    #7, cdcFlags1(a5)
	beq.s   @loc_1BD8
	bra.w   @loc_1C66
; ---------------------------------------------------------------------------

@loc_1C00:               ; CODE XREF: _cdcstart+EEj
				; _cdcstart+13Aj
	bsr.w   cdcSuspendExecution

	bsr.w   sub_1CF4
	bcs.s   @loc_1C1C

	bsr.w   sub_1DB0
	bcs.s   @loc_1C1C

	bsr.w   sub_1E44
	bcs.s   @loc_1C1C

	bsr.w   sub_1E6A
	bcc.s   @loc_1C66

@loc_1C1C:               ; CODE XREF: _cdcstart+120j
				; _cdcstart+126j ...
	btst    #7, cdcFlags1(a5)
	beq.s   @loc_1C00
	bra.s   @loc_1C66
; ---------------------------------------------------------------------------

@loc_1C26:               ; CODE XREF: _cdcstart+E6j
	move.b  #CDC_WRITE_CTRL0, (a2)
	move.b  #$A7, (a3)
	move.b  #$F0, (a3)

@loc_1C32:               ; CODE XREF: _cdcstart+17Cj
				; _cdcstart+1CEj
	bsr.w   cdcSuspendExecution

	bsr.w   sub_1CF4
	bcs.s   @loc_1C5E

	bsr.w   sub_1DB0
	bcs.s   @loc_1C5E

	bclr    #1, cdcFlags1(a5)

	bsr.w   sub_1DF6
	bcs.s   @loc_1C56

	bsr.w   sub_1E6A
	bcs.s   @loc_1C5E

	bra.s   @loc_1C66
; ---------------------------------------------------------------------------

@loc_1C56:               ; CODE XREF: _cdcstart+164j
	btst    #1, cdcFlags1(a5)
	bne.s   @loc_1C74

@loc_1C5E:               ; CODE XREF: _cdcstart+152j
				; _cdcstart+158j ...
	btst    #7, cdcFlags1(a5)
	beq.s   @loc_1C32

@loc_1C66:               ; CODE XREF: _cdcstart+98j
				; _cdcstart+CEj ...
	bsr.w   sub_1CE6

	bset    #0, cdcFlags1(a5)
	bra.w   loc_1AA4
; ---------------------------------------------------------------------------

@loc_1C74:               ; CODE XREF: _cdcstart+174j
	move.b  #CDC_WRITE_CTRL0, (a2)
	move.b  #$A3, (a3)
	move.b  #$B0, (a3)

	move.w  #$1E, d7
	move.w  #5, d6
	move.w  #5, d5

	@loc_1C8C:
		bsr.w   cdcSuspendExecution

		bsr.w   sub_1CF4
		bcs.s   @loc_1CB0

		move.w  #5, d5
		bsr.w   sub_1DF6
		bcs.s   @loc_1CB0

		btst    #1, cdcFlags1(a5)
		dbeq    d6, @loc_1C8C

@loc_1CAA:
	bsr.w   sub_1E6A
	bcc.s   @loc_1C66

@loc_1CB0:               ; CODE XREF: _cdcstart+1ACj
				; _cdcstart+1B6j
	btst    #7, cdcFlags1(a5)
	beq.w   @loc_1C32
	bra.s   @loc_1C66
; End of function _cdcstart


; =============== S U B R O U T I N E =======================================


resetCdc:               ; CODE XREF: initCdc+Cp _cdcstart+48p
	move.b #CDC_WRITE_RESET, (a2)
	move.b #0, (a3)

	move.b #CDC_WRITE_IFCTRL, (a2)
	move.b #$3A, (a3)

	move.b #CDC_WRITE_WAL,( a2)
	move.b #0, (a3)
	move.b #0, (a3)

	move.b #CDC_WRITE_PTL, (a2)
	move.b #0, (a3)
	move.b #0, (a3)
	rts
; End of function resetCdc


; =============== S U B R O U T I N E =======================================


sub_1CE6:               ; CODE XREF: _cdcstart+5Cp
					; _cdcstart:loc_1C66p
	move.b #CDC_WRITE_CTRL0, (a2)
	move.b #$A0, (a3)
	move.b #$F8, (a3)
	rts
; End of function sub_1CE6


; =============== S U B R O U T I N E =======================================


sub_1CF4:               ; CODE XREF: _cdcstart:loc_1B6Ep
					; _cdcstart+11Cp ...
	btst    #7, byte_5A43(a5)
	bne.s   @loc_1D1E

	btst    #5, cdcStat0(a5)
	beq.s   @loc_1D10

	subq.w  #1, d5
	bcc.s   @loc_1D14

	bset    #3, cdcFlags1(a5)
	bra.s   @loc_1D28
; ---------------------------------------------------------------------------

@loc_1D10:
	move.w  #5, d5

@loc_1D14:
	move.b  byte_5A41(a5), d0
	andi.b  #$F0, d0
	beq.s   @locret_1D32

@loc_1D1E:
	subq.w  #1, d7
	bcc.s   @loc_1D2E

	bset    #2, cdcFlags1(a5)

@loc_1D28:
	bset    #7, cdcFlags1(a5)

@loc_1D2E:
	m_setErrorFlag

@locret_1D32:
	rts
; End of function sub_1CF4


; =============== S U B R O U T I N E =======================================


sub_1D34:               ; CODE XREF: _cdcstart+F8p
	btst  #7, byte_5A43(a5)
	beq.s @locret_1D50

	subq.w #1, d7
	bcc.s  @loc_1D4C

	bset #2, cdcFlags1(a5)
	bset #7, cdcFlags1(a5)

@loc_1D4C:
	m_setErrorFlag

@locret_1D50:
	rts
; End of function sub_1D34


; =============== S U B R O U T I N E =======================================


sub_1D52:               ; CODE XREF: _cdcstart+8Cp
	move.l  cdcFrameHeader(a5), d0
	bsr.w   timecodeToFrames

	move.l  d0, dword_5A28(a5)
	move.l  dword_5A2C(a5), d1
	cmpi.l  #$FFFFFFFF, d1
	beq.s   @loc_1D84

	sub.l   d0, d1
	bls.s   @loc_1D8E

	cmpi.l  #4, d1
	bls.s   @returnSuccess

	cmpi.l  #75, d1
	bcc.s   @loc_1D9A

	move.w  #5, d6
	bra.s   @returnError
; ---------------------------------------------------------------------------

@loc_1D84:               ; CODE XREF: sub_1D52+16j
	addq.l  #4, d0
	move.l  d0, dword_5A30(a5)

@returnSuccess:               ; CODE XREF: sub_1D52+22j
	m_clearErrorFlag
	rts
; ---------------------------------------------------------------------------

@loc_1D8E:               ; CODE XREF: sub_1D52+1Aj
	subq.w  #1, d6
	bcc.s   @returnError

	bset    #5, cdcFlags1(a5)
	bra.s   @loc_1DA4
; ---------------------------------------------------------------------------

@loc_1D9A:               ; CODE XREF: sub_1D52+2Aj
	subq.w  #1, d6
	bcc.s   @returnError

	bset    #4, cdcFlags1(a5)

@loc_1DA4:               ; CODE XREF: sub_1D52+46j
	bset    #7, cdcFlags1(a5)

@returnError:               ; CODE XREF: sub_1D52+30j sub_1D52+3Ej ...
	m_setErrorFlag
	rts
; End of function sub_1D52


; =============== S U B R O U T I N E =======================================


sub_1DB0:               ; CODE XREF: _cdcstart+122p
					; _cdcstart+154p
	move.l  cdcFrameHeader(a5),d0
	bsr.w   timecodeToFrames

	move.l  d0,dword_5A28(a5)
	move.l  dword_5A30(a5),d1

	sub.l   d0,d1
	beq.s   @returnSuccess
	bcs.s   @loc_1DD4

	cmpi.l  #75,d1
	bcc.s   @loc_1DE0

	move.w  #5,d6
	bra.s   @returnError
; ---------------------------------------------------------------------------

@loc_1DD4:
	subq.w  #1,d6
	bcc.s   @returnError

	bset    #5,cdcFlags1(a5)
	bra.s   @loc_1DEA
; ---------------------------------------------------------------------------

@loc_1DE0:
	subq.w  #1,d6
	bcc.s   @returnError

	bset    #4,cdcFlags1(a5)

@loc_1DEA:
	bset    #7,cdcFlags1(a5)

@returnError:
	m_setErrorFlag

@returnSuccess:
	rts
; End of function sub_1DB0


; =============== S U B R O U T I N E =======================================


sub_1DF6:               ; CODE XREF: _cdcstart+160p
					; _cdcstart+1B2p
	move.b  cdcStat0(a5), d0
	andi.b  #$48, d0
	bne.s   @loc_1E2E

	move.b  cdcStat0(a5), d0
	andi.b  #3, d0
	bne.s   @loc_1E1A

	btst    #7, cdcStat0(a5)
	beq.s   @loc_1E1A

	move.w  #$1E, d7

@loc_1E16:
	m_clearErrorFlag
	rts
; ---------------------------------------------------------------------------

@loc_1E1A:
	bset    #1, cdcFlags1(a5)

	btst    #4, cdcFlags0(a5)
	bne.s   @loc_1E16

	subq.w  #1, d7
	bcc.s   @loc_1E3E
	bra.s   @loc_1E38
; ---------------------------------------------------------------------------

@loc_1E2E:
	subq.w  #1, d7
	bcc.s   @loc_1E3E

	bset    #2, cdcFlags1(a5)

@loc_1E38:
	bset    #7, cdcFlags1(a5)

@loc_1E3E:
	m_setErrorFlag
	rts
; End of function sub_1DF6


; =============== S U B R O U T I N E =======================================


sub_1E44:               ; CODE XREF: _cdcstart+FEp
					; _cdcstart+128p
	move.b cdcStat0(a5), d0

	andi.b #$48, d0
	bne.s  @loc_1E54

	move.w #$1E, d7
	rts
; ---------------------------------------------------------------------------

@loc_1E54:
	subq.w #1, d7
	bcc.s  @loc_1E64

	bset #2, cdcFlags1(a5)
	bset #7, cdcFlags1(a5)

@loc_1E64:
	m_setErrorFlag
	rts
; End of function sub_1E44


; =============== S U B R O U T I N E =======================================


sub_1E6A:               ; CODE XREF: _cdcstart+104p
					; _cdcstart+12Ep ...
	bsr.w   writeRingBuffer

	move.l  cdcFrameHeader(a5), (a1)+
	move.w  word_5A3E(a5), (a1)+
	move.b  byte_5A39(a5), (a1)+

	tst.w   d1
	bne.s   @loc_1E92

	move.b  cdcFlags1(a5), (a1)
	move.l  dword_5A30(a5), d0

	cmp.l   dword_5A34(a5), d0
	bcc.s   @locret_1EB4

	addq.l  #1,dword_5A30(a5)
	bra.s   @loc_1EB0
; ---------------------------------------------------------------------------

@loc_1E92:
	bset    #6, cdcFlags1(a5)
	move.b  cdcFlags0(a5), d0
	ori.b   #$E7, d0

	cmpi.b  #$FF, d0
	beq.s   @loc_1EAC

	bset    #7, cdcFlags1(a5)

@loc_1EAC:
	move.b  cdcFlags1(a5), (a1)

@loc_1EB0:
	m_setErrorFlag

@locret_1EB4:
	rts
; End of function sub_1E6A

; ---------------------------------------------------------------------------
dword_1EB6:        ; DATA XREF: _scdinit+22o
	dc.w $0018, $0060
	dc.w $00A8, $03C0
	dc.l $3D0

	dc.w $0018, $0018
	dc.w $0018, $0300
	dc.l $310

	dc.w $000C, $000C
	dc.w $000C, $0060
	dc.l $70

; =============== S U B R O U T I N E =======================================


_scdinit:               ; CODE XREF: executeCdbCommand+46j
	movem.l a2/a4/a6, -(sp)
	movea.l a0, a4

	; Disable SCD interrupt
	bclr #GA_IEN6, (GA_INT_MASK).w

	lea scdFlags0(a5), a0
	moveq #0, d0

	moveq #5, d1
	@loc_1EEE:
		move.l  d0, (a0)+
		dbf d1, @loc_1EEE

	bsr.w sub_23A6

	lea scdPcktBuffer(a5), a2
	lea dword_1EB6(pc), a6

	movea.l #'PCKT', a0
	bsr.s   sub_1F1E

	movea.l #'PACK', a0
	bsr.s   sub_1F1E

	movea.l #'QCOD', a0
	bsr.s   sub_1F1E

	movem.l (sp)+, a2/a4/a6
	rts
; End of function _scdinit


; =============== S U B R O U T I N E =======================================


sub_1F1E:
	move.l a4, (a2)+

	move.l (a6)+, d0
	move.l (a6)+, d1

	bsr.w  initRingBuffer

	adda.l (a6)+, a4
	rts
; End of function sub_1F1E


; =============== S U B R O U T I N E =======================================


_scdstop:               ; CODE XREF: _scdstart+Ap executeCdbCommand+4Ej
	clr.b scdFlags0(a5)
	bclr  #GA_IEN6, (GA_INT_MASK).w
	rts
; End of function _scdstop


; =============== S U B R O U T I N E =======================================


_scdstart:              ; CODE XREF: executeCdbCommand+4Aj
	movem.l a4, -(sp)
	m_saveStatusRegister
	m_maskInterrupts INT_SCD

	bsr.s   _scdstop

	move.w  #7, scdFlags0(a5)

	clr.l   $5A86(a5)
	clr.w   $5A8A(a5)

	; Store SCD mode
	lsl.w   #5, d1
	bset    #7, d1
	move.b  d1, scdFlags0(a5)

	move.b  #$80, d0
	move.b  d0, byte_5A8C(a5)
	move.b  d0, byte_5A8D(a5)

	clr.b   byte_5A8E(a5)
	move.b  #$FF, byte_5A8F(a5)

	; Clear ring buffers
	movea.l scdPcktBuffer(a5), a4
	move.w  RINGBUFFER.writePtr(a4), RINGBUFFER.readPtr(a4)

	movea.l scdPackBuffer(a5), a4
	move.w  RINGBUFFER.writePtr(a4), RINGBUFFER.readPtr(a4)

	movea.l scdQcodBuffer(a5), a4
	move.w  RINGBUFFER.writePtr(a4), RINGBUFFER.readPtr(a4)

	; Enable SCD interrupt
	bset #GA_IEN6, (GA_INT_MASK).w

	m_restoreStatusRegister
	movem.l (sp)+, a4
	rts
; End of function _scdstart


; =============== S U B R O U T I N E =======================================


_scdstat:               ; CODE XREF: executeCdbCommand+52j
	move.l dword_5A86(a5), d1

	move.w word_5A8A(a5), d0
	swap   d0
	move.w scdFlags0(a5), d0

	rts
; End of function _scdstat


; =============== S U B R O U T I N E =======================================


_scdpql:                ; CODE XREF: executeCdbCommand+5Ej
	bset    #2, scdFlags0(a5)

_scdpq:                 ; CODE XREF: executeCdbCommand+5Aj
	movem.l a4, -(sp)
	m_saveStatusRegister
	m_maskInterrupts INT_SCD

	movea.l scdQcodBuffer(a5), a4

	; Return error if buffer is empty
	move.w  RINGBUFFER.writePtr(a4), d0
	cmp.w   RINGBUFFER.readPtr(a4), d0
	beq.s   @loc_1FEC

	movea.l a0, a1

@loc_1FCE:
	bsr.w   readRingBuffer
	beq.s   @loc_1FDC

	btst    #2, scdFlags0(a5)
	bne.s   @loc_1FCE

@loc_1FDC:
	move.l  (a0)+, (a1)+
	move.l  (a0)+, (a1)+
	move.l  (a0)+, (a1)+

	lea -$C(a1), a0

	andi.w #$FFFE, (sp)
	bra.s  @loc_1FF0
; ---------------------------------------------------------------------------

@loc_1FEC:
	ori.w #1, (sp)

@loc_1FF0:
	m_restoreStatusRegister
	movem.l (sp)+, a4

	bclr #2, scdFlags0(a5)
	rts
; End of function _scdpql


; =============== S U B R O U T I N E =======================================


_scdread:               ; CODE XREF: executeCdbCommand+56j
	movem.l a4, -(sp)
	m_saveStatusRegister
	m_maskInterrupts INT_CDD

	movea.l scdPackBuffer(a5), a4

	; Return error if buffer is empty
	move.w RINGBUFFER.writePtr(a4), d0
	cmp.w RINGBUFFER.readPtr(a4), d0
	beq.s @loc_2032

	movea.l a0, a1

	bsr.w readRingBuffer

	move.l (a0)+, (a1)+
	move.l (a0)+, (a1)+
	move.l (a0)+, (a1)+
	move.l (a0)+, (a1)+
	move.l (a0)+, (a1)+
	move.l (a0)+, (a1)+

	lea -24(a1), a0

	andi.w  #$FFFE, (sp)
	bra.s   @loc_2036
; ---------------------------------------------------------------------------

@loc_2032:
	ori.w #1, (sp)

@loc_2036:
	m_restoreStatusRegister
	movem.l (sp)+, a4
	rts
; End of function _scdread


; =============== S U B R O U T I N E =======================================


sub_203E:               ; CODE XREF: BIOS:00000658p
	movem.l a2-a4, -(sp)

	; Return if bit 7 is cleared
	btst    #7, scdFlags0(a5)
	beq.w   @loc_2102

	clr.w   d0
	move.b  (GA_SUBCODE_ADDRESS).w, d0
	btst    #7, d0
	bne.w   @loc_2108
	bra.s   @loc_205E
; ---------------------------------------------------------------------------
	bra.s   @loc_20B4
; ---------------------------------------------------------------------------

@loc_205E:               ; CODE XREF: sub_203E+1Cj
	move.b  d0, d1

	cmp.b   byte_5A8D(a5), d1
	beq.s   @loc_209A

	sub.b   byte_5A8C(a5), d1
	andi.b  #$7F, d1
	cmpi.b  #$62, d1
	bcc.s   @loc_209A

	btst    #3, scdFlags0(a5)
	beq.s   @loc_2086

	add.b   byte_5A8E(a5), d1
	cmpi.b  #$62, d1
	beq.s   @loc_209A

@loc_2086:
	move.b  d0, byte_5A8C(a5)
	move.b  d1, byte_5A8E(a5)
	bset    #3, scdFlags0(a5)
	addq.b  #1, byte_5A8F(a5)
	bra.s   @loc_2102
; ---------------------------------------------------------------------------

@loc_209A:
	bclr    #3, scdFlags0(a5)
	move.b  d0, byte_5A8C(a5)
	clr.b   byte_5A8E(a5)
	addi.b  #$62, d1
	andi.b  #$7F, d1
	move.b  d1, byte_5A8D(a5)

@loc_20B4:
	lea (GA_SUBCODE_BUFFER).w, a0
	lea (a0, d0.w), a0

	movea.l scdPcktBuffer(a5), a4

	bsr.w   writeRingBuffer
	add.b   d1, byte_5A87(a5)

	move.w #2, d1
	@loc_20CC:
		move.l (a0)+, (a1)+
		move.l (a0)+, (a1)+
		move.l (a0)+, (a1)+
		move.l (a0)+, (a1)+
		move.l (a0)+, (a1)+
		move.l (a0)+, (a1)+
		move.l (a0)+, (a1)+
		move.l (a0)+, (a1)+
		dbf d1, @loc_20CC

	lea -96(a1), a0

	btst    #6, scdFlags0(a5)
	beq.s   @loc_2102

	movea.l scdQcodBuffer(a5), a4
	bsr.w   writeRingBuffer

	add.b   d1, dword_5A88(a5)
	bsr.w   sub_210E

	beq.s   @loc_2102

	addq.b  #1, word_5A8A(a5)

@loc_2102:
	movem.l (sp)+, a2-a4
	rts
; ---------------------------------------------------------------------------

@loc_2108:
	addq.b  #1, dword_5A86(a5)
	bra.s   @loc_2102
; End of function sub_203E


; =============== S U B R O U T I N E =======================================


sub_210E:               ; CODE XREF: sub_203E+BAp
	movea.l a0, a2

	bsr.s   sub_2168
	bsr.w   sub_860

	m_saveStatusRegister

	move.b  $18(a2), d0
	or.b    $30(a2), d0
	and.b   $48(a2), d0
	btst    #7, d0
	sne d0

	move.b  0(a1), d1
	andi.b  #$F, d1
	cmpi.b  #1, d1
	beq.s   @loc_2146

	cmpi.b  #2, d1
	beq.s   @loc_2146

	cmpi.b  #3, d1
	beq.s   @loc_2146
	bra.s   @loc_2164
; ---------------------------------------------------------------------------

@loc_2146:
	move.b  d0, 6(a1)
	bra.s   @loc_2164
; ---------------------------------------------------------------------------
	move.b  d0, 8(a1)
	bra.s   @loc_2164
; ---------------------------------------------------------------------------
	move.b  8(a1), d1
	andi.b  #$F0, d1
	andi.b  #$F, d0
	or.b    d1, d0
	move.b  d0, 8(a1)

@loc_2164:
	m_restoreConditionBits
	rts
; End of function sub_210E


; =============== S U B R O U T I N E =======================================


sub_2168:               ; CODE XREF: sub_210E+2p
	movem.l a0-a1/a6, -(sp)

	lea @loc_2172(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_2172:
	lea @loc_2178(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_2178:
	move.w  d1, (a1)+
	lea @loc_2180(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_2180:
	lea @loc_2186(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_2186:
	move.w  d1, (a1)+
	lea @loc_218E(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_218E:
	lea @loc_2194(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_2194:
	move.w  d1, (a1)+
	lea @loc_219C(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_219C:
	lea @loc_21A2(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_21A2:
	move.w  d1, (a1)+
	lea @loc_21AA(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_21AA:
	lea @loc_21B0(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_21B0:
	move.w  d1, (a1)+
	lea @loc_21B8(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_21B8:
	lea @loc_21BE(pc), a6
	bra.s   @loc_21C6
; ---------------------------------------------------------------------------

@loc_21BE:
	move.w  d1, (a1)+
	movem.l (sp)+, a0-a1/a6
	rts
; ---------------------------------------------------------------------------

@loc_21C6:
	move.b  (a0)+, d0
	lsl.b   #2, d0
	roxl.w  #1, d1

	move.b  (a0)+, d0
	lsl.b   #2, d0
	roxl.w  #1, d1

	move.b  (a0)+, d0
	lsl.b   #2, d0
	roxl.w  #1, d1

	move.b  (a0)+, d0
	lsl.b   #2, d0
	roxl.w  #1, d1

	move.b  (a0)+, d0
	lsl.b   #2, d0
	roxl.w  #1, d1

	move.b  (a0)+, d0
	lsl.b   #2, d0
	roxl.w  #1, d1

	move.b  (a0)+, d0
	lsl.b   #2, d0
	roxl.w  #1, d1

	move.b  (a0)+, d0
	lsl.b   #2, d0
	roxl.w  #1, d1

	jmp (a6)
; End of function sub_2168


; =============== S U B R O U T I N E =======================================


updateSubcode:               ; CODE XREF: BIOS:0000061Ep
	; Return if update flag already set
	bset  #1, scdFlags0(a5)
	bne.w @locret_2288

	; Return if bit 5 is cleared
	btst  #5, scdFlags0(a5)
	beq.s @loc_2282

	movem.l a3-a4, -(sp)
	movea.l scdPackBuffer(a5), a3
	movea.l scdPcktBuffer(a5), a4

	; Return if buffer is empty
	move.w RINGBUFFER.writePtr(a4), d0
	cmp.w  RINGBUFFER.readPtr(a4), d0
	beq.s  @loc_227E

	m_saveStatusRegister
	m_maskInterrupts INT_TIMER

@loc_2226:
	tst.b  scdFlags0+1(a5)
	beq.s  @loc_2242

	subq.b #1, scdFlags0+1(a5)

	m_saveStatusRegister
	m_maskInterrupts INT_SCD

	bsr.w readRingBuffer
	seq 1(sp)

	m_restoreStatusRegister
	bra.s @loc_227A
; ---------------------------------------------------------------------------

@loc_2242:
	exg   a3, a4
	bsr.w writeRingBuffer
	add.b d1, dword_5A88+1(a5)
	exg   a3, a4

	m_saveStatusRegister
	m_maskInterrupts INT_SCD

	bsr.w sub_22BC
	bsr.w readRingBuffer
	seq 1(sp)

	m_restoreStatusRegister
	seq 1(sp)

	bsr.w sub_23B8
	bcc.s @loc_2278

	addq.b #1, dword_5A88+3(a5)

	exg   a3, a4
	bsr.w rewindRingBuffer
	exg   a3, a4

@loc_2278:
	move (sp), ccr

@loc_227A:
	bne.s @loc_2226
	m_restoreStatusRegister

@loc_227E:
	movem.l (sp)+, a3-a4

@loc_2282:
	bclr #1, scdFlags0(a5)

@locret_2288:
	rts
; End of function updateSubcode

; ---------------------------------------------------------------------------
word_228A:      ; DATA XREF: sub_22BCo
	dc.w $FF58
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
	lea word_228A(pc), a0

	bra.s @loc_22DC
; ---------------------------------------------------------------------------

@loc_22C2:               ; CODE XREF: sub_22BC+22j
	bmi.s @loc_22C8
	sub.w RINGBUFFER.bufferSize(a4), d0

@loc_22C8:               ; CODE XREF: sub_22BC:loc_22C2j
	add.w RINGBUFFER.readPtr(a4), d0
	bpl.s @loc_22D2

	add.w RINGBUFFER.bufferSize(a4), d0

@loc_22D2:               ; CODE XREF: sub_22BC+10j
	move.b RINGBUFFER.structSize(a4, d0.w), d0
	andi.w #$3F, d0
	move.b d0, (a1)+

@loc_22DC:               ; CODE XREF: sub_22BC+4j
	move.w (a0)+, d0
	bne.s  @loc_22C2

	lea -24(a1), a1

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
	lea dword_5A9C(a5), a0
	moveq #0, d0

	; Clear RAM from $5A9C-$5AB6
	moveq #5, d1
	@loc_23AE:
		move.l  d0, (a0)+
		dbf d1, @loc_23AE

	move.w  d0, (a0)

	rts
; End of function sub_23A6


; =============== S U B R O U T I N E =======================================


sub_23B8:               ; CODE XREF: updateSubcode+6Ep
	movem.l d2-d6/a0-a4/a6, -(sp)
	movea.l a1, a2

	bsr.w sub_24D4

	lea unk_2326(pc),   a3
	lea unk_22E6(pc),   a4
	lea dword_5A9C(a5), a0

	move.b (a0)+, d0
	or.b   (a0)+, d0
	or.b   (a0)+, d0
	or.b   (a0),  d0
	beq.s  @loc_23F4

	bsr.w sub_254C

	lea dword_5AA0+2(a5), a0

	move.b (a0)+, d0
	or.b   (a0)+, d0
	or.b   (a0),  d0
	bne.s  @loc_23F0

	bsr.w sub_25A8

	bra.w @loc_23F4
; ---------------------------------------------------------------------------

@loc_23F0:
	bsr.w sub_262E

@loc_23F4:
	nop
	nop

	m_saveStatusRegister
	bsr.w sub_251E

	tst.w dword_5AA0(a5)
	beq.s @loc_240C

	bsr.w sub_25BC
	move  sr, d0
	or.w  d0, (sp)

@loc_240C:
	m_restoreConditionBits
	movem.l (sp)+, d2-d6/a0-a4/a6
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
	dc.b $22
	dc.b $24
	dc.b $26
	dc.b $28
	dc.b $2A
	dc.b $2C
	dc.b $2E
	dc.b $30
	dc.b $32
	dc.b $34
	dc.b $36
	dc.b $38
	dc.b $3A
	dc.b $3C
	dc.b $3E
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
	dc.b $23
	dc.b $21
	dc.b $27
	dc.b $25
	dc.b $2B
	dc.b $29
	dc.b $2F
	dc.b $2D
	dc.b $33
	dc.b $31
	dc.b $37
	dc.b $35
	dc.b $3B
	dc.b $39
	dc.b $3F
	dc.b $3D

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
	dc.b $24
	dc.b $28
	dc.b $2C
	dc.b $30
	dc.b $34
	dc.b $38
	dc.b $3C
	dc.b   3
	dc.b   7
	dc.b  $B
	dc.b  $F
	dc.b $13
	dc.b $17
	dc.b $1B
	dc.b $1F
	dc.b $23
	dc.b $27
	dc.b $2B
	dc.b $2F
	dc.b $33
	dc.b $37
	dc.b $3B
	dc.b $3F
	dc.b   6
	dc.b   2
	dc.b  $E
	dc.b  $A
	dc.b $16
	dc.b $12
	dc.b $1E
	dc.b $1A
	dc.b $26
	dc.b $22
	dc.b $2E
	dc.b $2A
	dc.b $36
	dc.b $32
	dc.b $3E
	dc.b $3A
	dc.b   5
	dc.b   1
	dc.b  $D
	dc.b   9
	dc.b $15
	dc.b $11
	dc.b $1D
	dc.b $19
	dc.b $25
	dc.b $21
	dc.b $2D
	dc.b $29
	dc.b $35
	dc.b $31
	dc.b $3D
	dc.b $39
	dc.b   0
	dc.b   8
	dc.b $10
	dc.b $18
	dc.b $20
	dc.b $28
	dc.b $30
	dc.b $38
	dc.b   3
	dc.b  $B
	dc.b $13
	dc.b $1B
	dc.b $23
	dc.b $2B
	dc.b $33
	dc.b $3B
	dc.b   6
	dc.b  $E
	dc.b $16
	dc.b $1E
	dc.b $26
	dc.b $2E
	dc.b $36
	dc.b $3E
	dc.b   5
	dc.b  $D
	dc.b $15
	dc.b $1D
	dc.b $25
	dc.b $2D
	dc.b $35
	dc.b $3D
	dc.b  $C
	dc.b   4
	dc.b $1C
	dc.b $14
	dc.b $2C
	dc.b $24
	dc.b $3C
	dc.b $34
	dc.b  $F
	dc.b   7
	dc.b $1F
	dc.b $17
	dc.b $2F
	dc.b $27
	dc.b $3F
	dc.b $37
	dc.b  $A
	dc.b   2
	dc.b $1A
	dc.b $12
	dc.b $2A
	dc.b $22
	dc.b $3A
	dc.b $32
	dc.b   9
	dc.b   1
	dc.b $19
	dc.b $11
	dc.b $29
	dc.b $21
	dc.b $39
	dc.b $31

; =============== S U B R O U T I N E =======================================


sub_24D4:               ; CODE XREF: sub_23B8+6p
	move.l  a2, -(sp)

	lea unk_2454(pc), a6
	lea dword_5A9C(a5), a0
	lea 1(a0), a1
	lea 2(a0), a3
	lea 3(a0), a4

	move.b (a2)+, d0

	move.b d0, (a0)
	move.b d0, (a1)
	move.b d0, (a3)
	move.b d0, (a4)

	clr.w  d0

	move.w #22,d1
	@loc_24FA:
		move.b (a1), d0
		move.b -64(a6, d0.w), (a1)
		move.b (a3), d0
		move.b (a6, d0.w), (a3)
		move.b (a4), d0
		move.b 64(a6, d0.w), (a4)
		move.b (a2)+, d0
		eor.b  d0, (a0)
		eor.b  d0, (a1)
		eor.b  d0, (a3)
		eor.b  d0, (a4)
		dbf    d1, @loc_24FA

	movea.l (sp)+, a2
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
	@loc_2538:
		move.b  (a1),d0
		move.b  (a3,d0.w),(a1)
		move.b  (a2)+,d0
		eor.b   d0,(a0)
		eor.b   d0,(a1)
		dbf d1,@loc_2538

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
	@loc_2590:
		move.b  (a0)+,d0
		add.b   (a0)+,d0
		move.b  (a3,d0.w),d1
		move.b  (a0)+,d0
		add.b   (a0)+,d0
		move.b  (a3,d0.w),(a1)
		eor.b   d1,(a1)+
		dbf d2,@loc_2590

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
	bcc.s   @loc_25DE
	addi.w  #$3F,d1

@loc_25DE:
	sub.w   d1,d2
	bcs.s   @loc_25E8
	eor.b   d3,(a2,d2.w)
	rts
; ---------------------------------------------------------------------------

@loc_25E8:
	m_setErrorFlag
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
	bcc.s   @loc_2654

	addi.w  #$3F,d1

@loc_2654:               ; CODE XREF: sub_262E+20j
	move.b  d1,d6
	move.b  (a3,d1.w),d5
	move.b  d4,d1
	move.b  d3,d0
	sub.w   d0,d1
	bcc.s   @loc_2666

	addi.w  #$3F,d1

@loc_2666:               ; CODE XREF: sub_262E+32j
	move.b  d2,d0
	add.w   d0,d1
	cmpi.w  #$3F,d1
	bcs.s   @loc_2674

	subi.w  #$3F,d1

@loc_2674:               ; CODE XREF: sub_262E+40j
	move.b  d3,d0
	sub.w   d0,d1
	bcc.s   @loc_267E

	addi.w  #$3F,d1

@loc_267E:               ; CODE XREF: sub_262E+4Aj
	lea unk_25EE(pc),a0
	move.b  (a0),d1
	move.b  d6,d0
	add.w   d0,d1
	cmpi.w  #$3F,d1
	bcs.s   @loc_2692

	subi.w  #$3F,d1

@loc_2692:               ; CODE XREF: sub_262E+5Ej
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
	bcc.s   @loc_26C8

	addi.w  #$3F,d1

@loc_26C8:               ; CODE XREF: sub_262E+94j
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
	sub.w d1, d2
	bcs.s loc_272E

	eor.b d3, (a2, d2.w)
	rts
; ---------------------------------------------------------------------------

loc_272E:               ; CODE XREF: sub_262E+CEj sub_2724+2j
	m_setErrorFlag
	rts
; End of function sub_2724


; =============== S U B R O U T I N E =======================================


_wonderreq:
	or.w d1, d1
	rts
; End of function _wonderreq


; =============== S U B R O U T I N E =======================================


_wonderchk:
	move.w #0, d0
	rts
; End of function _wonderchk

; =============== S U B M O D U L E =========================================
	include "submodules\volume.asm"

; ---------------------------------------------------------------------------
word_2924:          ; DATA XREF: installJumpTable+62o
	dc.w (_cdbios - word_2924)
	dc.w 0

; =============== S U B R O U T I N E =======================================


_cdbios:
	movem.l a5, -(sp)
	movea.l #0, a5

	bclr #7, d0

	; CDBIOS commands < $80
	beq.s @loc_293C

	; CDBIOS commands >= $80
	bsr.s executeCdbCommand
	bra.s @loc_2940
; ---------------------------------------------------------------------------

@loc_293C:              ; CODE XREF: _cdbios+Ej
	bsr.w   queueCdbCommand

@loc_2940:              ; CODE XREF: _cdbios+12j
	movem.l (sp)+, a5
	rts
; End of function _cdbios


; =============== S U B R O U T I N E =======================================


executeCdbCommand:               ; CODE XREF: _cdbios+10p
	add.w d0, d0
	add.w d0, d0

	cmpi.w #$64, d0
	bcc.s  @locret_29B8     ; Return if invalid command

	jmp @cdbJumpTable(pc, d0.w)
; ---------------------------------------------------------------------------

@cdbJumpTable:
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

@locret_29B8:                ; CODE XREF: executeCdbCommand+8j
	rts
; ---------------------------------------------------------------------------

_cdbchk:
	btst  #7, cdbCommand(a5)
	sne   d0
	lsr.b #1, d0
	rts
; ---------------------------------------------------------------------------

_cdbstat:               ; CODE XREF: executeCdbCommand+12j
	lea (_CDSTAT).w, a0
	movem.l a0, -(sp)

	move.w cdbControlStatus(a5), (a0)+

	move.b ledStatus(a5), d0
	lsl.w  #8, d0
	move.b ledMode+1(a5), d0
	move.w d0, (a0)+

	bsr.w  writeCddStatus
	bcc.s  @loc_29E8

	adda.w #20, a0

@loc_29E8:
	move.l masterVolume(a5), d0
	move.l d0, (a0)+

	bsr.w  getCdcFrameHeader
	move.l d0, (a0)

	movem.l (sp)+, a0
	rts
; ---------------------------------------------------------------------------

loc_29FA:               ; CODE XREF: _cdbtocwrite+6j
	bsr.w writeTocForTrack
; End of function executeCdbCommand


; =============== S U B R O U T I N E =======================================


_cdbtocwrite:
	cmpi.l #$FFFFFFFF, (a0)
	bne.s  loc_29FA
	rts
; End of function _cdbtocwrite


; =============== S U B R O U T I N E =======================================


_cdbtocread:
	move.w d1, d0
	bsr.w  getTocForTrack
	rts
; End of function _cdbtocread


; =============== S U B R O U T I N E =======================================


_ledset:
	move.w d1, userLedMode(a5)
	rts
; End of function _ledset


; =============== S U B R O U T I N E =======================================


_cdbpause:
	move.w d1, cdbSpindownDelay(a5)
	rts
; End of function _cdbpause


; =============== S U B R O U T I N E =======================================


queueCdbCommand:               ; CODE XREF: _cdbios:loc_293Cp
	; Determine number of arguments
	ror.w #4, d0

	; 0 args
	tst.b d0
	beq.s @loc_2A34

	; 1 arg
	cmpi.b #1, d0
	beq.s  @loc_2A2E

	; 2 args
	lea   @loc_2A3C(pc), a1
	bra.s @loc_2A38
; ---------------------------------------------------------------------------

@loc_2A2E:
	lea   @loc_2A48(pc), a1
	bra.s @loc_2A38
; ---------------------------------------------------------------------------

@loc_2A34:
	lea @loc_2A52(pc), a1

@loc_2A38:
	rol.w #4, d0
	jmp (a1)
; ---------------------------------------------------------------------------

@loc_2A3C:
	lea cdbCommand(a5), a1
	move.w  d0,   (a1)+
	move.l (a0)+, (a1)+
	move.l (a0)+, (a1)+
	bra.s  @loc_2A58
; ---------------------------------------------------------------------------

@loc_2A48:
	lea cdbCommand(a5), a1
	move.w  d0,   (a1)+
	move.l (a0)+, (a1)+
	bra.s  @loc_2A58
; ---------------------------------------------------------------------------

@loc_2A52:
	lea cdbCommand(a5), a1
	move.w d0, (a1)+

@loc_2A58:
	; Set command-pending flag
	bset #7, cdbCommand(a5)
	rts
; End of function queueCdbCommand


; =============== S U B R O U T I N E =======================================


cdbSuspendExecution:               ; CODE XREF: initCdb:loc_2A96p
					; initCdb+26p ...
	move.l  (sp)+, cdbResumeAddress(a5)
	rts
; End of function cdbSuspendExecution


; =============== S U B R O U T I N E =======================================


cdbResume:               ; CODE XREF: BIOS:00000622p
	tst.w  word_5B22(a5)
	beq.s  @loc_2A70
	subq.w #1, word_5B22(a5)

@loc_2A70:
	movea.l cdbResumeAddress(a5), a0
	jmp (a0)
; End of function cdbResume


; =============== S U B R O U T I N E =======================================


copyCdbCommand:             ; CODE XREF: initCdb+4Ap
					; BIOS:000031A2p ...
	move.w (a0)+, (a1)+
	move.l (a0)+, (a1)+
	move.l (a0)+, (a1)+
	rts
; End of function copyCdbCommand


; =============== S U B R O U T I N E =======================================


initCdb:               ; CODE XREF: BIOS:0000035Ap
	move.w #$8000, cdbControlStatus(a5)     ; Not ready
	move.w #4500,  cdbSpindownDelay(a5)
	move.w #$101,  cdbArg1Cache(a5)
	move.w #$2C,   cdbCommandCache(a5)

	; Wait for CDD to properly initialize
	@loc_2A96:
		bsr.s  cdbSuspendExecution

		move.b byte_5A04(a5), d0
		beq.s  @loc_2A96

		cmpi.b #$FF, d0
		beq.s  @loc_2A96

	bsr.s cdbSuspendExecution

	; Set volume to max
	move.w #$400, d1
	bsr.w  _fdrset

	cmpi.w #$800A, cdbCommand(a5)
	bne.s  loc_2ACA

cdbPrepareCommand:      ; CODE XREF: BIOS:00002C38j
				; BIOS:00002C54j ...
	bsr.s cdbSuspendExecution

	bclr  #7, cdbCommand(a5)
	beq.s loc_2AD0

	lea   cdbCommand(a5), a0
	lea   cdbCommandCache(a5), a1
	bsr.s copyCdbCommand

loc_2ACA:               ; CODE XREF: initCdb+36j
				; BIOS:00002C2Aj ...
	bset #7, cdbControlStatus(a5)           ; Not ready

loc_2AD0:               ; CODE XREF: initCdb+40j
				; BIOS:loc_2D66j ...
	move.w cdbCommandCache(a5), d0
	add.w  d0, d0
	add.w  d0, d0
	cmpi.w #$B4, d0
	bcc.w  loc_2C78

	jmp @loc_2AE4(pc, d0.w)
; End of function initCdb

; ---------------------------------------------------------------------------

@loc_2AE4:
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
	bra.w   @locret_2B98
; ---------------------------------------------------------------------------
	bra.w   @locret_2B98
; ---------------------------------------------------------------------------
	bra.w   @locret_2B98
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
	bra.w   @locret_2B98
; ---------------------------------------------------------------------------
	bra.w   @locret_2B98
; ---------------------------------------------------------------------------
	bra.w   @locret_2B98
; ---------------------------------------------------------------------------
	bra.w   @locret_2B98
; ---------------------------------------------------------------------------
	bra.w   @locret_2B98
; ---------------------------------------------------------------------------
	bra.w   @locret_2B98
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

@locret_2B98:
	rts

; =============== S U B R O U T I N E =======================================


sub_2B9A:               ; CODE XREF: BIOS:00002CDAp
					; BIOS:00002F56p
	move.w #$B, word_5B1E(a5)
	bra.s  loc_2BA8
; ---------------------------------------------------------------------------

sub_2BA2:               ; CODE XREF: BIOS:000035D4p
					; BIOS:loc_35DCp ...
	move.w #5, word_5B1E(a5)

loc_2BA8:
	move.l (sp)+, cdbDelayedRoutine(a5)

	@loc_2BAC:
		bsr.w cdbSuspendExecution

		subq.w #1, word_5B1E(a5)
		bcc.s  @loc_2BAC

	movea.l cdbDelayedRoutine(a5), a0
	jmp (a0)
; End of function sub_2B9A


; =============== S U B R O U T I N E =======================================


sub_2BBC:               ; CODE XREF: BIOS:000030D2p
					; BIOS:00003154p ...
	move.l (sp)+, cdbDelayedRoutine(a5)
	bra.s  @loc_2BC6
; ---------------------------------------------------------------------------

	@loc_2BC2:
		bsr.w cdbSuspendExecution

	@loc_2BC6:
		move.w #$20, d0
		move.w word_5B0A(a5), d1
		cmpi.w #$FFFF, d1
		bne.s  @loc_2BD8

		move.w #$8000, d0

	@loc_2BD8:
		swap  d1

		bsr.w sub_B0C
		bcs.s @loc_2BC2

	movea.l cdbDelayedRoutine(a5), a0
	jmp (a0)
; End of function sub_2BBC


; =============== S U B R O U T I N E =======================================


sub_2BE6:               ; CODE XREF: BIOS:loc_2C48p
	move.w #$80C0, d0
	bsr.w  sub_B0C
	rts
; End of function sub_2BE6

; ---------------------------------------------------------------------------

loc_2BF0:               ; CODE XREF: BIOS:00002B94j
	move.w  #LEDREADY, ledMode(a5)
	bsr.w   _cdcstop

	move.w  #1, word_5B00(a5)
	move.l  #$20000, dword_5B02(a5)
	bsr.w   cdbSuspendExecution

	bsr.w   cddGetStatusCodeByte

	cmpi.b  #$E, d0
	beq.w   loc_2C24

	cmpi.b  #5, d0
	beq.w   loc_2C24
	bra.w   loc_2C98
; ---------------------------------------------------------------------------

loc_2C24:               ; CODE XREF: BIOS:00002C14j
					; BIOS:00002C1Cj
	move.w  #1, cdbCommandCache(a5)
	bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_2C2E:               ; CODE XREF: BIOS:00002C44j
					; BIOS:00002C6Aj
	bsr.w   cdbSuspendExecution

	btst    #7, cdbCommand(a5)
	bne.w   cdbPrepareCommand

	bsr.w   cddGetStatusCodeByte

	cmpi.b  #$E, d0
	beq.s   loc_2C2E
	bra.s   loc_2C90
; ---------------------------------------------------------------------------

loc_2C48:               ; CODE XREF: BIOS:loc_2CB4j
	bsr.s   sub_2BE6

loc_2C4A:               ; CODE XREF: BIOS:00002C66j
	bsr.w   cdbSuspendExecution

	cmpi.w  #$8010, cdbCommand(a5)
	beq.w   cdbPrepareCommand

	cmpi.w  #$800A, cdbCommand(a5)
	beq.w   cdbPrepareCommand

	bsr.w   sub_AF6
	bcs.s   loc_2C4A

	tst.b   d0
	bne.s   loc_2C2E

	bsr.w   cddGetStatusCodeByte

	cmpi.b  #0,d0
	bne.w   loc_2D5A

loc_2C78:               ; CODE XREF: initCdb+5Ej
					; BIOS:00002B24j
		move.w  #LEDREADY, ledMode(a5)
		bsr.w   _cdcstop

		move.w  #1, word_5B00(a5)
		move.l  #$20000, dword_5B02(a5)

loc_2C90:               ; CODE XREF: BIOS:00002C46j
					; BIOS:00002CD8j
		bsr.w   cdbSuspendExecution

		bsr.w   cddGetStatusCodeByte

loc_2C98:               ; CODE XREF: BIOS:00002C20j
		cmpi.b  #0, d0
		beq.s   loc_2CDE

		cmpi.b  #1, d0
		beq.s   loc_2CDE

		cmpi.b  #4, d0
		beq.s   loc_2CDE

		cmpi.b  #$C, d0
		beq.s   loc_2CDE

		cmpi.b  #5, d0

loc_2CB4:               ; CODE XREF: BIOS:00002CC2j
		beq.s   loc_2C48

		cmpi.b  #$B, d0
		beq.w   loc_2D5A

		cmpi.b  #$E, d0
		beq.s   loc_2CB4

		move.w  #$8010, d0
		bsr.w   sub_B0C

loc_2CCC:               ; CODE XREF: BIOS:00002CD4j
		bsr.w   cdbSuspendExecution
		bsr.w   sub_AF6
		bcs.s   loc_2CCC

		tst.b   d0
		bne.s   loc_2C90

		bsr.w   sub_2B9A

loc_2CDE:               ; CODE XREF: BIOS:00002C9Cj
					; BIOS:00002CA2j ...
		move.w  #$2000, cdbControlStatus(a5)
		move.w  #5, d1
		swap    d1
		move.w  cdbArg1Cache(a5), d1
		move.w  #$8020, d0
		bsr.w   sub_B0C

loc_2CF6:               ; CODE XREF: BIOS:00002D0Ej
		bsr.w   cdbSuspendExecution

		cmpi.w  #$800A, cdbCommand(a5)
		beq.s   loc_2D6A

		cmpi.w  #$8010, cdbCommand(a5)
		beq.s   loc_2D6A

		bsr.w   sub_AF6
		bcs.s   loc_2CF6

		tst.b   d0
		bne.w   loc_2D5A

		move.w  #$22, d0
		btst    #7, cdbArg1Cache(a5)
		beq.s   loc_2D26

		move.w  #$23, d0

loc_2D26:               ; CODE XREF: BIOS:00002D20j
		move.w  d0, cdbCommandCache(a5)
		clr.w   word_5AEA(a5)
		clr.w   word_5AF4(a5)
		clr.w   word_5B0A(a5)
		bsr.w   getFirstTrack

		andi.w  #$FF, d0
		move.w  d0,word_5B16(a5)
		move.w  d0,word_5B00(a5)
		bsr.w   getTocForTrack

		move.l  d0, dword_5B02(a5)
		clr.b   byte_5B13(a5)
		move.b  #3, byte_5B12(a5)
		bra.s   loc_2D66
; ---------------------------------------------------------------------------

loc_2D5A:               ; CODE XREF: BIOS:00002C74j
					; BIOS:00002CBAj ...
	move.w  #$1000, cdbControlStatus(a5)
	move.w  #0, cdbCommandCache(a5)

loc_2D66:               ; CODE XREF: BIOS:00002D58j
	bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_2D6A:               ; CODE XREF: BIOS:00002D00j
					; BIOS:00002D08j
	bra.w   cdbPrepareCommand
; ---------------------------------------------------------------------------

loc_2D6E:               ; CODE XREF: BIOS:00002B6Cj
	bsr.w   cddGetStatusCodeByte
	cmpi.b  #4, d0
	beq.s   loc_2D7C
	bra.w   loc_2DCC
; ---------------------------------------------------------------------------

loc_2D7C:               ; CODE XREF: BIOS:00002D76j
	bset   #7, byte_5B18(a5)
	clr.w  word_5B0E(a5)
	move.w #$28, cdbCommandCache(a5)
	move.w #$0500, cdbControlStatus(a5)     ; Paused
	move.w #LEDDISCIN, ledMode(a5)
	bra.w  loc_2DBC
; ---------------------------------------------------------------------------

loc_2D9C:               ; CODE XREF: BIOS:00002B70j
	bsr.w   cddGetStatusCodeByte

	cmpi.b  #1, d0
	beq.s   loc_2DAA
	bra.w   loc_2DCC
; ---------------------------------------------------------------------------

loc_2DAA:               ; CODE XREF: BIOS:00002DA4j
	move.w #$25, cdbCommandCache(a5)
	move.w #$0100, cdbControlStatus(a5)     ; Playing music/data
	move.w #LEDACCESS, ledMode(a5)

loc_2DBC:               ; CODE XREF: BIOS:00002D98j
	move.w  word_5B16(a5), word_5B00(a5)
	move.w  #$25, word_5AEA(a5)
	bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_2DCC:               ; CODE XREF: BIOS:00002D78j
					; BIOS:00002DA6j
	cmpi.b  #5, d0
	beq.s   loc_2DE2

	cmpi.b  #$B, d0
	beq.s   loc_2DE2

	cmpi.b  #$E, d0
	beq.s   loc_2DE2
	bra.w   cdbPrepareCommand
; ---------------------------------------------------------------------------

loc_2DE2:               ; CODE XREF: BIOS:00002DD0j
					; BIOS:00002DD6j ...
	move.w  #1, cdbCommandCache(a5)
	bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_2DEC:               ; CODE XREF: BIOS:loc_2AE4j
	move.w #LEDREADY, ledMode(a5)
	move.w #$1000, cdbControlStatus(a5)     ; No disc
	bsr.w  cddGetStatusCodeByte

	cmpi.b #5, d0
	beq.s  loc_2E12

	cmpi.b #$E, d0
	beq.s  loc_2E12

	cmpi.b #9, d0
	beq.s  loc_2E12
	bra.w  cdbPrepareCommand
; ---------------------------------------------------------------------------

loc_2E12:               ; CODE XREF: BIOS:00002E00j
					; BIOS:00002E06j ...
	move.w  #1, cdbCommandCache(a5)
	bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_2E1C:               ; CODE XREF: BIOS:00002E32j
					; BIOS:00002EA6j
	bsr.w   cdbSuspendExecution

	btst    #7, cdbCommand(a5)
	bne.w   cdbPrepareCommand

	bsr.w   cddGetStatusCodeByte

	cmpi.b  #$E,d0
	beq.s   loc_2E1C
	bra.s   loc_2EAA
; ---------------------------------------------------------------------------

loc_2E36:               ; CODE XREF: BIOS:00002AE8j
	move.w  #LEDERROR, ledMode(a5)
	bset    #7, byte_5B19(a5)
	bra.s   loc_2E50
; ---------------------------------------------------------------------------

loc_2E44:               ; CODE XREF: BIOS:00002B0Cj
					; BIOS:00002E80j
	move.w  #LEDREADY, ledMode(a5)
	bclr    #7, byte_5B19(a5)

loc_2E50:               ; CODE XREF: BIOS:00002E42j
	bsr.w   cddGetStatusCodeByte

	cmpi.b  #0, d0
	beq.s   loc_2E82

	cmpi.b  #5, d0
	beq.s   loc_2EAA

	cmpi.b  #$B, d0
	beq.s   loc_2E82

	cmpi.b  #$E, d0
	beq.s   loc_2E82

	move.w  #$8010, d0
	bsr.w   sub_B0C

loc_2E74:               ; CODE XREF: BIOS:00002E7Cj
	bsr.w   cdbSuspendExecution

	bsr.w   sub_AF6
	bcs.s   loc_2E74

	tst.b   d0
	bne.s   loc_2E44

loc_2E82:               ; CODE XREF: BIOS:00002E58j
					; BIOS:00002E64j ...
	move.w  #$53, word_5B22(a5)
	move.w  #$80D0, d0
	bsr.w   sub_B0C

loc_2E90:               ; CODE XREF: BIOS:00002EA2j
	bsr.w   cdbSuspendExecution

	cmpi.w  #$8010, cdbCommand(a5)
	beq.w   cdbPrepareCommand

	bsr.w   sub_AF6
	bcs.s   loc_2E90

	tst.b   d0
	bne.w   loc_2E1C

loc_2EAA:               ; CODE XREF: BIOS:00002E34j
					; BIOS:00002E5Ej ...
	move.w  #$4000, cdbControlStatus(a5)
	bsr.w   cdbSuspendExecution

	cmpi.w  #$8010, cdbCommand(a5)
	beq.w   cdbPrepareCommand

	bsr.w   cddGetStatusCodeByte

	cmpi.b  #5, d0
	beq.s   loc_2EAA

	cmpi.b  #6, d0
	beq.s   loc_2EAA

	cmpi.b  #8, d0
	beq.s   loc_2EAA

	cmpi.b  #7, d0
	beq.s   loc_2EAA

	move.w  #$10, cdbCommandCache(a5)
	move.w  #$101, d0
	bclr    #7, byte_5B19(a5)
	beq.s   loc_2EF0

	move.w  #$1FF,d0

loc_2EF0:               ; CODE XREF: BIOS:00002EEAj
	move.w  d0, cdbArg1Cache(a5)
	bra.w   cdbPrepareCommand
; ---------------------------------------------------------------------------

loc_2EF8:               ; CODE XREF: BIOS:00002B10j
	bset    #2, byte_5B18(a5)
	move.w  #LEDSTANDBY, ledMode(a5)
	bra.s   loc_2F12
; ---------------------------------------------------------------------------

loc_2F06:               ; CODE XREF: BIOS:00002AECj
	move.w  #LEDDISCIN, ledMode(a5)
	move.w  word_5B16(a5), word_5B00(a5)

loc_2F12:               ; CODE XREF: BIOS:00002F04j
	andi.b  #$5F, byte_5B18(a5)

loc_2F18:               ; CODE XREF: BIOS:00002F48j
	bsr.w   cddGetStatusCodeByte

	cmpi.b  #0, d0
	beq.s   loc_2F4A

	cmpi.b  #5, d0
	beq.s   loc_2F4A

	cmpi.b  #$B, d0
	beq.s   loc_2F4A

	cmpi.b  #$E, d0
	beq.s   loc_2F4A

	move.w  #$8010, d0
	bsr.w   sub_B0C

loc_2F3C:               ; CODE XREF: BIOS:00002F44j
	bsr.w   cdbSuspendExecution

	bsr.w   sub_AF6
	bcs.s   loc_2F3C

	tst.b   d0
	bne.s   loc_2F18

loc_2F4A:               ; CODE XREF: BIOS:00002F20j
					; BIOS:00002F26j ...
		move.w  #0, cdbControlStatus(a5)
		move.w  #$24, cdbCommandCache(a5)
		bsr.w   sub_2B9A

loc_2F5A:               ; CODE XREF: BIOS:00002B74j
		bsr.w   cddGetStatusCodeByte

		move.w  #0, cdbControlStatus(a5)

		cmpi.b  #5, d0
		beq.s   loc_2F7A

		cmpi.b  #$B, d0
		beq.s   loc_2F7A

		cmpi.b  #$E, d0
		beq.s   loc_2F7A

		bra.w   cdbPrepareCommand
; ---------------------------------------------------------------------------

loc_2F7A:               ; CODE XREF: BIOS:00002F68j
					; BIOS:00002F6Ej ...
		move.w  #1, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_2F84:               ; CODE XREF: BIOS:0000336Cj
		move.w  cdbCommandCache(a5), word_5ADC(a5)
		bset    #0, byte_5B18(a5)
		andi.b  #$5D, byte_5B18(a5)
		bset    #6, byte_5B19(a5)
		move.w  #$40, word_5AFE(a5)
		bra.w   loc_306C
; ---------------------------------------------------------------------------

loc_2FA6:               ; CODE XREF: BIOS:00003598j
					; BIOS:000035ACj ...
		move.w  $5AEA(a5), word_5ADC(a5)
		andi.b  #$5C, byte_5B18(a5)
		move.w  #$30, word_5AFE(a5)
		bra.w   loc_306C
; ---------------------------------------------------------------------------

loc_2FBC:               ; CODE XREF: BIOS:00002B3Cj
		move.w  #$28, word_5ADC(a5)
		bset    #0, byte_5B18(a5)
		bclr    #1, byte_5B18(a5)
		move.w  #$40, word_5AFE(a5)
		bra.s   loc_2FEE
; ---------------------------------------------------------------------------

loc_2FD6:               ; CODE XREF: BIOS:00002B34j
		move.w  #LEDDISCIN, ledMode(a5)
		move.w  #$25, word_5ADC(a5)
		andi.b  #$FC, byte_5B18(a5)
		move.w  #$30, word_5AFE(a5)

loc_2FEE:               ; CODE XREF: BIOS:00002FD4j
					; BIOS:00003682j ...
		andi.b  #$5F, byte_5B18(a5)
		move.l  cdbArg1Cache(a5), d0
		move.l  d0, dword_5B02(a5)
		clr.w   word_5B00(a5)
		bra.s   loc_306C
; ---------------------------------------------------------------------------

loc_3002:               ; CODE XREF: BIOS:00002B48j
		bset    #3, byte_5B18(a5)

loc_3008:               ; CODE XREF: BIOS:00002B38j
		move.w  #$28, word_5ADC(a5)
		bset    #0, byte_5B18(a5)
		bclr    #1, byte_5B18(a5)
		move.w  #$40, word_5AFE(a5)
		bra.s   loc_3056
; ---------------------------------------------------------------------------

loc_3022:               ; CODE XREF: BIOS:00002B2Cj
		move.w  #LEDDISCIN, ledMode(a5)
		move.w  #$26, word_5ADC(a5)
		bra.s   loc_304A
; ---------------------------------------------------------------------------

loc_3030:               ; CODE XREF: BIOS:00002B30j
		move.w  #LEDDISCIN, ledMode(a5)
		move.w  #$27, word_5ADC(a5)
		bra.s   loc_304A
; ---------------------------------------------------------------------------

loc_303E:               ; CODE XREF: BIOS:00002B28j
		move.w  #LEDDISCIN, ledMode(a5)
		move.w  #$25, word_5ADC(a5)

loc_304A:               ; CODE XREF: BIOS:0000302Ej
					; BIOS:0000303Cj
		andi.b  #$FC, byte_5B18(a5)
		move.w  #$30, word_5AFE(a5)

loc_3056:               ; CODE XREF: BIOS:00003020j
		andi.b  #$5F, byte_5B18(a5)
		move.w  cdbArg1Cache(a5), d0
		move.w  d0, word_5B00(a5)
		bsr.w   getTocForTrack
		move.l  d0, dword_5B02(a5)

loc_306C:               ; CODE XREF: BIOS:00002FA2j
					; BIOS:00002FB8j ...
		cmpi.w  #$8010, cdbCommand(a5)
		beq.w   cdbPrepareCommand

		cmpi.w  #$800A, cdbCommand(a5)
		beq.w   cdbPrepareCommand

		bsr.w   cddGetStatusCodeByte

		cmpi.b  #1, d0
		beq.s   loc_30CC

		cmpi.b  #4, d0
		beq.s   loc_30CC

		cmpi.b  #$C, d0
		beq.s   loc_30CC

		cmpi.b  #5, d0
		beq.w   loc_31E0

		cmpi.b  #$B, d0
		beq.w   loc_31E0

		cmpi.b  #$E, d0
		beq.w   loc_31E0
		bra.s   loc_30B4
; ---------------------------------------------------------------------------

loc_30B0:               ; CODE XREF: BIOS:000030BCj
		bsr.w   cdbSuspendExecution

loc_30B4:               ; CODE XREF: BIOS:000030AEj
					; BIOS:00003104j
		move.w  #$60, d0
		bsr.w   sub_B0C
		bcs.s   loc_30B0

loc_30BE:               ; CODE XREF: BIOS:000030C6j
		bsr.w   cdbSuspendExecution

		bsr.w   sub_AF6
		bcs.s   loc_30BE

		tst.b   d0
		bne.s   loc_306C

loc_30CC:               ; CODE XREF: BIOS:00003088j
					; BIOS:0000308Ej ...
		move.w  #0, word_5B0A(a5)
		bsr.w   sub_2BBC

		move.w  #$800, cdbControlStatus(a5)
		btst    #1, byte_5B18(a5)
		beq.s   loc_30EA

		move.w  #$808, cdbControlStatus(a5)

loc_30EA:               ; CODE XREF: BIOS:000030E2j
		bra.s   loc_3106
; ---------------------------------------------------------------------------

loc_30EC:               ; CODE XREF: BIOS:00003112j
		bsr.w   cdbSuspendExecution

		bsr.w   cddGetStatusCodeByte

		cmpi.b  #1, d0
		beq.s   loc_3106

		cmpi.b  #4, d0
		beq.s   loc_3106

		cmpi.b  #$C, d0
		bne.s   loc_30B4

loc_3106:               ; CODE XREF: BIOS:loc_30EAj
					; BIOS:000030F8j ...
		move.l  dword_5B02(a5), d1
		move.w  #$A0, d0
		bsr.w   sub_B0C
		bcs.s   loc_30EC

		bra.s   loc_311A
; ---------------------------------------------------------------------------

loc_3116:               ; CODE XREF: BIOS:00003126j
		bsr.w   cdbSuspendExecution

loc_311A:               ; CODE XREF: BIOS:00003114j
		move.l  dword_5B02(a5), d1
		move.w  word_5AFE(a5), d0
		bsr.w   sub_B0C
		bcs.s   loc_3116

loc_3128:               ; CODE XREF: BIOS:00003146j
		bsr.w   cdbSuspendExecution

		bsr.w   cddGetStatusCodeByte

		cmpi.b  #8, d0
		bne.s   loc_3142

		bsr.w   sub_D7C

		cmpi.b  #6, d0
		bcc.w   loc_306C

loc_3142:               ; CODE XREF: BIOS:00003134j
		bsr.w   sub_AF6
		bcs.s   loc_3128
		tst.b   d0
		bne.w   loc_306C
		move.w  #$FFFF, word_5B0A(a5)
		bsr.w   sub_2BBC
		move.w  word_5ADC(a5), cdbCommandCache(a5)
		btst    #1, byte_5B18(a5)
		beq.s   loc_3192
		cmpi.w  #$2B, word_5ADC(a5)
		bne.s   loc_3178
		bset    #6, byte_5B18(a5)
		clr.w   word_5B0E(a5)

loc_3178:               ; CODE XREF: BIOS:0000316Cj
		bsr.w   sub_3728
; ---------------------------------------------------------------------------
		btst    #0, byte_5B18(a5)
		bne.s   loc_31BE
		move.w  #$101, cdbControlStatus(a5)
		move.w  #LEDACCESS, ledMode(a5)
		bra.s   loc_31BE
; ---------------------------------------------------------------------------

loc_3192:               ; CODE XREF: BIOS:00003164j
		btst    #0, byte_5B18(a5)
		bne.s   loc_31B4
		lea cdbCommandCache(a5), a0
		lea word_5AEA(a5), a1
		bsr.w   copyCdbCommand
		move.w  #$100, cdbControlStatus(a5)
		move.w  #LEDACCESS, ledMode(a5)
		bra.s   loc_31DC
; ---------------------------------------------------------------------------

loc_31B4:               ; CODE XREF: BIOS:00003198j
		bset    #7, byte_5B18(a5)
		clr.w   word_5B0E(a5)

loc_31BE:               ; CODE XREF: BIOS:00003182j
					; BIOS:00003190j
		bclr    #6, byte_5B19(a5)
		bne.w   loc_2AD0
		move.w  #$25, d0
		bclr    #3, byte_5B18(a5)
		beq.s   loc_31D8
		move.w  #$26, d0

loc_31D8:               ; CODE XREF: BIOS:000031D2j
		move.w  d0,word_5AEA(a5)

loc_31DC:               ; CODE XREF: BIOS:000031B2j
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_31E0:               ; CODE XREF: BIOS:0000309Aj
					; BIOS:000030A2j ...
		move.w  #$FFFF, word_5B0A(a5)
		bsr.w   sub_2BBC

loc_31EA:               ; CODE XREF: BIOS:000031F2j
		bsr.w   cdbSuspendExecution

		bsr.w   sub_AF6
		bcs.s   loc_31EA
		tst.b   d0
		move.w  #1, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3200:               ; CODE XREF: BIOS:00002B78j
		move.w  #$100, cdbControlStatus(a5)
		bsr.w   cddGetStatusCodeByte
		cmpi.b  #$C, d0
		beq.s   loc_323A
		cmpi.b  #8, d0
		beq.s   loc_3244
		cmpi.b  #6, d0
		beq.s   loc_3222
		cmpi.b  #1, d0
		bne.s   loc_31E0

loc_3222:               ; CODE XREF: BIOS:0000321Aj
					; BIOS:0000324Ej
		bsr.w   getCurrentTrackNumber
		bcs.w   cdbPrepareCommand

		cmp.w   word_5B00(a5), d0
		beq.w   cdbPrepareCommand

		move.w  d0, word_5B00(a5)
		bra.w   cdbPrepareCommand
; ---------------------------------------------------------------------------

loc_323A:               ; CODE XREF: BIOS:0000320Ej
		move.w  #3, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3244:               ; CODE XREF: BIOS:00003214j
		bsr.w   sub_D7C
		cmpi.b  #6, d0
		bcc.s   loc_31E0
		bra.s   loc_3222
; ---------------------------------------------------------------------------

loc_3250:               ; CODE XREF: BIOS:00002B80j
		move.w  #$100, cdbControlStatus(a5)
		bsr.w   cddGetStatusCodeByte

		cmpi.b  #$C, d0
		beq.s   loc_3284

		cmpi.b  #8, d0
		beq.s   loc_3298

		cmpi.b  #6, d0
		beq.s   loc_3274

		cmpi.b  #1, d0
		bne.w   loc_31E0

loc_3274:               ; CODE XREF: BIOS:0000326Aj
					; BIOS:000032A4j
		bsr.w   getCurrentTrackNumber
		bcs.w   cdbPrepareCommand

		cmp.w   word_5B00(a5), d0
		bls.w   cdbPrepareCommand

loc_3284:               ; CODE XREF: BIOS:0000325Ej
		moveq   #0, d0
		move.w  word_5B00(a5), d0
		move.w  d0, cdbArg1Cache(a5)
		move.w  #$13, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3298:               ; CODE XREF: BIOS:00003264j
		bsr.w   sub_D7C

		cmpi.b  #6, d0
		bcc.w   loc_31E0
		bra.s   loc_3274
; ---------------------------------------------------------------------------

loc_32A6:               ; CODE XREF: BIOS:00002B7Cj
		move.w  #$100, cdbControlStatus(a5)
		bsr.w   cddGetStatusCodeByte

		cmpi.b  #$C, d0
		beq.s   loc_32DA

		cmpi.b  #8, d0
		beq.s   loc_32E4

		cmpi.b  #6, d0
		beq.s   loc_32CA

		cmpi.b  #1, d0
		bne.w   loc_31E0

loc_32CA:               ; CODE XREF: BIOS:000032C0j
					; BIOS:000032F0j
		bsr.w   getCurrentTrackNumber
		bcs.w   cdbPrepareCommand

		cmp.w   word_5B00(a5), d0
		bls.w   cdbPrepareCommand

loc_32DA:               ; CODE XREF: BIOS:000032B4j
		move.w  #3, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_32E4:               ; CODE XREF: BIOS:000032BAj
		bsr.w   sub_D7C
		cmpi.b  #6, d0
		bcc.w   loc_31E0
		bra.s   loc_32CA
; ---------------------------------------------------------------------------

loc_32F2:               ; CODE XREF: BIOS:00002B00j
		move.w  #LEDACCESS, ledMode(a5)
		bset    #5, byte_5B18(a5)
		bra.s   loc_332C
; ---------------------------------------------------------------------------

loc_3300:               ; CODE XREF: BIOS:00002AFCj
		move.w  #LEDACCESS, ledMode(a5)
		bclr    #5, byte_5B18(a5)
		bset    #4, byte_5B18(a5)
		bra.s   loc_332C
; ---------------------------------------------------------------------------

loc_3314:               ; CODE XREF: BIOS:00002AF8j
		move.w  #LEDACCESS, ledMode(a5)
		andi.b  #$CF, byte_5B18(a5)
		bsr.w   cddGetStatusCodeByte

		cmpi.b  #$C, d0
		beq.w   loc_3440

loc_332C:               ; CODE XREF: BIOS:000032FEj
					; BIOS:00003312j ...
		bsr.w   cddGetStatusCodeByte

		cmpi.b  #$C, d0
		beq.w   loc_33CA

		cmpi.b  #1, d0
		beq.w   loc_33CA

		cmpi.b  #4, d0
		beq.w   loc_33CA

		cmpi.b  #5, d0
		beq.w   loc_344A

		cmpi.b  #$B, d0
		beq.w   loc_344A

		cmpi.b  #$E, d0
		beq.w   loc_344A

		cmpi.b  #0, d0
		bne.s   loc_3370

		bclr    #2, byte_5B18(a5)
		bne.w   loc_2F84

loc_3370:               ; CODE XREF: BIOS:00003364j
		btst    #7, byte_5B18(a5)
		bne.s   loc_3382

		move.w  #$8070, d0
		bsr.w   sub_B0C
		bra.s   loc_33BA
; ---------------------------------------------------------------------------

loc_3382:               ; CODE XREF: BIOS:00003376j
		move.w  #0, word_5B0A(a5)
		bsr.w   sub_2BBC
		move.w  #$8060, d0
		bsr.w   sub_B0C

loc_3394:               ; CODE XREF: BIOS:0000339Cj
		bsr.w   cdbSuspendExecution

		bsr.w   sub_AF6
		bcs.s   loc_3394

		tst.b   d0
		move.w  #$FFFF, word_5B0A(a5)
		bsr.w   sub_2BBC

		move.l  dword_59F8(a5), d0
		bpl.s   loc_33B6

		move.l  #$20000, d0

loc_33B6:               ; CODE XREF: BIOS:000033AEj
		move.l  d0, dword_5B02(a5)

loc_33BA:               ; CODE XREF: BIOS:00003380j
					; BIOS:000033C2j
		bsr.w   cdbSuspendExecution

		bsr.w   sub_AF6
		bcs.s   loc_33BA

		tst.b   d0
		bra.w   loc_332C
; ---------------------------------------------------------------------------

loc_33CA:               ; CODE XREF: BIOS:00003334j
					; BIOS:0000333Cj ...
		btst    #5, byte_5B18(a5)
		bne.s   loc_3412

		move.w  #$80, d0
		bchg    #4, byte_5B18(a5)
		beq.s   loc_33E2

		move.w  #$90, d0

loc_33E2:               ; CODE XREF: BIOS:000033DCj
		move.w  d0, word_5B10(a5)
		bra.s   loc_33EC
; ---------------------------------------------------------------------------

loc_33E8:               ; CODE XREF: BIOS:000033F4j
		bsr.w   cdbSuspendExecution

loc_33EC:               ; CODE XREF: BIOS:000033E6j
		move.w  word_5B10(a5), d0
		bsr.w   sub_B0C
		bcs.s   loc_33E8

loc_33F6:               ; CODE XREF: BIOS:000033FEj
		bsr.w   cdbSuspendExecution

		bsr.w   sub_AF6
		bcs.s   loc_33F6

		tst.b   d0
		bne.s   loc_344A

		move.w  #$300, cdbControlStatus(a5)
		bset    #5, byte_5B18(a5)
		bra.s   loc_3440
; ---------------------------------------------------------------------------

loc_3412:               ; CODE XREF: BIOS:000033D0j
		bclr    #5, byte_5B18(a5)
		btst    #7, byte_5B18(a5)
		bne.s   loc_3436

		move.w  #$100, cdbControlStatus(a5)
		lea word_5AEA(a5), a0
		lea cdbCommandCache(a5), a1
		bsr.w   copyCdbCommand
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3436:               ; CODE XREF: BIOS:0000341Ej
		move.w  #3, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3440:               ; CODE XREF: BIOS:00003328j
					; BIOS:00003410j
		move.w  #$29, cdbCommandCache(a5)
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_344A:               ; CODE XREF: BIOS:0000334Cj
					; BIOS:00003354j ...
		move.w  #1, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3454:               ; CODE XREF: BIOS:00002B88j
		move.w  #$0300, cdbControlStatus(a5)     ; Scanning music
		bsr.w   cddGetStatusCodeByte

		cmpi.b  #2, d0
		beq.s   loc_3490

		cmpi.b  #1, d0
		beq.s   loc_3490

		cmpi.b  #$C, d0
		beq.s   loc_3490

		cmpi.b  #3, d0
		beq.w   cdbPrepareCommand

		cmpi.b  #6, d0
		beq.w   cdbPrepareCommand

		cmpi.b  #8, d0
		beq.s   loc_349A

loc_3486:               ; CODE XREF: BIOS:000034A2j
		move.w  #1, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3490:               ; CODE XREF: BIOS:00003462j
					; BIOS:00003468j ...
		move.w  #3, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_349A:               ; CODE XREF: BIOS:00003484j
		bsr.w   sub_D7C
		cmpi.b  #6, d0
		bcc.s   loc_3486
		bra.w   cdbPrepareCommand
; ---------------------------------------------------------------------------

loc_34A8:               ; CODE XREF: BIOS:00002AF0j
		bclr    #2, byte_5B18(a5)

loc_34AE:               ; CODE XREF: BIOS:00002B14j
		andi.b  #$5F, byte_5B18(a5)
		move.w  #LEDDISCIN, ledMode(a5)
		bra.s   loc_34E4
; ---------------------------------------------------------------------------

loc_34BC:               ; CODE XREF: BIOS:00002AF4j
		move.w  #LEDACCESS, ledMode(a5)
		bset    #7, byte_5B18(a5)
		bclr    #5, byte_5B18(a5)
		bra.s   loc_34E4
; ---------------------------------------------------------------------------

loc_34D0:               ; CODE XREF: BIOS:000034ECj
					; BIOS:00003522j
		move.w  #$8060, d0
		bsr.w   sub_B0C

loc_34D8:               ; CODE XREF: BIOS:000034E0j
		bsr.w   cdbSuspendExecution
		bsr.w   sub_AF6
		bcs.s   loc_34D8
		tst.b   d0

loc_34E4:               ; CODE XREF: BIOS:000034BAj
					; BIOS:000034CEj
		bsr.w   cddGetStatusCodeByte

		cmpi.b  #$A, d0
		beq.s   loc_34D0

		cmpi.b  #5, d0
		beq.w   loc_3606

		cmpi.b  #$B, d0
		beq.w   loc_3606

		cmpi.b  #$E, d0
		beq.w   loc_3606

		btst    #7, byte_5B18(a5)
		bne.w   loc_3590

		cmpi.b  #$C, d0
		beq.w   loc_3576

		cmpi.b  #4, d0
		beq.s   loc_3576

		cmpi.b  #0, d0
		beq.s   loc_34D0

		move.w  #0, word_5B0A(a5)
		bsr.w   sub_2BBC

		move.w  #3, word_5B20(a5)
		bra.s   loc_353A
; ---------------------------------------------------------------------------

loc_3536:               ; CODE XREF: BIOS:00003542j
		bsr.w   cdbSuspendExecution

loc_353A:               ; CODE XREF: BIOS:00003534j
					; BIOS:00003556j
		move.w  #$60, d0
		bsr.w   sub_B0C
		bcs.s   loc_3536

loc_3544:               ; CODE XREF: BIOS:0000354Cj
		bsr.w   cdbSuspendExecution

		bsr.w   sub_AF6
		bcs.s   loc_3544

		tst.b   d0
		beq.s   loc_355C

		subq.w  #1, word_5B20(a5)
		bcc.s   loc_353A
		bra.w   loc_35FC
; ---------------------------------------------------------------------------

loc_355C:               ; CODE XREF: BIOS:00003550j
		move.w  #$FFFF, word_5B0A(a5)
		bsr.w   sub_2BBC
		move.l  dword_59F8(a5), d0
		bpl.s   loc_3572
		move.l  #$20000, d0

loc_3572:               ; CODE XREF: BIOS:0000356Aj
		move.l  d0, dword_5B02(a5)

loc_3576:               ; CODE XREF: BIOS:00003514j
					; BIOS:0000351Cj
		move.w  #$500, cdbControlStatus(a5)
		bset    #7, byte_5B18(a5)
		clr.w   word_5B0E(a5)
		move.w  #$28, cdbCommandCache(a5)
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_3590:               ; CODE XREF: BIOS:0000350Cj
		bclr    #2, byte_5B18(a5)
		beq.s   loc_359C
		bra.w   loc_2FA6
; ---------------------------------------------------------------------------

loc_359C:               ; CODE XREF: BIOS:00003596j
		cmpi.b  #$C, d0
		beq.s   loc_35DC
		cmpi.b  #1, d0
		beq.s   loc_35DC
		cmpi.b  #0, d0
		beq.w   loc_2FA6
		move.w  #3, word_5B20(a5)
		bra.s   loc_35BC
; ---------------------------------------------------------------------------

loc_35B8:               ; CODE XREF: BIOS:000035C4j
		bsr.w   cdbSuspendExecution

loc_35BC:               ; CODE XREF: BIOS:000035B6j
		move.w  #$70, d0
		bsr.w   sub_B0C
		bcs.s   loc_35B8

loc_35C6:               ; CODE XREF: BIOS:000035CEj
		bsr.w   cdbSuspendExecution
		bsr.w   sub_AF6
		bcs.s   loc_35C6
		tst.b   d0
		beq.s   loc_35DC
		bsr.w   sub_2BA2
		bra.w   loc_2FA6
; ---------------------------------------------------------------------------

loc_35DC:               ; CODE XREF: BIOS:000035A0j
					; BIOS:000035A6j ...
		bsr.w   sub_2BA2
		move.w  #$100, cdbControlStatus(a5)
		bclr    #7, byte_5B18(a5)
		lea word_5AEA(a5), a0
		lea cdbCommandCache(a5), a1
		bsr.w   copyCdbCommand
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_35FC:               ; CODE XREF: BIOS:00003558j
		move.w  #$FFFF, word_5B0A(a5)
		bsr.w   sub_2BBC

loc_3606:               ; CODE XREF: BIOS:000034F2j
					; BIOS:000034FAj ...
		move.w  #1, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3610:               ; CODE XREF: BIOS:00002B84j
		move.w  #$500, cdbControlStatus(a5)
		bsr.w   cddGetStatusCodeByte
		cmpi.b  #8, d0
		beq.s   loc_3658
		cmpi.b  #6, d0
		beq.s   loc_3632
		cmpi.b  #$C, d0
		beq.s   loc_3632
		cmpi.b  #4, d0
		bne.s   loc_3606

loc_3632:               ; CODE XREF: BIOS:00003624j
					; BIOS:0000362Aj ...
		btst    #1, cdcFlags0(a5)
		bne.s   loc_363E
		bsr.w   _cdcstop

loc_363E:               ; CODE XREF: BIOS:00003638j
		addq.w  #1, word_5B0E(a5)
		move.w  word_5B0E(a5), d0
		cmp.w   cdbSpindownDelay(a5), d0
		bls.w   cdbPrepareCommand
		move.w  #$B, cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3658:               ; CODE XREF: BIOS:0000361Ej
		bsr.w   sub_D7C
		cmpi.b  #6, d0
		bcc.s   loc_3606
		bra.s   loc_3632
; ---------------------------------------------------------------------------

loc_3664:               ; CODE XREF: BIOS:00003860j
					; BIOS:0000388Cj
		andi.b  #$9E, byte_5B18(a5)
		bset    #1, byte_5B18(a5)
		move.w  word_5AF4(a5), word_5ADC(a5)
		move.w  #$30, word_5AFE(a5)
		move.l  dword_5A30(a5), cdbArg1Cache(a5)
		bra.w   loc_2FEE
; ---------------------------------------------------------------------------

loc_3686:               ; CODE XREF: BIOS:00002B44j
		move.w  #LEDDISCIN,ledMode(a5)
		move.l  cdbArg1Cache(a5),d0
		addi.l  #$96,d0 ; '–'
		bsr.w   framesToTimecode
		move.l  d0,cdbArg1Cache(a5)
		move.w  #$2B,word_5ADC(a5)
		ori.b   #3,byte_5B18(a5)
		move.w  #$40,word_5AFE(a5)
		lea cdbCommandCache(a5),a0
		lea word_5AF4(a5),a1
		bsr.w   copyCdbCommand
		bra.w   loc_2FEE
; ---------------------------------------------------------------------------

loc_36C0:               ; CODE XREF: BIOS:00002B64j
		move.l  cdbArg1Cache(a5),d0
		addi.l  #$95,d0
		add.l   cdbArg2Cache(a5),d0
		move.l  d0,cdbArg2Cache(a5)
		bra.w   loc_36DE
; ---------------------------------------------------------------------------

loc_36D6:               ; CODE XREF: BIOS:00002B40j
		move.l  #$FFFFFFFF,cdbArg2Cache(a5)

loc_36DE:               ; CODE XREF: BIOS:00002B68j
					; BIOS:000036D2j
		bset    #2,byte_5B18(a5)
		move.w  #LEDDISCIN,ledMode(a5)
		lea cdbCommandCache(a5),a0
		lea word_5AF4(a5),a1
		bsr.w   copyCdbCommand
		move.l  cdbArg1Cache(a5),d0
		addi.l  #$94,d0
		bsr.w   framesToTimecode
		move.l  d0,cdbArg1Cache(a5)
		move.w  #$2A,word_5ADC(a5)
		bclr    #0,byte_5B18(a5)
		bset    #1,byte_5B18(a5)
		move.w  #$30,word_5AFE(a5)
		bsr.w   clearCdcRingBuffer
		bra.w   loc_2FEE

; =============== S U B R O U T I N E =======================================

; Attributes: noreturn

sub_3728:               ; CODE XREF: BIOS:loc_3178p
		move.l  (sp)+,cdbDelayedRoutine(a5)
		move.l  cdbArg1Cache(a5),d0
		bsr.w   timecodeToFrames
		addq.l  #2,d0
		move.l  cdbArg2Cache(a5),d1
		bsr.w   loc_1AFE
; End of function sub_3728

; ---------------------------------------------------------------------------
		movea.l cdbDelayedRoutine(a5),a0
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
		bra.w   cdbPrepareCommand
; ---------------------------------------------------------------------------

loc_375E:               ; CODE XREF: BIOS:0000377Aj
		clr.b   byte_5B13(a5)
		move.b  #3,byte_5B12(a5)

loc_3768:               ; CODE XREF: BIOS:00003752j
		move.w  #$C,cdbCommandCache(a5)
		bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_3772:               ; CODE XREF: BIOS:00003758j
		move.b  d0,byte_5B13(a5)
		subq.b  #1,byte_5B12(a5)
		bcs.s   loc_375E
		bsr.w   _cdcstop
		lea word_5AF4(a5),a0
		lea cdbCommandCache(a5),a1
		bsr.w   copyCdbCommand
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
		bsr.w   cdbSuspendExecution

		bsr.w   sub_AF6
		bcs.s   loc_37BA
		tst.b   d0

loc_37C6:               ; CODE XREF: BIOS:0000379Cj
					; BIOS:000037B0j
		bsr.w   cddGetStatusCodeByte

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
		bsr.w   cdbSuspendExecution

loc_3810:               ; CODE XREF: BIOS:0000380Aj
					; BIOS:0000382Cj
		move.w  #$60,d0
		bsr.w   sub_B0C
		bcs.s   loc_380C

loc_381A:               ; CODE XREF: BIOS:00003822j
		bsr.w   cdbSuspendExecution

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
		move.w  #$505, cdbControlStatus(a5)
		bset    #6, byte_5B18(a5)
		clr.w   word_5B0E(a5)
		move.w  #$2B, cdbCommandCache(a5)
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_3850:               ; CODE XREF: BIOS:000037EEj
		cmpi.b  #$C, d0
		beq.s   loc_3890

		cmpi.b  #1, d0
		beq.s   loc_3890

		cmpi.b  #0, d0
		beq.w   loc_3664

		move.w  #3, word_5B20(a5)
		bra.s   loc_3870
; ---------------------------------------------------------------------------

loc_386C:               ; CODE XREF: BIOS:00003878j
		bsr.w   cdbSuspendExecution

loc_3870:               ; CODE XREF: BIOS:0000386Aj
		move.w  #$70, d0
		bsr.w   sub_B0C
		bcs.s   loc_386C

loc_387A:               ; CODE XREF: BIOS:00003882j
		bsr.w   cdbSuspendExecution

		bsr.w   sub_AF6
		bcs.s   loc_387A

		tst.b   d0
		beq.s   loc_3890

		bsr.w   sub_2BA2
		bra.w   loc_3664
; ---------------------------------------------------------------------------

loc_3890:               ; CODE XREF: BIOS:00003854j
					; BIOS:0000385Aj ...
		bsr.w   sub_19D4

		bsr.w   sub_2BA2

		move.w  #$101, cdbControlStatus(a5)
		bclr    #6, byte_5B18(a5)
		move.w  #$2A, cdbCommandCache(a5)
		bra.w   loc_2AD0
; ---------------------------------------------------------------------------

loc_38AE:               ; CODE XREF: BIOS:000037D4j
					; BIOS:000037DCj ...
	move.w  #1, cdbCommandCache(a5)
	bra.w   loc_2ACA
; ---------------------------------------------------------------------------

loc_38B8:               ; CODE XREF: BIOS:00002B90j
	move.w  #$0505, cdbControlStatus(a5)
	bsr.w   cddGetStatusCodeByte

	cmpi.b  #8, d0
	beq.s   @loc_38F4

	cmpi.b  #6, d0
	beq.s   @loc_38DA

	cmpi.b  #$C, d0
	beq.s   @loc_38DA

	cmpi.b  #4, d0
	bne.s   loc_38AE

@loc_38DA:               ; CODE XREF: BIOS:000038CCj
				; BIOS:000038D2j ...
	addq.w  #1, word_5B0E(a5)
	move.w  word_5B0E(a5), d0

	cmp.w   cdbSpindownDelay(a5), d0
	bls.w   cdbPrepareCommand

	move.w  #$B, cdbCommandCache(a5)
	bra.w   loc_2ACA
; ---------------------------------------------------------------------------

@loc_38F4:               ; CODE XREF: BIOS:000038C6j
	bsr.w   sub_D7C

	cmpi.b  #6, d0
	bcc.s   loc_38AE

	bra.s   @loc_38DA
; ---------------------------------------------------------------------------

; =============== S U B M O D U L E =========================================
	include "submodules\cdboot.asm"


; =============== S U B R O U T I N E =======================================


checkDiscBootBlock:             ; CODE XREF: sub_3A6C+1B2p
	movem.l d0/a0-a1, -(sp)

	lea regionBootBlock(pc), a1

	move.w #705, d0
	@loc_3E46:
		cmpm.w (a0)+, (a1)+
		dbne   d0, @loc_3E46

	; Return error if it doesn't match
	beq.s @return
	m_setErrorFlag

@return:
	movem.l (sp)+, d0/a0-a1
	rts
; End of function checkDiscBootBlock

; ---------------------------------------------------------------------------
regionBootBlock:
	incbin "us_boot_block.bin"

; ---------------------------------------------------------------------------
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

asc_4412:
	dc.b 'SEGA_CD_ROM',0
	dc.l $1000000

asc_4422:
	dc.b 'RAM_CARTRIDGE___'

dword_4432:        ; DATA XREF: sub_447Er sub_448E+6r ...
	dc.l $FE0000

word_4436:      ; DATA XREF: installJumpTable+3Eo
	dc.w (_buram - word_4436)
    dc.w 0

; =============== S U B R O U T I N E =======================================


_buram:
	movem.l a2/a5, -(sp)
	movea.l #0, a5

	add.w d0, d0
	add.w d0, d0

	jsr loc_4452(pc, d0.w)

	movem.l (sp)+, a2/a5
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
	move.w  #$40,d1
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
	move.w  #$40,d1
	exg a0,a1
	bsr.w   sub_511A
	movep.l 0(a2),d0
	cmp.l   (a3),d0
	beq.s   @loc_44B0
	m_setErrorFlag

@loc_44B0:
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
	beq.s   @loc_457C

	cmpm.l  (a0)+,(a2)+
	beq.s   @loc_457C

	cmpm.l  (a0)+,(a2)+
	bne.w   loc_45D6

@loc_457C:               ; CODE XREF: BIOS:00004570j
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
	m_setErrorFlag
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
	bsr.w   validateString
	bcs.s   loc_45E6
	move.l  dword_5B84(a5),d0
	asr.l   #8,d0
	asr.l   #5,d0
	move.w  #2,d1
	bra.s   loc_45D0
; ---------------------------------------------------------------------------
off_460E:       ; DATA XREF: BIOS:000045BAo
	dc.l asc_4616
	dc.l asc_4622
asc_4616:
	dc.b 'NOT_EXIST__',0
asc_4622:
	dc.b 'UNFORMAT___',0
; ---------------------------------------------------------------------------

_brmstat:               ; CODE XREF: BIOS:00004456j
	movem.l d2-d3/a2, -(sp)

	moveq #0, d0
	bsr.w sub_531A
	bcs.s @loc_4660

	move.w d0, d3
	bsr.w  sub_5346
	bcs.s  @loc_4660

	tst.w d0
	bge.s @loc_4648

	moveq #0, d0

@loc_4648:               ; CODE XREF: BIOS:00004644j
	movea.l a1, a2

	lea    asc_4412(pc), a1 ; "SEGA_CD_ROM"
	move.w #$C, d1

	bsr.w sub_5176

	movea.l a2, a1
	move.w  d3, d1

@loc_465A:               ; CODE XREF: BIOS:0000466Cj
	movem.l (sp)+, d2-d3/a2
	rts
; ---------------------------------------------------------------------------

@loc_4660:               ; CODE XREF: BIOS:00004638j
				; BIOS:00004640j
	move.w #$FFFF, d0
	move.w #$FFFF, d1

	m_setErrorFlag
	bra.s @loc_465A

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
	m_setErrorFlag
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
		m_setErrorFlag
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
		m_setErrorFlag
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
		m_setErrorFlag
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
		m_setErrorFlag
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
		m_setErrorFlag
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
		m_setErrorFlag
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
		m_setErrorFlag

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
		m_setErrorFlag
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
		m_setErrorFlag
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
		m_setErrorFlag
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
		m_setErrorFlag
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
		m_setErrorFlag
		bra.s   loc_53CA
; End of function sub_53A0


; =============== S U B R O U T I N E =======================================


validateString:               ; CODE XREF: BIOS:000045FAp
	movem.l d0-d2/a0-a1, -(sp)

	subq.w #1, d1

@loc_53DC:
	move.b (a1)+, d2
	lea word_5406(pc), a0

	move.w (a0)+, d0
	@loc_53E4:
		cmp.b (a0)+, d2
		bcs.s @loc_5400

		cmp.b (a0)+, d2
		bls.s @loc_53F2

		dbf d0, @loc_53E4

	bra.s @loc_5400
; ---------------------------------------------------------------------------

@loc_53F2:
	dbf d1, @loc_53DC

	move #0, ccr

@loc_53FA:
	movem.l (sp)+, d0-d2/a0-a1
	rts
; ---------------------------------------------------------------------------

@loc_5400:
	m_setErrorFlag
	bra.s @loc_53FA
; End of function validateString

; ---------------------------------------------------------------------------
word_5406:
	dc.w 2

	dc.b '0', '9'
	dc.b 'A', 'Z'
	dc.b '_', '_'

fill_540E:
	dcb.b 1010, 0

	END
