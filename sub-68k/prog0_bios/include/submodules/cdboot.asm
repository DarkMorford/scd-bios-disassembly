;   ======================================================================
;       CD-BOOT Submodule
;   ======================================================================

word_3900:          ; DATA XREF: installJumpTable+50o
	dc.w 4
	dc.w 0

; =============== S U B R O U T I N E =======================================


_cdboot:
	movem.l a5, -(sp)
	movea.l #0, a5

	add.w   d0, d0
	add.w   d0, d0
	cmpi.w  #40, d0
	bcc.s   @return

	jsr loc_3922(pc, d0.w)

@return:
	movem.l (sp)+, a5
	rts
; End of function _cdboot

; ---------------------------------------------------------------------------

loc_3922:
	bra.w _cbtinit
; ---------------------------------------------------------------------------
	bra.w _cbtint
; ---------------------------------------------------------------------------
	bra.w _cbtopendisc
; ---------------------------------------------------------------------------
	bra.w _cbtopenstat
; ---------------------------------------------------------------------------
	bra.w _cbtchkdisc
; ---------------------------------------------------------------------------
	bra.w _cbtchkstat
; ---------------------------------------------------------------------------
	bra.w _cbtipdisc
; ---------------------------------------------------------------------------
	bra.w _cbtipstat
; ---------------------------------------------------------------------------
	bra.w _cbtspdisc
; ---------------------------------------------------------------------------
	bra.w _cbtspstat
; ---------------------------------------------------------------------------

_cbtipstat:
	moveq #4, d1
	bra.s loc_3958
; ---------------------------------------------------------------------------

_cbtspstat:
	moveq #3, d1
	bra.s loc_3958
; ---------------------------------------------------------------------------

_cbtopenstat:
	moveq #6, d1
	bra.s loc_3958
; ---------------------------------------------------------------------------

_cbtchkstat:
	moveq #5, d1

loc_3958:
	move.w (_BOOTSTAT).w, d0

	btst   d1, cbtFlags(a5)
	sne    d1

	lsr.w  #1, d1
	rts
; ---------------------------------------------------------------------------

_cbtopendisc:
	bset    #0, cbtFlags(a5)
	bne.s   @returnError

	bsr.w   sub_3A6C
; ---------------------------------------------------------------------------
	clr.b   byte_5A05(a5)
	bset    #6, cbtFlags(a5)

	bclr    #0, cbtFlags(a5)
	m_clearErrorFlag
	bra.s   @returnSuccess
; ---------------------------------------------------------------------------

@returnError:
	m_setErrorFlag

@returnSuccess:
	rts
; ---------------------------------------------------------------------------

_cbtchkdisc:
	; Error if loader is busy
	bset  #0, cbtFlags(a5)
	bne.s @returnError

	bset  #5, cbtFlags(a5)
	bne.s @loc_39AA

	move.l a0, bootHeaderAddress(a5)
	bsr.w  sub_3A6C
; ---------------------------------------------------------------------------
	bset #5, cbtFlags(a5)

@loc_39AA:
	bclr #0, cbtFlags(a5)
	m_clearErrorFlag
	bra.s @returnSuccess
; ---------------------------------------------------------------------------

@returnError:
	m_setErrorFlag

@returnSuccess:
	rts
; ---------------------------------------------------------------------------

_cbtipdisc:
	; Error if loader is busy
	bset   #0, cbtFlags(a5)
	bne.s  @returnError

	cmpi.w #CD_GAMESYSTEM, (_BOOTSTAT).w
	beq.s  @loc_39D0

	cmpi.w #CD_GAMEBOOT, (_BOOTSTAT).w

@loc_39D0:
	; Error if disc not bootable
	bne.s  @returnError

	; Disc is either Game System or Game Boot
	move.l a0, bootHeaderAddress(a5)
	move.l a1, ipDstAddress(a5)
	bsr.w  loc_3A84
; ---------------------------------------------------------------------------
	move.b #$90, cbtFlags(a5)       ; Set flags 7/4, clear other flags
	m_clearErrorFlag
	bra.s  @returnSuccess
; ---------------------------------------------------------------------------

@returnError:
	m_setErrorFlag

@returnSuccess:
	rts
; ---------------------------------------------------------------------------

_cbtspdisc:
	; Error if loader is busy
	bset   #0, cbtFlags(a5)
	bne.s  @returnError

	cmpi.w #CD_GAMESYSTEM, (_BOOTSTAT).w
	beq.s  @loc_3A04

	cmpi.w #CD_GAMEBOOT, (_BOOTSTAT).w

@loc_3A04:
	; Error if disc not bootable
	bne.s @returnError

	; Disc is either Game System or Game Boot
	move.l a1, spDstAddress(a5)
	bset   #3, cbtFlags(a5)         ; Set xx flag
	bclr   #0, cbtFlags(a5)         ; Clear busy flag
	m_clearErrorFlag
	bra.s  @returnSuccess
; ---------------------------------------------------------------------------

@returnError:
	m_setErrorFlag

@returnSuccess:
	rts
; ---------------------------------------------------------------------------

_cbtint:
	movem.l d7, -(sp)

	; Return if busy flag already set
	bset  #0, cbtFlags(a5)
	bne.s @loc_3A46

	; Return if bit 7 clear
	btst  #7, cbtFlags(a5)
	beq.s @loc_3A40

	; Fetch interrupt handler address and data
	movea.l cbtResumeAddress(a5), a0
	movem.l cbtResumeData(a5), d7

	; Resume from suspend point
	jsr (a0)

@loc_3A40:
	bclr #0, cbtFlags(a5)

@loc_3A46:
	movem.l (sp)+, d7
	rts

; =============== S U B R O U T I N E =======================================


cbtSuspendWithData:
	movem.l d7, cbtResumeData(a5)


; =============== S U B R O U T I N E =======================================


cbtSuspendExecution:
	move.l (sp)+, cbtResumeAddress(a5)
	rts
; End of function cbtSuspendExecution

; End of function cbtSuspendWithData

; ---------------------------------------------------------------------------

_cbtinit:
	lea cbtFlags(a5), a0
	moveq #0, d0
	moveq #5, d1

	; Clear RAM from $5B24-$5B53
	@loc_3A60:
		move.l d0, (a0)+
		move.l d0, (a0)+
		dbf d1, @loc_3A60

	clr.b byte_5A05(a5)

; =============== S U B R O U T I N E =======================================

; Attributes: noreturn

sub_3A6C:               ; CODE XREF: BIOS:0000396Ep
					; BIOS:000039A0p
	andi.b #%10000111, cbtFlags(a5)
	move.w #CD_NOTREADY, (_BOOTSTAT).w
	bclr   #1, cbtFlags(a5)
	bset   #7, cbtFlags(a5)

loc_3A84:
	bsr.s cbtSuspendExecution

	btst  #5, cbtFlags(a5)
	bne.s loc_3AE0

	btst  #4, cbtFlags(a5)
	bne.s loc_3AE0

	btst  #3, cbtFlags(a5)
	bne.s loc_3AE0

	btst  #6, cbtFlags(a5)
	bne.s loc_3AA8

	bra.s loc_3A84
; ---------------------------------------------------------------------------

loc_3AA8:               ; CODE XREF: sub_3A6C+38j
	bsr.w   sub_3DD6

	andi.b  #%11000111, cbtFlags(a5)
	moveq   #DRVOPEN, d0
	bsr.w   waitForCdbComplete

	bclr    #6, cbtFlags(a5)

	bra.s   loc_3A84
; ---------------------------------------------------------------------------
word_3AC0:
	dc.b 1      ; First track
	dc.b 1      ; Last track
word_3AC2:
	dc.b 2      ; First track
	dc.b $FF    ; Last track
; ---------------------------------------------------------------------------

loc_3AC4:
	move.w  #CD_MIXED, (_BOOTSTAT).w
	bra.s   loc_3ADA
; ---------------------------------------------------------------------------

loc_3ACC:
	move.w  #CD_ROM, (_BOOTSTAT).w
	bra.s   loc_3ADA
; ---------------------------------------------------------------------------

loc_3AD4:
	move.w  #CD_MUSIC, (_BOOTSTAT).w

loc_3ADA:
	lea word_3AC2(pc), a0
	bra.s   loc_3AE4
; ---------------------------------------------------------------------------

loc_3AE0:               ; CODE XREF: sub_3A6C+20j sub_3A6C+28j ...
	lea word_3AC0(pc), a0

loc_3AE4:               ; CODE XREF: sub_3A6C+72j
	move.w #DRVINIT, d0
	bsr.w  waitForCdbComplete

loc_3AEC:               ; CODE XREF: sub_3A6C+AAj
	bsr.w  cbtSuspendExecution

	move.w #CDBSTAT, d0
	jsr    _CDBIOS

	lea (_CDSTAT).w, a0
	move.b 0(a0), d0

	; Check for "no disc" status
	cmpi.b #$10, d0
	beq.w  loc_3B1E

	; Check for "open tray" status
	cmpi.b #$40, d0
	beq.w  loc_3B18

	; Check for "not ready" or "reading TOC" status
	andi.w #$F0,d0
	beq.s  loc_3B78
	bra.s  loc_3AEC
; ---------------------------------------------------------------------------

loc_3B18:
	nop
	nop
	nop

loc_3B1E:               ; CODE XREF: sub_3A6C+98j
	move.w  #CD_NODISC, (_BOOTSTAT).w

loc_3B24:               ; CODE XREF: sub_3A6C+11Ej
	bsr.w   sub_3DD6
	bclr    #5, cbtFlags(a5)
	bclr    #4, cbtFlags(a5)
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

	cmpi.w  #CD_NOTREADY, (_BOOTSTAT).w
	beq.s   loc_3B8C

	cmpi.w  #CD_GAMESYSTEM, (_BOOTSTAT).w
	bcs.s   loc_3B24

loc_3B8C:
	move.w #1,d1
	move.w #CDBTOCREAD, d0
	jsr    _CDBIOS

	tst.b   d1
	beq.w   loc_3AD4

	move.l  #0, readSectorStart(a5)

loc_3BA6:               ; CODE XREF: sub_3A6C+198j
	move.l  readSectorStart(a5), d0
	lsl.l   #8, d0
	lsl.l   #3, d0
	movea.l d0, a1
	move.l  #$800, d1
	move.l  bootHeaderAddress(a5), dataBufferAddress(a5)
	bsr.w   readSectorsFromDisc
	bcs.w   loc_3B18

	move.l  headerBuffer(a5), d0
	bsr.w   timecodeToFrames
	subi.l  #150, d0
	move.w  d0, dataStartSector(a5)

	movea.l bootHeaderAddress(a5), a0
	lea asc_3B38(pc), a1 ; "SEGADISC        "

	moveq #3, d0
	loc_3BE0:
		movem.l a0-a1, -(sp)

		moveq #3, d1
		loc_3BE6:
			cmpm.l (a0)+, (a1)+
			dbne   d1, loc_3BE6

		movem.l (sp)+, a0-a1
		beq.s   loc_3C0A

		adda.w #16, a1
		dbf d0, loc_3BE0

	lea readSectorStart(a5), a0
	cmpi.l #$F, (a0)
	bls.s  loc_3BA6

loc_3C06:               ; CODE XREF: sub_3A6C+1BAj
	bra.w   loc_3AC4
; ---------------------------------------------------------------------------

loc_3C0A:               ; CODE XREF: sub_3A6C+184j
	; Check if disc is bootable
	cmpi.w  #0, d0
	beq.s   loc_3C16

	cmpi.w  #2, d0
	bne.s   loc_3C28

loc_3C16:
	; Bootable disc, check security block
	movem.l d0/a0, -(sp)

	lea     $200(a0), a0
	bsr.w   checkDiscBootBlock

	movem.l (sp)+, d0/a0
	bcs.s   loc_3C06

loc_3C28:
	addq.w  #4, d0
	move.w  d0, (_BOOTSTAT).w
	bset    #1, cbtFlags(a5)
	bsr.w   sub_3DD6

	; Load IP/SP if needed
	btst    #4, cbtFlags(a5)
	bne.s   loadInitialProgram

	lea word_3AC2(pc), a0
	move.w  #DRVINIT, d0
	bsr.w   waitForCdbComplete

	bclr    #5, cbtFlags(a5)
	bra.w   loc_3A84
; ---------------------------------------------------------------------------

loadInitialProgram:
	movea.l ipDstAddress(a5), a0
	bsr.w   copySector0

	move.l  a0, dataBufferAddress(a5)
	movea.l bootHeaderAddress(a5), a0

	movea.l SYSTEMHEADER.ipAddress(a0), a1
	cmpa.l  #$200, a1
	bne.s   loc_3C80

	cmpi.l  #$600, SYSTEMHEADER.ipSize(a0)
	bne.s   loc_3C80
	bra.w   loc_3C88
; ---------------------------------------------------------------------------

loc_3C80:
	; Read IP from disc
	; d1 is most likely $FFFF if we get here
	bsr.w readSectorsFromDisc

	; Jump back if error
	bcs.w loc_3A84

loc_3C88:
	; Signal IP loaded
	bclr #4, cbtFlags(a5)

	; Wait for "SP not loaded" flag
	@loc_3C8E:
		bsr.w cbtSuspendExecution

		btst  #3, cbtFlags(a5)
		beq.s @loc_3C8E

loadSystemProgram:
	; Read SP from disc
	movea.l bootHeaderAddress(a5), a0
	movea.l SYSTEMHEADER.spAddress(a0), a1
	move.l  SYSTEMHEADER.spSize(a0), d1
	move.l  spDstAddress(a5), dataBufferAddress(a5)
	bsr.w   readSectorsFromDisc

	; Jump back if error
	bcs.w loc_3A84

	; Signal SP loaded
	bclr  #3, cbtFlags(a5)
	bra.w loc_3A84
; End of function sub_3A6C


; =============== S U B R O U T I N E =======================================


waitForCdbComplete:               ; CODE XREF: sub_3A6C+48p sub_3A6C+7Cp ...
	move.l (sp)+, cbtDeferredAddress(a5)
	jsr    _CDBIOS

	@loc_3CC6:
		bsr.w  cbtSuspendExecution
		move.w #CDBCHK, d0
		jsr    _CDBIOS
		bcs.s  @loc_3CC6

	movea.l cbtDeferredAddress(a5), a0
	jmp (a0)
; End of function waitForCdbComplete


; =============== S U B R O U T I N E =======================================

; Inputs:
;   a1: Address on disc to begin reading (will round down to sector)
;   d1: Number of bytes to read (will round up to sector)

readSectorsFromDisc:               ; CODE XREF: sub_3A6C+150p
					; sub_3A6C:loc_3C80p ...
	move.l  (sp)+, cbtDeferredAddress(a5)
	lea readSectorStart(a5), a0

	; Convert start address to sector number
	move.l  a1, d0
	lsr.l   #8, d0
	lsr.l   #3, d0
	move.l  d0, (a0)

	divu.w  #75, d0
	swap    d0
	bsr.w   convertToBcd
	move.b  d0, frameCheckValue(a5)

	; Convert bytes to sector count
	move.l  d1, d0
	lsr.l   #8, d0
	lsr.l   #3, d0

	andi.w  #$7FF, d1
	beq.s   @loc_3D06

	addq.l  #1, d0

@loc_3D06:
	move.l  d0, 4(a0)
	move.w  d0, readSectorLoopCount(a5)

@beginRead:
	; Error if byte is 0
	tst.b   byte_5A05(a5)
	beq.w   @returnError

	lea readSectorStart(a5), a0
	move.w  #ROMREADN, d0
	jsr     _CDBIOS

	move.w  #600, d7
	@loc_3D26:
		; Error if byte is 0
		tst.b  byte_5A05(a5)
		beq.w  @returnError

		bsr.w  cbtSuspendWithData

	@loc_3D32:
		move.w #CDCSTAT, d0
		jsr    _CDBIOS

		; Leave loop if data is ready
		dbcc d7, @loc_3D26

	; Retry if data not present
	bcs.s   @beginRead

	move.b  #3, (GA_CDC_TRANSFER).w     ; Sub-CPU READ transfer mode
	move.w  #CDCREAD, d0
	jsr     _CDBIOS

	; Retry if data not present
	bcs.s   @beginRead

	lsr.w   #8, d0
	cmp.b   frameCheckValue(a5), d0

	; Retry if wrong frame
	bne.s   @beginRead

	movea.l dataBufferAddress(a5), a0
	lea     headerBuffer(a5), a1
	move.w  #CDCTRN, d0
	jsr     _CDBIOS

	; Retry if transfer incomplete
	bcs.s   @beginRead

	move.l  headerBuffer(a5), d0
	lsr.w   #8, d0
	cmp.b   frameCheckValue(a5), d0

	; Retry if wrong frame
	bne.s   @beginRead

	; Increment frame check value
	moveq   #1, d1
	move    #4, ccr
	abcd    d1, d0
	cmpi.b  #$75, d0
	bcs.s   @loc_3D86

	; Reset to 0 if we hit frame 75
	moveq   #0, d0

@loc_3D86:
	; Update check value and buffer address for next frame
	move.b  d0, frameCheckValue(a5)
	move.l  a0, dataBufferAddress(a5)

	; Tell the CDC we read the sector correctly
	move.w  #CDCACK, d0
	jsr     _CDBIOS

	move.w  #6, d7
	addq.l  #1, readSectorStart(a5)
	subq.l  #1, readSectorCount(a5)
	subq.w  #1, readSectorLoopCount(a5)
	bne.s   @loc_3D32

	or.w    d1, d1
	bra.s   @returnSuccess
; ---------------------------------------------------------------------------

@returnError:
	move.w  #CD_NOTREADY, (_BOOTSTAT).w
	move    #1, ccr

@returnSuccess:
	movea.l cbtDeferredAddress(a5), a0
	jmp (a0)
; End of function readSectorsFromDisc


; =============== S U B R O U T I N E =======================================

; Copy bytes $200-$7FF (relative to bootHeaderAddress)
copySector0:
	movea.l bootHeaderAddress(a5), a1
	adda.w  #$200, a1
	move.w  #95, d1

	@loc_3DC8:
		move.l (a1)+, (a0)+
		move.l (a1)+, (a0)+
		move.l (a1)+, (a0)+
		move.l (a1)+, (a0)+
		dbf d1, @loc_3DC8

	rts
; End of function copySector0


; =============== S U B R O U T I N E =======================================


sub_3DD6:               ; CODE XREF: sub_3A6C:loc_3AA8p
					; sub_3A6C:loc_3B24p ...
	move.l  (sp)+, cbtDeferredAddress(a5)
	bra.s   @loc_3DE0
; ---------------------------------------------------------------------------

@loc_3DDC:
	bsr.w cbtSuspendExecution

@loc_3DE0:
	lea unk_3E36(pc), a0

	; Jump if not a GAME* disc
	cmpi.w #CD_GAMESYSTEM, (_BOOTSTAT).w
	bcs.s  @loc_3E14

	; Jump if NOTREADY status
	cmpi.w #CD_NOTREADY,(_BOOTSTAT).w
	beq.s  @loc_3E14

	lea    unk_3E32(pc), a0
	move.w #WONDERREQ, d0
	jsr    _CDBIOS
	bcs.s  @loc_3DDC

	@loc_3E02:
		bsr.w  cbtSuspendExecution

		move.w #WONDERCHK, d0
		jsr    _CDBIOS
		bcs.s  @loc_3E02

	nop
	nop

@loc_3E14:
	move.w  #0, d0

	; Jump if not a GAME* disc
	cmpi.w  #CD_GAMESYSTEM, (_BOOTSTAT).w
	bcs.s   @loc_3E2C

	; Jump if NOTREADY status
	cmpi.w  #CD_NOTREADY, (_BOOTSTAT).w
	beq.s   @loc_3E2C

	move.w  #1, d0

@loc_3E2C:
	movea.l cbtDeferredAddress(a5), a0
	jmp (a0)
; End of function sub_3DD6

; ---------------------------------------------------------------------------
unk_3E32:        ; DATA XREF: sub_3DD6+1Eo
	dc.b $E0
	dc.b   2
	dc.b   1
	dc.b   0

unk_3E36:        ; DATA XREF: sub_3DD6:loc_3DE0o
	dc.b $E0
	dc.b   2
	dc.b   0
	dc.b   0
