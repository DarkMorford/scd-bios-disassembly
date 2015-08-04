;   ======================================================================
;                     SEGA CD BIOS 2.00w US Disassembly
;   ======================================================================
;
;       Disassembly created by DarkMorford
;
;   ======================================================================

	include "constants.asm"
	include "structs.asm"
	include "variables.asm"
	include "macros.asm"

InitialSSP:
	dc.l $FFFFFD00
	dc.l _start
	dc.l errorReset
	dc.l _CODERR
	dc.l _CODERR
	dc.l _DEVERR
	dc.l _CHKERR
	dc.l _TRPERR
	dc.l _SPVERR
	dc.l _TRACE
	dc.l _NOCOD0
	dc.l _NOCOD1
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l _LEVEL2        ; External interrupt
	dc.l errorReset
	dc.l _LEVEL4        ; H-blank
	dc.l errorReset
	dc.l _LEVEL6        ; V-blank
	dc.l errorReset
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
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset
	dc.l errorReset

	dc.b 'SEGA MEGA DRIVE '
	dc.b '(C)SEGA 1993.JUN'
	dc.b 'CD2 BOOT ROM     06/01-1993     20:00      2.00W'
	dc.b 'CD2 BOOT ROM                                    '
	dc.b 'BR 000006-2.00'
	dc.w $AEE0
	dc.b 'JM4             '
	dc.l $000000
	dc.l $01FFFF
	dc.l $FF0000
	dc.l $FFFFFF
	dc.b '            '
	dc.b '            '
	dc.b '                                        '
	dc.b 'U 2             '
; ---------------------------------------------------------------------------

errorReset:
	lea (_EXCPT).w, a0
	move.w #INST_JMP, d0

	move.w d0, (a0)+
	move.l #sub_640, (a0)+

	movea.l (InitialSSP).w, sp
	bra.w   _start
	rte
; ---------------------------------------------------------------------------
fill_21A:
	dcb.b 102, $FF
; ---------------------------------------------------------------------------
	bra.w   sub_640
; ---------------------------------------------------------------------------
	bra.w   _start
; ---------------------------------------------------------------------------
	bra.w   loc_684
; ---------------------------------------------------------------------------
	bra.w   loc_67C
; ---------------------------------------------------------------------------
	bra.w   altVblankHandler
; ---------------------------------------------------------------------------
	bra.w   enableDefaultHInt
; ---------------------------------------------------------------------------
	bra.w   readJoypads
; ---------------------------------------------------------------------------
	bra.w   detectControllerType
; ---------------------------------------------------------------------------
	bra.w   clearAllVram
; ---------------------------------------------------------------------------
	bra.w   clearVdpPatternTables
; ---------------------------------------------------------------------------
	bra.w   clearVsram
; ---------------------------------------------------------------------------
	bra.w   loadDefaultVdpRegs
; ---------------------------------------------------------------------------
	bra.w   loadVdpRegs
; ---------------------------------------------------------------------------
	bra.w   fillVramSegment
; ---------------------------------------------------------------------------
	bra.w   clearVramSegment
; ---------------------------------------------------------------------------
	bra.w   dmaClearVramSegment
; ---------------------------------------------------------------------------
	bra.w   dmaFillVramSegment
; ---------------------------------------------------------------------------
	bra.w   writeTilemapToVram
; ---------------------------------------------------------------------------
	bra.w   sub_C52
; ---------------------------------------------------------------------------
	bra.w   fillVramTilemap
; ---------------------------------------------------------------------------
	bra.w   dmaTransferToVram
; ---------------------------------------------------------------------------
	bra.w   dmaTransferToVramWithRewrite
; ---------------------------------------------------------------------------
	bra.w   displayOn
; ---------------------------------------------------------------------------
	bra.w   displayOff
; ---------------------------------------------------------------------------
	bra.w   loadPalettesNoUpdate
; ---------------------------------------------------------------------------
	bra.w   loadPalettesToBuffer
; ---------------------------------------------------------------------------
	bra.w   dmaTransferPalettes
; ---------------------------------------------------------------------------
	bra.w   decompressNemesis
; ---------------------------------------------------------------------------
	bra.w   decompressNemesisToRam
; ---------------------------------------------------------------------------
	bra.w   updateObjects
; ---------------------------------------------------------------------------
	bra.w   clearRamSegment
; ---------------------------------------------------------------------------
	bra.w   sub_1C06
; ---------------------------------------------------------------------------
	bra.w   updateObjectSprite
; ---------------------------------------------------------------------------
	bra.w   loc_976
; ---------------------------------------------------------------------------
	bra.w   waitForVblank
; ---------------------------------------------------------------------------
	bra.w   dmaSendSpriteTable
; ---------------------------------------------------------------------------
	bra.w   sub_1904
; ---------------------------------------------------------------------------
	bra.w   enableUserHInt
; ---------------------------------------------------------------------------
	bra.w   disableHInt
; ---------------------------------------------------------------------------
	bra.w   writeTextToScreen
; ---------------------------------------------------------------------------
	bra.w   loadFont
; ---------------------------------------------------------------------------
	bra.w   loc_1952
; ---------------------------------------------------------------------------
	bra.w   loadDefaultFont
; ---------------------------------------------------------------------------
	bra.w   handleDpadRepeat
; ---------------------------------------------------------------------------
	bra.w   decompressEnigma
; ---------------------------------------------------------------------------
	bra.w   writeTransposedTilemapToVram
; ---------------------------------------------------------------------------
	bra.w   randWithModulo
; ---------------------------------------------------------------------------
	bra.w   rand
; ---------------------------------------------------------------------------
	bra.w   clearCommRegisters
; ---------------------------------------------------------------------------
	bra.w   sub_15EE
; ---------------------------------------------------------------------------
	bra.w   sub_1658
; ---------------------------------------------------------------------------
	bra.w   sub_16D2
; ---------------------------------------------------------------------------
	bra.w   sub_17E2
; ---------------------------------------------------------------------------
	bra.w   sub_17EC
; ---------------------------------------------------------------------------
	bra.w   sub_17F6
; ---------------------------------------------------------------------------
	bra.w   sub_1800
; ---------------------------------------------------------------------------
	bra.w   sendInt2ToSubCpu
; ---------------------------------------------------------------------------
	bra.w   playSegaAnimation
; ---------------------------------------------------------------------------
	bra.w   setVblankHandler
; ---------------------------------------------------------------------------
	bra.w   sub_CA0
; ---------------------------------------------------------------------------
	bra.w   sub_CC6
; ---------------------------------------------------------------------------
	bra.w   dmaCopyVram
; ---------------------------------------------------------------------------
	bra.w   sub_1730
; ---------------------------------------------------------------------------
	bra.w   sub_55AC
; ---------------------------------------------------------------------------
	bra.w   convertToBcd
; ---------------------------------------------------------------------------
	bra.w   displayBlack
; ---------------------------------------------------------------------------
	bra.w   fadeOutColors
; ---------------------------------------------------------------------------
	bra.w   fadeInColors
; ---------------------------------------------------------------------------
	bra.w   setFadeInTargetPalette
; ---------------------------------------------------------------------------
	bra.w   processDmaTransferQueue
; ---------------------------------------------------------------------------
	bra.w   sub_1A38
; ---------------------------------------------------------------------------
	bra.w   sub_1A76
; ---------------------------------------------------------------------------
	bra.w   sub_1A4E

; =============== S U B R O U T I N E =======================================


installErrorVectors:            ; CODE XREF: setupGenHardwarep
	lea (_EXCPT).w, a0
	move.w #INST_JMP, d0

	move.w d0, (a0)+
	move.l #sub_640, (a0)+

	move.w d0, (a0)+
	move.l #vblankHandler, (a0)+

	lea (_nullrte).w, a1

	moveq #17, d1
	@loc_3C2:
		move.w d0, (a0)+
		move.l a1, (a0)+
		dbf d1, @loc_3C2

	lea (errorReset).l, a1

	moveq #7, d1
	@loc_3D2:
		move.w d0, (a0)+
		move.l a1, (a0)+
		dbf d1, @loc_3D2

	move.w d0, (a0)+
	move.l #@locret_40C, (a0)+

	move.w d0, (a0)+
	move.l #sub_88F0, (a0)

	lea asc_40E(pc), a1 ; "RAM_CARTRIDG"
	lea (byte_400001).l, a2

	tst.b (a2)
	bpl.s @locret_40C

	lea $F(a2), a2

	moveq #5, d1
	@loc_3FE:
		cmpm.w (a1)+, (a2)+
		dbne d1, @loc_3FE

	bne.s @locret_40C

	move.l #byte_400020, (a0)

@locret_40C:
	rts
; End of function installErrorVectors

; ---------------------------------------------------------------------------
asc_40E:
	dc.b 'RAM_CARTRIDG'

; =============== S U B R O U T I N E =======================================

setVblankHandler:
	move.l a1, (_LEVEL6 + 2).w
	rts
; End of function setVblankHandler


; =============== S U B R O U T I N E =======================================

setVblankUserRoutine:
	move.l a1, (vblankUserRoutine + 2).w
	rts
; End of function setVblankUserRoutine

; ---------------------------------------------------------------------------

_start:
	tst.l ($A10008).l
	bne.s @loc_434

	tst.w ($A1000C).l

@loc_434:
	bne.w @loc_4C8

	lea     InitData(pc), a5
	movem.w (a5)+, d5-d7
	movem.l (a5)+, a0-a4

	move.b -$10FF(a1), d0
	andi.b #$F, d0
	beq.s  @loc_456

	move.l #'SEGA', $2F00(a1)

@loc_456:
	move.w (a4), d0
	moveq  #0, d0
	m_loadCramWriteAddress 0

	move.w #31, d1
	@loc_468:
		move.l  d0, (a3)
		dbf     d1, @loc_468

	movea.l d0, a6
	move.l  a6, usp

	moveq #23, d1
	@loc_474:
		move.b (a5)+, d5
		move.w d5, (a4)
		add.w  d7, d5
		dbf    d1, @loc_474

	move.l (a5)+, (a4)
	move.w d0, (a3)
	move.w d7, (a1)
	move.w d7, (a2)

	@loc_486:
		btst  d0, (a1)
		bne.s @loc_486

	moveq #37, d2
	@loc_48C:
		move.b (a5)+, (a0)+
		dbf    d2, @loc_48C

	move.w d0, (a2)
	move.w d0, (a1)
	move.w d7, (a2)

	@loc_498:
		move.l d0, -(a6)
		dbf    d6, @loc_498

	move.l (a5)+, (a4)
	move.l (a5)+, (a4)

	moveq #31, d3
	@loc_4A4:
		move.l d0, (a3)
		dbf    d3, @loc_4A4

	move.l (a5)+, (a4)

	moveq #19, d4
	@loc_4AE:
		move.l d0, (a3)
		dbf    d4, @loc_4AE

	moveq #3, d5
	@loc_4B6:
		move.b (a5)+, $11(a3)
		dbf    d5, @loc_4B6

	move.w  d0, (a2)
	movem.l (a6), d0-a6

	m_maskInterrupts 7

@loc_4C8:
	bra.s loc_536
; ---------------------------------------------------------------------------
InitData:
	dc.w $8000
	dc.w $3FFF
	dc.w $0100

	dc.l $A00000
	dc.l $A11100
	dc.l $A11200
	dc.l $C00000
	dc.l $C00004

	; VDP
	dc.b   4
	dc.b $14
	dc.b ($C000 >> 10)
	dc.b ($F000 >> 10)
	dc.b ($E000 >> 13)
	dc.b ($D800 >>  9)
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b $FF
	dc.b   0
	dc.b $81
	dc.b ($DC00 >> 10)
	dc.b   0
	dc.b   1
	dc.b   1
	dc.b   0
	dc.b   0
	dc.b $FF
	dc.b $FF
	dc.b   0
	dc.b   0
	dc.b $80

	dc.l $40000080

	; Z80 init program
	dc.b $AF                ; xor a
	dc.b $01, $D9, $1F      ; ld bc, 1FD9h
	dc.b $11, $27, $00      ; ld de, 0027h
	dc.b $21, $26, $00      ; ld hl, 0026h
	dc.b $F9                ; ld sp, hl
	dc.b $77                ; ld (hl), a
	dc.b $ED, $B0           ; ldir
	dc.b $DD, $E1           ; pop ix
	dc.b $FD, $E1           ; pop iy
	dc.b $ED, $47           ; ld i, a
	dc.b $ED, $4F           ; ld r, a
	dc.b $D1                ; pop de
	dc.b $E1                ; pop hl
	dc.b $F1                ; pop af
	dc.b $08                ; ex af, af'
	dc.b $D9                ; exx
	dc.b $C1                ; pop bc
	dc.b $D1                ; pop de
	dc.b $E1                ; pop hl
	dc.b $F1                ; pop af
	dc.b $F9                ; ld sp, hl
	dc.b $F3                ; di
	dc.b $ED, $56           ; im 1
	dc.b $36, $E9           ; ld (hl), 00E9h
	dc.b $E9                ; jp (hl)

	; VDP
	dc.w $8104
	dc.w $8F02
	dc.l $C0000000
	dc.l $40000010

	; PSG volume registers
	dc.b $9F
	dc.b $BF
	dc.b $DF
	dc.b $FF
; ---------------------------------------------------------------------------

loc_536:                ; CODE XREF: ROM:loc_4C8j
	tst.w (VDP_CONTROL).l

	m_disableInterrupts

	moveq #CD_NOTREADY, d1
	bsr.w setDiscType

	clr.b (byte_FFFFFE54).w

	btst  #JOYCTRL_PC6, (JOYCTRL3).l
	beq.s loc_598

	; Warm boot
	movea.l (InitialSSP).w, sp

	; Wait for DMA to finish
	@loc_558:
		move.w (VDP_CONTROL).l, d3
		btst   #VDP_DMA, d3
		bne.s  @loc_558

	bsr.w checkRegion

	movem.l d0-d1, -(sp)
	bsr.w   testCartBootBlock
	bne.w   sub_640             ; Boot block didn't match, bail out

	move.l  (_EXCPT+2).w, d0
	bcs.w   finishInit

bootCartridge:
	st    (byte_FFFFFE54).w
	bsr.w setupGenHardware

	move.w #INST_JMP, (_EXCPT).w
	move.l #finishInit,  (_EXCPT+2).w
	jmp    cartBoot
; ---------------------------------------------------------------------------

loc_598:                ; CODE XREF: ROM:00000552j
	; Cold boot
	jsr   (loadDefaultVdpRegs).w
	jsr   (clearAllVram).w

	bsr.w checkRegion

	bsr.w clearSubCpuPrg
	bsr.w clearWordRam2M

finishInit:                ; CODE XREF: ROM:00000578j sub_640+38j
	m_disableInterrupts

	bsr.w testCartBootBlock
	beq.s bootCartridge

	bsr.s finishHardwareInit

	moveq #1, d0
	moveq #4, d1
	jsr   sub_1800(pc)

	moveq #STATE_21F4, d0
	bsr.w setNextState

mainLoop:
	lea (nextState).w, a0

	move.w (a0), d0
	andi.w #$7FFC, d0

	jsr mainJumpTable(pc, d0.w)

	bra.s mainLoop
; ---------------------------------------------------------------------------

mainJumpTable:
	nop
	rts
; ---------------------------------------------------------------------------
	bra.w state_21F4
; ---------------------------------------------------------------------------
	bra.w state_3040
; ---------------------------------------------------------------------------
	bra.w loadPrgFromWordRam
; ---------------------------------------------------------------------------
	bra.w state_7374
; ---------------------------------------------------------------------------
	jmp workRamStart

; =============== S U B R O U T I N E =======================================


finishHardwareInit:                ; CODE XREF: ROM:000005B6p
	bsr.s setupGenHardware

	lea (_EXCPT).w, a0
	move.w #INST_JMP, (a0)+
	move.l #sub_640,  (a0)+

	jsr (waitForVblank).w

	bsr.w clearCommRegisters

	; Wait for sub-CPU to clear its comm flags
	lea (GA_COMM_SUBFLAGS).l, a4
	@loc_60E:
		move.b (a4), d0
		bne.s @loc_60E

	rts
; End of function finishHardwareInit


; =============== S U B R O U T I N E =======================================


setupGenHardware:           ; CODE XREF: ROM:00000580p finishHardwareInitp
	jsr   installErrorVectors(pc)
	bsr.w setupJoypads
	jsr   (loadZ80Prg).w
	bsr.w loadSubCpuPrg
	bsr.w loadDefaultVdpRegs

	; Set Palette0:Color0 to black
	clr.w (paletteBuffer0).w
	m_loadCramWriteAddress 0
	move.w #0, (VDP_DATA).l

	rts
; End of function setupGenHardware


; =============== S U B R O U T I N E =======================================


sub_640:                ; CODE XREF: ROM:00000280j
					; ROM:00000570j
	m_disableInterrupts

	move.b #$9F, (PSG_CTRL).l
	nop
	nop
	move.b #$BF, (PSG_CTRL).l
	nop
	nop
	move.b #$DF, (PSG_CTRL).l
	nop
	nop
	move.b #$FF, (PSG_CTRL).l

	jsr (loadDefaultVdpRegs).w
	jsr (clearAllVram).w

	bra.w finishInit
; End of function sub_640

; ---------------------------------------------------------------------------

loc_67C:                ; CODE XREF: ROM:0000028Cj
	m_disableInterrupts
	movea.l (InitialSSP).w, sp

loc_684:                ; CODE XREF: ROM:00000288j
	m_disableInterrupts

	jsr   (loadDefaultVdpRegs).w
	jsr   (clearAllVram).w
	jsr   installErrorVectors(pc)
	bsr.w setupJoypads
	jsr   (loadZ80Prg).w
	bsr.w detectControllerChange
	bsr.w loadSubCpuPrg

	jsr (waitForVblank).w

	bsr.w clearCommRegisters

	; Wait for sub-CPU to clear its comm flags
	lea (GA_COMM_SUBFLAGS).l, a4
	@loc_6B2:
		move.b (a4), d0
		bne.s  @loc_6B2

	bsr.w sub_16C4

	moveq #1, d0
	moveq #8, d1
	jsr   sub_1800(pc)

	moveq #STATE_3040, d0
	bsr.s setNextState
	bra.w mainLoop

; =============== S U B R O U T I N E =======================================


setNextState:
	andi.w #$1C, d0
	move.w d0, (nextState).w
	rts
; End of function setNextState


; =============== S U B R O U T I N E =======================================


clearSubCpuPrg:             ; CODE XREF: ROM:000005A4p
	lea (GA_RESET_HALT).l, a5
	lea 1(a5), a6

	@WaitForBus:
		bset  #GA_SBRQ, (a5)    ; Request sub-CPU bus
		beq.s @WaitForBus

	move.w  (a6), d5
	moveq   #0, d7

	andi.w  #2, d5
	ori.w   #$40, d5
	move.w  d5, (a6)
	bsr.s   fillSubCpuBank

	andi.w  #2, d5
	ori.w   #$80, d5
	move.w  d5, (a6)
	bsr.s   fillSubCpuBank

	andi.w  #2, d5
	ori.w   #$C0, d5
	move.w  d5, (a6)
	bsr.s   fillSubCpuBank

	andi.w  #2, d5
	move.w  d5, (a6)


; =============== S U B R O U T I N E =======================================


fillSubCpuBank:
	lea (SubCPU_Bank).l, a0
	move.w  #$7FFF, d0

	@FillLoop:
		move.l  d7, (a0)+
		dbf d0, @FillLoop

	rts
; End of function fillSubCpuBank

; End of function clearSubCpuPrg


; =============== S U B R O U T I N E =======================================


loadSubCpuPrg:              ; CODE XREF: setupGenHardware+Cp
	lea (GA_RESET_HALT).l, a5

	; Place sub-CPU in RESET state
	@loc_72A:
		bclr  #GA_SRES, (a5)
		bne.s @loc_72A

	; Switch to sub-CPU bank 0
	lea 1(a5), a6
	move.w (a6), d5
	andi.w #2, d5
	move.w d5, (a6)

	; Decompress the sub-CPU program into RAM
	lea (SubCPU_Prog0).l, a0
	lea (SubCPU_Base0).l, a1
	bsr.w decompressKosinski

	lea (SubCPU_Prog1).l, a0
	lea (SubCPU_Base1).l, a1
	bsr.w decompressKosinski

	lea (SubCPU_Prog2).l, a0
	lea (SubCPU_Base2).l, a1
	bsr.w decompressKosinski

	; Write-protect sub-CPU PRG_RAM $0-$5400
	move.b #$2A, (a6)

	; Release sub-CPU from RESET state
	@loc_770:
		bset  #GA_SRES, (a5)
		beq.s @loc_770

	; Release sub-CPU bus
	@loc_776:
		bclr  #GA_SBRQ, (a5)
		bne.s @loc_776

	rts
; End of function loadSubCpuPrg


; =============== S U B R O U T I N E =======================================


clearWordRam2M:             ; CODE XREF: ROM:000005A8p
	; Return if WordRAM in 1M mode
	btst  #GA_MODE, 1(a6)
	bne.s locret_79E

	; Return if sub-CPU has WordRAM
	btst  #GA_RET, 1(a6)
	beq.s locret_79E

	lea (WordRAM_Bank0).l, a0
	moveq #$FFFFFFFF, d0
	moveq #0, d7

	; Clear out all 256 KiB
	@loc_798:
		move.l d7, (a0)+
		dbf d0, @loc_798

locret_79E:
	rts
; End of function clearWordRam2M


; =============== S U B R O U T I N E =======================================


checkRegion:
	move.b (MD_VERSION).l, d0
	andi.b #$C0, d0
	cmpi.b #$80, d0
	bne.s  @regionMismatch
	rts
; ---------------------------------------------------------------------------

@regionMismatch:
	m_disableInterrupts

	jsr loadDefaultVdpRegs(pc)
	jsr loadDefaultFont(pc)

	lea regionErrorText(pc), a1

	m_loadCramWriteAddress 0
	move.l (a1)+, (VDP_DATA).l

	m_loadVramWriteAddress $C606, d0
	jsr writeTextToScreen(pc)

	jsr displayOn(pc)

	; Infinite loop while displaying error
	@loc_7E0:
		bra.s @loc_7E0
; End of function checkRegion

; ---------------------------------------------------------------------------
regionErrorText:
	dc.w $EE0
	dc.w $000
	dc.b '              ERROR!',0
	dc.b 0
	dc.b 'THIS IS AN NTSC-COMPATIBLE SEGA-CD',0
	dc.b 'FOR USE IN NTSC REGIONS OTHER THAN',0
	dc.b '     JAPAN AND SOUTHEAST ASIA.'
	dc.b $FF, 0

; =============== S U B R O U T I N E =======================================

; Decompression routine for Kosinski data format.
	include "compression\kosinski.asm"

; =============== S U B R O U T I N E =======================================


_nullrte:                ; DATA XREF: installErrorVectors+18o
	rte
; End of function _nullrte


; =============== S U B R O U T I N E =======================================


vblankHandler:
	movem.l d0-a6, -(sp)

	bsr.w sub_15EE

	tst.b (byte_FFFFFE28).w
	bne.s @loc_926

	bsr.w dmaTransferPalettes

	btst  #1, (vblankCode).w
	beq.s @loc_926

	jsr vblankUserRoutine
	addq.b #1, (byte_FFFFFE27).w

@loc_926:
	bsr.w detectControllerChange
	bsr.w readAllControllers

	clr.b (vblankCode).w

	bsr.w sub_1658
	bsr.w checkDiscReady

	movem.l (sp)+, d0-a6
	rte
; End of function vblankHandler


; =============== S U B R O U T I N E =======================================


altVblankHandler:           ; CODE XREF: ROM:00000290j
	movem.l d0-a6, -(sp)

	bsr.w sub_15EE

	tst.b (byte_FFFFFE28).w
	bne.s @loc_962

	bsr.w dmaTransferPalettes

	btst  #1, (vblankCode).w
	beq.s @loc_962

	jsr vblankUserRoutine
	addq.b  #1, (byte_FFFFFE27).w

@loc_962:
	bsr.w readJoypads
	clr.b (vblankCode).w

	movem.l (sp)+, d0-a6
	rte
; End of function altVblankHandler


; =============== S U B R O U T I N E =======================================


waitForVblank:              ; CODE XREF: ROM:00000308j finishHardwareInit+10p ...
	m_disableInterrupts
	moveq #3, d0

loc_976:                ; CODE XREF: ROM:00000304j
	move.b d0, (vblankCode).w
	m_enableInterrupts

	@loc_97E:
		tst.b (vblankCode).w
		bne.s @loc_97E

	bsr.w rand
	rts
; End of function waitForVblank


; =============== S U B R O U T I N E =======================================


enableUserHInt:             ; CODE XREF: ROM:00000314j
	move.l a1, (_LEVEL4+2).w
	move.w a1, (GA_HINT_VECTOR).l

	bset   #4, (vdpRegCache+1).w
	move.w (vdpRegCache).w, (VDP_CONTROL).l
	rts
; End of function enableUserHInt


; =============== S U B R O U T I N E =======================================


enableDefaultHInt:          ; CODE XREF: ROM:00000294j
	move.l a1, (_LEVEL4+2).w
	move.w #$FD0C, (GA_HINT_VECTOR).l

	bset   #4, (vdpRegCache+1).w
	move.w (vdpRegCache).w, (VDP_CONTROL).l
	rts
; End of function enableDefaultHInt


; =============== S U B R O U T I N E =======================================


disableHInt:                ; CODE XREF: ROM:00000318j
	bclr   #4, (vdpRegCache+1).w
	move.w (vdpRegCache).w, (VDP_CONTROL).l
	rts
; End of function disableHInt


; =============== S U B R O U T I N E =======================================


loadDefaultVdpRegs:         ; CODE XREF: ROM:000002ACj
	lea defaultVdpRegs(pc), a1
	move.w #$80, (vdpLineIncrement).w

loadVdpRegs:                ; CODE XREF: ROM:000002B0j
	lea (vdpRegCache).w, a2

	moveq #0, d0
	@loc_9E0:
		move.b (a1), d0
		bpl.s  @locret_9FA

		move.w (a1)+, d1
		cmpi.b #$92, d0
		bhi.s  @loc_9F2

		add.b  d0, d0
		move.w d1, (a2, d0.w)

	@loc_9F2:
		move.w d1, (VDP_CONTROL).l
		bra.s  @loc_9E0
; ---------------------------------------------------------------------------

@locret_9FA:
	rts
; End of function loadDefaultVdpRegs

; ---------------------------------------------------------------------------
defaultVdpRegs:
	dc.w $8004  ; Reg #00: H-int off, H/V counter active
	dc.w $8124  ; Reg #01: Display/DMA off, V-int on, V28-cell (NTSC) mode
	dc.w $9011  ; Reg #16: Scroll plane size 64x64 cells
	dc.w $8B00  ; Reg #11: Ext. Int off, H/V full scroll mode
	dc.w $8C81  ; Reg #12: H40-cell mode, Shadow/hilight off, no interlace
	dc.w $8328  ; Reg #03: Window pattern table $A000
	dc.w $8230  ; Reg #02: Scroll A pattern table $C000
	dc.w $8407  ; Reg #04: Scroll B pattern table $E000
	dc.w $855C  ; Reg #05: Sprite attribute table $B800
	dc.w $8D2F  ; Reg #13: H-scroll table $BC00
	dc.w $8700  ; Reg #07: Background color palette 0, color 0
	dc.w $8A00  ; Reg #10: H-interrupt every line (skip 0)
	dc.w $8F02  ; Reg #15: Auto-increment VDP set to 2
	dc.w $9100  ; Reg #17: Window H position set to 0
	dc.w $9200  ; Reg #18: Window V position set to 0
	dc.w 0

; =============== S U B R O U T I N E =======================================


clearAllVram:               ; CODE XREF: ROM:000002A0j
	; Set Palette0:Color0 to black
	m_loadCramWriteAddress 0
	move.w #0, (VDP_DATA).l

	bsr.w clearVsram

	; DMA fill VRAM with 0
	m_loadVramWriteAddress 0, d0
	move.w #$FFFF, d1
	bra.w  dmaClearVramSegment
; End of function clearAllVram


; =============== S U B R O U T I N E =======================================


clearVdpPatternTables:          ; CODE XREF: ROM:000002A4j
	bsr.s clearSpriteTable
	bsr.w dmaClearScrollTableA
	bsr.w dmaClearScrollTableB
	bra.w dmaClearWindowTable
; End of function clearVdpPatternTables


; =============== S U B R O U T I N E =======================================

; Clear VRAM dword at $BC00

clearHScrollTable:
	m_loadVramWriteAddress $BC00
	move.l #0, (VDP_DATA).l
	rts
; End of function clearHScrollTable


; =============== S U B R O U T I N E =======================================

; Clear VRAM dword at $B800

clearSpriteTable:           ; CODE XREF: clearVdpPatternTablesp
	clr.l  (spriteTable).w

	m_loadVramWriteAddress $B800
	move.l #0, (VDP_DATA).l
	rts
; End of function clearSpriteTable


; =============== S U B R O U T I N E =======================================


clearVsram:             ; CODE XREF: ROM:000002A8j
					; clearAllVram+12p
	m_loadVsramWriteAddress 0, d0
	moveq #39, d1

clearVramSegment:           ; CODE XREF: ROM:000002B8j
	moveq #0, d2

fillVramSegment:            ; CODE XREF: ROM:000002B4j
	move.l d0, (VDP_CONTROL).l

	@loc_A8E:
		move.w d2, (VDP_DATA).l
		dbf    d1, @loc_A8E

	rts
; End of function clearVsram


; =============== S U B R O U T I N E =======================================

; Clear VRAM from $A000-$ADFF

dmaClearWindowTable:            ; CODE XREF: clearVdpPatternTables+Aj
	m_loadVramWriteAddress $A000, d0
	move.w #$DFF, d1
	bra.s  dmaClearVramSegment
; End of function dmaClearWindowTable


; =============== S U B R O U T I N E =======================================

; Clear VRAM from $C000-$DFFF

dmaClearScrollTableA:           ; CODE XREF: clearVdpPatternTables+2p
	m_loadVramWriteAddress $C000, d0
	bra.s loc_AB4
; End of function dmaClearScrollTableA


; =============== S U B R O U T I N E =======================================

; Clear VRAM from $E000-$FFFF

dmaClearScrollTableB:           ; CODE XREF: clearVdpPatternTables+6p
	m_loadVramWriteAddress $E000, d0

loc_AB4:                ; CODE XREF: dmaClearScrollTableA+6j
	move.w #$1FFF, d1
; End of function dmaClearScrollTableB


dmaClearVramSegment:            ; CODE XREF: ROM:000002BCj
	moveq #0, d2

; =============== S U B R O U T I N E =======================================

; Input parameters:
; d0 - Fill address
; d1 - DMA length
; d2 - Fill value

dmaFillVramSegment:         ; CODE XREF: ROM:000002C0j
	lea (VDP_CONTROL).l, a6

	; Set auto-increment 1
	move.w #$8F01, (a6)

	; Enable DMA
	move.w (vdpRegCache+2).w, d3
	bset   #4, d3
	move.w d3, (a6)

	move.l #$940000, d3
	move.w d1, d3
	lsl.l  #8, d3
	move.w #$9300, d3
	move.b d1, d3
	move.l d3, (a6)

	move.w #$9780, (a6)
	ori.l  #$40000080, d0
	move.l d0, (a6)

	move.b d2, -4(a6)

	; Wait for DMA to finish
	@dmaWaitLoop:
		move.w (a6), d3
		btst   #VDP_DMA, d3
		bne.s  @dmaWaitLoop

	; Disable DMA
	move.w (vdpRegCache+2).w, (a6)

	; Set auto-increment 2
	move.w #$8F02, (a6)
	rts
; End of function dmaFillVramSegment


; =============== S U B R O U T I N E =======================================

; Input parameters:
; d0 - Dest address
; d1 - Source address
; d2 - DMA length

dmaTransferToVram:          ; CODE XREF: ROM:000002D0j
	lea (VDP_CONTROL).l,a6

	; Enable DMA
	move.w (vdpRegCache+2).w, d3
	bset   #4, d3
	move.w d3, (a6)

	asr.l  #1, d1

	; Set transfer word count
	move.l #$940000, d3
	move.w d2, d3
	lsl.l  #8, d3
	move.w #$9300, d3
	move.b d2, d3
	move.l d3, (a6)

	; Set source address
	move.l #$960000, d3
	move.w d1, d3
	lsl.l  #8, d3
	move.w #$9500, d3
	move.b d1, d3
	move.l d3, (a6)

	swap   d1
	move.w #$9700, d3
	move.b d1, d3
	move.w d3, (a6)

	; Set destination address
	ori.l  #$40000080, d0
	swap   d0
	move.w d0, (a6)

	swap   d0
	move.w d0, -(sp)
	move.w (sp)+, (a6)

	; Disable DMA
	move.w (vdpRegCache+2).w, (a6)
	rts
; End of function dmaTransferToVram


; =============== S U B R O U T I N E =======================================

; Input parameters:
; d0 - Dest address
; d1 - Source address
; d2 - DMA length

dmaTransferToVramWithRewrite:       ; CODE XREF: ROM:000002D4j processDmaTransferQueue+8p ...
	move.l  a1, -(sp)

	movea.l d1, a1
	addq.l  #2, d1
	asr.l   #1, d1

	lea (VDP_CONTROL).l, a6

	; Set auto-increment to 2
	move.w  #$8F02, (a6)

	; Enable DMA operation
	move.w  (vdpRegCache+2).w, d3
	bset    #4, d3
	move.w  d3, (a6)

	; Set transfer count
	move.l  #$940000, d3
	move.w  d2, d3
	lsl.l   #8, d3
	move.w  #$9300, d3
	move.b  d2, d3
	move.l  d3, (a6)

	; Set source
	move.l  #$960000, d3
	move.w  d1, d3
	lsl.l   #8, d3
	move.w  #$9500, d3
	move.b  d1, d3
	move.l  d3, (a6)

	swap    d1
	move.w  #$9700, d3
	move.b  d1, d3
	move.w  d3, (a6)

	; Set destination
	ori.l   #$40000080, d0
	swap    d0
	move.w  d0, (a6)

	swap    d0
	move.w  d0, -(sp)
	move.w  (sp)+, (a6)

	; Disable DMA operation
	move.w  (vdpRegCache+2).w, (a6)

	; Rewrite the first dword (I don't know why)
	andi.w  #$FF7F, d0
	move.l  d0, (a6)

	move.l  (a1), -4(a6)

	; Reset previous auto-increment
	move.w  (vdpRegCache+$1E).w, (a6)

	movea.l (sp)+, a1
	rts
; End of function dmaTransferToVramWithRewrite


; =============== S U B R O U T I N E =======================================

; Input parameters:
; d0 - Dest address
; d1 - Source address
; d2 - DMA length

dmaCopyVram:                ; CODE XREF: ROM:00000374j
	lea (VDP_CONTROL).l, a6

	move.w #$8F01, (a6)

	move.w (vdpRegCache+2).w, d3
	bset   #4, d3
	move.w d3, (a6)

	move.l #$940000, d3
	move.w d2, d3
	lsl.l  #8, d3
	move.w #$9300, d3
	move.b d2, d3
	move.l d3, (a6)

	move.l #$960000, d3
	move.w d1, d3
	lsl.l  #8, d3
	move.w #$9500, d3
	move.b d1, d3
	move.l d3, (a6)

	move.w #$97C0, (a6)

	ori.w  #$C0, d0
	move.l d0, (a6)

	; Wait for DMA to finish
	@dmaWaitLoop:
		move.w (a6), d3
		btst   #1, d3
		bne.s  @dmaWaitLoop

	move.w (vdpRegCache+2).w, (a6)

	move.w #$8F02, (a6)
	rts
; End of function dmaCopyVram


; =============== S U B R O U T I N E =======================================


readFromVram:
	move.l d0, (VDP_CONTROL).l

	@loc_C22:
		move.w (VDP_DATA).l, (a2)+
		dbf d1, @loc_C22

	rts
; End of function readFromVram


; =============== S U B R O U T I N E =======================================

; Inputs:
; d0: VDP-formatted address
; d1: Column count
; d2: Line count
; a1: Data source

writeTilemapToVram:             ; CODE XREF: ROM:000002C4j
					; sub_1CFA+70p ...
	lea (VDP_DATA).l, a5

	move.w #0, -(sp)
	move.w (vdpLineIncrement).w, -(sp)

	@loc_C3C:
		move.l d0, 4(a5)

		move.w d1, d3
		@loc_C42:
			move.w (a1)+, (a5)
			dbf    d3, @loc_C42

		add.l (sp), d0
		dbf   d2, @loc_C3C

	addq.w #4, sp
	rts
; End of function writeTilemapToVram


; =============== S U B R O U T I N E =======================================

; Inputs:
; d0: VDP-formatted address
; d1: Columns
; d2: Lines
; d3: Template word
; a1: Source data

sub_C52:                ; CODE XREF: ROM:000002C8j
	lea (VDP_DATA).l, a5

	move.w #0, -(sp)
	move.w (vdpLineIncrement).w, -(sp)

	@loc_C60:
		move.l d0, 4(a5)

		move.w d1, d4
		@loc_C66:
			move.b (a1)+, d3
			move.w d3, (a5)
			dbf    d4, @loc_C66

		add.l (sp), d0
		dbf   d2, @loc_C60

	addq.w #4, sp
	rts
; End of function sub_C52


; =============== S U B R O U T I N E =======================================

; Inputs:
; d0: VDP-formatted address
; d1: Columns
; d2: Lines
; d3: OR mask
; a1: Source data

sub_C78:                ; CODE XREF: sub_5764+60p
	lea (VDP_DATA).l, a5

	move.w #0, -(sp)
	move.w (vdpLineIncrement).w, -(sp)

	@loc_C86:
		move.l d0, 4(a5)

		move.w d1, d5
		@loc_C8C:
			move.w (a1)+, d4
			or.w   d3, d4
			move.w d4, (a5)
			dbf    d5, @loc_C8C

		add.l (sp), d0
		dbf   d2, @loc_C86

	addq.w #4,sp
	rts
; End of function sub_C78


; =============== S U B R O U T I N E =======================================


sub_CA0:                ; CODE XREF: ROM:0000036Cj
	lea (VDP_DATA).l, a5

	move.w #0, -(sp)
	move.w (vdpLineIncrement).w, -(sp)

	@loc_CAE:
		move.l d0, 4(a5)

		move.w d1, d4
		@loc_CB4:
			move.w d3, (a5)
			addq.w #1, d3
			dbf    d4, @loc_CB4

		add.l (sp), d0
		dbf   d2, @loc_CAE

	addq.w #4, sp
	rts
; End of function sub_CA0


; =============== S U B R O U T I N E =======================================


sub_CC6:                        ; CODE XREF: ROM:00000370j
	lea (VDP_DATA).l,a5

	move.w #0, -(sp)
	move.w (vdpLineIncrement).w, -(sp)

	sub.w  d1, d3
	sub.w  d1, d3
	subq.w #2, d3

	@loc_CDA:
		move.l d0, 4(a5)

		move.w d1, d4
		@loc_CE0:
			move.w (a1)+, (a5)
			dbf    d4, @loc_CE0

		adda.w d3,   a1
		add.l  (sp), d0
		dbf    d2, @loc_CDA

	addq.w #4, sp
	rts
; End of function sub_CC6


; =============== S U B R O U T I N E =======================================

; Inputs:
; d0: VDP-formatted address
; d1: Column count
; d2: Line count
; d3: Fill word

fillVramTilemap:                ; CODE XREF: ROM:000002CCj
	lea (VDP_DATA).l, a5

	move.w  #0, -(sp)
	move.w  (vdpLineIncrement).w, -(sp)

	@loc_D00:
		move.l d0, 4(a5)

		move.w d1, d5
		@loc_D06:
			move.w d3, (a5)
			dbf    d5, @loc_D06

		add.l (sp), d0
		dbf   d2, @loc_D00

	addq.w #4, sp
	rts
; End of function fillVramTilemap


; =============== S U B R O U T I N E =======================================


displayOn:                      ; CODE XREF: ROM:000002D8j
	bset  #6, (vdpRegCache+3).w
	bra.s loc_D36
; ---------------------------------------------------------------------------

displayBlack:                   ; CODE XREF: ROM:00000384j
	m_loadCramWriteAddress 0
	move.w #0, (VDP_DATA).l

displayOff:                     ; CODE XREF: ROM:000002DCj
	bclr #6, (vdpRegCache+3).w

loc_D36:
	move.w (vdpRegCache+2).w, (VDP_CONTROL).l
	rts
; End of function displayOn


; =============== S U B R O U T I N E =======================================


loadPalettesToBuffer:           ; CODE XREF: ROM:000002E4j
	bset #0, (vdpUpdateFlags).w

loadPalettesNoUpdate:           ; CODE XREF: ROM:000002E0j
	move.l  a3, -(sp)

	moveq   #0,    d0
	move.b  (a1)+, d0

	lea (paletteBuffer0).w, a3
	adda.w d0, a3

	move.b (a1)+, d0
	@loc_D54:
		move.w (a1)+, (a3)+
		dbf d0, @loc_D54

	movea.l (sp)+, a3
	rts
; End of function loadPalettesToBuffer


; =============== S U B R O U T I N E =======================================


dmaTransferPalettes:            ; CODE XREF: ROM:000002E8j
	bclr  #0, (vdpUpdateFlags).w
	beq.s @locret_DC2

	lea (VDP_CONTROL).l, a4

	; Enable DMA
	move.w (vdpRegCache+2).w, d4
	bset   #4, d4
	move.w d4, (a4)

	m_saveStatusRegister
	m_disableInterrupts
	m_z80RequestBus

	move.l #$94009340, (a4)            ; $40 words (128 bytes)

	move.l #$96FD95C0, (a4)            ; Source address: $FFFB80
	move.w #$977F, (a4)

	move.w #$C000, (a4)                ; Dest address: CRAM $0000
	move.w #$80, -(sp)

	m_z80WaitForBus

	move.w (sp)+, (a4)

	m_z80ReleaseBus

	; Disable DMA
	move.w (vdpRegCache+2).w, (a4)

	m_loadCramWriteAddress 0, (a4)
	move.w (paletteBuffer0).w, -4(a4)

	m_restoreStatusRegister

@locret_DC2:
	rts
; End of function dmaTransferPalettes


; =============== S U B R O U T I N E =======================================

; Input:
; d0: Color offset
; d1: Color count

fadeOutColors:                  ; CODE XREF: ROM:00000388j
	movem.l d0-d5/a0, -(sp)

	lea (paletteBuffer0).w, a0
	adda.w d0, a0

	moveq #0, d0

	@loc_DD0:
		moveq  #$E, d2

		move.w (a0), d3
		move.w d3, d4

		and.b  d2, d4
		beq.s  @loc_DDC

		subq.w #2, d3

	@loc_DDC:
		move.w #$E0, d2

		move.w d3, d4

		and.b  d2, d4
		beq.s  @loc_DEA

		subi.w #$20, d3

	@loc_DEA:
		move.w #$E00, d2

		and.w  d2, d4
		beq.s  @loc_DF6

		subi.w #$200, d3

	@loc_DF6:
		move.w d3, (a0)+
		or.w   d3, d0

		dbf d1, @loc_DD0

	bset #0, (vdpUpdateFlags).w

	tst.w d0

	movem.l (sp)+, d0-d5/a0
	rts
; End of function fadeOutColors


; =============== S U B R O U T I N E =======================================


setFadeInTargetPalette:                ; CODE XREF: ROM:00000390j
	move.b (a1)+, (paletteFadeInOffset).w
	move.b (a1)+, (paletteFadeInCount).w

	move.l a1, (paletteFadeInTarget).w

	move.w #$E, (paletteFadeInIncrement).w
	rts
; End of function setFadeInTargetPalette


; =============== S U B R O U T I N E =======================================


fadeInColors:                ; CODE XREF: ROM:0000038Cj
	movem.l d0-d4/a0-a1, -(sp)

	moveq  #0, d0
	move.b (paletteFadeInOffset).w, d0

	lea     (paletteBuffer0).w, a1
	adda.w  d0, a1

	move.b  (paletteFadeInCount).w,  d0
	movea.l (paletteFadeInTarget).w, a0

	@loc_E38:
		move.w (paletteFadeInIncrement).w, d1

		move.w (a0)+, d2
		move.w d2, d3
		andi.w #$E, d3

		sub.w  d1, d3
		bpl.s  @loc_E4A

		moveq  #0, d3

	@loc_E4A:
		asl.w  #4, d1

		move.w d2, d4
		andi.w #$E0, d4

		sub.w  d1, d4
		bpl.s  @loc_E58

		moveq  #0, d4

	@loc_E58:
		asl.w  #4, d1

		andi.w #$E00, d2

		sub.w  d1, d2
		bpl.s  @loc_E64

		moveq  #0, d2

	@loc_E64:
		or.w   d4, d3
		or.w   d3, d2
		move.w d2, (a1)+

		dbf d0, @loc_E38

	tst.w  (paletteFadeInIncrement).w
	beq.s  @loc_E78

	subq.w #2, (paletteFadeInIncrement).w

@loc_E78:
	; Signal palette update needed
	bset #0, (vdpUpdateFlags).w

	movem.l (sp)+, d0-d4/a0-a1
	rts
; End of function fadeInColors


; =============== S U B R O U T I N E =======================================

; Nemesis decompressor
	include "compression\nemesis.asm"

; =============== S U B R O U T I N E =======================================

loadZ80Prg:             ; CODE XREF: setupGenHardware+8p
					; ROM:00000698p
	lea (Z80_BUSREQ).l, a4

	m_saveStatusRegister
	m_disableInterrupts

	move.w  #$100,     (a4)
	move.w  #$100, $100(a4)

	@loc_FD6:
		btst  #0, (a4)
		bne.s @loc_FD6

	lea    (Z80_RAM_Base0).l, a6
	lea    (Z80_PRG_Base0).l, a5
	move.w #3231,d7
	@loc_FEC:
		move.b (a5)+, (a6)+
		dbf d7, @loc_FEC

	lea    (Z80_RAM_Base1).l, a6
	lea    (Z80_PRG_Base1).l, a5
	move.w #377,d7
	@loc_1002:
		move.b (a5)+, (a6)+
		dbf d7, @loc_1002

	lea    (Z80_RAM_Base2).l, a6
	lea    (Z80_PRG_Base2).l, a5
	move.w #1209, d7
	@loc_1018:
		move.b (a5)+, (a6)+
		dbf d7, @loc_1018

	move.w  #0,    $100(a4)
	move.w  #0,        (a4)
	move.w  #$100, $100(a4)

	m_restoreStatusRegister
	rts
; End of function loadZ80Prg


; =============== S U B R O U T I N E =======================================


loadZ80Prg0:                ; CODE XREF: playSegaAnimation+A6p
	lea (Z80_BUSREQ).l, a4

	m_saveStatusRegister
	m_disableInterrupts

	move.w #$100,     (a4)
	move.w #$100, $100(a4)

	@loc_1048:
		btst  #0, (a4)
		bne.s @loc_1048

	lea (Z80_RAM_Base0).l, a6
	lea (Z80_PRG_Base0).l, a5

	move.w #377, d7
	@loc_105E:
		move.b (a5)+, (a6)+
		dbf d7, @loc_105E

	move.w #0,    $100(a4)
	move.w #0,        (a4)
	move.w #$100, $100(a4)

	m_restoreStatusRegister
	rts
; End of function loadZ80Prg0


; =============== S U B R O U T I N E =======================================


copyToZ80Ram:               ; CODE XREF: playSegaAnimation+A2p
	m_saveStatusRegister
	m_disableInterrupts
	m_z80RequestBus

	@loc_1086:
		move.b (a1)+, (a0)+
		dbf d0, @loc_1086

	m_z80ReleaseBus
	m_restoreStatusRegister
	rts
; End of function copyToZ80Ram


; =============== S U B R O U T I N E =======================================


; Temporary name until I find out what the command E3 does.
sendE3ToZ80:
	move.b #Z80CMD_E3, d7

sendCommandToZ80:
	m_saveStatusRegister
	m_disableInterrupts
	m_z80RequestBus
	m_z80WaitForBus

	move.b d7, (byte_A01C0A).l

	m_z80ReleaseBus
	m_restoreStatusRegister
	rts
; End of function sendE3ToZ80


; =============== S U B M O D U L E =========================================


	; Controller processing
	include "submodules\joypads.asm"


; =============== S U B M O D U L E =========================================


	; Inter-CPU communication
	include "submodules\comm.asm"


; =============== S U B R O U T I N E =======================================

; Copy sprite table from RAM ($FFF900) to VRAM ($B800)

dmaSendSpriteTable:         ; CODE XREF: ROM:0000030Cj
	btst  #0, (vblankCode).w
	beq.s @locret_18CC

	lea (VDP_CONTROL).l, a4

	; Enable DMA
	move.w (vdpRegCache+2).w, d4
	bset   #4, d4
	move.w d4, (a4)

	m_saveStatusRegister
	m_disableInterrupts
	m_z80RequestBus

	move.l #$94019340, (a4)             ; $140 words (640 bytes)

	move.l #$96FC9580, (a4)             ; Source address: $FFF900
	move.w #$977F, (a4)

	move.w #$7800, (a4)                 ; Dest address: VRAM $B800
	move.w #$0082, -(sp)

	m_z80WaitForBus

	move.w (sp)+, (a4)

	m_z80ReleaseBus

	; Disable DMA
	move.w (vdpRegCache+2).w, (a4)

	m_loadVramWriteAddress $B800, (a4)
	move.w (spriteTable).w, -4(a4)

	m_restoreStatusRegister

@locret_18CC:
	rts
; End of function dmaSendSpriteTable


; =============== S U B R O U T I N E =======================================

; Inputs:
; d0: Joypad 0/1
; a1:

handleDpadRepeat:               ; CODE XREF: ROM:0000032Cj
	move.l  a5, -(sp)

	move.w  (joy1Down).w, d1

	tst.w   d0
	beq.s   @loc_18DC

	move.w  (joy2Down).w, d1

@loc_18DC:
	lea (joy1RepeatDelay).w, a5
	adda.w d0, a5

	; Check for D-pad trigger
	andi.b #$0F, d1
	bne.s  @loc_18FA

	; No trigger, check for D-pad hold
	andi.w #$0F00, d1
	beq.s  @loc_18FE

	; Direction is held
	subq.b #1, (a5)
	bpl.s  @loc_18FE

	move.b #5, (a5)

	lsr.w  #8, d1
	bra.s  @loc_18FE
; ---------------------------------------------------------------------------

@loc_18FA:
	; D-pad triggered
	move.b #$14, (a5)

@loc_18FE:
	move.b  d1, (a1)

	movea.l (sp)+, a5
	rts
; End of function handleDpadRepeat


; =============== S U B R O U T I N E =======================================


sub_1904:               ; CODE XREF: ROM:00000310j
	lsr.l  #2, d0
	move.w d0, d1
	swap   d0
	subq.w #1, d1

	@loc_190C:
		move.l (a0)+, (a1)+
		dbf d1, @loc_190C
		dbf d0, @loc_190C

	jmp (a2)
; End of function sub_1904


; =============== S U B R O U T I N E =======================================


writeTextToScreen:          ; CODE XREF: ROM:0000031Cj
	move.w (fontTileOffset).w, d1
	lea (VDP_DATA).l, a5

@loc_1922:
	move.l  d0, 4(a5)

@loc_1926:
	moveq   #0, d2
	move.b  (a1)+, d2
	bmi.s   @returnFinished
	beq.s   @newLine

	add.w   d1, d2
	move.w  d2, (a5)
	bra.s   @loc_1926
; ---------------------------------------------------------------------------

@newLine:
	swap    d0
	add.w   (vdpLineIncrement).w, d0
	swap    d0
	bra.s   @loc_1922
; ---------------------------------------------------------------------------

@returnFinished:
	rts
; End of function writeTextToScreen


; =============== S U B R O U T I N E =======================================


loadDefaultFont:            ; CODE XREF: ROM:00000328j
	m_loadVramWriteAddress $400, d0
	move.w #0, (fontTileOffset).w
	move.l #$00011011, d1

loc_1952:               ; CODE XREF: ROM:00000324j
	move.l d0, d2
	lea (defaultFontData).l, a1
	move.w #96, d2

loadFont:               ; CODE XREF: ROM:00000320j
	asl.w  #2, d2
	subq.w #1, d2

	lea (VDP_DATA).l, a5
	move.l d0, 4(a5)
	move.l d1, -(sp)

	@loc_196E:
		move.w (a1)+, d1

		bsr.s  loc_198E
		bsr.s  sub_198C
		bsr.s  sub_198C
		bsr.s  sub_198C
		move.l d3, (a5)

		bsr.s  loc_198E
		bsr.s  sub_198C
		bsr.s  sub_198C
		bsr.s  sub_198C
		move.l d3, (a5)

		dbf d2, @loc_196E

	move.l (sp)+, d1
	rts
; End of function loadDefaultFont


; =============== S U B R O U T I N E =======================================


sub_198C:
	rol.l   #8, d3

loc_198E:
	rol.w   #2, d1
	move.w  d1, d4
	andi.w  #3, d4
	move.b  4(sp, d4.w), d3
	rts
; End of function sub_198C


; =============== S U B R O U T I N E =======================================

; Inputs:
;   d0: VDP address
;   d1: Columns - 1
;   d2: Rows - 1
;   d3: Pattern descriptor for first tile

writeTransposedTilemapToVram:           ; CODE XREF: ROM:00000334j
	lea (VDP_DATA).l, a5

	move.w d2, d6
	addq.w #1, d6

	@loc_19A6:
		move.w d3, d5

		; Set VDP write address
		move.l d0, 4(a5)

		move.w d1, d4
		@loc_19AE:
			move.w d5, (a5)
			add.w  d6, d5
			dbf    d4, @loc_19AE

		addq.w #1, d3

		; Go to next row
		swap  d0
		add.w (vdpLineIncrement).w, d0
		swap  d0

		dbf d2, @loc_19A6

	rts
; End of function writeTransposedTilemapToVram


; =============== S U B R O U T I N E =======================================


randWithModulo:             ; CODE XREF: ROM:00000338j
	move.w (prngState).w, d1

	muls.w #$3619, d1
	addi.w #$5D35, d1

	move.w d1, (prngState).w

	muls.w d0, d1
	swap   d0

	clr.w  d0
	asr.l  #1, d0
	add.l  d1, d0
	swap   d0

	ext.l  d0
	rts
; End of function randWithModulo


; =============== S U B R O U T I N E =======================================


rand:                   ; CODE XREF: ROM:0000033Cj
	move.w (prngState).w, d0

	muls.w #$3619, d0
	addi.w #$5D35, d0

	move.w d0, (prngState).w
	rts
; End of function rand


; =============== S U B R O U T I N E =======================================


convertToBcd:                ; CODE XREF: ROM:00000380j
	move.w d6, -(sp)
	andi.l #$FFFF, d1

	divu.w #1000, d1
	move.w d1, d6
	asl.w  #4, d6
	clr.w  d1
	swap   d1

	divu.w #100, d1
	or.b   d1, d6
	asl.w  #4, d6
	clr.w  d1
	swap   d1

	divu.w #10, d1
	or.b   d1, d6
	asl.w  #4, d6
	swap   d1
	or.w   d6, d1

	move.w (sp)+, d6
	rts
; End of function convertToBcd


; =============== S U B R O U T I N E =======================================

; Input:
; a1:

processDmaTransferQueue:               ; CODE XREF: ROM:00000394j
	move.w (a1)+, d2
	beq.s  @locret_1A36

	movem.l (a1)+, d0-d1

	jsr dmaTransferToVramWithRewrite

	bra.s processDmaTransferQueue
; ---------------------------------------------------------------------------

@locret_1A36:
	rts
; End of function processDmaTransferQueue


; =============== S U B R O U T I N E =======================================

; Input:
; a1:

sub_1A38:               ; CODE XREF: ROM:00000398j
	move.l a1, d3

	move.w (a1)+, d2
	beq.s  @locret_1A4C

	move.l (a1)+, d0

	moveq  #0,    d1
	move.w (a1)+, d1
	add.l  d3,    d1

	jsr dmaTransferToVramWithRewrite

	bra.s processDmaTransferQueue
; ---------------------------------------------------------------------------

@locret_1A4C:
	rts
; End of function sub_1A38


; =============== S U B R O U T I N E =======================================

; Inputs:
; d0:
; d1:

sub_1A4E:               ; CODE XREF: ROM:000003A0j sub_4C74+Cp
	lea (unk_FFFFFE4E).w, a0
	lea (unk_FFFFFE50).w, a1

	move.l d0, (a0)+
	move.l d1, (a1)+

	subq.w #1, a0
	subq.w #1, a1

	move #4, ccr
	sbcd -(a1), -(a0)
	sbcd -(a1), -(a0)

	m_saveStatusRegister

	bcc.s   @loc_1A6E

	subi.b  #$40, (a0)

@loc_1A6E:
	m_restoreStatusRegister

	sbcd -(a1), -(a0)
	move.w (a0), d0
	rts
; End of function sub_1A4E


; =============== S U B R O U T I N E =======================================


sub_1A76:               ; CODE XREF: ROM:0000039Cj
	addq.w #2, a1

	abcd  -(a2), -(a1)
	bcs.s @loc_1A94

	cmpi.b #$60, (a1)
	bcs.s  @loc_1A9C

	movem.l d0-d1, -(sp)

	move.b (a1), d0
	moveq  #$40, d1
	abcd   d1, d0

	move.b d0, (a1)

	movem.l (sp)+, d0-d1

	bra.s @loc_1A9C
; ---------------------------------------------------------------------------

@loc_1A94:
	m_saveStatusRegister

	addi.b #$40, (a1)

	m_restoreStatusRegister

@loc_1A9C:
	abcd -(a2), -(a1)
	rts
; End of function sub_1A76


; =============== S U B R O U T I N E =======================================

; Enigma decompressor
	include "compression\enigma.asm"

; =============== S U B R O U T I N E =======================================

; Input:
; a0: Base address to clear
; d7: Number of dwords to clear

clearRamSegment:
	movea.w a0, a6
	moveq   #0, d6

	@loc_1BFE:
		move.l  d6, (a6)+
		dbf     d7, @loc_1BFE

	rts
; End of function clearRamSegment


; =============== S U B R O U T I N E =======================================


sub_1C06:               ; CODE XREF: ROM:000002FCj
	movem.l d5/a0, -(sp)

	@loc_1C0A:
		bsr.s clearRamSegment

		movea.w a6, a0
		dbf d5, @loc_1C0A

	movem.l (sp)+, d5/a0
	rts
; End of function sub_1C06


; =============== S U B R O U T I N E =======================================

; Inputs:
;   a0: Object address
;   a2: Sprite table address
;   d6: Link data (next sprite number)

updateObjectSprite:               ; CODE XREF: ROM:00000300j
	; Don't process if flag 1 is set
	btst    #1, OBJ6B14.flags2(a0)
	beq.s   @loc_1C22

	rts
; ---------------------------------------------------------------------------

@loc_1C22:
	movea.l OBJ6B14.addr4(a0), a1

	moveq   #0, d1
	move.b  (a1)+, d1
	move.b  (a1)+, OBJ6B14.byte19(a0)

	tst.b   OBJ6B14.flags2(a0)
	bpl.s   @loc_1C38

	addq.b  #1, OBJ6B14.byte19(a0)

@loc_1C38:
	move.w  OBJ6B14.wordC(a0), d2
	cmpi.w  #$180, d2
	bhi.s   @locret_1C8E

	move.w  OBJ6B14.word8(a0), d3

@loc_1C46:
	move.b  (a1)+, d0
	ext.w   d0
	add.w   d2, d0

	; Vertical position
	move.w  d0, (a2)+

	; Sprite size
	move.b  (a1)+, (a2)+

	; Link data (next sprite)
	move.b  d6, (a2)+

	; Priority/palette/flip
	move.b  (a1)+, d0
	or.b    OBJ6B14.byte18(a0), d0
	move.b  d0, (a2)+

	; Sprite pattern number
	move.b  (a1)+, (a2)+

	move.b  (a1)+, d0

	tst.b   OBJ6B14.flags2(a0)
	bpl.s   @loc_1C6C

	bchg    #3, -2(a2)
	move.b  (a1), d0

@loc_1C6C:
	addq.w  #1, a1

	ext.w   d0
	add.w   d3, d0
	move.w  d0, d4
	subi.w  #$41, d4

	cmpi.w  #$17F, d4
	bcs.s   @loc_1C86

	subq.w  #6, a2
	dbf     d1, @loc_1C46

	rts
; ---------------------------------------------------------------------------

@loc_1C86:
	; Horizontal position
	move.w d0, (a2)+

	addq.b #1, d6
	dbf    d1, @loc_1C46

@locret_1C8E:
	rts
; End of function updateObjectSprite


; =============== S U B R O U T I N E =======================================


updateObjectPosition:               ; CODE XREF: updateObjects+22p
	move.l  OBJ6B14.dword10(a0), d2
	add.l   d2, OBJ6B14.word8(a0)

	move.l  OBJ6B14.dword14(a0), d3
	add.l   d3, OBJ6B14.wordC(a0)
	rts
; End of function updateObjectPosition


; =============== S U B R O U T I N E =======================================

; Inputs:
; d0: Object count
; d1: Object size (bytes)
; a0: Base address of object memory
; a1: Address of sprite table

updateObjects:               ; CODE XREF: ROM:000002F4j
					; state_3040+2Cp ...
	move.l  a1, (spriteTableAddress).w
	move.l  a1, -(sp)
	move.w  #1, (nextSpriteIndex).w

	@loc_1CAE:
		movem.w d0-d1, -(sp)

		move.w  (a0), d0
		beq.s   @loc_1CDE

		andi.w  #$7FFC, d0
		movea.l (dword_FFFFFE34).w, a1
		movea.l (a1, d0.w), a1
		jsr (a1)

		bsr.s   updateObjectPosition

		tst.w   (a0)
		beq.s   @loc_1CDE

		movea.l (spriteTableAddress).w, a2
		move.w  (nextSpriteIndex).w, d6
		bsr.w   updateObjectSprite

		move.w  d6, (nextSpriteIndex).w
		move.l  a2, (spriteTableAddress).w

	@loc_1CDE:
		; Advance to the next object
		movem.w (sp)+, d0-d1
		adda.w  d1, a0
		dbf     d0, @loc_1CAE

	movea.l (spriteTableAddress).w, a2
	cmpa.l  (sp)+, a2
	beq.s   @loc_1CF6

	clr.b   -5(a2)
	rts
; ---------------------------------------------------------------------------

@loc_1CF6:
	clr.l (a2)
	rts
; End of function updateObjects

	; Game state 1 ($21F4)
	include "gamestates\state_21F4.asm"

	; Game state 2 ($3040)

; =============== S U B R O U T I N E =======================================


state_3040:               ; CODE XREF: ROM:000005DEj
	; Load assets for this state
	bsr.w sub_30C2

@loc_3044:
	jsr waitForVblank(pc)

	st (byte_FFFFFE28).w

	jsr sub_62E4(pc)

	bsr.w sub_43F2
	bcs.s @loc_3070

	cmpi.b #1, (byte_FFFFD002).w
	beq.s  @loc_3070

	lea (obj_FFFFD300).w, a0
	lea (spriteTable).w,  a1
	moveq  #1,   d0
	move.w #$80, d1
	jsr updateObjects

@loc_3070:
	bsr.w sub_44E2
	bsr.w sub_5F36
	bsr.w sub_56B6
	bsr.w sub_54B2
	bsr.w sub_6130

@loc_3084:
	move.w (VDP_COUNTER).l, d0
	bmi.s  @loc_3092

	cmpi.w #$5800, d0
	bls.s  @loc_3084

@loc_3092:
	bsr.w sub_5C8A

	jsr sub_6342(pc)

	clr.b (byte_FFFFFE28).w

	move.b (byte_FFFFD007).w, d0
	andi.b #$C0, d0
	beq.s  @loc_3044

	btst  #6, d0
	bne.s @loc_30BC

	moveq #1, d0
	moveq #$10, d1
	jsr   sub_1800(pc)

	moveq #STATE_7374, d0
	jmp   setNextState(pc)
; ---------------------------------------------------------------------------

@loc_30BC:
	moveq #STATE_LOAD, d0
	jmp   setNextState(pc)
; End of function state_3040


; =============== S U B R O U T I N E =======================================


; Asset loader for state_3040
sub_30C2:               ; CODE XREF: state_3040p
	st (byte_FFFFFE28).w

	jsr displayOff(pc)
	jsr loadDefaultVdpRegs(pc)
	jsr clearAllVram(pc)

	lea vdpReg_318C(pc), a1
	jsr loadVdpRegs(pc)

	jsr sendE3ToZ80(pc)

	lea (sub_319E).l, a1
	jsr setVblankUserRoutine(pc)

	; Clear the state's work RAM
	bsr.w sub_328C

	move.b #1,   (byte_FFFFD010).w
	move.b #$10, (byte_FFFFD00F).w
	move.b #$10, (byte_FFFFD011).w
	move.b #3,   (byte_FFFFD00E).w

	clr.w (word_FFFFD166).w

	; Clear more RAM
	bsr.w sub_5260
	bsr.w sub_5F2C

	; Get Word RAM in 1M mode
	bsr.w sub_62C8

	; Copy data into Word RAM
	jsr sub_6342(pc)

	clr.l (spriteTable).w
	clr.l (spriteTable+4).w

	move.l #$3180, (dword_FFFFFE34).w

	; Clear RAM $FFD300-$FFD500
	lea (obj_FFFFD300).w, a0
	moveq #$7F, d7
	bsr.w clearRamSegment

	bsr.w sub_329A

	move.w #8, (unk_FFFFD380).w
	bsr.w  sub_5FA2

	; Vertical scroll
	m_loadVsramWriteAddress 0
	move.l #$200100, (VDP_DATA).l

	; Horizontal scroll
	m_loadVramWriteAddress $8400
	move.w #$FF80, (VDP_DATA).l

	clr.b (byte_FFFFD003).w

	bsr.w sub_63AC
	bsr.w sub_5DFA
	bsr.w sub_16D2

	clr.b (byte_FFFFFE28).w

	jsr waitForVblank(pc)
	jsr displayOn(pc)
	rts
; End of function sub_30C2

; ---------------------------------------------------------------------------
	dc.l loc_32DC
	dc.l sub_4220

vdpReg_318C:
	dc.w $8334 ; Reg #03: Window pattern table $D000
	dc.w $8230 ; Reg #02: Scroll A pattern table $C000
	dc.w $8407 ; Reg #04: Scroll B pattern table $E000
	dc.w $8568 ; Reg #05: Sprite attribute table $D000
	dc.w $8D21 ; Reg #13: H-scroll data table $8400
	dc.w $8C81 ; Reg #12: Shadow/hilight/interlace off, H40-cell mode
	dc.w $9100 ; Reg #17: Window H position 0
	dc.w $9200 ; Reg #18: Window V position 0
	dc.w 0

; =============== S U B R O U T I N E =======================================


; V-blank handler for state_3040
sub_319E:                               ; DATA XREF: sub_30C2+1Co
	lea (VDP_CONTROL).l, a4

	; Enable DMA
	move.w (vdpRegCache+2).w, d4
	bset   #4, d4
	move.w d4, (a4)

	m_saveStatusRegister
	m_disableInterrupts
	m_z80RequestBus

	move.l #$94009380, (a4)             ; $80 words (256 bytes)

	move.l #$96FC9580, (a4)             ; Source address $FFF900
	move.w #$977F, (a4)

	move.w #$5000, (a4)                 ; Dest address VRAM $D000
	move.w #$0083, -(sp)

	m_z80WaitForBus

	move.w (sp)+, (a4)

	m_z80ReleaseBus

	; Disable DMA
	move.w (vdpRegCache+2).w, (a4)

	m_loadVramWriteAddress $D000, (a4)
	move.w (spriteTable).w, -4(a4)

	m_restoreStatusRegister

	bsr.w  sub_6476

	bclr   #5, (byte_FFFFD007).w
	beq.s  @locret_3210

	tst.b  (byte_FFFFD003).w
	beq.s  sub_3212

	bra.w  sub_63D4
; ---------------------------------------------------------------------------

@locret_3210:
	rts
; End of function sub_319E


; =============== S U B R O U T I N E =======================================


sub_3212:               ; CODE XREF: sub_31FE+Cj
	jsr displayOff(pc)

	move.w #$9011, (VDP_CONTROL).l
	move.w #$9011, (vdpRegCache+$20).w

	move.w #$8700, (VDP_CONTROL).l
	move.w #$8700, (vdpRegCache+$0E).w

	move.w #$9100, (VDP_CONTROL).l
	move.w #$9100, (vdpRegCache+$22).w

	move.w #$9200, (VDP_CONTROL).l
	move.w #$9200, (vdpRegCache+$24).w

	m_loadVramWriteAddress $C220, d6
	bsr.w  sub_6816
	bsr.w  sub_5DD8

	clr.b  (byte_FFFFD061).w

	m_loadVsramWriteAddress 0
	move.l #$200100, (VDP_DATA).l

	m_loadVramWriteAddress $8400
	move.l #$FF800000, (VDP_DATA).l

	jmp displayOn(pc)
; End of function sub_3212


; =============== S U B R O U T I N E =======================================


; Clear RAM from $FFD000-$FFD062
sub_328C:               ; CODE XREF: sub_30C2+26p
	lea (word_FFFFD000).w, a0

	moveq #48, d0
	@loc_3292:
		clr.w (a0)+
		dbf   d0, @loc_3292

	rts
; End of function sub_328C


; =============== S U B R O U T I N E =======================================


sub_329A:               ; CODE XREF: sub_30C2+70p
	lea (obj_FFFFD300).w, a0

	; Initialize structure
	move.w  #4, (a0)
	move.b  #$80, STR329A.byte18(a0)
	move.l  #$12BBD, STR329A.dword4(a0)
	clr.l   STR329A.dword36(a0)
	move.l  #1, STR329A.word32(a0)

	bsr.w   checkDiscBootable
	beq.s   @loc_32D4

	move.l  #$10003, STR329A.word32(a0)

	bsr.w   getDiscType
	bne.s   @loc_32D4

	clr.l   STR329A.word32(a0)

@loc_32D4:
	clr.w   STR329A.word24(a0)
	bra.w   sub_35CA
; ---------------------------------------------------------------------------

loc_32DC:
	bsr.w sub_40AE
	bsr.w sub_42B8

	lea   $44(a0), a1
	moveq #0, d0
	bsr.w handleDpadRepeat

	btst  #3, (byte_FFFFD008).w
	beq.s loc_32F8

	rts
; ---------------------------------------------------------------------------

loc_32F8:               ; CODE XREF: sub_329A+5Aj
	btst    #JOYBIT_START, (joy1Down).w
	bne.s   loc_3342

	tst.b   (byte_FFFFD003).w
	beq.s   loc_331A

	btst    #JOYBIT_BTNB, (joy1Triggered).w
	bne.w   loc_34A2

	btst    #1, 2(a0)
	beq.s   loc_331A

	rts
; ---------------------------------------------------------------------------

loc_331A:               ; CODE XREF: sub_329A+6Aj sub_329A+7Cj
	move.w  $24(a0), d0
	jmp loc_3322(pc, d0.w)
; ---------------------------------------------------------------------------

loc_3322:
	bra.w   loc_3448
; ---------------------------------------------------------------------------
	bra.w   loc_3470
; ---------------------------------------------------------------------------
	bra.w   sub_3654
; ---------------------------------------------------------------------------
	bra.w   sub_3710
; ---------------------------------------------------------------------------
	bra.w   loc_3A46
; ---------------------------------------------------------------------------
	bra.w   sub_3A40
; ---------------------------------------------------------------------------
	bra.w   sub_3ABC
; ---------------------------------------------------------------------------
	bra.w   sub_3AE4
; ---------------------------------------------------------------------------

loc_3342:               ; CODE XREF: sub_329A+64j
	move.b (joy1Triggered).w, d0

	btst  #JOYBIT_START, d0
	beq.w loc_33AE

	move.w #8, $5C(a0)

	bsr.w checkDiscBootable
	bne.w @loc_338E

	tst.w $24(a0)
	bne.s @loc_336E

	cmpi.l #1, $32(a0)
	beq.w  sub_4054

@loc_336E:
	bsr.w   sub_3AE4

	tst.b   (byte_FFFFD003).w
	beq.s   @loc_3382

	move.l  #$10003,$32(a0)
	bra.s   @loc_338A
; ---------------------------------------------------------------------------

@loc_3382:
	move.l  #1,$32(a0)

@loc_338A:
	bra.w   sub_35CA
; ---------------------------------------------------------------------------

@loc_338E:
	bsr.w   sub_3AE4
	bsr.w   sub_1856
	bcs.s   loc_33A6

	btst    #0,(byte_FFFFD008).w
	bne.s   loc_33A6

	bsr.w   getDiscType
	bne.s   loc_33AA

loc_33A6:               ; CODE XREF: sub_329A+FCj
					; sub_329A+104j
	bsr.w   sub_41EE

loc_33AA:               ; CODE XREF: sub_329A+10Aj
	bra.w   sub_35CA
; ---------------------------------------------------------------------------

loc_33AE:               ; CODE XREF: sub_329A+B0j
	bsr.w   sub_1856
	bcs.s   loc_33F0

	btst    #0,(byte_FFFFD008).w
	bne.s   loc_33F0

	bsr.w   getDiscType
	beq.s   loc_33F0

	tst.w   $5C(a0)
	bmi.s   loc_33CC

	addq.w  #1,$5C(a0)

loc_33CC:               ; CODE XREF: sub_329A+12Cj
	move.b  (joy1Triggered).w, d0
	andi.b  #$7C, d0
	beq.w   sub_35CA

	cmpi.w  #$10, $5C(a0)
	bls.w   sub_35CA

	bsr.s   loc_33F8
	bsr.w   sub_35CA

	clr.w   $5C(a0)
	bra.w   sub_4054
; ---------------------------------------------------------------------------

loc_33F0:               ; CODE XREF: sub_329A+118j
					; sub_329A+120j ...
	clr.l   $32(a0)
	bra.w   sub_35CA
; ---------------------------------------------------------------------------

loc_33F8:               ; CODE XREF: sub_329A+148p
	btst  #JOYBIT_BTNA, d0
	bne.s loc_342A

	btst  #JOYBIT_BTNC, d0
	bne.s loc_341A

	btst  #JOYBIT_BTNB, d0
	bne.s loc_3434

	btst  #JOYBIT_RIGHT, d0
	bne.s loc_343E

	move.l #3, $32(a0)
	rts
; ---------------------------------------------------------------------------

loc_341A:               ; CODE XREF: sub_329A+168j
	move.l  #5,$32(a0)
	btst    #2,(byte_FFFFD008).w
	bne.s   locret_3432

loc_342A:               ; CODE XREF: sub_329A+162j
	move.l  #$10003,$32(a0)

locret_3432:                ; CODE XREF: sub_329A+18Ej
	rts
; ---------------------------------------------------------------------------

loc_3434:               ; CODE XREF: sub_329A+16Ej
	move.l  #$10004,$32(a0)
	rts
; ---------------------------------------------------------------------------

loc_343E:               ; CODE XREF: sub_329A+174j
	move.l  #$20003,$32(a0)
	rts
; ---------------------------------------------------------------------------

loc_3448:               ; CODE XREF: sub_329A:loc_3322j
	move.w  (joy1Down).w,d0
	andi.w  #$7070,d0
	bne.s   loc_345E
	tst.b   (byte_FFFFD060).w
	bne.w   sub_3BD8
	bra.w   loc_34DA
; ---------------------------------------------------------------------------

loc_345E:               ; CODE XREF: sub_329A+1B6j
	bsr.w   sub_35CA
	move.b  (joy1Triggered).w,d0
	andi.b  #$70,d0 ; 'p'
	bne.w   sub_4054
	rts
; ---------------------------------------------------------------------------

loc_3470:               ; CODE XREF: sub_329A+8Cj
	btst    #1,2(a0)
	bne.w   sub_35CA
	move.w  (joy1Down).w,d0
	andi.w  #$7070,d0
	bne.s   loc_3490
	tst.b   (byte_FFFFD060).w
	bne.w   sub_3BD8
	bra.w   loc_34DA
; ---------------------------------------------------------------------------

loc_3490:               ; CODE XREF: sub_329A+1E8j
	bsr.w   sub_35CA
	move.b  (joy1Triggered).w,d0
	andi.b  #$70,d0 ; 'p'
	bne.w   sub_4054
	rts
; ---------------------------------------------------------------------------

loc_34A2:               ; CODE XREF: sub_329A+72j
	bchg    #1,2(a0)
	move.b  (byte_FFFFD004).w,d0
	addq.b  #1,d0
	andi.b  #3,d0
	andi.b  #$FC,(byte_FFFFD004).w
	or.b    d0,(byte_FFFFD004).w
	cmpi.b  #3,d0
	bne.s   loc_34C8
	bsr.w   sub_5F10
	bra.s   loc_34CC
; ---------------------------------------------------------------------------

loc_34C8:               ; CODE XREF: sub_329A+226j
	bsr.w   sub_5ED2

loc_34CC:               ; CODE XREF: sub_329A+22Cj
	btst    #0,(byte_FFFFD004).w
	beq.w   sub_5E6C
	bra.w   sub_5EA8
; ---------------------------------------------------------------------------

loc_34DA:               ; CODE XREF: sub_329A+1C0j
					; sub_329A+1F2j
	move.b  (joy1Triggered).w,d1
	bsr.w   sub_1856
	bcs.s   loc_34F2
	btst    #0,(byte_FFFFD008).w
	bne.s   loc_34F2
	bsr.w   getDiscType
	bne.s   loc_34FA

loc_34F2:               ; CODE XREF: sub_329A+248j
					; sub_329A+250j
	clr.l   $32(a0)
	bra.w   loc_35BE
; ---------------------------------------------------------------------------

loc_34FA:               ; CODE XREF: sub_329A+256j
	tst.b   (byte_FFFFD003).w
	beq.s   loc_3512
	cmpi.w  #3,$34(a0)
	bhi.s   loc_3512
	btst    #0,d1
	beq.s   loc_3512
	bra.w   loc_35BE
; ---------------------------------------------------------------------------

loc_3512:               ; CODE XREF: sub_329A+264j
					; sub_329A+26Cj ...
	move.w  $34(a0),d0
	bne.s   loc_3532
	move.l  #1,$32(a0)
	bsr.w   checkDiscBootable
	beq.s   loc_352E
	move.l  #$10003,$32(a0)

loc_352E:               ; CODE XREF: sub_329A+28Aj
	bra.w   loc_35BE
; ---------------------------------------------------------------------------

loc_3532:               ; CODE XREF: sub_329A+27Cj
	lea unk_35C0(pc),a1
	move.b  (a1,d0.w),d0
	btst    #3,d1
	beq.s   loc_354C
	cmp.w   $32(a0),d0
	ble.s   loc_355C
	addq.w  #1,$32(a0)
	bra.s   loc_355C
; ---------------------------------------------------------------------------

loc_354C:               ; CODE XREF: sub_329A+2A4j
	btst    #2,d1
	beq.s   loc_355C
	tst.w   $32(a0)
	beq.s   loc_355C
	subq.w  #1,$32(a0)

loc_355C:               ; CODE XREF: sub_329A+2AAj
					; sub_329A+2B0j ...
	btst    #0,d1
	beq.s   loc_358C
	bsr.w   checkDiscBootable
	beq.s   loc_3570
	cmpi.w  #3,$34(a0)
	bra.s   loc_3576
; ---------------------------------------------------------------------------

loc_3570:               ; CODE XREF: sub_329A+2CCj
	cmpi.w  #1,$34(a0)

loc_3576:               ; CODE XREF: sub_329A+2D4j
	ble.s   loc_35BE
	subq.w  #1,$34(a0)
	cmpi.w  #4,$34(a0)
	bne.s   loc_35AC
	move.w  #1,$32(a0)
	bra.s   loc_35AC
; ---------------------------------------------------------------------------

loc_358C:               ; CODE XREF: sub_329A+2C6j
	btst    #1,d1
	beq.s   loc_35BE
	cmpi.w  #8,$34(a0)
	bcc.s   loc_35BE
	addq.w  #1,$34(a0)
	cmpi.w  #3,$34(a0)
	bne.s   loc_35AC
	move.w  #1,$32(a0)

loc_35AC:               ; CODE XREF: sub_329A+2E8j
					; sub_329A+2F0j ...
	move.w  $34(a0),d0
	move.b  (a1,d0.w),d0
	cmp.w   $32(a0),d0
	bge.s   loc_35BE
	move.w  d0,$32(a0)

loc_35BE:               ; CODE XREF: sub_329A+25Cj
					; sub_329A+274j ...
	bra.s   sub_35CA
; End of function sub_329A

; ---------------------------------------------------------------------------
unk_35C0:        ; DATA XREF: sub_329A:loc_3532o
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 2
	dc.b 2
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b 0

; =============== S U B R O U T I N E =======================================


sub_35CA:               ; CODE XREF: sub_329A+3Ej
					; sub_329A:loc_338Aj ...
	move.w  STR329A.word32(a0), d0
	or.w    STR329A.word34(a0), d0
	bmi.s   @locret_35EE

	bsr.s   sub_3624

	clr.b   STR329A.byte4C(a0)

	move.w  STR329A.word30(a0), d1
	add.w   d1, d1
	add.w   d1, d1

	move.w  word_35F0(pc, d1.w), STR329A.wordC(a0)
	move.w  word_35F2(pc, d1.w), STR329A.word8(a0)

@locret_35EE:
	rts
; End of function sub_329A

; ---------------------------------------------------------------------------
word_35F0:
	dc.w $C8
word_35F2:
	dc.w $138

	dc.w $A6
	dc.w $188

	dc.w $B6
	dc.w $188

	dc.w $DE
	dc.w $174

	dc.w $D6
	dc.w $192

	dc.w $DE
	dc.w $1A8

	dc.w $EE
	dc.w $174

	dc.w $E6
	dc.w $192

	dc.w $EE
	dc.w $1A8

	dc.w $F6
	dc.w $192

	dc.w $104
	dc.w $192

	dc.w $116
	dc.w $188

	dc.w $126
	dc.w $188

; =============== S U B R O U T I N E =======================================


sub_3624:               ; CODE XREF: sub_329A+33Ap
					; sub_3BD8:loc_3C8Ej
	moveq  #0, d0
	move.w STR329A.word34(a0), d1
	lea    word_3642(pc), a1

	subq.w #1, d1
	bmi.s  @loc_3638

	@loc_3632:
		add.w (a1)+, d0
		dbf   d1, @loc_3632

@loc_3638:
	add.w  STR329A.word32(a0), d0
	move.w d0, STR329A.word30(a0)
	rts
; End of function sub_3624

; ---------------------------------------------------------------------------
word_3642:          ; DATA XREF: sub_3624+6o
	dc.w 1
	dc.w 1
	dc.w 1
	dc.w 3
	dc.w 3
	dc.w 1
	dc.w 1
	dc.w 1
	dc.w 1

; =============== S U B R O U T I N E =======================================


sub_3654:               ; CODE XREF: sub_329A+90j
	move.w (joy1Down).w, d0

	andi.w #$7070, d0
	bne.s  @loc_366A

	tst.b  (byte_FFFFD060).w
	bne.w  sub_3D80
	bsr.w  sub_367C

@loc_366A:
	bsr.w  sub_36CA

	move.b (joy1Triggered).w, d0
	andi.b #$70, d0
	bne.w  sub_4054

	rts
; End of function sub_3654


; =============== S U B R O U T I N E =======================================


sub_367C:               ; CODE XREF: sub_3654+12p
	move.b  (joy1Triggered).w,d1

	btst    #JOYBIT_LEFT, d1
	beq.s   @loc_3692

	tst.w   $32(a0)
	beq.s   @loc_36A4

	subq.w  #1, $32(a0)
	bra.s   @loc_36A4
; ---------------------------------------------------------------------------

@loc_3692:
	btst    #JOYBIT_RIGHT, d1
	beq.s   @loc_36A4

	cmpi.w  #2, $32(a0)
	bcc.s   @loc_36A4

	addq.w  #1, $32(a0)

@loc_36A4:
	btst    #JOYBIT_DOWN, d1
	beq.s   @loc_36B8

	cmpi.w  #2, $34(a0)
	bcc.s   @locret_36C8

	addq.w  #1, $34(a0)
	bra.s   @locret_36C8
; ---------------------------------------------------------------------------

@loc_36B8:
	btst    #JOYBIT_UP, d1
	beq.s   @locret_36C8

	tst.w   $34(a0)
	beq.s   @locret_36C8

	subq.w  #1, $34(a0)

@locret_36C8:
	rts
; End of function sub_367C


; =============== S U B R O U T I N E =======================================


sub_36CA:               ; CODE XREF: sub_3654:loc_366Ap
					; sub_3D80+6p
	move.w $32(a0), d0
	or.w   $34(a0), d0
	bmi.s  @locret_36E6

	bsr.s  sub_36F4

	clr.b  $4C(a0)

	move.w word_36E8(pc, d0.w), $C(a0)
	move.w word_36EE(pc, d1.w), 8(a0)

@locret_36E6:
	rts
; End of function sub_36CA

; ---------------------------------------------------------------------------
word_36E8:
	dc.w $11E
	dc.w $12E
	dc.w $13E

word_36EE:
	dc.w  $D4
	dc.w $10C
	dc.w $144

; =============== S U B R O U T I N E =======================================


sub_36F4:               ; CODE XREF: sub_36CA+Ap sub_3D80+1Aj
	move.w $34(a0), d0

	move.w d0, d2
	add.w  d0, d0
	add.w  d0, d2

	move.w $32(a0), d1

	add.w  d1,  d2
	addi.w #$D, d2

	move.w d2, $30(a0)

	add.w  d1, d1
	rts
; End of function sub_36F4


; =============== S U B R O U T I N E =======================================


sub_3710:               ; CODE XREF: sub_329A+94j
	move.b  (joy1Triggered).w,d1
	move.b  d1,d0
	andi.b  #$70,d0 ; 'p'
	bne.w   loc_3726
	tst.b   (byte_FFFFD060).w
	bne.w   sub_3DE0

loc_3726:               ; CODE XREF: sub_3710+Aj
	cmpi.w  #1,$34(a0)
	beq.w   loc_37D2
	bhi.w   loc_3850
	move.b  d1,d0
	andi.b  #$70,d0 ; 'p'
	bne.w   sub_3A08
	btst    #3,d1
	beq.s   loc_374E
	move.w  #2,$32(a0)
	bra.w   sub_3910
; ---------------------------------------------------------------------------

loc_374E:               ; CODE XREF: sub_3710+32j
	tst.w   $3C(a0)
	bne.s   loc_3786
	btst    #2,d1
	beq.w   loc_376E
	tst.w   (word_FFFFD168).w
	beq.w   sub_3910
	move.w  #1,$32(a0)
	bra.w   sub_3910
; ---------------------------------------------------------------------------

loc_376E:               ; CODE XREF: sub_3710+48j
	btst    #1,d1
	beq.w   sub_3910
	move.w  #1,$34(a0)
	move.w  $3E(a0),$32(a0)
	bra.w   sub_392A
; ---------------------------------------------------------------------------

loc_3786:               ; CODE XREF: sub_3710+42j
	btst    #2,d1
	beq.w   loc_3796
	clr.w   $32(a0)
	bra.w   sub_3910
; ---------------------------------------------------------------------------

loc_3796:               ; CODE XREF: sub_3710+7Aj
	btst    #1,d1
	beq.w   sub_3910
	tst.w   (word_FFFFD168).w
	beq.w   sub_3910
	move.w  #2,$34(a0)
	move.w  $40(a0),d0
	add.w   (word_FFFFD042).w,d0
	cmp.w   (word_FFFFD168).w,d0
	bcs.s   loc_37C8
	move.w  (word_FFFFD168).w,d0
	sub.w   (word_FFFFD042).w,d0
	subq.w  #1,d0
	move.w  d0,$40(a0)

loc_37C8:               ; CODE XREF: sub_3710+A8j
	move.w  $40(a0),$32(a0)
	bra.w   sub_392A
; ---------------------------------------------------------------------------

loc_37D2:               ; CODE XREF: sub_3710+1Cj
	move.b  d1,d0
	andi.b  #$70,d0 ; 'p'
	bne.w   sub_3950
	btst    #0,d1
	beq.w   loc_37F8
	move.w  $32(a0),$3E(a0)
	clr.w   $34(a0)
	move.w  #2,$32(a0)
	bra.w   sub_3910
; ---------------------------------------------------------------------------

loc_37F8:               ; CODE XREF: sub_3710+D0j
	btst    #1,d1
	beq.w   loc_3830
	tst.w   (word_FFFFD168).w
	beq.w   sub_392A
	move.w  $32(a0),$3E(a0)
	addq.w  #1,$34(a0)
	move.w  (word_FFFFD166).w,d0
	sub.w   (word_FFFFD042).w,d0
	bmi.s   loc_3826
	cmpi.w  #$A,d0
	bls.s   loc_3828
	moveq   #9,d0
	bra.s   loc_3828
; ---------------------------------------------------------------------------

loc_3826:               ; CODE XREF: sub_3710+10Aj
	moveq   #0,d0

loc_3828:               ; CODE XREF: sub_3710+110j
				; sub_3710+114j
	move.w  d0,$32(a0)
	bra.w   sub_392A
; ---------------------------------------------------------------------------

loc_3830:               ; CODE XREF: sub_3710+ECj
	move.w  (word_FFFFD100).w,d0
	move.w  (word_FFFFD040).w,d2
	bsr.w   sub_38C8
	cmp.w   (word_FFFFD040).w,d2
	beq.w   sub_392A
	move.w  d2,(word_FFFFD040).w
	bsr.w   sub_5C50
	bra.w   sub_392A
; ---------------------------------------------------------------------------

loc_3850:               ; CODE XREF: sub_3710+20j
	move.b  d1,d0
	tst.w   $3C(a0)
	beq.s   loc_3860
	andi.b  #$70,d0 ; 'p'
	bne.w   sub_39AC

loc_3860:               ; CODE XREF: sub_3710+146j
	tst.b   (byte_FFFFD060).w
	bne.s   locret_38BE
	btst    #0,d1
	beq.w   loc_3896
	tst.w   $3C(a0)
	bne.s   loc_3882
	subq.w  #1,$34(a0)
	move.w  $3E(a0),$32(a0)
	bra.w   sub_392A
; ---------------------------------------------------------------------------

loc_3882:               ; CODE XREF: sub_3710+162j
	move.w  $32(a0),$40(a0)
	clr.w   $34(a0)
	move.w  #2,$32(a0)
	bra.w   sub_3910
; ---------------------------------------------------------------------------

loc_3896:               ; CODE XREF: sub_3710+15Aj
	move.w  (word_FFFFD168).w,d0
	tst.w   $3C(a0)
	bne.s   loc_38A2
	addq.w  #1,d0

loc_38A2:               ; CODE XREF: sub_3710+18Ej
	move.w  (word_FFFFD042).w,d2
	bsr.w   sub_38C8
	cmp.w   (word_FFFFD042).w,d2
	beq.w   sub_392A
	move.w  d2,(word_FFFFD042).w
	bsr.w   sub_5C68
	bra.w   sub_392A
; ---------------------------------------------------------------------------

locret_38BE:                ; CODE XREF: sub_3710+154j
	rts
; End of function sub_3710


; =============== S U B R O U T I N E =======================================


sub_38C0:               ; CODE XREF: sub_3950+4j sub_3950+Cj ...
	moveq #Z80CMD_FF92, d7
	jsr   sendCommandToZ80(pc)
	rts
; End of function sub_38C0


; =============== S U B R O U T I N E =======================================


sub_38C8:               ; CODE XREF: sub_3710+128p
					; sub_3710+196p
	move.b $44(a0), d1

	btst   #3, d1
	beq.s  @loc_38F0

	move.w $32(a0), d3
	add.w  d2, d3
	addq.w #1, d3

	cmp.w  d0, d3
	bcc.s  @locret_38FA

	cmpi.w #9, $32(a0)
	bcc.s  @loc_38EC

	addq.w #1, $32(a0)
	bra.s  @locret_38FA
; ---------------------------------------------------------------------------

@loc_38EC:
	addq.w #1, d2
	bra.s  @locret_38FA
; ---------------------------------------------------------------------------

@loc_38F0:
	btst  #2, d1
	beq.s @locret_38FA

	bsr.w sub_38FC

@locret_38FA:
	rts
; End of function sub_38C8


; =============== S U B R O U T I N E =======================================


sub_38FC:               ; CODE XREF: sub_38C8+2Ep
	tst.w  $32(a0)
	beq.s  @loc_3908

	subq.w #1, $32(a0)
	rts
; ---------------------------------------------------------------------------

@loc_3908:
	tst.w  d2
	beq.s  @locret_390E

	subq.w #1, d2

@locret_390E:
	rts
; End of function sub_38FC


; =============== S U B R O U T I N E =======================================


sub_3910:               ; CODE XREF: sub_3710+3Aj sub_3710+50j ...
	move.w #$11E, $C(a0)

	move.w $32(a0), d0
	add.w  d0, d0

	move.w word_3924(pc, d0.w), 8(a0)
	rts
; End of function sub_3910

; ---------------------------------------------------------------------------
word_3924:
	dc.w $D4
	dc.w $10C
	dc.w $144

; =============== S U B R O U T I N E =======================================


sub_392A:               ; CODE XREF: sub_3710+72j sub_3710+BEj ...
	move.w #$128, $C(a0)

	cmpi.w #1, $34(a0)
	beq.s  @loc_393E

	move.w #$138, $C(a0)

@loc_393E:
	move.w $32(a0), d0
	mulu.w #$10, d0
	addi.w #$B8, d0
	move.w d0, 8(a0)
	rts
; End of function sub_392A


; =============== S U B R O U T I N E =======================================


sub_3950:               ; CODE XREF: sub_3710+C8j
	tst.w  $30(a0)
	bmi.w  sub_38C0

	tst.w  $3C(a0)
	bne.w  sub_38C0

	move.w $32(a0), d0
	add.w  (word_FFFFD040).w, d0
	cmp.w  (word_FFFFD100).w, d0
	bhi.w  sub_38C0

	lea    (unk_FFFFD102).w, a1
	move.b (a1, d0.w), d0
	bsr.w  sub_5282
	bcs.s  @locret_39AA

	move.w (word_FFFFD166).w, d0
	sub.w  (word_FFFFD042).w, d0
	bmi.s  @loc_39A0

	cmpi.w #$A, d0
	bcs.s  @loc_39A6

	addq.w #1,(word_FFFFD042).w
	move.w (word_FFFFD166).w, d0
	bsr.w  sub_5DCE

	move.w d0, (word_FFFFD042).w
	bra.s  @loc_39A6
; ---------------------------------------------------------------------------

@loc_39A0:
	move.w (word_FFFFD166).w, (word_FFFFD042).w

@loc_39A6:
	bsr.w sub_5C68

@locret_39AA:
	rts
; End of function sub_3950


; =============== S U B R O U T I N E =======================================


sub_39AC:               ; CODE XREF: sub_3710+14Cj
	tst.w  $30(a0)
	bmi.w  sub_38C0

	move.w $32(a0), d0
	add.w  (word_FFFFD042).w, d0
	cmp.w  (word_FFFFD168).w, d0
	bge.w  sub_38C0

	bsr.w  sub_52CA

	m_saveStatusRegister

	bsr.s  sub_39E8
	bsr.w  sub_5C68

	m_restoreStatusRegister

	beq.s  @loc_39DA

	bsr.w  sub_392A
	rts
; ---------------------------------------------------------------------------

@loc_39DA:
	clr.w $3C(a0)
	clr.l $32(a0)

	bsr.s sub_3A08
	bra.w sub_3910
; End of function sub_39AC


; =============== S U B R O U T I N E =======================================


sub_39E8:               ; CODE XREF: sub_39AC+1Ep
	move.w $32(a0), d0
	move.w (word_FFFFD042).w,d1

	add.w  d1, d0
	cmp.w  (word_FFFFD168).w,d0
	bcs.s  @locret_3A06

	tst.w  d1
	beq.s  @loc_3A02

	subq.w #1, (word_FFFFD042).w
	rts
; ---------------------------------------------------------------------------

@loc_3A02:
	subq.w #1, $32(a0)

@locret_3A06:
	rts
; End of function sub_39E8


; =============== S U B R O U T I N E =======================================


sub_3A08:               ; CODE XREF: sub_3710+2Aj sub_39AC+36p
	tst.w  $30(a0)
	bmi.w  sub_38C0

	move.w $32(a0), d0
	cmpi.w #2, d0
	beq.w  loc_3A34

	move.w d0, $3C(a0)
	beq.s  loc_3A34

	tst.w  (word_FFFFD168).w
	bne.s  loc_3A34

	clr.w  $3C(a0)

	moveq  #Z80CMD_FF92, d7
	jsr    sendCommandToZ80(pc)

	rts
; ---------------------------------------------------------------------------

loc_3A34:               ; CODE XREF: sub_3A08+10j sub_3A08+18j ...
	addi.w #$16, d0
	move.w d0, $30(a0)

	bra.w  sub_4054
; End of function sub_3A08


; =============== S U B R O U T I N E =======================================


sub_3A40:               ; CODE XREF: sub_329A+9Cj
	lea (byte_FFFFD011).w,a6
	bra.s   loc_3A4A
; ---------------------------------------------------------------------------

loc_3A46:               ; CODE XREF: sub_329A+98j
	lea (byte_FFFFD00F).w,a6

loc_3A4A:               ; CODE XREF: sub_3A40+4j
	move.b  (joy1Triggered).w,d0
	move.b  d0,d1
	andi.b  #$70,d1 ; 'p'
	beq.s   loc_3A60
	bsr.w   sub_416A
	moveq   #6,d1
	bra.w   sub_59DE
; ---------------------------------------------------------------------------

loc_3A60:               ; CODE XREF: sub_3A40+14j
	tst.b   (byte_FFFFD060).w
	bne.w   sub_3F76
	move.b  $44(a0),d1
	move.b  (a6),d2
	btst    #0,d1
	beq.s   loc_3A8C
	moveq   #1,d1
	move    #4,ccr
	abcd    d1,d2
	cmpi.b  #$59,d2 ; 'Y'
	bls.s   loc_3AA8
	moveq   #1,d2
	move.b  #$14,(joy1RepeatDelay).w
	bra.s   loc_3AA8
; ---------------------------------------------------------------------------

loc_3A8C:               ; CODE XREF: sub_3A40+32j
	btst    #1,d1
	beq.s   loc_3AAA
	moveq   #1,d1
	move    #4,ccr
	sbcd    d1,d2
	cmpi.b  #1,d2
	bge.s   loc_3AA8
	moveq   #$59,d2 ; 'Y'
	move.b  #$14,(joy1RepeatDelay).w

loc_3AA8:               ; CODE XREF: sub_3A40+40j sub_3A40+4Aj ...
	move.b  d2,(a6)

loc_3AAA:               ; CODE XREF: sub_3A40+50j
	move.w  #$C8,$C(a0) ; '├ê'
	move.w  #$144,8(a0)
	move.b  (a6),d1
	bra.w   sub_5480
; End of function sub_3A40


; =============== S U B R O U T I N E =======================================


sub_3ABC:               ; CODE XREF: sub_329A+A0j
	cmpi.w #0, (word_FFFFD024).w
	beq.w  sub_416A

	move.b (joy1Triggered).w, d1
	andi.b #$70, d1
	beq.s  @locret_3AE2

	cmpi.w #$100, (word_FFFFD024).w
	bne.s  @locret_3AE2

	moveq  #$1A, d0
	bsr.w  sub_44CC
	bra.w  sub_416A
; ---------------------------------------------------------------------------

@locret_3AE2:
	rts
; End of function sub_3ABC


; =============== S U B R O U T I N E =======================================


sub_3AE4:               ; CODE XREF: sub_329A+A4j
					; sub_329A:loc_336Ep ...
	tst.b (byte_FFFFD003).w
	bne.w sub_3B76
; End of function sub_3AE4


; =============== S U B R O U T I N E =======================================


sub_3AEC:               ; CODE XREF: sub_41EE+8p
	clr.l  (dword_FFFFD336).w

	move.w $24(a0), d0
	jmp    loc_3AF8(pc, d0.w)
; End of function sub_3AEC

; ---------------------------------------------------------------------------

loc_3AF8:
	bra.w loc_3B3A
; ---------------------------------------------------------------------------
	bra.w loc_3B56
; ---------------------------------------------------------------------------
	bra.w sub_3B28
; ---------------------------------------------------------------------------
	bra.w sub_3B28
; ---------------------------------------------------------------------------
	bra.w loc_3B1E
; ---------------------------------------------------------------------------
	bra.w loc_3B1E
; ---------------------------------------------------------------------------
	bra.w loc_3B18
; ---------------------------------------------------------------------------
	bra.w loc_3B1E
; ---------------------------------------------------------------------------

loc_3B18:               ; CODE XREF: ROM:00003B10j
	bsr.w sub_5034
	bra.s sub_3B28
; ---------------------------------------------------------------------------

loc_3B1E:               ; CODE XREF: ROM:00003B08j
				; ROM:00003B0Cj ...
	bsr.s sub_3B28

	moveq #6, d1
	bsr.w sub_59DE
	rts

; =============== S U B R O U T I N E =======================================


sub_3B28:               ; CODE XREF: ROM:00003B00j
					; ROM:00003B04j ...
	bsr.w loc_4EAE
	bsr.w sub_5C20

	clr.w $24(a0)

	tst.b (byte_FFFFD003).w
	bne.s loc_3B56

loc_3B3A:               ; CODE XREF: ROM:loc_3AF8j
	btst   #2, (byte_FFFFD008).w
	beq.s  @loc_3B4C

	move.l #5, $32(a0)
	rts
; ---------------------------------------------------------------------------

@loc_3B4C:
	move.l #$10003, $32(a0)
	rts
; ---------------------------------------------------------------------------

loc_3B56:               ; CODE XREF: ROM:00003AFCj
	btst  #0, (byte_FFFFD004).w
	beq.w sub_4FB4

	bclr  #0, (byte_FFFFD004).w
	bsr.w loc_5E74

	moveq #$A, d1
	moveq #0, d0
	bsr.w sub_5764

	bra.w sub_4FB4
; End of function sub_3B28


; =============== S U B R O U T I N E =======================================


sub_3B76:               ; CODE XREF: sub_3AE4+4j
	clr.l  (dword_FFFFD336).w

	move.w $24(a0), d0
	jmp    loc_3B82(pc, d0.w)
; End of function sub_3B76

; ---------------------------------------------------------------------------

loc_3B82:
	nop
	rts
; ---------------------------------------------------------------------------
	bra.w   loc_3BBC
; ---------------------------------------------------------------------------
	bra.w   sub_3BAE
; ---------------------------------------------------------------------------
	bra.w   sub_3BAE
; ---------------------------------------------------------------------------
	bra.w   loc_3BA2
; ---------------------------------------------------------------------------
	bra.w   loc_3BA2
; ---------------------------------------------------------------------------
	bra.w   loc_3BAA
; ---------------------------------------------------------------------------
	bra.w   *+4
; ---------------------------------------------------------------------------

loc_3BA2:               ; CODE XREF: ROM:00003B92j
					; ROM:00003B96j ...
	bsr.s sub_3BAE

	moveq #6, d1
	bra.w sub_59DE
; ---------------------------------------------------------------------------

loc_3BAA:               ; CODE XREF: ROM:00003B9Aj
	bsr.w sub_5034

; =============== S U B R O U T I N E =======================================


sub_3BAE:               ; CODE XREF: ROM:00003B8Aj
					; ROM:00003B8Ej ...
	bsr.w   loc_4EAE
	bsr.w   sub_5C20

	move.w  #4, $24(a0)

loc_3BBC:               ; CODE XREF: ROM:00003B86j
	btst   #2, (byte_FFFFD008).w
	beq.s  @loc_3BCE

	move.l #$10003, $32(a0)
	rts
; ---------------------------------------------------------------------------

@loc_3BCE:
	move.l #5, $32(a0)
	rts
; End of function sub_3BAE


; =============== S U B R O U T I N E =======================================


sub_3BD8:               ; CODE XREF: sub_329A+1BCj
					; sub_329A+1EEj
	bsr.w sub_1856
	bcs.s @loc_3BEC

	btst  #0, (byte_FFFFD008).w
	bne.s @loc_3BEC

	bsr.w getDiscType
	bne.s @loc_3BF4

@loc_3BEC:
	clr.l $32(a0)
	bra.w sub_35CA
; ---------------------------------------------------------------------------

@loc_3BF4:
	move.w $34(a0), d0
	bne.s  @loc_3C14

	move.l #1, $32(a0)

	bsr.w  checkDiscBootable
	beq.s  @loc_3C10

	move.l #$10003, $32(a0)

@loc_3C10:
	bra.w sub_35CA
; ---------------------------------------------------------------------------

@loc_3C14:
	tst.b $4C(a0)
	beq.s @loc_3C1E

	bsr.w sub_35CA

@loc_3C1E:
	lea   unk_3C94(pc), a1
	tst.b (byte_FFFFD003).w
	bne.s @loc_3C2E

	bsr.w checkDiscBootable
	beq.s @loc_3C30

@loc_3C2E:
	addq.w #8, a1

@loc_3C30:
	bsr.w  sub_3FD4

	lea    off_3CB8(pc), a1

	bsr.w  sub_4016
	bcs.s  @locret_3C92

	move.w $34(a0), d0
	bmi.s  @locret_3C92

	cmpi.w #3, d0
	bcs.s  @loc_3C8E

	cmpi.w #5, d0
	bhi.s  @loc_3C8E

	move.w $32(a0), d1
	bmi.s  @locret_3C92

	cmpi.w #1, $32(a0)
	bne.s  @loc_3C84

	move.w $C(a0), d0

	lea    unk_3CA4(pc), a1

	bsr.w  sub_4048

	move.w d1, $34(a0)
	bmi.s  @loc_3C7C

	cmpi.w #5, d1
	bne.s  @loc_3C8E

	clr.w  $32(a0)
	bra.s  @loc_3C8E
; ---------------------------------------------------------------------------

@loc_3C7C:
	move.w #$FFFF, $30(a0)
	rts
; ---------------------------------------------------------------------------

@loc_3C84:
	lea   off_3D18(pc), a1
	bsr.w sub_4016
	bcs.s @locret_3C92

@loc_3C8E:
	bra.w sub_3624
; ---------------------------------------------------------------------------

@locret_3C92:
	rts
; End of function sub_3BD8

; ---------------------------------------------------------------------------
unk_3C94:        ; DATA XREF: sub_3BD8:loc_3C1Eo
	dc.b   1
	dc.b $6C
	dc.b   1
	dc.b $A8
	dc.b   0
	dc.b $A0
	dc.b   1
	dc.b $28
	dc.b   1
	dc.b $6C
	dc.b   1
	dc.b $A8
	dc.b   0
	dc.b $CA
	dc.b   1
	dc.b $28

unk_3CA4:        ; DATA XREF: sub_3BD8+8Ao
	dc.b   0
	dc.b $D8
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b $DC
	dc.b $80
	dc.b   3
	dc.b   0
	dc.b $E8
	dc.b   0
	dc.b   4
	dc.b   0
	dc.b $EC
	dc.b $80
	dc.b   4
	dc.b   0
	dc.b $F8
	dc.b   0
	dc.b   5

off_3CB8:       ; DATA XREF: sub_3BD8+5Co
	dc.l off_3D30
	dc.b   0
	dc.b $AA
	dc.b   0
	dc.b   1
	dc.b   0
	dc.b $B0
	dc.b $80
	dc.b   1
	dc.b   0
	dc.b $BA
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b $CA
	dc.b $80
	dc.b   2
	dc.b   0
	dc.b $D8
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b $E8
	dc.b   0
	dc.b   4
	dc.b   0
	dc.b $F8
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b $FC
	dc.b $80
	dc.b   5
	dc.b   1
	dc.b   4
	dc.b   0
	dc.b   6
	dc.b   1
	dc.b $10
	dc.b $80
	dc.b   6
	dc.b   1
	dc.b $18
	dc.b   0
	dc.b   7
	dc.b   1
	dc.b $20
	dc.b $80
	dc.b   7
	dc.b   1
	dc.b $28
	dc.b   0
	dc.b   8
	dc.b   0
	dc.b   0
	dc.b $3D
	dc.b $30
	dc.b   0
	dc.b $D8
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b $E8
	dc.b   0
	dc.b   4
	dc.b   0
	dc.b $F8
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b $FC
	dc.b $80
	dc.b   5
	dc.b   1
	dc.b   4
	dc.b   0
	dc.b   6
	dc.b   1
	dc.b $10
	dc.b $80
	dc.b   6
	dc.b   1
	dc.b $18
	dc.b   0
	dc.b   7
	dc.b   1
	dc.b $20
	dc.b $80
	dc.b   7
	dc.b   1
	dc.b $28
	dc.b   0
	dc.b   8

off_3D18:       ; DATA XREF: sub_3BD8:loc_3C84o
	dc.l off_3D30
	dc.b   0
	dc.b $D2
	dc.b $80
	dc.b   2
	dc.b   0
	dc.b $DF
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b $E2
	dc.b $80
	dc.b   3
	dc.b   0
	dc.b $EF
	dc.b   0
	dc.b   4
	dc.b   0
	dc.b $FC
	dc.b $80
	dc.b   4

off_3D30:
	dc.l unk_3D54
	dc.l unk_3D58
	dc.l unk_3D58
	dc.l unk_3D60
	dc.l unk_3D60
	dc.l unk_3D60
	dc.l unk_3D74
	dc.l unk_3D58
	dc.l unk_3D58

unk_3D54:
	dc.b   1
	dc.b $A8
	dc.b   0
	dc.b   0

unk_3D58:
	dc.b   1
	dc.b $88
	dc.b   0
	dc.b   0
	dc.b   1
	dc.b $A8
	dc.b $80
	dc.b   0

unk_3D60:
	dc.b   1
	dc.b $78
	dc.b   0
	dc.b   0
	dc.b   1
	dc.b $7B
	dc.b $80
	dc.b   0
	dc.b   1
	dc.b $95
	dc.b   0
	dc.b   1
	dc.b   1
	dc.b $98
	dc.b $80
	dc.b   1
	dc.b   1
	dc.b $A8
	dc.b   0
	dc.b   2

unk_3D74:
	dc.b   1
	dc.b $74
	dc.b $FF
	dc.b $FF
	dc.b   1
	dc.b $9C
	dc.b   0
	dc.b   0
	dc.b   1
	dc.b $A8
	dc.b $80
	dc.b   0

; =============== S U B R O U T I N E =======================================


sub_3D80:               ; CODE XREF: sub_3654+Ej
	tst.b $4C(a0)
	beq.s @loc_3D8A

	bsr.w sub_36CA

@loc_3D8A:
	lea   word_3DA0(pc), a1
	bsr.w sub_3FD4

	lea   off_3DA8(pc), a1
	bsr.w sub_4016
	bcc.w sub_36F4

	rts
; End of function sub_3D80

; ---------------------------------------------------------------------------
word_3DA0:        ; DATA XREF: sub_3D80:loc_3D8Ao
	dc.w $A8
	dc.w $148
	dc.w $112
	dc.w $13E

off_3DA8:       ; DATA XREF: sub_3D80+12o
	dc.l off_3DC0
	dc.b   1
	dc.b $1E
	dc.b   0
	dc.b   0
	dc.b   1
	dc.b $22
	dc.b $80
	dc.b   0
	dc.b   1
	dc.b $2E
	dc.b   0
	dc.b   1
	dc.b   1
	dc.b $32
	dc.b $80
	dc.b   1
	dc.b   1
	dc.b $3E
	dc.b   0
	dc.b   2

off_3DC0:
	dc.l unk_3DCC
	dc.l unk_3DCC
	dc.l unk_3DCC

unk_3DCC:
	dc.b   0
	dc.b $D8
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b $E0
	dc.b $80
	dc.b   0
	dc.b   1
	dc.b $10
	dc.b   0
	dc.b   1
	dc.b   1
	dc.b $18
	dc.b $80
	dc.b   1
	dc.b   1
	dc.b $48
	dc.b   0
	dc.b   2

; =============== S U B R O U T I N E =======================================


sub_3DE0:               ; CODE XREF: sub_3710+12j
	lea   off_3DF2(pc), a1
	bsr.w sub_3E6A

	lea   off_3DFA(pc), a1
	bsr.w sub_3F56

	rts
; End of function sub_3DE0

; ---------------------------------------------------------------------------
off_3DF2:     ; DATA XREF: sub_3DE0o
	dc.l unk_A00150
	dc.b   1
	dc.b $12
	dc.b   1
	dc.b $39

off_3DFA:       ; DATA XREF: sub_3DE0+8o
	dc.l off_3E12
	dc.b   1
	dc.b $1E
	dc.b   0
	dc.b   0
	dc.b   1
	dc.b $20
	dc.b $80
	dc.b   0
	dc.b   1
	dc.b $29
	dc.b   0
	dc.b   1
	dc.b   1
	dc.b $2F
	dc.b $80
	dc.b   1
	dc.b   1
	dc.b $39
	dc.b   0
	dc.b   2

off_3E12:
	dc.l unk_3DCC
	dc.l unk_3E1E
	dc.l unk_3E1E

unk_3E1E:
	dc.b   0
	dc.b $B8
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b $B9
	dc.b $80
	dc.b   0
	dc.b   0
	dc.b $C8
	dc.b   0
	dc.b   1
	dc.b   0
	dc.b $C9
	dc.b $80
	dc.b   1
	dc.b   0
	dc.b $D8
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b $D9
	dc.b $80
	dc.b   2
	dc.b   0
	dc.b $E8
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b $E9
	dc.b $80
	dc.b   3
	dc.b   0
	dc.b $F8
	dc.b   0
	dc.b   4
	dc.b   0
	dc.b $F9
	dc.b $80
	dc.b   4
	dc.b   1
	dc.b   8
	dc.b   0
	dc.b   5
	dc.b   1
	dc.b   9
	dc.b $80
	dc.b   5
	dc.b   1
	dc.b $18
	dc.b   0
	dc.b   6
	dc.b   1
	dc.b $19
	dc.b $80
	dc.b   6
	dc.b   1
	dc.b $28
	dc.b   0
	dc.b   7
	dc.b   1
	dc.b $29
	dc.b $80
	dc.b   7
	dc.b   1
	dc.b $38
	dc.b   0
	dc.b   8
	dc.b   1
	dc.b $39
	dc.b $80
	dc.b   8
	dc.b   1
	dc.b $51
	dc.b   0
	dc.b   9

; =============== S U B R O U T I N E =======================================


sub_3E6A:               ; CODE XREF: sub_3DE0+4p
	move.l  a1, -(sp)
	bsr.w   sub_3FD4
	movea.l (sp)+, a1

	tst.w   $34(a0)
	bne.s   @loc_3EA6

	moveq   #0, d7
	move.w  (a1), d7
	addq.w  #8, d7
	swap    d7
	cmp.l   8(a0), d7
	blt.s   @loc_3E8C

	move.l  d7, 8(a0)
	bra.s   @locret_3EE8
; ---------------------------------------------------------------------------

@loc_3E8C:
	moveq  #0, d7
	move.w 2(a1), d7
	subq.w #8, d7
	swap   d7
	cmp.l  8(a0), d7
	bgt.s  @locret_3EE8

	move.l 8(a0), d6
	move.l d7, 8(a0)
	bra.s  @locret_3EE8
; ---------------------------------------------------------------------------

@loc_3EA6:
	cmpi.w #1, $34(a0)
	bne.s  @loc_3EC8

	move.w (word_FFFFD100).w, d0
	move.w (word_FFFFD040).w, d2
	bsr.s  sub_3EEA

	cmp.w  (word_FFFFD040).w, d2
	beq.s  @locret_3EE8

	move.w d2,(word_FFFFD040).w
	bsr.w  sub_5C50

	bra.s  @locret_3EE8
; ---------------------------------------------------------------------------

@loc_3EC8:
	move.w (word_FFFFD168).w, d0
	tst.w  $3C(a0)
	bne.s  @loc_3ED4

	addq.w #1, d0

@loc_3ED4:
	move.w (word_FFFFD042).w, d2
	bsr.s  sub_3EEA

	cmp.w  (word_FFFFD042).w, d2
	beq.s  @locret_3EE8

	move.w d2, (word_FFFFD042).w
	bsr.w  sub_5C68

@locret_3EE8:
	rts
; End of function sub_3E6A


; =============== S U B R O U T I N E =======================================


sub_3EEA:               ; CODE XREF: sub_3E6A+4Cp sub_3E6A+6Ep
	moveq  #0,   d7
	move.w (a1), d7
	addq.w #8,   d7
	swap   d7

	cmp.l  8(a0), d7
	blt.s  @loc_3F1A

	move.l 8(a0), d6
	move.l d7, 8(a0)
	sub.l  d7, d6
	add.l  d6, $58(a0)

	cmpi.w #$FFF8, $58(a0)
	bgt.s  @locret_3F54

	clr.l  $58(a0)

	tst.w  d2
	beq.s  @locret_3F54

	subq.w #1, d2
	bra.s  @locret_3F54
; ---------------------------------------------------------------------------

@loc_3F1A:
	moveq  #0,    d7
	move.w 2(a1), d7
	subq.w #8,    d7
	swap   d7

	cmp.l  8(a0), d7
	bgt.s  @loc_3F50

	move.l 8(a0), d6
	move.l d7, 8(a0)
	sub.l  d7, d6
	add.l  d6, $58(a0)

	cmpi.w #8, $58(a0)
	bls.s  @locret_3F54

	move.l d0, d5
	subi.w #$A, d5
	bmi.w  @loc_3F50

	cmp.w  d5, d2
	bge.s  @loc_3F50

	addq.w #1, d2

@loc_3F50:
	clr.l $58(a0)

@locret_3F54:
	rts
; End of function sub_3EEA


; =============== S U B R O U T I N E =======================================


sub_3F56:               ; CODE XREF: sub_3DE0+Cp
	movem.l d0/d2, -(sp)
	bsr.w   sub_4016
	movem.l (sp)+, d0/d2

	bcs.s  @loc_3F6E

	move.w $32(a0), d7
	move.w d7, $30(a0)
	rts
; ---------------------------------------------------------------------------

@loc_3F6E:
	move.w #$FFFF, $30(a0)
	rts
; End of function sub_3F56


; =============== S U B R O U T I N E =======================================


sub_3F76:               ; CODE XREF: sub_3A40+24j
	moveq  #0, d3
	move.b (a6), d2

	move.l $54(a0), d0
	beq.s  @loc_3FC2
	bpl.s  @loc_3F86

	moveq  #$FFFFFFFF, d3
	neg.l  d0

@loc_3F86:
	add.l  $58(a0), d0
	swap   d0
	move.w d0, d1

	andi.w #$1F, d0
	swap   d0
	move.l d0, $58(a0)

	lsr.w  #5, d1
	andi.w #7, d1

	tst.w  d3
	bpl.s  @loc_3FB2

	move   #4, ccr
	abcd   d1, d2

	cmpi.b #$59, d2
	bls.s  @loc_3FC0

	moveq  #1, d2
	bra.s  @loc_3FC0
; ---------------------------------------------------------------------------

@loc_3FB2:
	move   #4, ccr
	sbcd   d1, d2

	cmpi.b #1, d2
	bge.s  @loc_3FC0

	moveq  #$59, d2

@loc_3FC0:
	move.b d2, (a6)

@loc_3FC2:
	move.w #$C8, $C(a0)
	move.w #$144, 8(a0)
	move.b (a6), d1
	bra.w  sub_5480
; End of function sub_3F76


; =============== S U B R O U T I N E =======================================


sub_3FD4:               ; CODE XREF: sub_3BD8:loc_3C30p
					; sub_3D80+Ep ...
	move.l  $50(a0), d0
	add.l   d0, 8(a0)
	move.w  (a1)+, d0

	cmp.w   8(a0), d0
	ble.s   @loc_3FE8

	move.w  d0, 8(a0)

@loc_3FE8:
	move.w  (a1)+, d0

	cmp.w   8(a0), d0
	bge.s   @loc_3FF4

	move.w  d0, 8(a0)

@loc_3FF4:
	move.l  $54(a0), d0
	add.l   d0, $C(a0)
	move.w  (a1)+, d0

	cmp.w   $C(a0), d0
	ble.s   @loc_4008

	move.w  d0, $C(a0)

@loc_4008:
	move.w  (a1)+, d0

	cmp.w   $C(a0), d0
	bge.s   @locret_4014

@loc_4010:
	move.w  d0, $C(a0)

@locret_4014:
	rts
; End of function sub_3FD4


; =============== S U B R O U T I N E =======================================


sub_4016:               ; CODE XREF: sub_3BD8+60p sub_3BD8+B0p ...
	movea.l (a1)+, a2
	move.w  $C(a0), d0
	bsr.s   sub_4048

	move.w  d1, $34(a0)
	bpl.s   loc_4026
	bmi.s   loc_403C

loc_4026:               ; CODE XREF: sub_4016+Cj sub_42B8+BAp
	move.w  8(a0), d0
	add.w   d1, d1
	add.w   d1, d1
	movea.l (a2, d1.w), a1
	bsr.s   sub_4048

	move.w  d1, $32(a0)
	bmi.s   loc_403C

	rts
; ---------------------------------------------------------------------------

loc_403C:
	move.w #$FFFF, $30(a0)
	ori    #1, ccr
	rts
; End of function sub_4016


; =============== S U B R O U T I N E =======================================


sub_4048:               ; CODE XREF: sub_3BD8+8Ep sub_4016+6p ...
	cmp.w  (a1)+, d0
	bls.s  @loc_4050

	addq.w #2, a1
	bra.s  sub_4048
; ---------------------------------------------------------------------------

@loc_4050:
	move.w (a1), d1
	rts
; End of function sub_4048


; =============== S U B R O U T I N E =======================================


sub_4054:               ; CODE XREF: sub_329A+D0j
					; sub_329A+152j ...
	move.w $30(a0), d0
	bpl.s  @loc_4066

	move.w d7, -(sp)

	moveq  #Z80CMD_FF92, d7
	jsr    sendCommandToZ80(pc)

	move.w (sp)+, d7
	rts
; ---------------------------------------------------------------------------

@loc_4066:
	cmpi.w #4, $24(a0)
	beq.s  @loc_4074

	lea    unk_4084(pc), a1
	bra.s  @loc_4078
; ---------------------------------------------------------------------------

@loc_4074:
	lea unk_409E(pc), a1

@loc_4078:
	move.w  $30(a0), d0
	move.b  (a1, d0.w), d0
	bra.w   sub_44CC
; End of function sub_4054

; ---------------------------------------------------------------------------
unk_4084:        ; DATA XREF: sub_4054+1Ao
	dc.b   0
	dc.b  $C
	dc.b $15
	dc.b   4
	dc.b   2
	dc.b   5
	dc.b   7
	dc.b   6
	dc.b   8
	dc.b   3
	dc.b   9
	dc.b $1F
	dc.b  $E
	dc.b $10
	dc.b  $F
	dc.b  $A
	dc.b $12
	dc.b $13
	dc.b $16
	dc.b $14
	dc.b $1C
	dc.b $20
	dc.b $21
	dc.b $22
	dc.b $23
	dc.b   0

unk_409E:        ; DATA XREF: sub_4054:loc_4074o
	dc.b   0
	dc.b  $C
	dc.b $15
	dc.b   4
	dc.b   2
	dc.b   5
	dc.b $18
	dc.b   6
	dc.b $17
	dc.b   3
	dc.b   9
	dc.b $1F
	dc.b $19
	dc.b $13
	dc.b   9
	dc.b   0

; =============== S U B R O U T I N E =======================================


sub_40AE:               ; CODE XREF: sub_329A+42p
	addi.b #$40, OBJ6B14.byte21(a0)
	bcc.s  @locret_40D2

	move.b OBJ6B14.byte21(a0), d0
	addq.b #1, d0
	andi.w #$F, d0
	move.b d0, OBJ6B14.byte21(a0)

	add.w  d0, d0
	move.w palette_40D4(pc, d0.w), (paletteBuffer2+$16).w
	bset   #0, (vdpUpdateFlags).w

@locret_40D2:
	rts
; End of function sub_40AE

; ---------------------------------------------------------------------------
palette_40D4:
	dc.w $000
	dc.w $022
	dc.w $044
	dc.w $066
	dc.w $088
	dc.w $0AA
	dc.w $0CC
	dc.w $0EE
	dc.w $0CC
	dc.w $0AA
	dc.w $088
	dc.w $066
	dc.w $044
	dc.w $022
	dc.w $000
	dc.w $000

; =============== S U B R O U T I N E =======================================


sub_40F4:               ; CODE XREF: sub_4CA6:loc_4CB2p
					; sub_4FB4p
	move.l #$10003, (dword_FFFFD332).w

	tst.b (byte_FFFFD003).w
	bne.s @loc_4108

	move.l (dword_FFFFD336).w, (dword_FFFFD332).w

@loc_4108:
	move.w (word_FFFFD33A).w, (word_FFFFD330).w
	bclr   #1, (byte_FFFFD302).w
	clr.l  (dword_FFFFD336).w
	clr.w  (word_FFFFD324).w

	st (byte_FFFFD34C).w

	bclr #0, (byte_FFFFD004).w
	bclr #1, (byte_FFFFD004).w
	rts
; End of function sub_40F4


; =============== S U B R O U T I N E =======================================


sub_412E:               ; CODE XREF: sub_4CA6+6p sub_4F9A+4p
	move.l #$10003, (dword_FFFFD332).w

	tst.b  (byte_FFFFD003).w
	beq.s  @loc_4142

	move.l (dword_FFFFD336).w, (dword_FFFFD332).w

@loc_4142:
	move.w (word_FFFFD33A).w, (word_FFFFD330).w
	bclr   #1, (byte_FFFFD302).w
	clr.l  (dword_FFFFD336).w

	move.w #4, (word_FFFFD324).w

	bclr   #0, (byte_FFFFD004).w
	bclr   #1, (byte_FFFFD004).w

	st (byte_FFFFD34C).w
	rts
; End of function sub_412E


; =============== S U B R O U T I N E =======================================


sub_416A:               ; CODE XREF: sub_3A40+16p sub_3ABC+6j ...
	move.l (dword_FFFFD336).w, (dword_FFFFD332).w

	move.l #7, (dword_FFFFD336).w
	move.w #8, (word_FFFFD324).w

	st (byte_FFFFD34C).w
	rts
; End of function sub_416A


; =============== S U B R O U T I N E =======================================


sub_4184:               ; CODE XREF: sub_4E48+30p
	move.l #$20000, (dword_FFFFD336).w
	move.w #$C,     (word_FFFFD324).w
	move.l #$20000, (dword_FFFFD332).w

	clr.l (dword_FFFFD33E).w
	clr.w (word_FFFFD33C).w

	st (byte_FFFFD34C).w
	rts
; End of function sub_4184


; =============== S U B R O U T I N E =======================================


sub_41A8:               ; CODE XREF: sub_50F6+20p
	bsr.s  sub_41DC

	moveq  #1, d1
	bsr.w  sub_59DE

	move.w #$10, (word_FFFFD324).w
	rts
; End of function sub_41A8


; =============== S U B R O U T I N E =======================================


sub_41B8:               ; CODE XREF: sub_5134+1Cp
	bsr.s  sub_41DC

	moveq  #2, d1
	bsr.w  sub_59DE

	move.w #$14, (word_FFFFD324).w
	rts
; End of function sub_41B8


; =============== S U B R O U T I N E =======================================


sub_41C8:
	bsr.s  sub_41DC

	move.w #$1C, (word_FFFFD324).w
	rts
; End of function sub_41C8


; =============== S U B R O U T I N E =======================================


sub_41D2:               ; CODE XREF: sub_4FDC+46p
	bsr.s  sub_41DC

	move.w #$18, (word_FFFFD324).w
	rts
; End of function sub_41D2


; =============== S U B R O U T I N E =======================================


sub_41DC:               ; CODE XREF: sub_41A8p sub_41B8p ...
	move.l (dword_FFFFD332).w, (dword_FFFFD336).w
	move.w (word_FFFFD330).w,  (word_FFFFD33A).w
	clr.l  (dword_FFFFD332).w
	rts
; End of function sub_41DC


; =============== S U B R O U T I N E =======================================


sub_41EE:               ; CODE XREF: sub_329A:loc_33A6p
					; sub_4400+74p ...
	movem.l a0, -(sp)

	lea   (obj_FFFFD300).w, a0
	bsr.w sub_3AEC

	st    $4C(a0)
	clr.l $32(a0)

	movem.l (sp)+, a0
	rts
; End of function sub_41EE


; =============== S U B R O U T I N E =======================================


sub_4208:               ; CODE XREF: sub_59DE+2p
	cmpi.w #$10, (word_FFFFD324).w
	beq.s  @locret_4216

	cmpi.w #$14, (word_FFFFD324).w

@locret_4216:
	rts
; End of function sub_4208


; =============== S U B R O U T I N E =======================================


sub_4218:               ; CODE XREF: sub_5E6Cp
	cmpi.w #4, (word_FFFFD324).w
	rts
; End of function sub_4218


; =============== S U B R O U T I N E =======================================


sub_4220:
	bset    #7, (a0)
	bne.s   @loc_423E

	move.l  #unk_12BD2, OBJ6B14.addr4(a0)
	move.w  #$130,      OBJ6B14.wordC(a0)
	move.b  #$80,       OBJ6B14.byte18(a0)
	clr.w               OBJ6B14.word32(a0)

@loc_423E:
	lea (obj_FFFFD300).w, a1

	cmpi.w  #$C, OBJ6B14.word24(a1)
	bne.s   @loc_42B0

	btst    #0, (byte_FFFFD004).w
	bne.w   @loc_42B0

	tst.w   OBJ6B14.word3C(a1)
	bne.s   @loc_42B0

	bclr    #1, OBJ6B14.flags2(a0)
	cmpi.w  #2, OBJ6B14.word34(a1)
	bne.s   @loc_4292

	move.b  (joy1Triggered).w, d0
	andi.b  #$70, d0
	beq.s   @loc_4292

	move.w  OBJ6B14.word32(a1), d0
	add.w   (word_FFFFD042).w,  d0
	move.w  (word_FFFFD168).w,  d1
	addq.w  #1, d1
	cmp.w   d1, d0
	bge.w   sub_38C0

	tst.w   OBJ6B14.word30(a1)
	bmi.w   sub_38C0

	move.w  d0, (word_FFFFD166).w

@loc_4292:
	move.w  (word_FFFFD166).w, d0
	sub.w   (word_FFFFD042).w, d0
	bmi.s   @loc_42B0

	cmpi.w  #$A, d0
	bge.s   @loc_42B0

	mulu.w  #$10, d0
	addi.w  #$A8, d0
	move.w  d0, OBJ6B14.word8(a0)
	rts
; ---------------------------------------------------------------------------

@loc_42B0:
	bset #1, OBJ6B14.flags2(a0)
	rts
; End of function sub_4220


; =============== S U B R O U T I N E =======================================


sub_42B8:               ; CODE XREF: sub_329A+46p
	cmpi.b #JOYTYPE_MULTITAP, (joy1Type).w
	bne.s  @loc_42D0

	lea (multitapControllerTypes).w, a1

	moveq #3, d0
	@loc_42C6:
		cmpi.b #2, (a1)+
		dbeq   d0, @loc_42C6

	beq.s @loc_42E0

@loc_42D0:
	cmpi.b #JOYTYPE_MEGAMOUSE, (joy2Type).w
	bne.s  @loc_4306

	cmpi.b #JOYTYPE_MEGAMOUSE, (joy1Type).w
	beq.s  @loc_4320

@loc_42E0:
	move.b (joy2Triggered).w, d0
	andi.w #$F0, d0
	or.b   d0, (joy1Triggered).w

	lea   ($FFFFFE0C).w, a3
	tst.l 6(a3)
	bne.s @loc_4318

	tst.b (joy1Down).w
	bne.s @loc_430E

	clr.l $50(a0)
	clr.l $54(a0)
	rts
; ---------------------------------------------------------------------------

@loc_4306:
	cmpi.b #JOYTYPE_MEGAMOUSE, (joy1Type).w
	beq.s  @loc_4320

@loc_430E:
	tst.b  (byte_FFFFD060).w
	bne.w  @loc_4348
	rts
; ---------------------------------------------------------------------------

@loc_4318:
	move.b #$81, (byte_FFFFD060).w
	bra.s  @loc_432A
; ---------------------------------------------------------------------------

@loc_4320:
	lea    (joy1MouseData).w, a3
	move.b #1, (byte_FFFFD060).w

@loc_432A:
	moveq  #0, d0
	move.w 6(a3), d0
	swap   d0
	asr.l  #1, d0
	move.l d0, $50(a0)

	moveq  #0, d0
	move.w 8(a3), d0
	swap   d0
	asr.l  #1, d0
	move.l d0, $54(a0)
	rts
; ---------------------------------------------------------------------------

@loc_4348:
	clr.b  (byte_FFFFD060).w

	move.w $34(a0), d1
	bpl.s  @loc_4376

	andi.w #$FF, d1

	btst   #JOYBIT_UP, (joy1Down).w
	beq.s  @loc_4360

	addq.w #1, d1

@loc_4360:
	move.w  d1, $34(a0)
	move.w  $24(a0), d0

	cmpi.w  #$10, d0
	bcc.s   @loc_4376

	movea.l dword_43CE(pc, d0.w), a2
	bsr.w   loc_4026

@loc_4376:
	move.w $32(a0), d0
	bpl.s  @loc_43B8

	cmpi.w #0, $24(a0)
	bne.s  @loc_43A4

	tst.w  $34(a0)
	bne.s  @loc_43A4

	cmpi.w #$FFFF, d0
	beq.s  @loc_439A

	cmpi.w #$8001, d0
	bne.s  @loc_43A4

@loc_4396:
	moveq #1, d0
	bra.s @loc_43B2
; ---------------------------------------------------------------------------

@loc_439A:
	bsr.w checkDiscBootable
	bne.s @loc_4396

	moveq #0, d0
	bra.s @loc_43B2
; ---------------------------------------------------------------------------

@loc_43A4:
	andi.w #$FF, d0
	btst   #JOYBIT_LEFT, (joy1Down).w
	beq.s  @loc_43B2

	addq.w #1, d0

@loc_43B2:
	move.w d0, $32(a0)
	bra.s  @locret_43CC
; ---------------------------------------------------------------------------

@loc_43B8:
	cmpi.w #0, $24(a0)
	bne.s  @locret_43CC

	tst.l  $34(a0)
	bne.s  @locret_43CC

	bsr.w  checkDiscBootable
	bne.s  @loc_4396

@locret_43CC:
	rts
; End of function sub_42B8

; ---------------------------------------------------------------------------
dword_43CE:
	dc.l off_3D30
	dc.l off_3DC0
	dc.l off_3E12
	dc.l off_3E12

; =============== S U B R O U T I N E =======================================


sub_43DE:               ; CODE XREF: sub_4B46p sub_4BA2+9Cp
	move.b (joy1Down).w, d0

	tst.b  (byte_FFFFD060).w
	bpl.s  @loc_43EC

	or.b   (joy2Down).w, d0

@loc_43EC:
	andi.b #$70, d0

	rts
; End of function sub_43DE


; =============== S U B R O U T I N E =======================================


sub_43F2:               ; CODE XREF: state_3040+10p
	move.w (word_FFFFD020).w, d0
	beq.s  @locret_43FE

	bsr.s  sub_4400

	ori    #1, ccr

@locret_43FE:
	rts
; End of function sub_43F2


; =============== S U B R O U T I N E =======================================


sub_4400:               ; CODE XREF: sub_43F2+6p
	lea (byte_FFFFD008).w, a0
	lea sub_1730(pc), a6

	bclr    #0, (word_FFFFD020+1).w
	bne.w   sub_4A58

	bclr    #6, (word_FFFFD020+1).w
	bne.w   sub_4B70

	bclr    #7, (word_FFFFD020+1).w
	bne.w   sub_47EE

	bclr    #0, (word_FFFFD020).w
	bne.w   sub_47D2

	bclr    #2, (word_FFFFD020+1).w
	bne.w   sub_4624

	bclr    #4, (word_FFFFD020+1).w
	bne.w   sub_45BE

	bclr    #5, (word_FFFFD020+1).w
	bra.w   @loc_444E
; ---------------------------------------------------------------------------

@loc_444E:
	move.b (word_FFFFFE44+1).w, d7

	cmpi.w #$1000, (word_FFFFD024).w
	bne.s  @loc_447E

	moveq  #0, d7
	bset   #4, (byte_FFFFD004).w
	bset   #0, (byte_FFFFD005).w

	bsr.w  sub_4720
	bsr.w  sub_4718
	bsr.w  sub_47FE
	bsr.w  sub_41EE

	moveq  #8, d1
	bsr.w  sub_59DE

@loc_447E:
	bsr.w  sub_52F4
	bsr.w  sub_5336

	bset   #2, (byte_FFFFD004).w
	bsr.w  sub_5CFA

	tst.b  (byte_FFFFD038).w
	beq.s  @loc_44BC

	bset   #6, (byte_FFFFD004).w
	bset   #6, 1(a0)
	bsr.w  sub_53D2

	cmp.b  (byte_FFFFD038).w, d1
	bcc.s  @loc_44B0

	move.b d1, (byte_FFFFD038).w

@loc_44B0:
	moveq  #0, d0
	move.b (byte_FFFFD038).w, d0
	subq.w #1, d0
	bsr.w  sub_53B6

@loc_44BC:
	btst   #4, (byte_FFFFD004).w
	bne.w  @locret_44CA
	bsr.w  sub_6396

@locret_44CA:
	rts
; End of function sub_4400


; =============== S U B R O U T I N E =======================================


sub_44CC:               ; CODE XREF: sub_3ABC+1Ep sub_4054+2Cj
	move.w d0, (word_FFFFD000).w
	st     (byte_FFFFD002).w

	rts
; End of function sub_44CC


; =============== S U B R O U T I N E =======================================


sub_44D6:
	move.w #$B, (word_FFFFD000).w
	st     (byte_FFFFD002).w

	rts
; End of function sub_44D6


; =============== S U B R O U T I N E =======================================


sub_44E2:               ; CODE XREF: state_3040:loc_3070p
	bsr.w getDiscType

	bmi.s @loc_4504

	btst  #0, (byte_FFFFD008).w
	beq.s @loc_44F8

	moveq #$FFFFFFFF, d1
	bsr.w setDiscType

	bra.s @loc_4504
; ---------------------------------------------------------------------------

@loc_44F8:
	bset  #3, (byte_FFFFD004).w
	bne.s @loc_4504

	bsr.w sub_5732

@loc_4504:
	lea    (byte_FFFFD008).w, a0
	lea    sub_1730(pc), a6

	move.w (word_FFFFD000).w, d0
	asl.w  #2, d0
	jmp    loc_4516(pc, d0.w)
; End of function sub_44E2

; ---------------------------------------------------------------------------

loc_4516:
	bra.w   sub_45A6
; ---------------------------------------------------------------------------
	bra.w   locret_45BC
; ---------------------------------------------------------------------------
	bra.w   sub_4642
; ---------------------------------------------------------------------------
	bra.w   sub_4730
; ---------------------------------------------------------------------------
	bra.w   sub_4822
; ---------------------------------------------------------------------------
	bra.w   sub_48FE
; ---------------------------------------------------------------------------
	bra.w   sub_49DC
; ---------------------------------------------------------------------------
	bra.w   sub_4A70
; ---------------------------------------------------------------------------
	bra.w   sub_4BA2
; ---------------------------------------------------------------------------
	bra.w   sub_4D24
; ---------------------------------------------------------------------------
	bra.w   loc_4D88
; ---------------------------------------------------------------------------
	bra.w   sub_4F2C
; ---------------------------------------------------------------------------
	bra.w   sub_4F64
; ---------------------------------------------------------------------------
	bra.w   sub_4F8E
; ---------------------------------------------------------------------------
	bra.w   sub_4F9A
; ---------------------------------------------------------------------------
	bra.w   sub_4FDC
; ---------------------------------------------------------------------------
	bra.w   sub_506A
; ---------------------------------------------------------------------------
	bra.w   sub_506A
; ---------------------------------------------------------------------------
	bra.w   sub_50F6
; ---------------------------------------------------------------------------
	bra.w   sub_516C
; ---------------------------------------------------------------------------
	bra.w   sub_5134
; ---------------------------------------------------------------------------
	bra.w   sub_51C6
; ---------------------------------------------------------------------------
	bra.w   sub_4E48
; ---------------------------------------------------------------------------
	bra.w   sub_51D6
; ---------------------------------------------------------------------------
	bra.w   loc_51FA
; ---------------------------------------------------------------------------
	bra.w   sub_4FB4
; ---------------------------------------------------------------------------
	bra.w   sub_5042
; ---------------------------------------------------------------------------
	bra.w   sub_480C
; ---------------------------------------------------------------------------
	bra.w   sub_4F2C
; ---------------------------------------------------------------------------
	nop
	rts
; ---------------------------------------------------------------------------
	nop
	rts
; ---------------------------------------------------------------------------
	bra.w   sub_4C8E
; ---------------------------------------------------------------------------
	bra.w   sub_4CA6
; ---------------------------------------------------------------------------
	bra.w   sub_4CC4
; ---------------------------------------------------------------------------
	bra.w   sub_4D08
; ---------------------------------------------------------------------------
	bra.w   sub_4E9E

; =============== S U B R O U T I N E =======================================


sub_45A6:               ; CODE XREF: ROM:loc_4516j
	btst  #1, (word_FFFFD04E).w
	bne.w sub_4730

	btst  #2, (word_FFFFD04E).w
	bne.w sub_4642

	rts
; End of function sub_45A6

; ---------------------------------------------------------------------------

locret_45BC:                ; CODE XREF: ROM:0000451Aj
	rts

; =============== S U B R O U T I N E =======================================


sub_45BE:               ; CODE XREF: sub_4400+40j
	clr.w   (word_FFFFD04E).w
	moveq   #2,d0
	bsr.w   sub_1800
	bset    #0,(a0)
	andi.b  #3,(byte_FFFFD004).w
	bclr    #0,(byte_FFFFD005).w
	bsr.w   sub_4A58
	moveq   #0,d7
	bsr.w   sub_52F4
	bsr.w   loc_4F3C
	move.b  #$10,(byte_FFFFD00F).w
	move.b  #$10,(byte_FFFFD011).w
	bsr.w   sub_4F18
	bsr.w   sub_5DB0
	clr.b   (byte_FFFFD038).w
	clr.b   (word_FFFFFE44+1).w
	clr.w   (word_FFFFFE40).w
	moveq   #$FFFFFFFF,d1
	bsr.w   setDiscType
	bsr.w   sub_5732
	bsr.w   sub_41EE
	moveq   #7,d1
	bsr.w   sub_59DE
	rts
; End of function sub_45BE


; =============== S U B R O U T I N E =======================================


sub_461C:
	bclr    #0,(a0)
	bne.s   sub_4624
	rts
; End of function sub_461C


; =============== S U B R O U T I N E =======================================


sub_4624:               ; CODE XREF: sub_4400+36j sub_461C+4j
	move.w  #$1FF,d1
	moveq   #$12,d0
	jsr (a6)
	bclr    #0,(a0)
	bclr    #2,(byte_FFFFD004).w
	moveq   #6,d1
	bsr.w   sub_59DE
	andi    #$FB,ccr ; '├╗'
	rts
; End of function sub_4624


; =============== S U B R O U T I N E =======================================


sub_4642:               ; CODE XREF: ROM:0000451Ej
					; sub_45A6+10j
	btst    #4,(byte_FFFFD004).w
	bne.s   loc_46B8
	btst    #2,(byte_FFFFD004).w
	bne.s   loc_4670
	bsr.w   sub_4710
	bsr.w   sub_4728
	bset    #2,(word_FFFFD04E).w
	bclr    #1,(word_FFFFD04E).w
	beq.w   loc_46B8
	bsr.w   sub_47FE
	bra.s   loc_46B8
; ---------------------------------------------------------------------------

loc_4670:               ; CODE XREF: sub_4642+Ej
	clr.w   (word_FFFFD04E).w
	btst    #1,(a0)
	beq.s   loc_4692
	tst.b   (byte_FFFFD050).w
	bne.s   locret_46C0
	bclr    #1,(a0)
	bset    #2,(a0)
	moveq   #6,d0
	jsr (a6)
	bsr.w   sub_47FE
	bra.s   loc_46A6
; ---------------------------------------------------------------------------

loc_4692:               ; CODE XREF: sub_4642+36j
	bset    #2,(a0)
	bne.s   loc_46B8
	bsr.s   sub_46F4
	beq.s   loc_46A2
	moveq   #$4E,d0 ; 'N'
	jsr (a6)
	bra.s   loc_46A6
; ---------------------------------------------------------------------------

loc_46A2:               ; CODE XREF: sub_4642+58j
	moveq   #$4C,d0 ; 'L'
	jsr (a6)

loc_46A6:               ; CODE XREF: sub_4642+4Ej sub_4642+5Ej
	bsr.w   sub_4710
	bsr.w   sub_4728
	moveq   #4,d1
	bsr.w   sub_59DE
	bsr.w   sub_51A4

loc_46B8:               ; CODE XREF: sub_4642+6j sub_4642+24j ...
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w

locret_46C0:                ; CODE XREF: sub_4642+3Cj
	rts
; End of function sub_4642


; =============== S U B R O U T I N E =======================================


sub_46C2:               ; CODE XREF: sub_4D9E+36j sub_506A+40j
	bsr.s   sub_46F4
	btst    #1,(a0)
	beq.s   loc_46D0
	moveq   #$50,d0 ; 'P'
	jsr (a6)
	bra.s   loc_46EA
; ---------------------------------------------------------------------------

loc_46D0:               ; CODE XREF: sub_46C2+6j
	moveq   #$4E,d0 ; 'N'
	jsr (a6)
	bset    #2,(a0)
	bsr.w   sub_4710
	bsr.w   sub_4728
	moveq   #4,d1
	bsr.w   sub_59DE
	bsr.w   sub_51A4

loc_46EA:               ; CODE XREF: sub_46C2+Cj
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_46C2


; =============== S U B R O U T I N E =======================================


sub_46F4:               ; CODE XREF: sub_4642+56p sub_46C2p ...
	move.w  (a0),d0
	andi.w  #$400D,d0
	bne.s   loc_4704
	moveq   #0,d1
	move.b  (byte_FFFFD038).w,d1
	bne.s   loc_4708

loc_4704:               ; CODE XREF: sub_46F4+6j
	bsr.w   sub_53C2

loc_4708:               ; CODE XREF: sub_46F4+Ej
	move.w  (a0),d0
	andi.w  #$400D,d0
	rts
; End of function sub_46F4


; =============== S U B R O U T I N E =======================================


sub_4710:               ; CODE XREF: sub_4642+10p
					; sub_4642:loc_46A6p ...
	move.w  #$2000,d0
	bra.w   loc_471A
; End of function sub_4710


; =============== S U B R O U T I N E =======================================


sub_4718:               ; CODE XREF: sub_4400+6Cp sub_4730+12p ...
	moveq   #0,d0

loc_471A:               ; CODE XREF: sub_4710+4j
	moveq   #1,d1
	bra.w   sub_5764
; End of function sub_4718


; =============== S U B R O U T I N E =======================================


sub_4720:               ; CODE XREF: sub_4400+68p sub_49DC+Cp ...
	move.w  #$2000,d0
	bra.w   loc_472A
; End of function sub_4720


; =============== S U B R O U T I N E =======================================


sub_4728:               ; CODE XREF: sub_4642+14p sub_4642+68p ...
	moveq   #0,d0

loc_472A:               ; CODE XREF: sub_4720+4j
	moveq   #3,d1
	bra.w   sub_5764
; End of function sub_4728


; =============== S U B R O U T I N E =======================================


sub_4730:               ; CODE XREF: ROM:00004522j sub_45A6+6j
	btst    #4,(byte_FFFFD004).w
	bne.w   loc_47C8
	btst    #2,(byte_FFFFD004).w
	bne.s   loc_4754
	bsr.s   sub_4718
	bsr.s   sub_4728
	bsr.w   sub_47DA
	bset    #1,(word_FFFFD04E).w
	bra.w   loc_47C8
; ---------------------------------------------------------------------------

loc_4754:               ; CODE XREF: sub_4730+10j
	move.w  (a0),d0
	move.w  (word_FFFFD022).w,d1
	eor.w   d1,d0
	btst    #9,d0
	bne.w   locret_47D0
	clr.w   (word_FFFFD04E).w
	btst    #2,(a0)
	bne.s   loc_47A2
	btst    #1,(a0)
	bne.s   loc_47C0
	bset    #1,(a0)
	bset    #2,(a0)
	move.w  #$2000,d0
	bsr.w   sub_4806
	bsr.s   sub_4728
	moveq   #5,d1
	bsr.w   sub_59DE
	bsr.w   sub_51A4
	bsr.w   sub_46F4
	beq.s   loc_479C
	moveq   #$50,d0 ; 'P'
	jsr (a6)
	bra.s   loc_47C8
; ---------------------------------------------------------------------------

loc_479C:               ; CODE XREF: sub_4730+64j
	moveq   #$1C,d0
	jsr (a6)
	bra.s   loc_47C8
; ---------------------------------------------------------------------------

loc_47A2:               ; CODE XREF: sub_4730+3Cj
	btst    #1,(a0)
	bne.s   loc_47C0
	btst    #4,(word_FFFFD036+1).w
	bne.s   loc_47C0
	bsr.w   sub_4C74
	bcs.s   loc_47C8
	tst.b   (byte_FFFFD050).w
	bne.s   locret_47D0
	bsr.s   sub_47D2
	bra.s   loc_47C8
; ---------------------------------------------------------------------------

loc_47C0:               ; CODE XREF: sub_4730+42j sub_4730+76j ...
	tst.b   (byte_FFFFD050).w
	bne.s   locret_47D0
	bsr.s   sub_47EE

loc_47C8:               ; CODE XREF: sub_4730+6j sub_4730+20j ...
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w

locret_47D0:                ; CODE XREF: sub_4730+30j sub_4730+8Aj ...
	rts
; End of function sub_4730


; =============== S U B R O U T I N E =======================================


sub_47D2:               ; CODE XREF: sub_4400+2Cj sub_4730+8Cp
	bset    #1,(a0)
	moveq   #4,d0
	jsr (a6)
; End of function sub_47D2


; =============== S U B R O U T I N E =======================================


sub_47DA:               ; CODE XREF: sub_4730+16p
	move.w  #$2000,d0
	bsr.s   sub_4806
	moveq   #5,d1
	bsr.w   sub_59DE
	bsr.w   sub_4728
	bra.w   sub_4718
; End of function sub_47DA


; =============== S U B R O U T I N E =======================================


sub_47EE:               ; CODE XREF: sub_4400+22j sub_4730+96p
	bclr    #1,(a0)
	moveq   #6,d0
	jsr (a6)
	bsr.w   sub_4710
	bsr.w   sub_4728
; End of function sub_47EE


; =============== S U B R O U T I N E =======================================


sub_47FE:               ; CODE XREF: sub_4400+70p sub_4642+28p ...
	moveq   #6,d1
	bsr.w   sub_59DE
	moveq   #0,d0
; End of function sub_47FE


; =============== S U B R O U T I N E =======================================


sub_4806:               ; CODE XREF: sub_4730+50p sub_47DA+4p
	moveq   #2,d1
	bra.w   sub_5764
; End of function sub_4806


; =============== S U B R O U T I N E =======================================


sub_480C:               ; CODE XREF: ROM:00004582j
	cmpi.w  #$100,(word_FFFFD024).w
	bne.s   locret_4820
	moveq   #4,d0
	jsr (a6)
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w

locret_4820:                ; CODE XREF: sub_480C+6j
	rts
; End of function sub_480C


; =============== S U B R O U T I N E =======================================


sub_4822:               ; CODE XREF: ROM:00004526j
	move.w  (a0),d7
	btst    #8,d7
	bne.w   loc_48EC
	btst    #2,(byte_FFFFD004).w
	beq.w   loc_48EC
	btst    #4,(byte_FFFFD004).w
	bne.w   loc_48E2
	btst    #1,d7
	bne.w   sub_5250
	btst    #$A,d7
	beq.s   loc_48BE
	move.w  (dword_FFFFD02C).w,d6
	cmpi.w  #2,d6
	bcs.s   loc_485E
	bsr.w   sub_53C2
	bra.s   loc_4862
; ---------------------------------------------------------------------------

loc_485E:               ; CODE XREF: sub_4822+34j
	bsr.w   sub_541C

loc_4862:               ; CODE XREF: sub_4822+3Aj
	move.b  d1,(byte_FFFFD038).w
	bset    #4,(byte_FFFFD005).w
	andi.b  #$DF,(byte_FFFFD005).w
	move.w  d1,-(sp)
	move.w  #$2000,d0
	moveq   #4,d1
	bsr.w   sub_5764
	moveq   #0,d0
	moveq   #5,d1
	bsr.w   sub_5764
	move.w  (sp)+,d1
	bset    #6,(byte_FFFFD004).w
	bset    #6,1(a0)
	andi.w  #$400D,d7
	beq.s   loc_48AC
	btst    #1,(a0)
	beq.s   loc_48A6
	moveq   #$50,d0 ; 'P'
	jsr (a6)
	bra.s   loc_48E2
; ---------------------------------------------------------------------------

loc_48A6:               ; CODE XREF: sub_4822+7Cj
	moveq   #$4E,d0 ; 'N'
	jsr (a6)
	bra.s   loc_48E2
; ---------------------------------------------------------------------------

loc_48AC:               ; CODE XREF: sub_4822+76j
	btst    #1,(a0)
	beq.s   loc_48B8
	moveq   #$1C,d0
	jsr (a6)
	bra.s   loc_48E2
; ---------------------------------------------------------------------------

loc_48B8:               ; CODE XREF: sub_4822+8Ej
	moveq   #$4C,d0 ; 'L'
	jsr (a6)
	bra.s   loc_48E2
; ---------------------------------------------------------------------------

loc_48BE:               ; CODE XREF: sub_4822+2Aj
	bsr.w   sub_541C
	move.b  d1,(byte_FFFFD038).w

loc_48C6:               ; CODE XREF: sub_4822+D2j sub_4822+DAj
	bset    #6,(byte_FFFFD004).w
	bset    #6,1(a0)
	move.w  #$2000,d0
	moveq   #4,d1
	bsr.w   sub_5764
	move.b  #$14,(byte_FFFFD05A).w

loc_48E2:               ; CODE XREF: sub_4822+1Aj sub_4822+82j ...
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; ---------------------------------------------------------------------------

loc_48EC:               ; CODE XREF: sub_4822+6j sub_4822+10j
	subq.b  #1,(byte_FFFFD038).w
	beq.s   loc_48F6
	bmi.s   loc_48F6
	bra.s   loc_48C6
; ---------------------------------------------------------------------------

loc_48F6:               ; CODE XREF: sub_4822+CEj sub_4822+D0j
	move.b  #1,(byte_FFFFD038).w
	bra.s   loc_48C6
; End of function sub_4822


; =============== S U B R O U T I N E =======================================


sub_48FE:               ; CODE XREF: ROM:0000452Aj
	move.w  (a0),d7
	btst    #8,d7
	bne.w   loc_498E
	btst    #2,(byte_FFFFD004).w
	beq.w   loc_498E
	btst    #4,(byte_FFFFD004).w
	bne.w   loc_4984
	btst    #1,d7
	bne.w   sub_5250
	btst    #$A,d7
	beq.w   loc_495E
	bsr.w   sub_53E4
	beq.w   loc_4984
	move.b  d1,(byte_FFFFD038).w
	bset    #5,(byte_FFFFD005).w
	andi.b  #$EF,(byte_FFFFD005).w
	move.w  d1,-(sp)
	move.w  #$2000,d0
	moveq   #5,d1
	bsr.w   sub_5764
	moveq   #0,d0
	moveq   #4,d1
	bsr.w   sub_5764
	move.w  (sp)+,d1
	bsr.s   sub_49A2
	bra.s   loc_4984
; ---------------------------------------------------------------------------

loc_495E:               ; CODE XREF: sub_48FE+2Aj
	bsr.w   sub_53E4
	beq.s   loc_4984
	move.b  d1,(byte_FFFFD038).w

loc_4968:               ; CODE XREF: sub_48FE+9Aj sub_48FE+A2j
	bset    #6,(byte_FFFFD004).w
	bset    #6,1(a0)
	move.w  #$2000,d0
	moveq   #5,d1
	bsr.w   sub_5764
	move.b  #$14,(byte_FFFFD05B).w

loc_4984:               ; CODE XREF: sub_48FE+1Aj sub_48FE+32j ...
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; ---------------------------------------------------------------------------

loc_498E:               ; CODE XREF: sub_48FE+6j sub_48FE+10j
	addq.b  #1,(byte_FFFFD038).w
	cmpi.b  #$63,(byte_FFFFD038).w ; 'c'
	bls.s   loc_4968
	move.b  #$63,(byte_FFFFD038).w ; 'c'
	bra.s   loc_4968
; End of function sub_48FE


; =============== S U B R O U T I N E =======================================


sub_49A2:               ; CODE XREF: sub_48FE+5Cp sub_4BA2+68j ...
	move.b  d1,(byte_FFFFD038).w
	bset    #6,(byte_FFFFD004).w
	bset    #6,1(a0)
	andi.w  #$400D,d7
	beq.s   loc_49CA
	btst    #1,(a0)
	beq.s   loc_49C4
	moveq   #$50,d0 ; 'P'
	jsr (a6)
	bra.s   locret_49DA
; ---------------------------------------------------------------------------

loc_49C4:               ; CODE XREF: sub_49A2+1Aj
	moveq   #$4E,d0 ; 'N'
	jsr (a6)
	bra.s   locret_49DA
; ---------------------------------------------------------------------------

loc_49CA:               ; CODE XREF: sub_49A2+14j
	btst    #1,(a0)
	beq.s   loc_49D6
	moveq   #$1C,d0
	jsr (a6)
	bra.s   locret_49DA
; ---------------------------------------------------------------------------

loc_49D6:               ; CODE XREF: sub_49A2+2Cj
	moveq   #$4C,d0 ; 'L'
	jsr (a6)

locret_49DA:                ; CODE XREF: sub_49A2+20j sub_49A2+26j ...
	rts
; End of function sub_49A2


; =============== S U B R O U T I N E =======================================


sub_49DC:               ; CODE XREF: ROM:0000452Ej
	btst    #2,(a0)
	bne.s   loc_49FE
	tst.w   (word_FFFFD04E).w
	beq.s   loc_49F8
	bsr.w   sub_4720
	bsr.w   sub_4718
	bsr.w   sub_47FE
	clr.w   (word_FFFFD04E).w

loc_49F8:               ; CODE XREF: sub_49DC+Aj
	btst    #1,(a0)
	beq.s   loc_4A04

loc_49FE:               ; CODE XREF: sub_49DC+4j
	bsr.s   sub_4A0E
	bsr.w   sub_5034

loc_4A04:               ; CODE XREF: sub_49DC+20j
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_49DC


; =============== S U B R O U T I N E =======================================


sub_4A0E:               ; CODE XREF: sub_49DC:loc_49FEp
				; sub_4BA2+74j
	moveq   #2,d0
	jsr (a6)

loc_4A12:               ; CODE XREF: sub_4A58+4j sub_4A58+16j
	bclr    #2,(a0)
	bclr    #1,(a0)
	moveq   #6,d1
	bsr.w   sub_59DE
	bsr.w   sub_51BC
	bsr.w   sub_53B0
	bsr.w   sub_53C2
	move.b  d1,(byte_FFFFD038).w
	bclr    #6,(byte_FFFFD004).w
	bclr    #6,1(a0)
	move.b  (byte_FFFFFE43).w,d3
	bsr.w   sub_53B0
	clr.b   (byte_FFFFFE43).w
	bsr.w   sub_5034
	bsr.w   sub_4720
	bsr.w   sub_47FE
	bra.w   sub_4718
; End of function sub_4A0E


; =============== S U B R O U T I N E =======================================


sub_4A58:               ; CODE XREF: sub_4400+Ej sub_45BE+1Ap
	btst    #3,(a0)
	beq.s   loc_4A12
	bsr.w   sub_4B80
	bsr.w   sub_4C54
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	bra.s   loc_4A12
; End of function sub_4A58


; =============== S U B R O U T I N E =======================================


sub_4A70:               ; CODE XREF: ROM:00004532j
	move.w  (a0),d0
	btst    #$A,d0
	beq.w   sub_5250
	btst    #1,d0
	bne.w   sub_5250
	move.w  (word_FFFFD022).w,d1
	eor.w   d0,d1
	btst    #$A,d1
	bne.w   loc_4B66
	btst    #9,d1
	bne.w   locret_4B6E
	btst    #$B,d1
	bne.w   locret_4B6E
	tst.b   (byte_FFFFD002).w
	bpl.w   sub_4B46
	cmpi.w  #$100,(word_FFFFD024).w
	beq.s   loc_4ADE
	cmpi.w  #$500,(word_FFFFD024).w
	beq.s   loc_4ADE
	cmpi.w  #0,(word_FFFFD024).w
	bne.w   loc_4B66
	btst    #1,(word_FFFFD036+1).w
	bne.w   loc_4B66
	andi.w  #$400D,d0
	beq.s   loc_4ADE
	bsr.w   sub_53C2
	cmp.b   (byte_FFFFD030).w,d1
	bne.w   loc_4B66

loc_4ADE:               ; CODE XREF: sub_4A70+3Ej sub_4A70+46j ...
	bset    #3,(a0)
	bclr    #4,(a0)
	move.b  #1,(byte_FFFFD002).w
	move.w  #$2000,d0
	moveq   #6,d1
	bsr.w   sub_5764
	move.w  (a0),d0
	andi.w  #$400D,d0
	bne.s   sub_4B22
	bsr.w   sub_53C2
	cmp.b   (word_FFFFFE44).w,d1
	bne.s   sub_4B40
	cmpi.w  #5,(dword_FFFFD02C).w
	bhi.s   sub_4B40
	bset    #5,1(a0)
	bset    #0,(byte_FFFFD00A).w
	moveq   #$1C,d0
	jsr (a6)
	rts
; End of function sub_4A70


; =============== S U B R O U T I N E =======================================


sub_4B22:               ; CODE XREF: sub_4A70+8Cj
	cmpi.w  #5,(dword_FFFFD02C).w
	bhi.s   sub_4B40
	bset    #5,1(a0)
	bset    #0,(byte_FFFFD00A).w
	bsr.w   sub_53C2
	moveq   #$50,d0 ; 'P'
	jsr (a6)
	rts
; End of function sub_4B22


; =============== S U B R O U T I N E =======================================


sub_4B40:               ; CODE XREF: sub_4A70+96j sub_4A70+9Ej ...
	moveq   #$A,d0
	jsr (a6)
	rts
; End of function sub_4B40


; =============== S U B R O U T I N E =======================================


sub_4B46:               ; CODE XREF: sub_4A70+34j
	bsr.w   sub_43DE
	bne.s   locret_4B6E
	bsr.s   sub_4B80
	bclr    #0,(byte_FFFFD00A).w
	beq.s   loc_4B62
	btst    #1,(a0)
	bne.s   loc_4B66
	moveq   #6,d0
	jsr (a6)
	bra.s   loc_4B66
; ---------------------------------------------------------------------------

loc_4B62:               ; CODE XREF: sub_4B46+Ej
	moveq   #$C,d0
	jsr (a6)

loc_4B66:               ; CODE XREF: sub_4A70+1Cj sub_4A70+4Ej ...
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w

locret_4B6E:                ; CODE XREF: sub_4A70+24j sub_4A70+2Cj ...
	rts
; End of function sub_4B46


; =============== S U B R O U T I N E =======================================


sub_4B70:               ; CODE XREF: sub_4400+18j
	btst    #3,(a0)
	bne.s   loc_4B78
	rts
; ---------------------------------------------------------------------------

loc_4B78:               ; CODE XREF: sub_4B70+4j
	bset    #0,(byte_FFFFD00A).w
	rts
; End of function sub_4B70


; =============== S U B R O U T I N E =======================================


sub_4B80:               ; CODE XREF: sub_4A58+6p sub_4B46+6p
	btst    #4,(a0)
	bne.s   locret_4B8C
	bclr    #3,(a0)
	bne.s   loc_4B8E

locret_4B8C:                ; CODE XREF: sub_4B80+4j
	rts
; ---------------------------------------------------------------------------

loc_4B8E:               ; CODE XREF: sub_4B80+Aj
	bclr    #5,1(a0)
	moveq   #2,d0
	bsr.w   sub_1800
	moveq   #0,d0
	moveq   #6,d1
	bra.w   sub_5764
; End of function sub_4B80


; =============== S U B R O U T I N E =======================================


sub_4BA2:               ; CODE XREF: ROM:00004536j
	move.w  (a0),d0
	btst    #$A,d0
	beq.w   sub_5250
	btst    #1,d0
	bne.w   sub_5250
	move.w  (word_FFFFD022).w,d1
	eor.w   d0,d1
	btst    #$A,d1
	bne.w   loc_4C4A
	btst    #9,d1
	bne.w   locret_4C52
	btst    #$B,d1
	bne.w   locret_4C52
	tst.b   (byte_FFFFD002).w
	bpl.s   loc_4C36
	cmpi.w  #$100,(word_FFFFD024).w
	beq.s   loc_4BF0
	cmpi.w  #$500,(word_FFFFD024).w
	beq.s   loc_4BF0
	cmpi.w  #0,(word_FFFFD024).w
	bne.s   loc_4C4A

loc_4BF0:               ; CODE XREF: sub_4BA2+3Cj sub_4BA2+44j
	bsr.w   sub_4C74
	bcc.s   loc_4C1A
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	btst    #0,1(a0)
	beq.s   loc_4C0E
	bsr.w   sub_53C2
	bra.w   sub_49A2
; ---------------------------------------------------------------------------

loc_4C0E:               ; CODE XREF: sub_4BA2+62j
	bsr.w   sub_53E4
	bne.w   sub_49A2
	bra.w   sub_4A0E
; ---------------------------------------------------------------------------

loc_4C1A:               ; CODE XREF: sub_4BA2+52j
	bset    #3,(a0)
	bset    #4,(a0)
	move.b  #1,(byte_FFFFD002).w
	moveq   #8,d0
	jsr (a6)
	move.w  #$2000,d0
	moveq   #7,d1
	bra.w   sub_5764
; ---------------------------------------------------------------------------

loc_4C36:               ; CODE XREF: sub_4BA2+34j
	btst    #1,(word_FFFFD036+1).w
	bne.s   locret_4C52
	bsr.w   sub_43DE
	bne.s   locret_4C52
	moveq   #$C,d0
	jsr (a6)
	bsr.s   sub_4C54

loc_4C4A:               ; CODE XREF: sub_4BA2+1Cj sub_4BA2+4Cj
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w

locret_4C52:                ; CODE XREF: sub_4BA2+24j sub_4BA2+2Cj ...
	rts
; End of function sub_4BA2


; =============== S U B R O U T I N E =======================================


sub_4C54:               ; CODE XREF: sub_4A58+Ap sub_4BA2+A6p
	bclr    #4,(a0)
	beq.s   locret_4C60
	bclr    #3,(a0)
	bne.s   loc_4C62

locret_4C60:                ; CODE XREF: sub_4C54+4j
	rts
; ---------------------------------------------------------------------------

loc_4C62:               ; CODE XREF: sub_4C54+Aj
	moveq   #2,d0
	bsr.w   sub_1800
	bclr    #4,(a0)
	moveq   #0,d0
	moveq   #7,d1
	bra.w   sub_5764
; End of function sub_4C54


; =============== S U B R O U T I N E =======================================


sub_4C74:               ; CODE XREF: sub_4730+80p
					; sub_4BA2:loc_4BF0p
	move.l (word_FFFFFE40).w, d0

	moveq #4, d1
	swap  d1

	movem.l a0-a1, -(sp)
	bsr.w   sub_1A4E
	movem.l (sp)+, a0-a1

	cmp.w (dword_FFFFD028).w, d0
	rts
; End of function sub_4C74


; =============== S U B R O U T I N E =======================================


sub_4C8E:               ; CODE XREF: ROM:00004592j
	btst    #0,(a0)
	bne.s   loc_4C9C
	bsr.w   sub_5B82
	bsr.w   sub_416A

loc_4C9C:               ; CODE XREF: sub_4C8E+4j
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4C8E


; =============== S U B R O U T I N E =======================================


sub_4CA6:               ; CODE XREF: ROM:00004596j
	tst.b   (byte_FFFFD003).w
	beq.s   loc_4CB2
	bsr.w   sub_412E
	bra.s   loc_4CB6
; ---------------------------------------------------------------------------

loc_4CB2:               ; CODE XREF: sub_4CA6+4j
	bsr.w   sub_40F4

loc_4CB6:               ; CODE XREF: sub_4CA6+Aj
	bsr.w   sub_5C20
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4CA6


; =============== S U B R O U T I N E =======================================


sub_4CC4:               ; CODE XREF: ROM:0000459Aj
	move.w  #$2000,d0
	moveq   #$18,d1
	bsr.w   sub_5764
	moveq   #0,d0
	moveq   #$19,d1
	bsr.w   sub_5764
	move.w  (word_FFFFD166).w,d0
	sub.w   (word_FFFFD042).w,d0
	bcs.s   loc_4CF4
	cmpi.b  #9,d0
	bls.s   loc_4CFE
	move.w  (word_FFFFD166).w,d0
	subi.w  #9,d0
	move.w  d0,(word_FFFFD042).w
	bra.s   loc_4CFA
; ---------------------------------------------------------------------------

loc_4CF4:               ; CODE XREF: sub_4CC4+1Aj
	move.w  (word_FFFFD166).w,(word_FFFFD042).w

loc_4CFA:               ; CODE XREF: sub_4CC4+2Ej
	bsr.w   sub_5C68

loc_4CFE:               ; CODE XREF: sub_4CC4+20j
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4CC4


; =============== S U B R O U T I N E =======================================


sub_4D08:               ; CODE XREF: ROM:0000459Ej
	moveq   #0,d0
	moveq   #$18,d1
	bsr.w   sub_5764
	move.w  #$2000,d0
	moveq   #$19,d1
	bsr.w   sub_5764
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4D08


; =============== S U B R O U T I N E =======================================


sub_4D24:               ; CODE XREF: ROM:0000453Aj
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	btst    #0,(a0)
	beq.s   loc_4D34
	rts
; ---------------------------------------------------------------------------

loc_4D34:               ; CODE XREF: sub_4D24+Cj
	btst    #1,1(a0)
	bne.w   sub_5250
	btst    #5,(a0)
	beq.s   sub_4D64
	bchg    #0,1(a0)
	beq.s   sub_4D78
; End of function sub_4D24


; =============== S U B R O U T I N E =======================================


sub_4D4C:               ; CODE XREF: sub_4F2C+18p
	bclr    #0,1(a0)
	moveq   #0,d0
	bsr.s   loc_4D84
	bclr    #5,(a0)
	moveq   #0,d0
	moveq   #$B,d1
	bsr.w   sub_5764
	rts
; End of function sub_4D4C


; =============== S U B R O U T I N E =======================================


sub_4D64:               ; CODE XREF: sub_4D24+1Ej
	bset    #5,(a0)
	moveq   #2,d0
	bsr.s   loc_4D84
	move.w  #$2000,d0
	moveq   #$B,d1
	bsr.w   sub_5764
	rts
; End of function sub_4D64


; =============== S U B R O U T I N E =======================================


sub_4D78:               ; CODE XREF: sub_4D24+26j
	move.w  #$4000,d0
	moveq   #$B,d1
	bsr.w   sub_5764
	moveq   #1,d0

loc_4D84:               ; CODE XREF: sub_4D4C+8p sub_4D64+6p
	bra.w   sub_5A90
; End of function sub_4D78

; ---------------------------------------------------------------------------

loc_4D88:               ; CODE XREF: ROM:0000453Ej
	tst.w   (word_FFFFD168).w
	beq.w   sub_5250
	btst    #6,(a0)
	beq.s   sub_4D9E
	bsr.w   sub_5034
	bsr.s   sub_4DF2
	bra.s   sub_4DD8

; =============== S U B R O U T I N E =======================================


sub_4D9E:               ; CODE XREF: ROM:00004D94j
	btst    #2,(a0)
	beq.s   loc_4DAE
	btst    #1,1(a0)
	bne.w   sub_5250

loc_4DAE:               ; CODE XREF: sub_4D9E+4j
	move.w  #$2000,d0
	moveq   #$10,d1
	bsr.w   sub_5764
	bsr.w   sub_5374
	clr.w   (word_FFFFD03E).w
	bset    #6,(a0)
	btst    #2,1(a0)
	beq.s   loc_4DD0
	bsr.w   sub_5444

loc_4DD0:               ; CODE XREF: sub_4D9E+2Cj
	bsr.w   sub_5CFA
	bra.w   sub_46C2
; End of function sub_4D9E


; =============== S U B R O U T I N E =======================================


sub_4DD8:               ; CODE XREF: ROM:00004D9Cj
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4DD8


; =============== S U B R O U T I N E =======================================


sub_4DE2:
	tst.w   (word_FFFFD168).w
	beq.s   sub_4DF2
	move.w  #$2000,d0
	moveq   #$13,d1
	bra.w   sub_5764
; End of function sub_4DE2


; =============== S U B R O U T I N E =======================================


sub_4DF2:               ; CODE XREF: ROM:00004D9Ap sub_4DE2+4j ...
	bclr    #6,(byte_FFFFD008).w
	beq.s   loc_4E24
	btst    #2,(byte_FFFFD009).w
	bne.s   loc_4E0C
	bsr.w   sub_5336
	clr.b   (byte_FFFFD038).w
	bra.s   loc_4E24
; ---------------------------------------------------------------------------

loc_4E0C:               ; CODE XREF: sub_4DF2+Ej
	bsr.w   sub_53C2
	move.w  d1,-(sp)
	bsr.w   sub_531A
	bsr.w   sub_5444
	move.w  (sp)+,d0
	bsr.w   sub_5392
	bsr.w   sub_5CFA

loc_4E24:               ; CODE XREF: sub_4DF2+6j sub_4DF2+18j
	moveq   #0,d0
	tst.w   (word_FFFFD168).w
	beq.s   loc_4E30
	move.w  #$2000,d0

loc_4E30:               ; CODE XREF: sub_4DF2+38j
	moveq   #$13,d1
	bsr.w   sub_5764
	bsr.w   sub_5CFA
	bclr    #6,(byte_FFFFD008).w
	moveq   #0,d0
	moveq   #$10,d1
	bra.w   sub_5764
; End of function sub_4DF2


; =============== S U B R O U T I N E =======================================


sub_4E48:               ; CODE XREF: ROM:0000456Ej
	btst    #2,(byte_FFFFD004).w
	beq.w   sub_5250
	tst.b   (word_FFFFFE44+1).w
	beq.w   sub_5250
	bsr.w   getDiscType
	beq.s   loc_4E94
	btst    #2,(a0)
	beq.s   loc_4E6E
	btst    #6,(a0)
	bne.w   sub_5250

loc_4E6E:               ; CODE XREF: sub_4E48+1Cj
	move.w  #$2000,d0
	moveq   #$13,d1
	bsr.w   sub_5764
	bsr.w   sub_4184
	moveq   #0,d1
	bsr.w   sub_59DE
	bsr.w   sub_5BEC
	bsr.w   sub_5C50
	bsr.w   sub_5C68
	bset    #7,1(a0)

loc_4E94:               ; CODE XREF: sub_4E48+16j
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4E48


; =============== S U B R O U T I N E =======================================


sub_4E9E:               ; CODE XREF: ROM:000045A2j
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	bsr.w   sub_5B82
	bsr.w   sub_416A

loc_4EAE:               ; CODE XREF: sub_3B28p sub_3BAEp
	moveq   #6,d1
	bsr.w   sub_59DE
	bclr    #7,(byte_FFFFD009).w
	tst.w   (word_FFFFD168).w
	beq.w   sub_4DF2
	btst    #6,(byte_FFFFD008).w
	beq.s   loc_4EEA
	btst    #2,(byte_FFFFD008).w
	bne.s   loc_4EEA
	bsr.w   sub_5374
	btst    #2,(byte_FFFFD009).w
	beq.s   loc_4EE2
	bsr.w   sub_5444

loc_4EE2:               ; CODE XREF: sub_4E9E+3Ej
	clr.w   (word_FFFFD03E).w
	bsr.w   sub_5CFA

loc_4EEA:               ; CODE XREF: sub_4E9E+2Aj sub_4E9E+32j
	move.w  #$2000,d0
	moveq   #$13,d1
	bsr.w   sub_5764
	rts
; End of function sub_4E9E


; =============== S U B R O U T I N E =======================================


sub_4EF6:
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	bclr    #6,(a0)
	beq.s   loc_4F0A
	bsr.w   sub_5034
	bsr.s   sub_4F18

loc_4F0A:               ; CODE XREF: sub_4EF6+Cj
	bsr.w   sub_5260
	moveq   #0,d0
	moveq   #$13,d1
	bsr.w   sub_5764
	rts
; End of function sub_4EF6


; =============== S U B R O U T I N E =======================================


sub_4F18:               ; CODE XREF: sub_45BE+34p sub_4EF6+12p
	bsr.w   sub_5260
	bsr.w   sub_4DF2
	clr.w   (word_FFFFD166).w
	clr.b   (byte_FFFFD038).w
	bra.w   sub_5CFA
; End of function sub_4F18


; =============== S U B R O U T I N E =======================================


sub_4F2C:               ; CODE XREF: ROM:00004542j
				; ROM:00004586j
	move.w  #$2000,d0
	moveq   #$14,d1
	bsr.w   sub_5764
	move.b  #$14,(byte_FFFFD059).w

loc_4F3C:               ; CODE XREF: sub_45BE+24p
	bsr.w   sub_50B8
	bsr.w   sub_4DF2
	bsr.w   sub_4D4C
	bsr.w   sub_5034
	bsr.w   sub_515E
	bsr.w   sub_5128
	move.b  #1,(byte_FFFFD010).w
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4F2C


; =============== S U B R O U T I N E =======================================


sub_4F64:               ; CODE XREF: ROM:00004546j
	btst    #0,(a0)
	bne.w   sub_5250
	bsr.w   checkDiscBootable
	bne.w   sub_5250
	move.w  #$2000,d0
	moveq   #$E,d1
	bsr.w   sub_5764
	bset    #6,(byte_FFFFD007).w
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4F64


; =============== S U B R O U T I N E =======================================


sub_4F8E:               ; CODE XREF: ROM:0000454Aj
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4F8E

; ---------------------------------------------------------------------------
	rts

; =============== S U B R O U T I N E =======================================


sub_4F9A:               ; CODE XREF: ROM:0000454Ej
	bsr.w   sub_5034
	bsr.w   sub_412E
	bsr.s   sub_4FC8
	bsr.w   sub_5E22
	move.w  #$2000,d0
	moveq   #$C,d1
	bsr.w   sub_5764
	rts
; End of function sub_4F9A


; =============== S U B R O U T I N E =======================================


sub_4FB4:               ; CODE XREF: sub_3B28+34j sub_3B28+4Aj ...
	bsr.w   sub_40F4
	bsr.s   sub_4FC8
	bsr.w   sub_5E54
	moveq   #$C,d1
	moveq   #0,d0
	bsr.w   sub_5764
	rts
; End of function sub_4FB4


; =============== S U B R O U T I N E =======================================


sub_4FC8:               ; CODE XREF: sub_4F9A+8p sub_4FB4+4p
	not.b   (byte_FFFFD003).w
	bset    #5,(byte_FFFFD007).w
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4FC8


; =============== S U B R O U T I N E =======================================


sub_4FDC:               ; CODE XREF: ROM:00004552j
	btst    #2,(a0)
	beq.w   sub_5250
	tst.b   (byte_FFFFD003).w
	bne.w   sub_5250
	btst    #1,1(a0)
	bne.s   loc_5028
	btst    #1,(a0)
	bne.w   sub_5250
	cmpi.w  #$100,(word_FFFFD024).w
	bne.s   loc_502A
	move.l  (dword_FFFFD028).w,d0
	move.w  (word_FFFFD1CE).w,d1
	move.b  d1,d0
	move.l  d0,(dword_FFFFD014).w
	move.l  (dword_FFFFD02C).w,(dword_FFFFD01C).w
	move.w  #$4000,d0
	moveq   #$11,d1
	bsr.w   sub_5764
	bsr.w   sub_41D2
	bra.s   loc_502A
; ---------------------------------------------------------------------------

loc_5028:               ; CODE XREF: sub_4FDC+16j
	bsr.s   sub_5034

loc_502A:               ; CODE XREF: sub_4FDC+26j sub_4FDC+4Aj
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_4FDC


; =============== S U B R O U T I N E =======================================


sub_5034:               ; CODE XREF: ROM:loc_3B18p
					; ROM:loc_3BAAp ...
	bclr    #1,(byte_FFFFD009).w
	moveq   #0,d0
	moveq   #$11,d1
	bra.w   sub_5764
; End of function sub_5034


; =============== S U B R O U T I N E =======================================


sub_5042:               ; CODE XREF: ROM:0000457Ej
	move.w  (word_FFFFD1CE).w,d1
	move.l  (dword_FFFFD028).w,d0
	move.b  d1,d0
	move.l  d0,(dword_FFFFD018).w
	move.w  #$2000,d0
	moveq   #$11,d1
	bsr.w   sub_5764
	bset    #1,(byte_FFFFD009).w
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_5042


; =============== S U B R O U T I N E =======================================


sub_506A:               ; CODE XREF: ROM:00004556j
				; ROM:0000455Aj
	btst    #2,(byte_FFFFD004).w
	beq.w   sub_5250
	btst    #2,1(a0)
	beq.s   loc_5082
	bsr.s   sub_50B8
	bsr.s   sub_5034
	bra.s   loc_50AE
; ---------------------------------------------------------------------------

loc_5082:               ; CODE XREF: sub_506A+10j
	btst    #1,1(a0)
	bne.w   sub_5250
	bset    #2,1(a0)
	bsr.w   sub_5444
	bsr.w   sub_5CFA
	move.w  #$2000,d0
	moveq   #$F,d1
	bsr.w   sub_5764
	btst    #2,(a0)
	beq.s   loc_50AE
	bne.w   sub_46C2

loc_50AE:               ; CODE XREF: sub_506A+16j sub_506A+3Ej
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_506A


; =============== S U B R O U T I N E =======================================


sub_50B8:               ; CODE XREF: sub_4F2C:loc_4F3Cp
				; sub_506A+12p
	bclr    #2,1(a0)
	bne.s   loc_50C2
	rts
; ---------------------------------------------------------------------------

loc_50C2:               ; CODE XREF: sub_50B8+6j
	move.w  #0,d0
	moveq   #$F,d1
	bsr.w   sub_5764
	btst    #6,(a0)
	beq.s   loc_50E6
	bsr.w   sub_5374
	btst    #2,(a0)
	beq.s   loc_50EA
	move.b  (unk_FFFFD039).w,d0
	bsr.w   sub_5392
	bra.s   loc_50EA
; ---------------------------------------------------------------------------

loc_50E6:               ; CODE XREF: sub_50B8+18j
	bsr.w   sub_5336

loc_50EA:               ; CODE XREF: sub_50B8+22j sub_50B8+2Cj
	bsr.w   sub_53C2
	move.b  d1,(byte_FFFFD038).w
	bra.w   sub_5CFA
; End of function sub_50B8


; =============== S U B R O U T I N E =======================================


sub_50F6:               ; CODE XREF: ROM:0000455Ej
	btst    #0,(a0)
	bne.s   loc_511E
	btst    #1,1(a0)
	bne.w   sub_5250
	bchg    #7,(a0)
	bne.s   loc_511C
	move.w  #$2000,d0
	moveq   #$12,d1
	bsr.w   sub_5764
	bsr.w   sub_41A8
	bra.s   loc_511E
; ---------------------------------------------------------------------------

loc_511C:               ; CODE XREF: sub_50F6+14j
	bsr.s   sub_5128

loc_511E:               ; CODE XREF: sub_50F6+4j sub_50F6+24j
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_50F6


; =============== S U B R O U T I N E =======================================


sub_5128:               ; CODE XREF: sub_4F2C+24p
				; sub_50F6:loc_511Cp
	bclr    #7,(a0)
	moveq   #$12,d1
	moveq   #0,d0
	bra.w   sub_5764
; End of function sub_5128


; =============== S U B R O U T I N E =======================================


sub_5134:               ; CODE XREF: ROM:00004566j
	btst    #0,(a0)
	bne.s   loc_5154
	bchg    #4,1(a0)
	beq.s   loc_5146
	bsr.s   sub_515E
	bra.s   loc_5154
; ---------------------------------------------------------------------------

loc_5146:               ; CODE XREF: sub_5134+Cj
	move.w  #$2000,d0
	moveq   #$15,d1
	bsr.w   sub_5764
	bsr.w   sub_41B8

loc_5154:               ; CODE XREF: sub_5134+4j sub_5134+10j
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_5134


; =============== S U B R O U T I N E =======================================


sub_515E:               ; CODE XREF: sub_4F2C+20p sub_5134+Ep
	bclr    #4,1(a0)
	moveq   #0,d0
	moveq   #$15,d1
	bra.w   sub_5764
; End of function sub_515E


; =============== S U B R O U T I N E =======================================


sub_516C:               ; CODE XREF: ROM:00004562j
	btst    #2,(a0)
	beq.s   loc_519A
	addq.b  #1,(byte_FFFFD00E).w
	andi.b  #3,(byte_FFFFD00E).w
	bsr.w   sub_5AD0
	moveq   #$16,d1
	move.w  #$2000,d0
	bsr.w   sub_5764
	move.b  #$14,(byte_FFFFD058).w
	st  (byte_FFFFD00C).w
	move.b  (byte_FFFFD00E).w,(byte_FFFFD00D).w

loc_519A:               ; CODE XREF: sub_516C+4j
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_516C


; =============== S U B R O U T I N E =======================================


sub_51A4:               ; CODE XREF: sub_4642+72p sub_46C2+24p ...
	tst.b   (byte_FFFFD00C).w
	beq.s   loc_51B2
	move.b  (byte_FFFFD00D).w,(byte_FFFFD00E).w
	bra.s   loc_51B6
; ---------------------------------------------------------------------------

loc_51B2:               ; CODE XREF: sub_51A4+4j
	clr.b   (byte_FFFFD00E).w

loc_51B6:               ; CODE XREF: sub_51A4+Cj
	bsr.w   sub_5AD0
	rts
; End of function sub_51A4


; =============== S U B R O U T I N E =======================================


sub_51BC:               ; CODE XREF: sub_4A0E+12p
	move.b  #3,(byte_FFFFD00E).w
	bra.w   sub_5AD0
; End of function sub_51BC


; =============== S U B R O U T I N E =======================================


sub_51C6:               ; CODE XREF: ROM:0000456Aj
	bset    #7,(byte_FFFFD007).w
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_51C6


; =============== S U B R O U T I N E =======================================


sub_51D6:               ; CODE XREF: ROM:00004572j
	btst    #0,(a0)
	bne.s   loc_521C
	cmpi.b  #$F,(byte_FFFFD010).w
	bcc.s   loc_521C
	addq.b  #1,(byte_FFFFD010).w
	moveq   #9,d1
	move.w  #$2000,d0
	bsr.w   sub_5764
	move.b  #$14,(byte_FFFFD05D).w
	bra.s   loc_521C
; ---------------------------------------------------------------------------

loc_51FA:               ; CODE XREF: ROM:00004576j
	btst    #0,(a0)
	bne.s   loc_521C
	cmpi.b  #1,(byte_FFFFD010).w
	bls.s   loc_521C
	subq.b  #1,(byte_FFFFD010).w
	moveq   #8,d1
	move.w  #$2000,d0
	bsr.w   sub_5764
	move.b  #$14,(byte_FFFFD05C).w

loc_521C:               ; CODE XREF: sub_51D6+4j sub_51D6+Cj ...
	move.b  (byte_FFFFD010).w,d1
	bsr.w   sub_55AC
	bsr.w   sub_5480
	clr.w   (word_FFFFD000).w
	clr.b   (byte_FFFFD002).w
	rts
; End of function sub_51D6


; =============== S U B R O U T I N E =======================================


sub_5232:
	btst    #2,(byte_FFFFD008).w
	beq.s   loc_5240
	cmp.b   (byte_FFFFFE43).w,d1
	rts
; ---------------------------------------------------------------------------

loc_5240:               ; CODE XREF: sub_5232+6j
	andi    #$FB,ccr ; '├╗'
	rts
; End of function sub_5232


; =============== S U B R O U T I N E =======================================


sub_5246:
	bsr.w sub_53C2

	move.b d1, (byte_FFFFD038).w
	rts
; End of function sub_5246


; =============== S U B R O U T I N E =======================================


sub_5250:               ; CODE XREF: sub_4822+22j sub_48FE+22j ...
	moveq #Z80CMD_FF92, d7
	jsr   sendCommandToZ80(pc)

	clr.w (word_FFFFD000).w
	clr.b (byte_FFFFD002).w
	rts
; End of function sub_5250


; =============== S U B R O U T I N E =======================================


sub_5260:               ; CODE XREF: sub_30C2+46p
				; sub_4EF6:loc_4F0Ap ...
	movem.l d7/a6, -(sp)

	clr.w (word_FFFFD042).w
	clr.w (word_FFFFD168).w
	clr.w (word_FFFFD166).w

	lea (unk_FFFFD16A).w, a6

	moveq #24, d7
	@loc_5276:
		clr.l (a6)+
		dbf d7, @loc_5276

	movem.l (sp)+, d7/a6
	rts
; End of function sub_5260


; =============== S U B R O U T I N E =======================================


sub_5282:               ; CODE XREF: sub_3950+28p
	lea (word_FFFFD168).w,a1
	cmpi.w  #$63,(a1) ; 'c'
	beq.s   loc_52C4
	addq.w  #1,(a1)
	addq.w  #1,(word_FFFFD166).w
	movem.l d1-d2,-(sp)
	move.w  (word_FFFFD166).w,d1
	move.w  (a1),d2
	cmp.w   d1,d2
	beq.s   loc_52BA
	movem.l a1-a2,-(sp)
	lea 2(a1,d2.w),a2
	adda.w  d2,a1
	addq.w  #1,a1
	sub.w   d1,d2
	subq.w  #1,d2

loc_52B0:               ; CODE XREF: sub_5282+30j
	move.b  -(a1),-(a2)
	dbf d2,loc_52B0
	movem.l (sp)+,a1-a2

loc_52BA:               ; CODE XREF: sub_5282+1Cj
	move.b  d0,1(a1,d1.w)
	movem.l (sp)+,d1-d2
	rts
; ---------------------------------------------------------------------------

loc_52C4:               ; CODE XREF: sub_5282+8j
	ori #1,ccr
	rts
; End of function sub_5282


; =============== S U B R O U T I N E =======================================


sub_52CA:               ; CODE XREF: sub_39AC+18p
	lea (word_FFFFD168).w,a1
	tst.w   (a1)
	beq.s   locret_52F2
	subq.w  #1,(a1)
	move.w  (a1),d1
	sub.w   d0,d1

loc_52D8:               ; CODE XREF: sub_52CA+16j
	move.b  3(a1,d0.w),2(a1,d0.w)
	addq.w  #1,d0
	dbf d1,loc_52D8
	move.w  (a1),d1
	cmp.w   (word_FFFFD166).w,d1
	bcc.s   loc_52F0
	move.w  d1,(word_FFFFD166).w

loc_52F0:               ; CODE XREF: sub_52CA+20j
	tst.w   (a1)

locret_52F2:                ; CODE XREF: sub_52CA+6j
	rts
; End of function sub_52CA


; =============== S U B R O U T I N E =======================================


sub_52F4:               ; CODE XREF: sub_4400:loc_447Ep
				; sub_45BE+20p
	movem.l d0-d1/a1,-(sp)
	moveq   #0,d0
	tst.b   d7
	beq.s   loc_5310
	move.b  (word_FFFFFE44).w,d1
	lea (unk_FFFFD102).w,a1

loc_5306:               ; CODE XREF: sub_52F4+1Aj
	move.b  d1,(a1)+
	addq.w  #1,d0
	addq.w  #1,d1
	cmp.b   d7,d1
	bls.s   loc_5306

loc_5310:               ; CODE XREF: sub_52F4+8j
	move.w  d0,(word_FFFFD100).w
	movem.l (sp)+,d0-d1/a1
	rts
; End of function sub_52F4


; =============== S U B R O U T I N E =======================================


sub_531A:               ; CODE XREF: sub_4DF2+20p
	movem.l d0-d1/a1-a2,-(sp)
	lea (word_FFFFD100).w,a1
	lea (unk_FFFFD1D0).w,a2
	move.w  (a1)+,d0
	move.w  d0,(a2)+

loc_532A:               ; CODE XREF: sub_531A+12j
	move.b  (a1)+,(a2)+
	dbf d0,loc_532A
	movem.l (sp)+,d0-d1/a1-a2
	rts
; End of function sub_531A


; =============== S U B R O U T I N E =======================================


sub_5336:               ; CODE XREF: sub_4400+82p sub_4DF2+10p ...
	movem.l d0-d1/a1-a2,-(sp)
	btst    #2,(byte_FFFFD008).w
	bne.s   loc_5346
	bsr.s   sub_53B0
	bra.s   loc_534C
; ---------------------------------------------------------------------------

loc_5346:               ; CODE XREF: sub_5336+Aj
	bsr.s   sub_53C2
	movem.l d1,-(sp)

loc_534C:               ; CODE XREF: sub_5336+Ej
	lea (word_FFFFD100).w,a1
	lea (unk_FFFFD1D0).w,a2
	move.w  (a1)+,d0
	move.w  d0,(a2)+

loc_5358:               ; CODE XREF: sub_5336+24j
	move.b  (a1)+,(a2)+
	dbf d0,loc_5358
	btst    #2,(byte_FFFFD008).w
	beq.s   loc_536E
	movem.l (sp)+,d0
	bsr.w   sub_5392

loc_536E:               ; CODE XREF: sub_5336+2Ej
	movem.l (sp)+,d0-d1/a1-a2
	rts
; End of function sub_5336


; =============== S U B R O U T I N E =======================================


sub_5374:               ; CODE XREF: sub_4D9E+1Ap sub_4E9E+34p ...
	movem.l a1-a2,-(sp)
	lea (word_FFFFD1CE).w,a1
	clr.w   (a1)+
	lea (word_FFFFD168).w,a2
	move.w  (a2)+,(a1)+
	moveq   #$18,d0

loc_5386:               ; CODE XREF: sub_5374+14j
	move.l  (a2)+,(a1)+
	dbf d0,loc_5386
	movem.l (sp)+,a1-a2
	rts
; End of function sub_5374


; =============== S U B R O U T I N E =======================================


sub_5392:               ; CODE XREF: sub_4DF2+2Ap sub_50B8+28p ...
	movem.l d1/a1-a2,-(sp)
	lea (word_FFFFD1CE).w,a1
	lea (unk_FFFFD1D2).w,a2
	moveq   #0,d1

loc_53A0:               ; CODE XREF: sub_5392+14j
	cmp.b   (a2)+,d0
	beq.s   loc_53A8
	addq.w  #1,d1
	bra.s   loc_53A0
; ---------------------------------------------------------------------------

loc_53A8:               ; CODE XREF: sub_5392+10j
	move.w  d1,(a1)
	movem.l (sp)+,d1/a1-a2
	rts
; End of function sub_5392


; =============== S U B R O U T I N E =======================================


sub_53B0:               ; CODE XREF: sub_4A0E+16p sub_4A0E+32p ...
	clr.w   (word_FFFFD1CE).w
	rts
; End of function sub_53B0


; =============== S U B R O U T I N E =======================================


sub_53B6:               ; CODE XREF: sub_4400+B8p sub_62E4+56p
	cmp.w  (word_FFFFD1CE).w, d0
	beq.s  @locret_53C0

	move.w d0, (word_FFFFD1CE).w

@locret_53C0:                ; CODE XREF: sub_53B6+4j
	rts
; End of function sub_53B6


; =============== S U B R O U T I N E =======================================


sub_53C2:               ; CODE XREF: sub_46F4:loc_4704p
				; sub_4822+36p ...
	move.l  a1,-(sp)
	lea (word_FFFFD1CE).w,a1
	move.w  (a1),d1
	move.b  4(a1,d1.w),d1
	movea.l (sp)+,a1
	rts
; End of function sub_53C2


; =============== S U B R O U T I N E =======================================


sub_53D2:               ; CODE XREF: sub_4400+A2p
	move.l  a1,-(sp)
	lea (unk_FFFFD1D0).w,a1
	move.w  (a1)+,d1
	subq.w  #1,d1
	move.b  (a1,d1.w),d1
	movea.l (sp)+,a1
	rts
; End of function sub_53D2


; =============== S U B R O U T I N E =======================================


sub_53E4:               ; CODE XREF: sub_48FE+2Ep
				; sub_48FE:loc_495Ep ...
	movem.l a1,-(sp)
	lea (word_FFFFD1CE).w,a1
	addq.w  #1,(a1)
	move.w  (a1)+,d1
	cmp.w   (a1)+,d1
	bcs.s   loc_5412
	btst    #5,(byte_FFFFD008).w
	beq.s   loc_5404
	clr.w   -4(a1)
	moveq   #0,d1
	bra.s   loc_5412
; ---------------------------------------------------------------------------

loc_5404:               ; CODE XREF: sub_53E4+16j
	subq.w  #1,d1
	move.w  d1,-4(a1)
	moveq   #0,d1
	movem.l (sp)+,a1
	rts
; ---------------------------------------------------------------------------

loc_5412:               ; CODE XREF: sub_53E4+Ej sub_53E4+1Ej
	move.b  (a1,d1.w),d1
	movem.l (sp)+,a1
	rts
; End of function sub_53E4


; =============== S U B R O U T I N E =======================================


sub_541C:               ; CODE XREF: sub_4822:loc_485Ep
				; sub_4822:loc_48BEp
	move.l  a1,-(sp)
	lea (word_FFFFD1CE).w,a1
	subq.w  #1,(a1)
	bpl.s   loc_543A
	btst    #5,(byte_FFFFD008).w
	beq.s   loc_5438
	move.w  2(a1),d1
	subq.w  #1,d1
	move.w  d1,(a1)
	bra.s   loc_543A
; ---------------------------------------------------------------------------

loc_5438:               ; CODE XREF: sub_541C+10j
	clr.w   (a1)

loc_543A:               ; CODE XREF: sub_541C+8j sub_541C+1Aj
	move.w  (a1),d1
	move.b  4(a1,d1.w),d1
	movea.l (sp)+,a1
	rts
; End of function sub_541C


; =============== S U B R O U T I N E =======================================


sub_5444:               ; CODE XREF: sub_4D9E+2Ep sub_4DF2+24p ...
	move.b  (byte_FFFFFE28).w,d0
	move.w  d0,-(sp)
	clr.b   (byte_FFFFFE28).w
	lea (word_FFFFD1CE).w,a1
	clr.w   (a1)+
	move.w  (a1)+,d3
	move.w  d3,d4
	subq.w  #1,d3
	cmpi.w  #$63,d3 ; 'c'
	bhi.s   locret_547E

loc_5460:               ; CODE XREF: sub_5444+30j
	move.w  d4,d0
	bsr.w   randWithModulo
	move.b  (a1,d3.w),d2
	move.b  (a1,d0.w),(a1,d3.w)
	move.b  d2,(a1,d0.w)
	dbf d3,loc_5460
	move.w  (sp)+,d0
	move.b  d0,(byte_FFFFFE28).w

locret_547E:                ; CODE XREF: sub_5444+1Aj
	rts
; End of function sub_5444


; =============== S U B R O U T I N E =======================================


sub_5480:               ; CODE XREF: sub_3A40+78j sub_3F76+5Aj ...
	move.l  #$45CE0003,d0
	moveq   #1,d2
	bra.w   sub_5618
; End of function sub_5480


; =============== S U B R O U T I N E =======================================


sub_548C:
	m_loadVramWriteAddress $C5CE
	move.l  (unk_FFFFE0A2).w, (VDP_DATA).l

	m_loadVramWriteAddress $C64E
	move.l  (unk_FFFFE0A2).w, (VDP_DATA).l
	rts
; End of function sub_548C


; =============== S U B R O U T I N E =======================================


sub_54B2:               ; CODE XREF: state_3040+3Cp
	moveq   #0,d0
	moveq   #0,d1
	btst    #4,(byte_FFFFD004).w
	bne.s   loc_54EE
	btst    #2,(byte_FFFFD004).w
	bne.s   loc_54D6
	btst    #6,(byte_FFFFD004).w
	beq.s   loc_54EE
	moveq   #0,d1
	move.b  (byte_FFFFD038).w,d0
	bne.s   loc_54EE

loc_54D6:               ; CODE XREF: sub_54B2+12j
	move.b  (byte_FFFFD030).w,d0
	cmpi.b  #$FF,d0
	bne.s   loc_54E2
	moveq   #0,d0

loc_54E2:               ; CODE XREF: sub_54B2+2Cj
	move.w  (word_FFFFD026).w,d1
	cmpi.w  #$FFFF,d1
	bne.s   loc_54EE
	moveq   #0,d1

loc_54EE:               ; CODE XREF: sub_54B2+Aj sub_54B2+1Aj ...
	lea (VDP_DATA).l,a5
	lea (unk_FFFFD039).w,a6
	move.b  d0,(a6)
	move.w  d1,(unk_FFFFD03A).w
	lea dword_5590(pc),a4
	moveq   #1,d2
	move.w  d2,-(sp)
	move.b  (a6)+,d1
	bsr.w   sub_55AC
	move.l  (a4)+,d0
	bsr.w   sub_5618
	move.l  (a4)+,d0
	move.w  (sp)+,d2
	bsr.w   sub_55C4
	moveq   #0,d2
	cmpi.w  #$800,(word_FFFFD024).w
	beq.s   loc_5548
	move.w  (byte_FFFFD008).w,d0
	move.w  (word_FFFFD022).w,d1
	btst    #$A,d0
	beq.s   loc_5568
	eor.w   d0,d1
	btst    #$A,d1
	bne.s   loc_5548
	move.w  (word_FFFFD036).w,d0
	andi.w  #$C0,d0 ; '├Ç'
	cmpi.w  #$C0,d0 ; '├Ç'
	beq.s   loc_5568

loc_5548:               ; CODE XREF: sub_54B2+70j sub_54B2+86j
	bset    #7,(byte_FFFFD005).w
	move.l  (a4)+,d0
	bsr.w   sub_566E
	move.l  (a4)+,d0
	bsr.w   sub_5694
	move.l  (a4)+,d0
	bsr.w   sub_566E
	move.l  (a4)+,d0
	bsr.w   sub_5694
	bra.s   loc_5586
; ---------------------------------------------------------------------------

loc_5568:               ; CODE XREF: sub_54B2+7Ej sub_54B2+94j
	bclr    #7,(byte_FFFFD005).w
	move.b  (a6)+,d1
	move.l  (a4)+,d0
	bsr.w   sub_5618
	move.l  (a4)+,d0
	bsr.s   sub_55C4
	move.b  (a6)+,d1
	move.l  (a4)+,d0
	bsr.w   sub_5618
	move.l  (a4)+,d0
	bsr.s   sub_55C4

loc_5586:               ; CODE XREF: sub_54B2+B4j
	move.b  (byte_FFFFD010).w,d1
	bsr.s   sub_55AC
	move.l  (a4)+,d0
	bra.s   sub_55C4
; End of function sub_54B2

; ---------------------------------------------------------------------------
dword_5590:      ; DATA XREF: sub_54B2+4Co
	dc.l $45AA0003      ; VRAM $C5AA
	dc.l $42BE0003      ; VRAM $C2BE
	dc.l $45B20003      ; VRAM $C5B2
	dc.l $42C80003      ; VRAM $C2C8
	dc.l $45B80003      ; VRAM $C5B8
	dc.l $42CE0003      ; VRAM $C2CE
	dc.l $42D80003      ; VRAM $C2D8

; =============== S U B R O U T I N E =======================================


sub_55AC:               ; CODE XREF: ROM:0000037Cj
				; sub_51D6+4Ap ...
	move.w  d6,-(sp)
	andi.l  #$FF,d1
	divu.w  #$A,d1
	move.w  d1,d6
	asl.w   #4,d6
	swap    d1
	add.b   d6,d1
	move.w  (sp)+,d6
	rts
; End of function sub_55AC


; =============== S U B R O U T I N E =======================================


sub_55C4:               ; CODE XREF: sub_54B2+64p sub_54B2+C6p ...
	tst.b   (byte_FFFFD003).w
	beq.s   locret_5616
	btst    #0,(byte_FFFFD004).w
	beq.s   loc_55DA
	btst    #1,(byte_FFFFD004).w
	bne.s   locret_5616

loc_55DA:               ; CODE XREF: sub_55C4+Cj
	movem.l d0-d2,-(sp)
	move.l  d0,(VDP_CONTROL).l
	move.b  d1,d0
	andi.w  #$F0,d0 ; '├░'
	bne.s   loc_55F8
	tst.w   d2
	beq.s   loc_55FA
	moveq   #0,d2
	move.w  #$C001,d0
	bra.s   loc_55FE
; ---------------------------------------------------------------------------

loc_55F8:               ; CODE XREF: sub_55C4+26j
	lsr.w   #4,d0

loc_55FA:               ; CODE XREF: sub_55C4+2Aj
	addi.w  #$6EF,d0

loc_55FE:               ; CODE XREF: sub_55C4+32j
	move.w  d0,(VDP_DATA).l
	andi.w  #$F,d1
	addi.w  #$6EF,d1
	move.w  d1,(VDP_DATA).l
	movem.l (sp)+,d0-d2

locret_5616:                ; CODE XREF: sub_55C4+4j sub_55C4+14j
	rts
; End of function sub_55C4


; =============== S U B R O U T I N E =======================================


sub_5618:               ; CODE XREF: sub_5480+8j sub_54B2+5Cp ...
	movem.l d0-d6/a5-a6,-(sp)
	lea (unk_FFFFEB1E).w,a6
	lea (VDP_DATA).l,a5
	move.l  d0,4(a5)
	move.b  d1,d4
	asr.w   #4,d1
	bsr.s   sub_5654
	move.w  d5,d6
	swap    d5
	move.w  d5,(a5)
	move.w  d4,d1
	bsr.s   sub_5654
	swap    d5
	move.w  d5,(a5)
	addi.l  #$800000,d0
	move.l  d0,4(a5)
	move.w  d6,(a5)
	swap    d5
	move.w  d5,(a5)
	movem.l (sp)+,d0-d6/a5-a6
	rts
; End of function sub_5618


; =============== S U B R O U T I N E =======================================


sub_5654:               ; CODE XREF: sub_5618+16p sub_5618+20p
	andi.w  #$F,d1
	bne.s   loc_5662
	tst.w   d2
	beq.s   loc_5662
	moveq   #$28,d1 ; '('
	bra.s   loc_5666
; ---------------------------------------------------------------------------

loc_5662:               ; CODE XREF: sub_5654+4j sub_5654+8j
	add.w   d1,d1
	add.w   d1,d1

loc_5666:               ; CODE XREF: sub_5654+Cj
	moveq   #0,d2
	move.l  (a6,d1.w),d5
	rts
; End of function sub_5654


; =============== S U B R O U T I N E =======================================


sub_566E:               ; CODE XREF: sub_54B2+9Ep sub_54B2+AAp
	lea (VDP_DATA).l,a5
	move.l  d0,4(a5)
	move.w  (unk_FFFFEB4A).w,(a5)
	move.w  (unk_FFFFEB4A).w,(a5)
	addi.l  #$800000,d0
	move.l  d0,4(a5)
	move.w  (unk_FFFFEB4C).w,(a5)
	move.w  (unk_FFFFEB4C).w,(a5)
	rts
; End of function sub_566E


; =============== S U B R O U T I N E =======================================


sub_5694:               ; CODE XREF: sub_54B2+A4p sub_54B2+B0p
	tst.b   (byte_FFFFD003).w
	beq.s   locret_56B4
	btst    #0,(byte_FFFFD004).w
	beq.s   loc_56AA
	btst    #1,(byte_FFFFD004).w
	bne.s   locret_56B4

loc_56AA:               ; CODE XREF: sub_5694+Cj
	move.l  d0,4(a5)
	move.l  #$6FF06FF,(a5)

locret_56B4:                ; CODE XREF: sub_5694+4j sub_5694+14j
	rts
; End of function sub_5694


; =============== S U B R O U T I N E =======================================


sub_56B6:               ; CODE XREF: state_3040+38p
	moveq   #0,d0
	lea (byte_FFFFD058).w,a0
	moveq   #$16,d1
	bsr.w   sub_5722
	moveq   #$14,d1
	bsr.w   sub_5722
	moveq   #4,d1
	bsr.w   sub_5722
	moveq   #5,d1
	bsr.w   sub_5722
	tst.b   (byte_FFFFD003).w
	beq.s   loc_56E8
	moveq   #8,d1
	bsr.w   sub_5722
	moveq   #9,d1
	bsr.w   sub_5722
	bra.s   loc_56EA
; ---------------------------------------------------------------------------

loc_56E8:               ; CODE XREF: sub_56B6+22j
	clr.w   (a0)

loc_56EA:               ; CODE XREF: sub_56B6+30j
	moveq   #0,d0
	moveq   #4,d1
	btst    #4,(byte_FFFFD005).w
	bne.s   loc_5702
	moveq   #5,d1
	btst    #5,(byte_FFFFD005).w
	bne.s   loc_5702
	rts
; ---------------------------------------------------------------------------

loc_5702:               ; CODE XREF: sub_56B6+3Ej sub_56B6+48j
	btst    #7,(byte_FFFFD005).w
	bne.s   loc_571A
	btst    #6,(byte_FFFFD005).w
	beq.s   locret_5720
	andi.b  #$8F,(byte_FFFFD005).w
	bra.s   sub_5764
; ---------------------------------------------------------------------------

loc_571A:               ; CODE XREF: sub_56B6+52j
	bset    #6,(byte_FFFFD005).w

locret_5720:                ; CODE XREF: sub_56B6+5Aj
	rts
; End of function sub_56B6


; =============== S U B R O U T I N E =======================================


sub_5722:               ; CODE XREF: sub_56B6+8p sub_56B6+Ep ...
	tst.b (a0)+
	beq.s @locret_5730

	subq.b #1, -1(a0)
	bne.s  @locret_5730

	bra.w sub_5764
; ---------------------------------------------------------------------------

@locret_5730:
	rts
; End of function sub_5722


; =============== S U B R O U T I N E =======================================


sub_5732:               ; CODE XREF: sub_44E2+1Ep sub_45BE+4Ep ...
	m_loadVramWriteAddress $C358, d0
	bsr.w checkDiscBootable
	bne.s sub_5754

	tst.b (byte_FFFFD003).w
	beq.s @loc_5746
	rts
; ---------------------------------------------------------------------------

@loc_5746:
	lea (addr_FFFFE438).w, a1
	moveq  #9, d1
	move.w #6, d2
	bra.w  writeTilemapToVram
; End of function sub_5732


; =============== S U B R O U T I N E =======================================


sub_5754:               ; CODE XREF: sub_5732+Aj sub_5DFA+18p ...
	lea (addr_FFFFE4C4).w, a1
	moveq  #9, d1
	move.w #6, d2
	bra.w  writeTilemapToVram

	rts
; End of function sub_5754


; =============== S U B R O U T I N E =======================================


sub_5764:               ; CODE XREF: sub_3B28+46p sub_4718+4j ...
	btst    #0, (byte_FFFFD004).w
	beq.s   loc_5774

	lea unk_5904(pc), a1
	bsr.s   sub_57CE
	bra.s   loc_5780
; ---------------------------------------------------------------------------

loc_5774:               ; CODE XREF: sub_5764+6j
	cmpi.w  #$C,d1
	bhi.s   loc_5780
	lea unk_5904(pc),a1
	bsr.s   loc_5784

loc_5780:               ; CODE XREF: sub_5764+Ej sub_5764+14j
	lea unk_580C(pc),a1

loc_5784:               ; CODE XREF: sub_5764+1Ap
	cmpi.w  #$1F,d1
	bcs.s   loc_578C

locret_578A:                ; CODE XREF: sub_5764+2Cj sub_5764+40j ...
	rts
; ---------------------------------------------------------------------------

loc_578C:               ; CODE XREF: sub_5764+24j
	cmpi.w  #$1B,d1
	bcc.s   locret_578A
	cmpi.w  #$E,d1
	bls.s   loc_57B0
	cmpi.w  #$17,d1
	bls.s   loc_57A8
	cmpi.w  #2,(word_FFFFD052).w
	bne.s   locret_578A
	bra.s   loc_57B0
; ---------------------------------------------------------------------------

loc_57A8:               ; CODE XREF: sub_5764+38j
	cmpi.w  #1,(word_FFFFD052).w
	bne.s   locret_578A

loc_57B0:               ; CODE XREF: sub_5764+32j sub_5764+42j
	movem.l d0-d5/a5,-(sp)
	asl.w   #3,d1
	adda.w  d1,a1
	move.w  d0,d3
	movem.w (a1),d0-d2/a1
	swap    d0
	move.w  #3,d0
	jsr sub_C78(pc)
	movem.l (sp)+,d0-d5/a5
	rts
; End of function sub_5764


; =============== S U B R O U T I N E =======================================


sub_57CE:               ; CODE XREF: sub_5764+Cp
	cmpi.w  #$C,d1
	bls.s   loc_57D6
	rts
; ---------------------------------------------------------------------------

loc_57D6:               ; CODE XREF: sub_57CE+4j
	movem.l d0-d5/a2,-(sp)
	asl.w   #3,d1
	adda.w  d1,a1
	move.w  d0,d3
	movem.w (a1),d0-d2/a1
	subi.w  #$138,d0
	move.w  d0,d4
	andi.w  #$7E,d0 ; '~'
	andi.w  #$F80,d4
	lsr.w   #5,d4
	mulu.w  #5,d4
	add.w   d4,d0
	lea (unk_FFFFF5C6).w,a2
	adda.w  d0,a2
	moveq   #$14,d0
	bsr.w   sub_62AE
	movem.l (sp)+,d0-d5/a2
	rts
; End of function sub_57CE

; ---------------------------------------------------------------------------
unk_580C:   dc.b $46 ; F        ; DATA XREF: sub_5764:loc_5780o
	dc.b $D8 ; ├ÿ
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   0
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $46 ; F
	dc.b $DE ; ├₧
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b   1
	dc.b $E8 ; ├¿
	dc.b $FE ; ├╛
	dc.b $48 ; H
	dc.b $DE ; ├₧
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $1E
	dc.b $47 ; G
	dc.b $DE ; ├₧
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b  $E
	dc.b $47 ; G
	dc.b $58 ; X
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $2E ; .
	dc.b $47 ; G
	dc.b $66 ; f
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $3A ; :
	dc.b $48 ; H
	dc.b $58 ; X
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $46 ; F
	dc.b $48 ; H
	dc.b $66 ; f
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $52 ; R
	dc.b $48 ; H
	dc.b $58 ; X
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $76 ; v
	dc.b $48 ; H
	dc.b $66 ; f
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $82 ; ΓÇÜ
	dc.b $4B ; K
	dc.b $5C ; \
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   0
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $49 ; I
	dc.b $DC ; ├£
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $5E ; ^
	dc.b $4C ; L
	dc.b $5C ; \
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   0
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $45 ; E
	dc.b $5C ; \
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   0
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $44 ; D
	dc.b $5C ; \
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   0
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $4B ; K
	dc.b $2A ; *
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $D6 ; ├û
	dc.b $4B ; K
	dc.b $46 ; F
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $EA ; ├¬
	dc.b   6
	dc.b $4B ; K
	dc.b $38 ; 8
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $EE ; ├«
	dc.b $4C ; L
	dc.b $2A ; *
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $EA ; ├¬
	dc.b $1E
	dc.b $4C ; L
	dc.b $46 ; F
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $EA ; ├¬
	dc.b $4E ; N
	dc.b $4D ; M
	dc.b $38 ; 8
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $EA ; ├¬
	dc.b $7E ; ~
	dc.b $4D ; M
	dc.b $2A ; *
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $EA ; ├¬
	dc.b $66 ; f
	dc.b $4C ; L
	dc.b $38 ; 8
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $EA ; ├¬
	dc.b $36 ; 6
	dc.b $4D ; M
	dc.b $46 ; F
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $BE ; ┬╛
	dc.b $4B ; K
	dc.b $2A ; *
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $8E ; ┼╜
	dc.b $4B ; K
	dc.b $38 ; 8
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $A6 ; ┬ª
	dc.b $4B ; K
	dc.b $46 ; F
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $BE ; ┬╛
	dc.b $46 ; F
	dc.b $D8 ; ├ÿ
	dc.b   0
	dc.b   1
	dc.b   0
	dc.b   1
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $46 ; F
	dc.b $D8 ; ├ÿ
	dc.b   0
	dc.b   1
	dc.b   0
	dc.b   1
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $46 ; F
	dc.b $D8 ; ├ÿ
	dc.b   0
	dc.b   1
	dc.b   0
	dc.b   1
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $46 ; F
	dc.b $D8 ; ├ÿ
	dc.b   0
	dc.b   1
	dc.b   0
	dc.b   1
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
unk_5904:   dc.b $54 ; T        ; DATA XREF: sub_5764+8o sub_5764+16o
	dc.b $B8 ; ┬╕
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   0
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $54 ; T
	dc.b $BE ; ┬╛
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b   1
	dc.b $E8 ; ├¿
	dc.b $FE ; ├╛
	dc.b $56 ; V
	dc.b $BE ; ┬╛
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $1E
	dc.b $55 ; U
	dc.b $BE ; ┬╛
	dc.b   0
	dc.b   3
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b  $E
	dc.b $55 ; U
	dc.b $38 ; 8
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $2E ; .
	dc.b $55 ; U
	dc.b $46 ; F
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $3A ; :
	dc.b $56 ; V
	dc.b $38 ; 8
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $46 ; F
	dc.b $56 ; V
	dc.b $46 ; F
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $52 ; R
	dc.b $56 ; V
	dc.b $38 ; 8
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $76 ; v
	dc.b $56 ; V
	dc.b $46 ; F
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $82 ; ΓÇÜ
	dc.b $59 ; Y
	dc.b $3C ; <
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   0
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $57 ; W
	dc.b $BC ; ┬╝
	dc.b   0
	dc.b   5
	dc.b   0
	dc.b   1
	dc.b $E9 ; ├⌐
	dc.b $5E ; ^
	dc.b $5A ; Z
	dc.b $3C ; <
	dc.b   0
	dc.b   2
	dc.b   0
	dc.b   0
	dc.b $E8 ; ├¿
	dc.b $F8 ; ├╕
	dc.b $43 ; C
	dc.b $FA ; ├║
	dc.b   0
	dc.b $2C ; ,
	dc.b  $C
	dc.b $41 ; A
	dc.b   0
	dc.b  $A
	dc.b $63 ; c
	dc.b   2
	dc.b $4E ; N
	dc.b $75 ; u

; =============== S U B R O U T I N E =======================================


sub_5978:
	movem.l d0-d5/a5,-(sp)
	add.w   d1,d1
	adda.w  d1,a1
	add.w   d1,d1
	adda.w  d1,a1
	move.w  d0,d3
	movem.w (a1),d0-d1/a1
	swap    d0
	move.w  #3,d0
	bsr.w   sub_5B6C
	movem.l (sp)+,d0-d5/a5
	rts
; End of function sub_5978

; ---------------------------------------------------------------------------
	dc.b $48 ; H
	dc.b $26 ; &
	dc.b   0
	dc.b   2
	dc.b $EB ; ├½
	dc.b $4E ; N
	dc.b $48 ; H
	dc.b $30 ; 0
	dc.b   0
	dc.b   2
	dc.b $EB ; ├½
	dc.b $54 ; T
	dc.b $48 ; H
	dc.b $38 ; 8
	dc.b   0
	dc.b   2
	dc.b $EB ; ├½
	dc.b $5A ; Z
	dc.b $48 ; H
	dc.b $40 ; @
	dc.b   0
	dc.b   2
	dc.b $EB ; ├½
	dc.b $60 ; `
	dc.b $48 ; H
	dc.b $48 ; H
	dc.b   0
	dc.b   7
	dc.b $EB ; ├½
	dc.b $66 ; f
	dc.b $48 ; H
	dc.b $48 ; H
	dc.b   0
	dc.b   7
	dc.b $EB ; ├½
	dc.b $66 ; f
	dc.b $48 ; H
	dc.b $5A ; Z
	dc.b   0
	dc.b   7
	dc.b $EB ; ├½
	dc.b $76 ; v
	dc.b $48 ; H
	dc.b $5A ; Z
	dc.b   0
	dc.b   7
	dc.b $EB ; ├½
	dc.b $76 ; v
	dc.b $48 ; H
	dc.b $5A ; Z
	dc.b   0
	dc.b   7
	dc.b $EB ; ├½
	dc.b $86 ; ΓÇá
	dc.b $48 ; H
	dc.b $5A ; Z
	dc.b   0
	dc.b   7
	dc.b $EB ; ├½
	dc.b $86 ; ΓÇá
	dc.b $48 ; H
	dc.b $26 ; &
	dc.b   0
	dc.b   2
	dc.b $EB ; ├½
	dc.b $96 ; ΓÇô
	dc.b $4E ; N
	dc.b $75 ; u

; =============== S U B R O U T I N E =======================================


sub_59DE:               ; CODE XREF: sub_3A40+1Cj
				; ROM:00003B22p ...
	move.l  a1,-(sp)
	bsr.w   sub_4208
	bne.s   loc_59F2
	cmpi.w  #1,d1
	beq.s   loc_59F2
	cmpi.w  #2,d1
	bne.s   loc_5A60

loc_59F2:               ; CODE XREF: sub_59DE+6j sub_59DE+Cj
	m_loadVramWriteAddress $C5BE, d0
	tst.b   (byte_FFFFD003).w
	beq.s   loc_5A1C
	cmpi.w  #4,d1
	bcs.s   loc_5A5E
	cmpi.w  #7,d1
	bcc.s   loc_5A5E
	movem.l d0-d2,-(sp)
	moveq   #3,d1
	bsr.s   sub_5A64
	movem.l (sp)+,d0-d2
	bsr.w   sub_5DEE
	bra.s   loc_5A60
; ---------------------------------------------------------------------------

loc_5A1C:               ; CODE XREF: sub_59DE+1Ej
	cmpi.w  #6,d1
	bne.s   loc_5A5E
	tst.b   (insertedDiscType).w
	beq.s   loc_5A60
	btst    #1,(byte_FFFFD008).w
	bne.s   loc_5A3E
	btst    #2,(byte_FFFFD008).w
	beq.s   loc_5A42
	moveq   #4,d1
	bra.w   loc_5A5E
; ---------------------------------------------------------------------------

loc_5A3E:               ; CODE XREF: sub_59DE+50j
	moveq   #5,d1
	bra.s   loc_5A5E
; ---------------------------------------------------------------------------

loc_5A42:               ; CODE XREF: sub_59DE+58j
	moveq   #9,d1
	lea (unk_FFFFE152).w,a1
	bsr.w   writeToVram
	addi.l  #$800000,d0
	moveq   #9,d1
	lea (unk_FFFFE152).w,a1
	bsr.w   writeToVram
	bra.s   loc_5A60
; ---------------------------------------------------------------------------

loc_5A5E:               ; CODE XREF: sub_59DE+24j sub_59DE+2Aj ...
	bsr.s   sub_5A64

loc_5A60:               ; CODE XREF: sub_59DE+12j sub_59DE+3Cj ...
	movea.l (sp)+,a1
	rts
; End of function sub_59DE


; =============== S U B R O U T I N E =======================================


sub_5A64:               ; CODE XREF: sub_59DE+32p
				; sub_59DE:loc_5A5Ep
	move.w  d1,-(sp)
	add.w   d1,d1
	movea.w word_5A7E(pc,d1.w),a1
	moveq   #9,d1
	moveq   #1,d2
	m_loadVramWriteAddress $C5BE, d0
	bsr.w   writeTilemapToVram
	move.w  (sp)+,d1
	rts
; End of function sub_5A64

; ---------------------------------------------------------------------------
word_5A7E:
	dc.w $EC3E
	dc.w $EC16
	dc.w $EBC6
	dc.w $EBEE
	dc.w $EB4E
	dc.w $EB76
	dc.w $EB9E
	dc.w $ECB6
	dc.w $ECDE

; =============== S U B R O U T I N E =======================================


sub_5A90:               ; CODE XREF: sub_4D78:loc_4D84j
	cmpi.w  #2,d0
	bhi.s   locret_5ACA
	move.w  d0,d1
	m_loadVramWriteAddress $C4BE, d0
	tst.w   d1
	bne.s   loc_5ABC
	moveq   #9,d1
	lea (unk_FFFFE0B6).w,a1
	bsr.w   writeToVram
	addi.l  #$800000,d0
	moveq   #9,d1
	lea (unk_FFFFE0EA).w,a1
	bra.w   writeToVram
; ---------------------------------------------------------------------------

loc_5ABC:               ; CODE XREF: sub_5A90+10j
	add.w   d1,d1
	movea.w locret_5ACA(pc,d1.w),a1
	moveq   #9,d1
	moveq   #1,d2
	bsr.w   writeTilemapToVram

locret_5ACA:                ; CODE XREF: sub_5A90+4j
	rts
; End of function sub_5A90

; ---------------------------------------------------------------------------
	asr.w   d6,d6
	lsr.l   #6,d6

; =============== S U B R O U T I N E =======================================


sub_5AD0:               ; CODE XREF: sub_516C+10p
				; sub_51A4:loc_51B6p ...
	moveq   #0,d0
	move.b  (byte_FFFFD00E).w,d0
	mulu.w  #$C,d0
	lea (unk_FFFFEAEE).w,a1
	adda.w  d0,a1
	m_loadVramWriteAddress $C4B2, d0
	moveq   #5,d1
	bra.w   writeToVram
; End of function sub_5AD0


; =============== S U B R O U T I N E =======================================


sub_5AEC:               ; CODE XREF: sub_5FA2+16p
	m_loadVramWriteAddress $C324, d0
	lea (decompScratch).w,a1
	moveq   #$19,d1
	moveq   #$E,d2
	jsr writeTilemapToVram(pc)
	m_loadVramWriteAddress $C6D8, d0
	lea (unk_FFFFE30C).w,a1
	moveq   #9,d1
	moveq   #$E,d2
	jsr writeTilemapToVram(pc)
	bsr.w   sub_5732
	bsr.s   sub_5AD0
	bsr.s   sub_5B22
	bsr.w   sub_5F36
	clr.w   (word_FFFFD052).w
	rts
; End of function sub_5AEC


; =============== S U B R O U T I N E =======================================


sub_5B22:               ; CODE XREF: sub_5AEC+2Ap
	move.w  #1,d1
	moveq   #3,d7

loc_5B28:               ; CODE XREF: sub_5B22+20j
	moveq   #0,d0
	cmpi.w  #3,d1
	bne.s   loc_5B3C
	btst    #2,(byte_FFFFD008).w
	bne.s   loc_5B3C
	move.w  #$2000,d0

loc_5B3C:               ; CODE XREF: sub_5B22+Cj sub_5B22+14j
	bsr.w   sub_5764
	addq.w  #1,d1
	dbf d7,loc_5B28
	move.w  #$A,d1
	moveq   #1,d7

loc_5B4C:               ; CODE XREF: sub_5B22+32j
	moveq   #0,d0
	bsr.w   sub_5764
	addq.w  #1,d1
	dbf d7,loc_5B4C
	rts
; End of function sub_5B22


; =============== S U B R O U T I N E =======================================


writeToVram:                ; CODE XREF: sub_59DE+6Ap sub_59DE+7Ap ...
	move.l  d0,(VDP_CONTROL).l

loc_5B60:               ; CODE XREF: writeToVram+Cj
	move.w  (a1)+,(VDP_DATA).l
	dbf d1,loc_5B60
	rts
; End of function writeToVram


; =============== S U B R O U T I N E =======================================


sub_5B6C:               ; CODE XREF: sub_5978+18p
	move.l  d0,(VDP_CONTROL).l

loc_5B72:               ; CODE XREF: sub_5B6C+10j
	move.w  (a1)+,d4
	or.w    d3,d4
	move.w  d4,(VDP_DATA).l
	dbf d1,loc_5B72
	rts
; End of function sub_5B6C


; =============== S U B R O U T I N E =======================================


sub_5B82:               ; CODE XREF: sub_4C8E+6p sub_4E9E+8p
	moveq   #$A,d1
	move.w  #$2000,d0
	bsr.w   sub_5764
	move.w  #1,(word_FFFFD052).w
	m_loadVramWriteAddress $CAA4, d0
	lea (unk_FFFFE550).w,a1
	moveq   #$19,d1
	moveq   #8,d2
	jsr writeTilemapToVram(pc)
	lea unk_5BE2(pc),a2
	move.w  (byte_FFFFD008).w,d2
	moveq   #$F,d1

loc_5BAE:               ; CODE XREF: sub_5B82+52j
	move.b  (a2)+,d3
	bmi.s   loc_5BBC
	btst    d3,d2
	beq.s   loc_5BBC

loc_5BB6:               ; CODE XREF: sub_5B82+44j
	move.w  #$2000,d0
	bra.s   loc_5BCA
; ---------------------------------------------------------------------------

loc_5BBC:               ; CODE XREF: sub_5B82+2Ej sub_5B82+32j
	cmpi.b  #$FE,d3
	bne.s   loc_5BC8
	tst.w   (word_FFFFD168).w
	bne.s   loc_5BB6

loc_5BC8:               ; CODE XREF: sub_5B82+3Ej
	moveq   #0,d0

loc_5BCA:               ; CODE XREF: sub_5B82+38j
	bsr.w   sub_5764
	addq.w  #1,d1
	cmpi.w  #$17,d1
	bls.s   loc_5BAE
	tst.b   (byte_FFFFD003).w
	beq.s   locret_5BE0
	bsr.w   resetWindowVPos

locret_5BE0:                ; CODE XREF: sub_5B82+58j
	rts
; End of function sub_5B82

; ---------------------------------------------------------------------------
unk_5BE2:   dc.b   2        ; DATA XREF: sub_5B82+22o
	dc.b  $E
	dc.b   1
	dc.b  $F
	dc.b $FE ; ├╛
	dc.b $FF
	dc.b   4
	dc.b $FF
	dc.b $FF
	dc.b   0

; =============== S U B R O U T I N E =======================================


sub_5BEC:               ; CODE XREF: sub_4E48+3Ap
	move.w  #2,(word_FFFFD052).w
	m_loadVramWriteAddress $CAA4, d0
	lea (unk_FFFFE724).w,a1
	moveq   #$19,d1
	moveq   #8,d2
	jsr writeTilemapToVram(pc)
	move.w  #$2000,d0
	moveq   #$18,d1
	bsr.w   sub_5764
	moveq   #0,d0
	addq.w  #1,d1
	bsr.w   sub_5764
	moveq   #0,d0
	addq.w  #1,d1
	bsr.w   sub_5764
	rts
; End of function sub_5BEC


; =============== S U B R O U T I N E =======================================


sub_5C20:               ; CODE XREF: sub_3B28+4p sub_3BAE+4p ...
	moveq   #$A,d1
	moveq   #0,d0
	bsr.w   sub_5764
	m_loadVramWriteAddress $CAA4, d0
	moveq   #$19,d1
	moveq   #8,d2
	move.w  #0,d3
	jsr fillVramTilemap(pc)
	moveq   #6,d1
	bsr.w   sub_59DE
	clr.w   (word_FFFFD052).w
	tst.b   (byte_FFFFD003).w
	beq.s   locret_5C4E
	bsr.w   sub_5E88

locret_5C4E:                ; CODE XREF: sub_5C20+28j
	rts
; End of function sub_5C20


; =============== S U B R O U T I N E =======================================


sub_5C50:               ; CODE XREF: sub_3710+138p
				; sub_3E6A+58p ...
	m_loadVramWriteAddress $CC2A, d0
	moveq   #0,d2
	move.w  (word_FFFFD040).w,d4
	move.w  (word_FFFFD100).w,d6
	lea (unk_FFFFD102).w,a1
	bra.w   sub_5D22
; End of function sub_5C50


; =============== S U B R O U T I N E =======================================


sub_5C68:               ; CODE XREF: sub_3710+1A6p
				; sub_3950:loc_39A6p ...
	m_loadVramWriteAddress $CD2A, d0
	moveq   #0,d2
	move.w  (word_FFFFD042).w,d4
	move.w  (word_FFFFD168).w,d6
	lea (unk_FFFFD16A).w,a1
	bra.w   sub_5D22
; End of function sub_5C68


; =============== S U B R O U T I N E =======================================


sub_5C80:
	move.w  d1,d4
	move.w  d2,d6
	moveq   #0,d2
	bra.w   sub_5D22
; End of function sub_5C80


; =============== S U B R O U T I N E =======================================


sub_5C8A:               ; CODE XREF: state_3040:loc_3092p
	btst    #2,(byte_FFFFD004).w
	beq.s   locret_5CF8
	btst    #4,(byte_FFFFD004).w
	bne.s   locret_5CF8
	m_loadVramWriteAddress $C6AA, d0
	move.w  (word_FFFFD03E).w,d1
	moveq   #0,d2
	move.w  (unk_FFFFD03C).w,d3
	lea (unk_FFFFD1D2).w,a1
	cmp.w   (unk_FFFFD1D0).w,d3
	bcc.s   loc_5CB8
	bsr.w   sub_5D4C

loc_5CB8:               ; CODE XREF: sub_5C8A+28j
	move.w  (word_FFFFD1CE).w,d3
	move.w  d3,(unk_FFFFD03C).w
	btst    #2,(byte_FFFFD008).w
	beq.s   locret_5CF8
	moveq   #0,d1
	move.w  d3,d1
	divu.w  #$A,d1
	subq.w  #1,d1
	bpl.s   loc_5CD6
	moveq   #0,d1

loc_5CD6:               ; CODE XREF: sub_5C8A+48j
	cmp.w   (word_FFFFD03E).w,d1
	beq.s   loc_5CEA
	move.w  d1,(word_FFFFD03E).w
	movem.l d1/d3/a1,-(sp)
	bsr.s   sub_5CFA
	movem.l (sp)+,d1/d3/a1

loc_5CEA:               ; CODE XREF: sub_5C8A+50j
	m_loadVramWriteAddress $C6AA, d0
	move.w  #$2000,d2
	bra.w   sub_5D4C
; ---------------------------------------------------------------------------

locret_5CF8:                ; CODE XREF: sub_5C8A+6j sub_5C8A+Ej ...
	rts
; End of function sub_5C8A


; =============== S U B R O U T I N E =======================================


sub_5CFA:               ; CODE XREF: sub_4400+8Cp
				; sub_4D9E:loc_4DD0p ...
	move.w  (unk_FFFFD1D0).w,d2
	beq.w   sub_5DB0
	m_loadVramWriteAddress $C6AA, d0
	move.w  (word_FFFFD03E).w,d1
	lea (unk_FFFFD1D2).w,a1
	mulu.w  #$A,d1
	move.w  d1,d4
	move.w  d2,d6
	moveq   #0,d2
	bsr.s   sub_5D22
	addi.l  #$800000,d0
; End of function sub_5CFA


; =============== S U B R O U T I N E =======================================


sub_5D22:               ; CODE XREF: sub_5C50+14j sub_5C68+14j ...
	move.l  d0,(VDP_CONTROL).l
	moveq   #9,d5

@loc_5D2A:               ; CODE XREF: sub_5D22+16j
	cmp.w   d4,d6
	ble.s   @loc_5D3E
	move.b  (a1,d4.w),d1
	bsr.w   sub_5D82
	addq.w  #1,d4
	dbf d5,@loc_5D2A
	rts
; ---------------------------------------------------------------------------

@loc_5D3E:               ; CODE XREF: sub_5D22+Aj sub_5D22+24j
	move.l  (word_FFFFE172).w,(VDP_DATA).l
	dbf d5,@loc_5D3E
	rts
; End of function sub_5D22


; =============== S U B R O U T I N E =======================================


sub_5D4C:               ; CODE XREF: sub_5C8A+2Ap sub_5C8A+6Aj
	mulu.w  #$A,d1
	move.w  d3,d4
	sub.w   d1,d4
	bmi.s   locret_5D80
	cmpi.b  #$14,d4
	bcc.s   locret_5D80
	swap    d0
	cmpi.b  #$A,d4
	bcs.s   loc_5D6C
	addi.w  #$80,d0 ; 'Γé¼'
	subi.w  #$A,d4

loc_5D6C:               ; CODE XREF: sub_5D4C+16j
	add.w   d4,d4
	add.w   d4,d4
	add.w   d4,d0
	swap    d0
	move.l  d0,(VDP_CONTROL).l
	move.b  (a1,d3.w),d1
	bsr.s   sub_5D82

locret_5D80:                ; CODE XREF: sub_5D4C+8j sub_5D4C+Ej
	rts
; End of function sub_5D4C


; =============== S U B R O U T I N E =======================================


sub_5D82:               ; CODE XREF: sub_5D22+10p sub_5D4C+32p
	bsr.w   sub_55AC
	move.w  d1,d3
	lsr.w   #4,d3
	andi.w  #$F,d3
	bne.s   loc_5D94
	move.w  #$168B,d3

loc_5D94:               ; CODE XREF: sub_5D82+Cj
	addi.w  #$5B2,d3
	add.w   d2,d3
	swap    d3
	move.w  d1,d3
	andi.w  #$F,d3
	addi.w  #$5A9,d3
	add.w   d2,d3
	move.l  d3,(VDP_DATA).l
	rts
; End of function sub_5D82


; =============== S U B R O U T I N E =======================================


sub_5DB0:               ; CODE XREF: sub_45BE+38p sub_5CFA+4j
	clr.w   (word_FFFFD03E).w
	m_loadVramWriteAddress $C6AA, d0
	bsr.w   loc_5DC4
	m_loadVramWriteAddress $C72A, d0

loc_5DC4:               ; CODE XREF: sub_5DB0+Ap
	lea (word_FFFFE172).w,a1
	moveq   #$13,d1
	bra.w   writeToVram
; End of function sub_5DB0


; =============== S U B R O U T I N E =======================================


sub_5DCE:               ; CODE XREF: sub_3950+46p
	subi.w  #9,d0
	bpl.s   locret_5DD6
	moveq   #0,d0

locret_5DD6:                ; CODE XREF: sub_5DCE+4j
	rts
; End of function sub_5DCE


; =============== S U B R O U T I N E =======================================


sub_5DD8:               ; CODE XREF: sub_31FE+5Ap
	moveq #6, d1
	moveq #0, d0
	bsr.w sub_5764

	moveq #7, d1
	moveq #0, d0
	bra.w sub_5764
; End of function sub_5DD8


; =============== S U B R O U T I N E =======================================


sub_5DE8:               ; CODE XREF: sub_63D4+98p
	moveq #3, d1
	bsr.w sub_59DE
; End of function sub_5DE8


; =============== S U B R O U T I N E =======================================


sub_5DEE:               ; CODE XREF: sub_59DE+38p
	move.b  (byte_FFFFD010).w,d1
	bsr.w   sub_55AC
	bra.w   sub_5480
; End of function sub_5DEE


; =============== S U B R O U T I N E =======================================


sub_5DFA:               ; CODE XREF: sub_30C2+ACp
	m_loadVramWriteAddress $D4B8, d0
	lea (unk_FFFFE30C).w, a1
	moveq #9,  d1
	moveq #$E, d2
	jsr writeTilemapToVram(pc)

	m_loadVramWriteAddress $D138, d0
	bsr.w sub_5754

	move.w #$2000, d0
	moveq  #3, d1
	bsr.w  sub_5764
	rts
; End of function sub_5DFA


; =============== S U B R O U T I N E =======================================


sub_5E22:               ; CODE XREF: sub_4F9A+Ap
	bsr.w   sub_5E88
	m_loadVramWriteAddress $C220, d6
	bsr.w   loc_67E2
	m_loadVramWriteAddress $C358, d0
	bsr.w   sub_5754
	moveq   #0,d0
	moveq   #9,d1
	bsr.w   sub_5764
	moveq   #8,d1
	bsr.w   sub_5764
	moveq   #3,d1
	bsr.w   sub_59DE
	bsr.w   sub_5ED2
	rts
; End of function sub_5E22


; =============== S U B R O U T I N E =======================================


sub_5E54:               ; CODE XREF: sub_4FB4+6p
	bsr.s   resetWindowVPos
	bsr.w   sub_5732
	m_loadVramWriteAddress $C220, d6
	bsr.w   sub_6816
	moveq   #6,d1
	bsr.w   sub_59DE
	rts
; End of function sub_5E54


; =============== S U B R O U T I N E =======================================


sub_5E6C:               ; CODE XREF: sub_329A+238j
	bsr.w   sub_4218
	bls.s   loc_5E74
	bsr.s   resetWindowVPos

loc_5E74:               ; CODE XREF: sub_3B28+3Ep sub_5E6C+4j
	m_loadVramWriteAddress $D138, d0
	lea (unk_FFFFF5C6).w,a1
	moveq   #9,d1
	moveq   #$15,d2
	jsr writeTilemapToVram(pc)
	rts
; End of function sub_5E6C


; =============== S U B R O U T I N E =======================================


sub_5E88:               ; CODE XREF: sub_5C20+2Ap sub_5E22p ...
	move.w #$9282, (VDP_CONTROL).l
	move.w #$9282, (vdpRegCache + $24).w
	rts
; End of function sub_5E88


; =============== S U B R O U T I N E =======================================


resetWindowVPos:            ; CODE XREF: sub_5B82+5Ap sub_5E54p ...
	move.w #$9200, (VDP_CONTROL).l
	move.w #$9200, (vdpRegCache + $24).w
	rts
; End of function resetWindowVPos


; =============== S U B R O U T I N E =======================================


sub_5EA8:               ; CODE XREF: sub_329A+23Cj
	m_loadVramReadAddress $D138, d0
	lea (unk_FFFFF5C6).w,a1
	moveq   #9,d1
	moveq   #$15,d2
	jsr sub_6282(pc)

	m_loadVramWriteAddress $D138, d0
	moveq   #9,d1
	move.w  #$15,d2
	move.w  #0,d3
	jsr fillVramTilemap(pc)

	bsr.s   sub_5E88
	rts
; End of function sub_5EA8


; =============== S U B R O U T I N E =======================================


sub_5ED2:               ; CODE XREF: sub_329A:loc_34C8p
				; sub_5E22+2Cp
	lea (VDP_DATA).l, a5

	m_loadVramWriteAddress $C2BA, 4(a5)
	move.l #$C6F9C6FA, (a5)

	m_loadVramWriteAddress $C2C4, 4(a5)
	move.l #$C6F9C6FD, (a5)

	m_loadVramWriteAddress $C2CC, 4(a5)
	move.w #$C6FE, (a5)

	m_loadVramWriteAddress $C2D4, 4(a5)
	move.l #$C6FBC6FC, (a5)
	rts
; End of function sub_5ED2


; =============== S U B R O U T I N E =======================================


sub_5F10:               ; CODE XREF: sub_329A+228p
	lea (VDP_DATA).l,a5
	m_loadVramWriteAddress $C2BA, 4(a5)
	move.w  #$C001,d0
	moveq   #$13,d1

loc_5F24:               ; CODE XREF: sub_5F10+16j
	move.w  d0,(a5)
	dbf d1,loc_5F24
	rts
; End of function sub_5F10


; =============== S U B R O U T I N E =======================================


sub_5F2C:               ; CODE XREF: sub_30C2+4Ap
	clr.l (dword_FFFFD062).w
	clr.l (dword_FFFFD066).w
	rts
; End of function sub_5F2C


; =============== S U B R O U T I N E =======================================


sub_5F36:               ; CODE XREF: state_3040+34p sub_5AEC+2Cp
	lea (VDP_DATA).l,a5
	m_loadVramWriteAddress $C92C, 4(a5)
	move.w  (dword_FFFFD032).w,d0
	lea (unk_FFFFEAAE).w,a1
	lea (unk_FFFFD044).w,a2
	bsr.s   loc_5F66

	m_loadVramWriteAddress $C82C, 4(a5)
	move.w  (dword_FFFFD032+2).w,d0
	lea (unk_FFFFEAAE).w,a1
	lea (unk_FFFFD048).w,a2

loc_5F66:               ; CODE XREF: sub_5F36+1Ap
	move.b  2(a2),3(a2)
	move.b  1(a2),2(a2)
	move.b  (a2),1(a2)
	move.b  d0,(a2)+
	add.b   (a2)+,d0
	add.b   (a2)+,d0
	add.b   (a2)+,d0
	lsr.b   #2,d0
	lea $20(a1),a1
	moveq   #$F,d1
	sub.w   d0,d1
	subq.w  #1,d0
	bmi.s   loc_5F92

loc_5F8C:               ; CODE XREF: sub_5F36+58j
	move.w  (a1)+,(a5)
	dbf d0,loc_5F8C

loc_5F92:               ; CODE XREF: sub_5F36+54j
	tst.w   d1
	bmi.s   locret_5FA0
	lea -$20(a1),a1

loc_5F9A:               ; CODE XREF: sub_5F36+66j
	move.w  (a1)+,(a5)
	dbf d1,loc_5F9A

locret_5FA0:                ; CODE XREF: sub_5F36+5Ej
	rts
; End of function sub_5F36


; =============== S U B R O U T I N E =======================================


sub_5FA2:               ; CODE XREF: sub_30C2+7Ap
	bsr.w sub_5FBE

	lea (unk_FFFFED06).w, a1
	m_loadVramWriteAddress $F000, d0
	moveq #$27, d1
	moveq #$1B, d2
	jsr writeTilemapToVram(pc)

	bsr.w sub_5AEC

	rts
; End of function sub_5FA2


; =============== S U B R O U T I N E =======================================


sub_5FBE:               ; CODE XREF: sub_5FA2p
	lea off_602C(pc), a0

	movea.l (a0)+, a1
	jsr loadPalettesToBuffer(pc)

	bsr.s sub_6018
	bsr.s sub_6018

	@loc_5FCC:
		move.l (a0)+, d0
		beq.s  @loc_5FDC

		movea.l (a0)+, a1
		move.l  (a0)+, d1
		move.w  (a0)+, d2
		jsr loadFont(pc)

		bra.s @loc_5FCC
; ---------------------------------------------------------------------------

@loc_5FDC:               ; CODE XREF: sub_5FBE+10j
	movea.w (a0)+, a2

	@loc_5FDE:
		move.w  (a0)+, d0
		beq.s   @loc_5FEA

		movea.l (a0)+, a1
		jsr decompressEnigma(pc)

		bra.s @loc_5FDE
; ---------------------------------------------------------------------------

@loc_5FEA:               ; CODE XREF: sub_5FBE+22j
	m_loadVramWriteAddress $F060, d0
	move.l #$11188188, d1
	moveq  #$19, d7
	lea (word_15108).l, a1

	@loc_5FFE:
		bsr.s sub_6010

		addi.l #$800000, d0
		dbf d7, @loc_5FFE

	lea (word_15070).l, a1
; End of function sub_5FBE


; =============== S U B R O U T I N E =======================================


sub_6010:               ; CODE XREF: sub_5FBE:loc_5FFEp
	moveq #1, d2
	jsr loadFont(pc)
	rts
; End of function sub_6010


; =============== S U B R O U T I N E =======================================


sub_6018:               ; CODE XREF: sub_5FBE+Ap sub_5FBE+Cp
	move.l (a0)+, (VDP_CONTROL).l

	@loc_601E:
		move.l (a0)+, d0
		beq.s  @locret_602A

		movea.l d0, a1
		jsr decompressNemesis(pc)

		bra.s @loc_601E
; ---------------------------------------------------------------------------

@locret_602A:
	rts
; End of function sub_6018

; ---------------------------------------------------------------------------
off_602C:       ; DATA XREF: sub_5FBEo
	dc.l palette_60AE

	dc.l $44200002      ; VRAM $8420
	dc.l $10890
	dc.l $12626
	dc.l 0

	dc.l $7DE00003      ; VRAM $FDE0
	dc.l $10800
	dc.l 0

	dc.l $5DE00003      ; VRAM $DDE0
	dc.l $12674
	dc.l $11188188
	dc.w $11

	dc.l $7EA00003      ; VRAM $FEA0
	dc.l $12BE0
	dc.l $000BB0BB
	dc.w $3

	dc.l 0

	dc.w $E000

	dc.w $8421
	dc.l $12704

	dc.w $8421
	dc.l $127B0

	dc.w $8421
	dc.l $12862

	dc.w $8421
	dc.l $129C2

	dc.w $8421
	dc.l $12A0E

	dc.w $8421
	dc.l $12A78

	dc.w $8421
	dc.l $12A86

	dc.w $8421
	dc.l $12A9E

	dc.w $8421
	dc.l $12AB4

	dc.w $4609
	dc.l $12B6C

	dc.w 0

locret_60AC:
	rts

palette_60AE:
	dc.b 0
	dc.b 63

	dc.w $E88
	dc.w $000
	dc.w $222
	dc.w $444
	dc.w $666
	dc.w $888
	dc.w $AAA
	dc.w $CCC
	dc.w $EEE
	dc.w $ECA
	dc.w $E66
	dc.w $0EC
	dc.w $666
	dc.w $2EA
	dc.w $4A4
	dc.w $00E

	dc.w $E88
	dc.w $000
	dc.w $222
	dc.w $444
	dc.w $064
	dc.w $086
	dc.w $0CA
	dc.w $0EC
	dc.w $0EE
	dc.w $0EC
	dc.w $E00
	dc.w $0EC
	dc.w $6EC
	dc.w $EEE
	dc.w $4A4
	dc.w $00E

	dc.w $E88
	dc.w $000
	dc.w $222
	dc.w $444
	dc.w $460
	dc.w $680
	dc.w $8A0
	dc.w $AC0
	dc.w $EE0
	dc.w $CC0
	dc.w $AE0
	dc.w $044
	dc.w $EE0
	dc.w $000
	dc.w $0AA
	dc.w $0EE

	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000

; =============== S U B R O U T I N E =======================================


sub_6130:               ; CODE XREF: state_3040+40p
	lea (unk_FFFFD05E).w,a0
	btst    #0,(a0)
	bne.s   loc_6184
	btst    #2,(a0)
	bne.s   loc_6160
	tst.b   (byte_FFFFD003).w
	beq.w   locret_61DE
	bset    #2,(a0)
	move.b  #$B4,(unk_FFFFD05F).w
	m_loadVramWriteAddress $DA04, d0
	lea asc_6214(pc),a1 ; "  PRESS THE B BUTTON TO"
	bra.w   loc_6248
; ---------------------------------------------------------------------------

loc_6160:               ; CODE XREF: sub_6130+Ej
	subq.b  #1,1(a0)
	beq.s   loc_6174
	tst.b   (byte_FFFFD003).w
	beq.s   loc_6174
	btst    #0,(byte_FFFFD004).w
	beq.s   locret_61DE

loc_6174:               ; CODE XREF: sub_6130+34j sub_6130+3Aj
	bset    #0,(a0)
	bclr    #2,(a0)
	m_loadVramWriteAddress $DA04, d0
	bra.s   loc_61D2
; ---------------------------------------------------------------------------

loc_6184:               ; CODE XREF: sub_6130+8j
	btst    #1,(a0)
	bne.s   locret_61DE
	btst    #3,(a0)
	bne.s   loc_61B6
	tst.b   (byte_FFFFD003).w
	beq.s   locret_61DE
	btst    #0,(byte_FFFFD004).w
	beq.s   locret_61DE
	bset    #3,(a0)
	move.b  #$B4,(unk_FFFFD05F).w
	m_loadVramWriteAddress $D284, d0
	lea asc_61E0(pc),a1 ; "  PRESS THE B BUTTON TO"
	bra.w   loc_6248
; ---------------------------------------------------------------------------

loc_61B6:               ; CODE XREF: sub_6130+5Ej
	subq.b  #1,1(a0)
	beq.s   loc_61C4
	btst    #0,(byte_FFFFD004).w
	bne.s   locret_61DE

loc_61C4:               ; CODE XREF: sub_6130+8Aj
	bset    #1,(a0)
	bclr    #3,(a0)
	m_loadVramWriteAddress $D284, d0

loc_61D2:               ; CODE XREF: sub_6130+52j
	moveq   #$19,d1
	moveq   #2,d2
	move.w  #$8000,d3
	jsr fillVramTilemap(pc)

locret_61DE:                ; CODE XREF: sub_6130+14j sub_6130+42j ...
	rts
; ---------------------------------------------------------------------------
asc_61E0:   dc.b '  PRESS THE B BUTTON TO',0,0 ; DATA XREF: sub_6130+7Eo
	dc.b 'DISPLAY THE CONTROL PANEL['
	dc.b $FF
asc_6214:   dc.b '  PRESS THE B BUTTON TO',0,0 ; DATA XREF: sub_6130+28o
	dc.b 'REMOVE THE CONTROL PANEL['
	dc.b $FF
	dc.b   0
; ---------------------------------------------------------------------------

loc_6248:               ; CODE XREF: sub_6130+2Cj sub_6130+82j
	lea (VDP_DATA).l,a5
	move.w  #$783,d1

loc_6252:               ; CODE XREF: sub_6130+14Ej
	move.l  d0,4(a5)

loc_6256:               ; CODE XREF: sub_6130+144j
	moveq   #0,d2
	move.b  (a1)+,d2
	bmi.s   locret_6280
	beq.s   loc_6276
	cmpi.w  #$20,d2 ; ' '
	bne.s   loc_6268
	moveq   #0,d2
	bra.s   loc_6272
; ---------------------------------------------------------------------------

loc_6268:               ; CODE XREF: sub_6130+132j
	subi.w  #$41,d2 ; 'A'
	add.w   d2,d2
	add.w   d2,d2
	add.w   d1,d2

loc_6272:               ; CODE XREF: sub_6130+136j
	move.w  d2,(a5)
	bra.s   loc_6256
; ---------------------------------------------------------------------------

loc_6276:               ; CODE XREF: sub_6130+12Cj
	swap    d0
	add.w   (vdpLineIncrement).w,d0
	swap    d0
	bra.s   loc_6252
; ---------------------------------------------------------------------------

locret_6280:                ; CODE XREF: sub_6130+12Aj
	rts
; End of function sub_6130


; =============== S U B R O U T I N E =======================================


sub_6282:               ; CODE XREF: sub_5EA8+Ep
	lea (VDP_DATA).l,a5

@loc_6288:
	move.l  d0,4(a5)
	move.w  d1,d3

@loc_628E:
	move.w  (a5),(a1)+
	dbf d3,@loc_628E
	nop
	movem.l d6-d7,-(sp)
	clr.l   d7
	move.w  (vdpLineIncrement).w,d7
	swap    d7
	add.l   d7,d0
	movem.l (sp)+,d6-d7
	dbf d2,@loc_6288
	rts
; End of function sub_6282


; =============== S U B R O U T I N E =======================================


sub_62AE:               ; CODE XREF: sub_57CE+34p
	sub.w   d1,d0
	sub.w   d1,d0
	subq.w  #2,d0

loc_62B4:               ; CODE XREF: sub_62AE+14j
	move.w  d1,d5

loc_62B6:               ; CODE XREF: sub_62AE+Ej
	move.w  (a1)+,d4
	or.w    d3,d4
	move.w  d4,(a2)+
	dbf d5,loc_62B6
	adda.w  d0,a2
	dbf d2,loc_62B4
	rts
; End of function sub_62AE


; =============== S U B R O U T I N E =======================================


sub_62C8:               ; CODE XREF: sub_30C2+4Ep sub_62C8+8j
	m_waitForWordRam1M
	m_waitForWordRam0

	clr.w (word_200400).l
	rts
; End of function sub_62C8


; =============== S U B R O U T I N E =======================================


sub_62E4:               ; CODE XREF: state_3040+Cp sub_62E4+8j
	m_waitForWordRam0
	m_saveStatusRegister
	m_disableInterrupts

	lea (WordRAM_Bank0).l, a1

	move.w $400(a1), (word_FFFFD020).w
	move.w $402(a1), (word_FFFFD022).w
	move.w $404(a1), (word_FFFFD024).w
	move.w $424(a1), (word_FFFFD026).w
	move.l $408(a1), (dword_FFFFD028).w
	move.l $40C(a1), (dword_FFFFD02C).w
	move.b $410(a1), (byte_FFFFD030).w
	move.l $426(a1), (dword_FFFFD032).w
	move.w $42A(a1), (word_FFFFD036).w
	move.b $440(a1), (byte_FFFFD050).w
	move.w $564(a1), d0

	bsr.w   sub_53B6

	m_restoreStatusRegister
	rts
; End of function sub_62E4


; =============== S U B R O U T I N E =======================================


sub_6342:               ; CODE XREF: state_3040+56p sub_30C2+52p ...
	m_waitForWordRam0
	m_saveStatusRegister
	m_disableInterrupts

	lea (WordRAM_Bank0).l, a1

	move.w (word_FFFFD020).w,  $400(a1)
	move.w (byte_FFFFD008).w,  $42C(a1)
	move.l (byte_FFFFD00E).w,  $42E(a1)
	move.w (word_FFFFD012).w,  $432(a1)
	move.l (dword_FFFFD014).w, $434(a1)
	move.l (dword_FFFFD018).w, $438(a1)
	move.l (dword_FFFFD01C).w, $43C(a1)

	lea $4FE(a1), a1
	lea (word_FFFFD168).w, a2

	; Copy 208 bytes
	moveq #51,d0
	@loc_638C:
		move.l (a2)+, (a1)+
		dbf d0, @loc_638C

	m_restoreStatusRegister
	rts
; End of function sub_6342


; =============== S U B R O U T I N E =======================================


sub_6396:               ; CODE XREF: sub_4400+C6p
	lea (WordRAM_Bank0).l,a1
	lea (dword_FFFFD700).w,a2

	; Copy 600 bytes
	move.w #149,d0
	@loc_63A4:
		move.l  (a1)+, (a2)+
		dbf d0, @loc_63A4

	rts
; End of function sub_6396


; =============== S U B R O U T I N E =======================================


sub_63AC:               ; CODE XREF: sub_30C2+A8p
	clr.b (byte_FFFFD003).w

	m_loadVramWriteAddress $20

	moveq #7, d0
	@loc_63BC:
		move.l #$FFFFFFFF, (VDP_DATA).l
		dbf d0, @loc_63BC

	bsr.w sub_67DC
	bsr.w sub_681C
	rts
; End of function sub_63AC


; =============== S U B R O U T I N E =======================================


sub_63D4:               ; CODE XREF: sub_31FE+Ej sub_63D4+8j
	btst    #GA_RET, (GA_MEM_MODE).l
	beq.s   sub_63D4

	jsr displayOff(pc)

	; Scroll planes: 32V x 64H cells
	move.w  #$9001, (VDP_CONTROL).l
	move.w  #$9001, (vdpRegCache+$20).w

	; Background color: Palette3:Color0
	move.w  #$8730, (VDP_CONTROL).l
	move.w  #$8730, (vdpRegCache+$E).w

	m_loadVsramWriteAddress 0
	move.w  #$20, (VDP_DATA).l

	lea (VDP_CONTROL).l, a4

	; Enable DMA
	move.w  (vdpRegCache+2).w, d4
	bset    #4, d4
	move.w  d4, (a4)

	m_z80RequestBus

	; DMA source address
	move.w  #$9501,     d0
	move.l  #$97119600, d1

	; DMA destination address (VRAM $0060)
	move.w  #$4060,     d2
	move.w  #$0080,     d3

	lea (WordRAM_Bank1).l, a1

	moveq #38, d6
	@loc_6442:
		bsr.w   sub_67B6

		lea     $400(a1), a1
		addq.w  #2, d1
		addi.w  #$360, d2
		bpl.s   @loc_6458

		subi.w  #$4000, d2
		addq.w  #1, d3

	@loc_6458:
		dbf d6, @loc_6442

	m_z80ReleaseBus

	bsr.w sub_6618

	st  (byte_FFFFD061).w
	bsr.w sub_5DE8

	jsr displayOn(pc)
	rts
; End of function sub_63D4


; =============== S U B R O U T I N E =======================================


sub_6476:
	; Wait for sub-CPU to give us Word RAM
	btst    #GA_RET, (GA_MEM_MODE).l
	beq.s   sub_6476

	lea     (unk_20E0FC).l, a0
	move.b  (byte_FFFFD010).w, -$78(a0)

	lea     (VDP_CONTROL).l, a4
	lea     -4(a4), a3

	tst.b   (byte_FFFFD061).w
	beq.s   @loc_64BC

	m_loadVramWriteAddress $8402
	move.w  (word_20E080).l, (a3)

	m_loadVsramWriteAddress 2
	move.w  (word_20E082).l, (a3)

@loc_64BC:
	; Enable DMA transfer
	bset    #4, (vdpRegCache+3).w
	move.w  (vdpRegCache+2).w, (a4)

	m_z80RequestBus

	moveq   #0, d7

@loc_64D0:
	move.w  2(a0), d6
	cmp.w   (a0), d6
	beq.s   @loc_6512

	addq.w  #8, 2(a0)
	andi.w  #$7F8, 2(a0)

	lea     loc_654C(pc), a6

	tst.b   (byte_FFFFD061).w
	bne.s   @loc_64F0

	lea     sub_6572(pc), a6

@loc_64F0:
	bsr.s   sub_6534

	btst    #1, (GA_COMM_MAINFLAGS).l
	beq.s   @loc_6512

	move.w  #2000, d6   ; NTSC

	btst    #MDV_VMOD, (MD_VERSION).l
	beq.s   @loc_650E

	move.w  #6000, d6   ; PAL

@loc_650E:
	cmp.w   d0, d7
	bls.s   @loc_64D0

@loc_6512:
	tst.b   (byte_FFFFD061).w
	beq.s   @loc_6520

	bclr    #1, (GA_COMM_MAINFLAGS).l

@loc_6520:
	m_z80ReleaseBus

	; Disable DMA transfer
	bclr    #4, (vdpRegCache+3).w
	move.w  (vdpRegCache+2).w, (a4)

	rts
; End of function sub_6476


; =============== S U B R O U T I N E =======================================


sub_6534:               ; CODE XREF: sub_6476:loc_64F0p
	moveq   #0,d0
	move.w  6(a0,d6.w),d0
	move.l  8(a0,d6.w),d1
	move.w  4(a0,d6.w),d6
	cmpi.w  #$20,d6
	bhi.s   locret_6570
	jmp (a6,d6.w)
; ---------------------------------------------------------------------------

loc_654C:               ; DATA XREF: sub_6476+6Co
	bra.w   locret_6570
; ---------------------------------------------------------------------------
	bra.w   loc_6598
; ---------------------------------------------------------------------------
	bra.w   sub_65FC
; ---------------------------------------------------------------------------
	bra.w   sub_66E8
; ---------------------------------------------------------------------------
	bra.w   sub_671A
; ---------------------------------------------------------------------------
	bra.w   sub_676C
; ---------------------------------------------------------------------------
	bra.w   sub_6618
; ---------------------------------------------------------------------------
	bra.w   sub_6640
; ---------------------------------------------------------------------------
	bra.w   sub_669E
; ---------------------------------------------------------------------------

locret_6570:
	rts
; End of function sub_6534


; =============== S U B R O U T I N E =======================================


sub_6572:               ; DATA XREF: sub_6476+76o
	bra.w   locret_6596
; ---------------------------------------------------------------------------
	bra.w   loc_6598
; ---------------------------------------------------------------------------
	bra.w   sub_65FC
; ---------------------------------------------------------------------------
	bra.w   locret_6596
; ---------------------------------------------------------------------------
	bra.w   locret_6596
; ---------------------------------------------------------------------------
	bra.w   locret_6596
; ---------------------------------------------------------------------------
	bra.w   locret_6596
; ---------------------------------------------------------------------------
	bra.w   sub_6640
; ---------------------------------------------------------------------------
	bra.w   sub_669E
; ---------------------------------------------------------------------------

locret_6596:                ; CODE XREF: sub_6572j sub_6572+Cj ...
	rts
; End of function sub_6572

; ---------------------------------------------------------------------------

loc_6598:               ; CODE XREF: sub_6534+1Cj sub_6572+4j
	btst    #3,d0
	beq.s   sub_65BA
	bclr    #7,(byte_FFFFD004).w
	beq.s   locret_65FA
	bclr    #1,(GA_COMM_MAINFLAGS).l
	addi.w  #$1771,d7
	bsr.w   sub_681C
	jmp displayOn(pc)

; =============== S U B R O U T I N E =======================================


sub_65BA:               ; CODE XREF: ROM:0000659Cj
	bset    #7,(byte_FFFFD004).w
	bne.s   locret_65FA
	tst.b   (byte_FFFFD061).w
	beq.s   locret_65FA
	bclr    #1,(GA_COMM_MAINFLAGS).l
	addi.w  #$1771,d7
	jsr displayOff(pc)
	move.w  #$8F01,(a4)
	move.l  #$9483939F,(a4)
	move.w  #$9780,(a4)
	move.l  #$40600080,(a4)
	move.b  d1,(a3)

loc_65EE:               ; CODE XREF: sub_65BA+3Aj
	move.w  (a4),d4
	btst    #1,d4
	bne.s   loc_65EE
	move.w  #$8F02,(a4)

locret_65FA:                ; CODE XREF: ROM:000065A4j sub_65BA+6j ...
	rts
; End of function sub_65BA


; =============== S U B R O U T I N E =======================================


sub_65FC:               ; CODE XREF: sub_6534+20j sub_6572+8j
	andi.w #$F, d1
	add.w   d1, d1
	move.w  d1, (word_FFFFD04C).w

	lea (paletteBuffer0).w, a1

	move.w  $60(a1, d1.w), $5E(a1)

	bset #0, (vdpUpdateFlags).w
	rts
; End of function sub_65FC


; =============== S U B R O U T I N E =======================================


sub_6618:               ; CODE XREF: sub_63D4+90p sub_6534+30j
	lea (paletteBuffer3).w, a2
	lea (unk_20E002).l, a1

	moveq #7, d0
	@loc_6624:
		move.l (a1)+, (a2)+
		dbf d0, @loc_6624

	move.w (word_FFFFD04C).w,  d1
	lea    (paletteBuffer0).w, a1

	move.w  $60(a1, d1.w), $5E(a1)

	bset #0, (vdpUpdateFlags).w
	rts
; End of function sub_6618


; =============== S U B R O U T I N E =======================================


sub_6640:               ; CODE XREF: sub_6534+34j sub_6572+1Cj
	bsr.s sub_6684

	; Set VDP auto-increment to $80 (128)
	move.w #$8F80, (VDP_CONTROL).l
	move.w #$8F80, (vdpRegCache+$1E).w

	moveq  #$1A, d6
	move.l d4, (a4)

	@loc_6654:
		move.w d0, (a3)
		addq.w #1, d0
		dbf    d3, @loc_6660

		subi.w #27, d0

	@loc_6660:
		dbf    d2, @loc_666C

		andi.l #$707E0003, d4
		move.l d4, (a4)

	@loc_666C:
		dbf    d6, @loc_6654

	; Set VDP auto-increment to 2
	move.w #$8F02, (VDP_CONTROL).l
	move.w #$8F02, (vdpRegCache+$1E).w

	addi.w #180, d7
	rts
; End of function sub_6640


; =============== S U B R O U T I N E =======================================


sub_6684:               ; CODE XREF: sub_6640p sub_669E+4p
	move.w  d1, d2
	move.w  d1, d3

	lsr.w   #8, d2

	andi.w  #$FF, d2
	andi.w  #$FF, d3

	move.l  #$60000003, d4

	clr.w   d1
	add.l   d1, d4
	rts
; End of function sub_6684


; =============== S U B R O U T I N E =======================================


sub_669E:               ; CODE XREF: sub_6534+38j sub_6572+20j
	addi.w  #$1A7, d7

	bsr.s   sub_6684

	movem.l d0-d4, -(sp)
	bsr.s   @sub_66C4
	movem.l (sp)+, d0-d4

	addi.l  #$800000,   d4
	cmpi.l  #$70000003, d4
	bcs.s   @loc_66C2

	subi.l  #$10000000, d4

@loc_66C2:
	addq.w  #1, d0


; =============== S U B R O U T I N E =======================================


@sub_66C4:
	moveq  #38, d6
	move.l d4, (a4)

	@loc_66C8:
		move.w d0, (a3)
		addi.w #27, d0
		dbf    d3, @loc_66D6

		subi.w #$41D, d0

	@loc_66D6:
		dbf    d2, @loc_66E2

		andi.l #$7F800003, d4
		move.l d4, (a4)

	@loc_66E2:
		dbf    d6, @loc_66C8

	rts
; End of function sub_66C4

; End of function sub_669E


; =============== S U B R O U T I N E =======================================


sub_66E8:               ; CODE XREF: sub_6534+24j
	move.w  d0, d2
	andi.w  #$FFFE, d0

	lea     (WordRAM_Bank1).l, a1
	adda.l  d0, a1
	bsr.w   sub_6796

	lsr.w   #1, d2
	bcc.s   @locret_6718

	lea     $3D0(a1), a1
	addi.l  #$3600000, d1
	bpl.w   sub_6796

	subi.l  #$40000000, d1
	addq.w  #1, d1
	bsr.w   sub_6796

@locret_6718:
	rts
; End of function sub_66E8


; =============== S U B R O U T I N E =======================================


sub_671A:               ; CODE XREF: sub_6534+28j
	move.w  d0,d6
	move.w  d1,d3
	ori.w   #$80,d3 ; 'Γé¼'
	swap    d1
	move.w  d1,d2
	addq.w  #2,d0
	lea (WordRAM_Bank1).l,a1
	andi.w  #$FFFE,d0
	adda.l  d0,a1
	lsr.w   #1,d0
	move.l  #$97110000,d1
	move.w  d0,d1
	lsr.w   #8,d1
	ori.w   #$9600,d1
	andi.w  #$FF,d0
	ori.w   #$9500,d0
	bsr.w   sub_67B6
	lsr.w   #1,d6
	bcc.s   locret_676A
	addq.w  #2,d1
	lea $400(a1),a1
	addi.w  #$360,d2
	bpl.s   loc_6766
	subi.w  #$4000,d2
	addq.w  #1,d3

loc_6766:               ; CODE XREF: sub_671A+44j
	bsr.w   sub_67B6

locret_676A:                ; CODE XREF: sub_671A+38j
	rts
; End of function sub_671A


; =============== S U B R O U T I N E =======================================


sub_676C:               ; CODE XREF: sub_6534+2Cj
	andi.w #$FFFE, d0
	lea    (WordRAM_Bank1).l, a1
	adda.l d0, a1

	moveq #38, d3
	@loc_677A:
		bsr.s  sub_6796

		lea    $3D0(a1), a1
		addi.l #$3600000, d1
		bpl.s  @loc_6790

		subi.l #$40000000, d1
		addq.w #1, d1

	@loc_6790:
		dbf d3, @loc_677A

	rts
; End of function sub_676C


; =============== S U B R O U T I N E =======================================


sub_6796:               ; CODE XREF: sub_66E8+Ep sub_66E8+20j ...
	; Set VDP address
	move.l d1, (a4)

	; Copy 48 bytes to VDP
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)
	move.l (a1)+, (a3)

	addi.w #40, d7
	rts
; End of function sub_6796


; =============== S U B R O U T I N E =======================================


sub_67B6:               ; CODE XREF: sub_63D4:loc_6442p
					; sub_671A+32p ...
	; DMA length: $1B0 words (864 bytes)
	move.l #$940193B0, (a4)

	; DMA source address
	move.w d0, (a4)
	move.l d1, (a4)

	; DMA destination address
	move.w d2, (a4)
	move.w d3, -(sp)
	move.w (sp)+, (a4)

	;---------------

	; Reset VDP address
	move.w d2, (a4)
	andi.w #$FF7F, d3
	move.w d3, (a4)
	ori.w  #$80, d3

	move.l (a1), -4(a4)

	addi.w #250, d7
	rts
; End of function sub_67B6


; =============== S U B R O U T I N E =======================================


sub_67DC:               ; CODE XREF: sub_63AC+1Ep
	m_loadVramWriteAddress $D000, d6

loc_67E2:               ; CODE XREF: sub_5E22+Ap
	move.w #$C001, d3

loc_67E6:               ; CODE XREF: sub_6816+4j
	move.l d6, d0
	bsr.s  sub_680E

	move.l d6, d0
	addi.l #$D000000, d0
	bsr.s  sub_680E

	move.l d6, d0
	addi.l #$1000000, d0
	bsr.s  sub_6806

	move.l d6, d0
	addi.l #$14C0000, d0


; =============== S U B R O U T I N E =======================================


sub_6806:               ; CODE XREF: sub_67DC+20p
	moveq #1,  d1
	moveq #23, d2
	bra.w fillVramTilemap
; End of function sub_6806

; End of function sub_67DC


; =============== S U B R O U T I N E =======================================


sub_680E:               ; CODE XREF: sub_67DC+Cp sub_67DC+16p
	moveq #39, d1
	moveq #1,  d2
	bra.w fillVramTilemap
; End of function sub_680E


; =============== S U B R O U T I N E =======================================


sub_6816:               ; CODE XREF: sub_31FE+56p sub_5E54+Cp
	move.w #$8000, d3
	bra.s  loc_67E6
; End of function sub_6816


; =============== S U B R O U T I N E =======================================


sub_681C:               ; CODE XREF: sub_63AC+22p
					; ROM:000065B2p
	movem.l d4-d6/a5, -(sp)

	m_loadVramWriteAddress $E000, d0
	moveq  #38, d1
	moveq  #26, d2
	move.w #$6003, d3

	jsr writeTransposedTilemapToVram(pc)

	movem.l (sp)+, d4-d6/a5
	rts
; End of function sub_681C


; =============== S U B R O U T I N E =======================================


loadPrgFromWordRam:         ; CODE XREF: ROM:000005E2j
	lea (sub_68A6).l, a1
	jsr setVblankHandler

	m_enableInterrupts

	; Clear RAM from $FF0000-$FFFB00
	lea ($FFFF0000).l, a0
	move.w #$3EBF, d0
	moveq  #0, d1

	@loc_6852:
		move.l d1, (a0)+
		dbf d0, @loc_6852

	bsr.w clearCommRegisters

	jsr sub_16E6

	move.w #600, d7
	@loc_6864:
		bsr.w   waitForVblank
		bsr.w   sub_16FE
		bcc.s   @loc_687A
		dbf d7, @loc_6864

	; Timed out, go back and start all over!
	movea.l (InitialSSP).w, sp
	bra.w   _start
; ---------------------------------------------------------------------------

@loc_687A:
	move.w #$1FFF, d0
	lea ($FFFF0000).l, a1
	lea (WordRAM_Bank0).l, a0

	; Copy from WordRAM to $FF0000-$FF8000 (32 KiB)
	@loc_688A:
		move.l (a0)+, (a1)+
		dbf d0, @loc_688A

	moveq #$FFFFFFFF, d1
	bsr.w setDiscType

	lea (sub_68AE).l, a1
	jsr setVblankHandler

	moveq #STATE_LAUNCH, d0
	jmp setNextState
; End of function loadPrgFromWordRam


; =============== S U B R O U T I N E =======================================


sub_68A6:
	bsr.s sendInt2ToSubCpu
	clr.b (vblankCode).w
	rte
; End of function sub_68A6


; =============== S U B R O U T I N E =======================================


sub_68AE:
	bsr.s sendInt2ToSubCpu
	rte
; End of function sub_68AE


; =============== S U B R O U T I N E =======================================


sendInt2ToSubCpu:
	move.l  a5, -(sp)

	lea  (GA_RESET_HALT).l, a5
	bset #0, -1(a5)

	movea.l (sp)+, a5
	rts
; End of function sendInt2ToSubCpu


; =============== S U B R O U T I N E =======================================


playSegaAnimation:               ; CODE XREF: ROM:00000364j
	move.l (_LEVEL6+2).w, -(sp)
	move.w (_LEVEL6).w,   -(sp)

	move.l a1, -(sp)

	st (byte_FFFFFE28).w

	move.l #@loc_6A1E, (vblankUserRoutine+2).w
	move.w #INST_JMP,  (vblankUserRoutine).w

	move.l #sub_6AF0, (_LEVEL6+2).w
	move.w #INST_JMP, (_LEVEL6).w

	m_enableInterrupts

	jsr loadDefaultVdpRegs(pc)

	jsr clearAllVram(pc)

	clr.l (spriteTable).w
	clr.l (spriteTable+4).w

	jsr loadDefaultFont(pc)

	lea palette_6A38(pc), a1
	jsr loadPalettesNoUpdate

	m_loadVramWriteAddress $20
	jsr decompressNemesis

	movea.l (sp)+, a1

	jsr loadPalettesToBuffer(pc)

	m_loadVramWriteAddress $2000
	jsr decompressNemesis

	adda.w #$1D0, a1
	jsr decompressNemesis

	adda.w #$206, a1
	move.w #$6100, d0
	lea (decompScratch).w, a2
	jsr decompressEnigma

	move.w #$613F, d0
	jsr decompressEnigma

	subq.w #1, a1
	m_loadVramWriteAddress $CB0C, d0
	jsr writeTextToScreen(pc)

	lea (Z80_RAM_Base2).l, a0
	move.w #223, d0
	jsr copyToZ80Ram(pc)

	jsr loadZ80Prg0(pc)

	lea (decompScratch).w, a1
	m_loadVramWriteAddress $C51A, d0
	moveq  #$11, d1
	moveq  #5,   d2
	jsr writeTilemapToVram(pc)

	bsr.w sub_6A20

	clr.b (byte_FFFFFE28).w

	jsr displayOn(pc)

	move.l #$6B0C, (dword_FFFFFE34).w

	; Clear out object memory ($FFC000-$FFD400)
	lea (spriteObjectBase).w, a0
	move.w #$4FF, d7
	bsr.w  clearRamSegment

	; Initialize objects
	bsr.w sub_6B14

	move.w #59, d7
	@loc_69A8:
		jsr waitForVblank
		dbf d7, @loc_69A8

	move.w #56, d7
	moveq  #0,  d6

	@loc_69B6:
		jsr waitForVblank

		addi.b #$1A, d6
		bpl.s  @loc_69C4

		bsr.s  sub_6A20
		bra.s  @loc_69C6
	; ---------------------------------------------------------------------------

	@loc_69C4:
		bsr.s sub_6A26

	@loc_69C6:
		dbf d7, @loc_69B6

	move.w #Z80CMD_81, d7
	jsr sendCommandToZ80

	move.w #3, d7
	@loc_69D6:
		move.w d7, -(sp)

		jsr waitForVblank

		lea (word_FFFFD000).w, a0
		lea (spriteTable).w,   a1
		moveq  #$F,  d0
		move.w #64, d1
		jsr updateObjects(pc)

		move.w (sp)+, d7
		dbf d7, @loc_69D6

	move.w #240, d7
	@loc_69F8:
		move.w d7, -(sp)

		jsr waitForVblank

		lea (spriteObjectBase).w, a0
		lea (spriteTable).w,  a1
		moveq  #$4F, d0
		move.w #64, d1
		jsr updateObjects(pc)

		move.w (sp)+, d7
		dbf d7, @loc_69F8

	move.w (sp)+, (_LEVEL6).w
	move.l (sp)+, (_LEVEL6+2).w

@loc_6A1E:
	rts
; End of function playSegaAnimation


; =============== S U B R O U T I N E =======================================


sub_6A20:               ; CODE XREF: playSegaAnimation+BCp playSegaAnimation+FCp
	lea   (unk_FFFFE0D8).w, a1
	bra.s loc_6A2A
; End of function sub_6A20


; =============== S U B R O U T I N E =======================================


sub_6A26:               ; CODE XREF: playSegaAnimation:loc_69C4p
	lea (unk_FFFFE0F6).w, a1

loc_6A2A:
	m_loadVramWriteAddress $C590, d0
	moveq  #2, d1
	moveq  #4, d2
	jmp writeTilemapToVram(pc)
; End of function sub_6A26

; ---------------------------------------------------------------------------
palette_6A38:
	dc.b 0
	dc.b 47

palette_6A3A:
	dc.w $000
	dc.w $EE8
	dc.w $000
	dc.w $EE4
	dc.w $EE0
	dc.w $EC0
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000

palette_6A5A:
	dc.w $000
	dc.w $EC0
	dc.w $000
	dc.w $EE0
	dc.w $EC0
	dc.w $EA0
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000

palette_6A7A:
	dc.w $000
	dc.w $E80
	dc.w $000
	dc.w $EC0
	dc.w $EA0
	dc.w $E80
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000
	dc.w $000

byte_6A9A:
	incbin "misc\nemesis_6A9A.bin"

unk_6ABE:
	dc.b   4
	dc.b   8

	dc.l byte_6AD0
	dc.l byte_6AD8
	dc.l byte_6AE0
	dc.l byte_6AE8

byte_6AD0:
	dc.b   0
	dc.b   0
	dc.b $F8    ; Vertical offset (-8)
	dc.b   0    ; Sprite size (8x8 dots)
	dc.w   1    ; Sprite pattern 1
	dc.b   0    ; Horizontal offset, not flipped
	dc.b $FC    ; Horizontal offset, flipped (-4)

byte_6AD8:
	dc.b   0
	dc.b   0
	dc.b $F8    ; Vertical offset (-8)
	dc.b   0    ; Sprite size (8x8 dots)
	dc.w   2    ; Sprite pattern 2
	dc.b   0    ; Horizontal offset, not flipped
	dc.b $FC    ; Horizontal offset, flipped (-4)

byte_6AE0:
	dc.b   0
	dc.b   0
	dc.b $F8    ; Vertical offset (-8)
	dc.b   0    ; Sprite size (8x8 dots)
	dc.w   3    ; Sprite pattern 3
	dc.b   0    ; Horizontal offset, not flipped
	dc.b $FC    ; Horizontal offset, flipped (-4)

byte_6AE8:
	dc.b   0
	dc.b   0
	dc.b $F8    ; Vertical offset (-8)
	dc.b   0    ; Sprite size (8x8 dots)
	dc.w   4    ; Sprite pattern 4
	dc.b   0    ; Horizontal offset, not flipped
	dc.b $FC    ; Horizontal offset, flipped (-4)

; =============== S U B R O U T I N E =======================================


sub_6AF0:
	movem.l d0-a6, -(sp)

	jsr sendInt2ToSubCpu(pc)

	tst.b (byte_FFFFFE28).w
	bne.s @loc_6B06

	bsr.w dmaTransferPalettes
	jsr   dmaSendSpriteTable

@loc_6B06:
	clr.b (vblankCode).w

	movem.l (sp)+, d0-a6
	rte
; End of function sub_6AF0

; ---------------------------------------------------------------------------
	dc.l sub_6D68

; =============== S U B R O U T I N E =======================================


sub_6B14:               ; CODE XREF: playSegaAnimation+DCp
	; Fill $FFC000-$FFD400 with object data
	lea (spriteObjectBase).w, a0

	moveq #64, d6
	moveq #79, d7

	lea objectInitData(pc), a1

	@loc_6B20:
		move.w #4,   (a0)
		move.w #$D3, OBJ6B14.word8(a0)
		move.w #$EB, OBJ6B14.wordC(a0)

		move.b d7,   OBJ6B14.byte23(a0)

		cmpi.b #15, d7
		bls.s  @loc_6B40

		move.w #$E4, OBJ6B14.wordC(a0)

	@loc_6B40:
		moveq  #0,    d0
		move.w (a1)+, d0

		add.l  d0, d0
		add.l  d0, d0
		neg.l  d0
		move.l d0, OBJ6B14.dword14(a0)

		move.w (a1)+, OBJ6B14.word28(a0)

		moveq  #0,    d0
		move.w (a1)+, d0
		add.l  d0,    d0
		subi.l #$E00, d0
		move.l d0,    OBJ6B14.dword10(a0)

		move.w d7,   d0
		andi.w #$3C, d0
		asr.w  #2,   d0
		move.b d0,   OBJ6B14.byte21(a0)

		move.w d7, d0
		andi.w #3, d0
		move.b d0, OBJ6B14.byte20(a0)

		clr.b      OBJ6B14.byte18(a0)
		move.b d7, OBJ6B14.byte26(a0)

		adda.w d6, a0

		dbf d7, @loc_6B20

	rts
; End of function sub_6B14

; ---------------------------------------------------------------------------

objectInitData:
	incbin "misc\unk_6B88.bin"

; =============== S U B R O U T I N E =======================================


; Inputs:
;   a0: Object address

sub_6D68:
	tst.w  OBJ6B14.word28(a0)
	beq.s  @loc_6D84

	addi.l #$800, OBJ6B14.dword14(a0)
	subq.w #1, OBJ6B14.word28(a0)
	bne.s  @loc_6D84

	clr.l  OBJ6B14.dword10(a0)
	clr.l  OBJ6B14.dword14(a0)

@loc_6D84:
	move.b OBJ6B14.byte23(a0), d0

	addq.b #8, OBJ6B14.byte26(a0)
	move.b OBJ6B14.byte26(a0), d0
	andi.b #$60, d0
	cmpi.b #$60, d0
	bne.s  @loc_6D9C

	moveq  #0, d0

@loc_6D9C:
	move.b d0, OBJ6B14.byte18(a0)

	lea unk_6ABE(pc), a1

	subq.b #1, OBJ6B14.byte21(a0)
	bpl.s  @loc_6DB4

	move.b 1(a1), OBJ6B14.byte21(a0)
	addq.b #1, OBJ6B14.byte20(a0)

@loc_6DB4:
	moveq  #0, d0
	move.b OBJ6B14.byte20(a0), d0

	cmp.b  (a1), d0
	bcs.s  @loc_6DC4

	moveq  #0, d0
	move.b d0, OBJ6B14.byte20(a0)

@loc_6DC4:
	asl.w  #2, d0
	move.l 2(a1, d0.w), OBJ6B14.addr4(a0)
	rts
; End of function sub_6D68

; =============== S U B R O U T I N E =======================================


testCartBootBlock:
	lea (cartBoot).l, a0

	cmpi.l #'SEGA', -$100(a0)
	bne.s  @locret_6DEC ; Bail if it doesn't start with SEGA

	lea regionBootBlock(pc), a1
	move.w #706, d0

	@loc_6DE6:
		cmpm.w (a0)+, (a1)+
		dbne   d0, @loc_6DE6

@locret_6DEC:
	rts
; End of function testCartBootBlock

; ---------------------------------------------------------------------------
regionBootBlock:        ; DATA XREF: testCartBootBlock+10o
	incbin "us_boot_block.bin"

; =============== S U B R O U T I N E =======================================


state_7374:               ; CODE XREF: ROM:000005E6j
	bsr.w sub_873A

	bsr.s sub_738A

	moveq #1, d0
	moveq #8, d1
	bsr.w sub_1800

	moveq #STATE_3040, d0
	bsr.w setNextState
	rts
; End of function state_7374


; =============== S U B R O U T I N E =======================================


sub_738A:               ; CODE XREF: state_7374+4p sub_738A+Ej
	moveq #$3C, d0
	and.w (word_FFFFFF00).w, d0

	jsr loc_739C(pc,d0.w)

	tst.w (word_FFFFFF00).w
	bpl.s sub_738A

	rts
; End of function sub_738A

; ---------------------------------------------------------------------------

loc_739C:
	bra.w   loc_73F6
; ---------------------------------------------------------------------------
	bra.w   loc_743A
; ---------------------------------------------------------------------------
	bra.w   sub_7484
; ---------------------------------------------------------------------------
	bra.w   sub_74E6
; ---------------------------------------------------------------------------
	bra.w   sub_87EC
; ---------------------------------------------------------------------------

loc_73B0:
	bsr.w waitForVblank
	nop
	nop
	nop
	nop
	bra.s loc_73B0

; =============== S U B R O U T I N E =======================================


waitForWordRam:             ; CODE XREF: sub_73CA+2Aj ...
	btst  #GA_RET, (GA_MEM_MODE).l
	beq.s waitForWordRam

	rts
; End of function waitForWordRam


; =============== S U B R O U T I N E =======================================


sub_73CA:               ; CODE XREF: ROM:000073FAp sub_7446+4p ...
	lea (mainCommData).w, a0
	lea $10(a0), a1

	@loc_73D2:
		tst.l 8(a1)
		beq.s @loc_73DE

		bsr.w waitForVblank

		bra.s @loc_73D2
; ---------------------------------------------------------------------------

@loc_73DE:
	move.w d0, 8(a0)

	@loc_73E2:
		bset  #GA_DMNA, (GA_MEM_MODE).l
		beq.s @loc_73E2

	bsr.w waitForVblank

	clr.l 8(a0)
	bra.s waitForWordRam
; End of function sub_73CA

; ---------------------------------------------------------------------------

loc_73F6:               ; CODE XREF: ROM:loc_739Cj
	move.w #1, d0
	bsr.s  sub_73CA

	lea (unk_210000).l, a2
	lea $4010(a2), a0
	lea $4000(a2), a1
	move.w #0, d0

	jsr byte_FFFFFDAE
	bcs.s   @loc_7416

	moveq #3, d1

@loc_7416:
	add.w   d1, d1
	move.w  word_7432(pc,d1.w), 0(a2)

	moveq   #Z80CMD_FF93, d7
	bsr.w   sendCommandToZ80

	move.w  #4, (word_FFFFFF00).w
	move.b  #0, $C(a1)
	rts
; ---------------------------------------------------------------------------
word_7432:
	dc.w 0
	dc.w $8000
	dc.w $8001
	dc.w $8081
; ---------------------------------------------------------------------------

loc_743A:               ; CODE XREF: ROM:000073A0j
	bsr.s  sub_7446
	bsr.s  sub_7450
	move.w #8, (word_FFFFFF00).w
	rts

; =============== S U B R O U T I N E =======================================


sub_7446:               ; CODE XREF: ROM:loc_743Ap
	move.w #2, d0
	bsr.w  sub_73CA
	rts
; End of function sub_7446


; =============== S U B R O U T I N E =======================================


sub_7450:               ; CODE XREF: ROM:0000743Cp
	lea (unk_210000).l, a2

	cmpi.w  #$8081, 0(a2)
	bne.s   @loc_7476

	lea $4000(a2), a1

	move.w  #1, d0
	jsr byte_FFFFFDAE

	cmpi.w #$FFFF, d0
	bne.s  @loc_747A

	cmpi.w #$FFFF, d1
	bne.s  @loc_747A

@loc_7476:
	moveq  #0, d0
	moveq  #0, d1

@loc_747A:
	move.w d0, 2(a2)
	move.w d1, 4(a2)
	rts
; End of function sub_7450


; =============== S U B R O U T I N E =======================================


sub_7484:               ; CODE XREF: ROM:000073A4j
	lea (WordRAM_Bank0).l, a0
	lea (unk_210000).l,    a1
	lea (byte_FFFFFF06).w, a2

	move.b #0, (a2)
	bset   #0, (a2)

	tst.w  0(a1)
	bpl.s  @loc_74A6

	bset   #1, (a2)

@loc_74A6:
	tst.w  4(a0)
	beq.s  @loc_74B0

	bset   #2, (a2)

@loc_74B0:
	tst.w  4(a1)
	beq.s  @loc_74BA

	bset   #3, (a2)

@loc_74BA:
	tst.w  4(a0)
	beq.s  @loc_74CA

	tst.w  2(a1)
	beq.s  @loc_74CA

	bset   #4, (a2)

@loc_74CA:
	tst.w  4(a1)
	beq.s  @loc_74DA

	tst.w  2(a0)
	beq.s  @loc_74DA

	bset   #5, (a2)

@loc_74DA:
	bset   #6, (a2)
	move.w #$C, (word_FFFFFF00).w
	rts
; End of function sub_7484


; =============== S U B R O U T I N E =======================================


sub_74E6:               ; CODE XREF: ROM:000073A8j
	moveq #$7C, d0
	and.w (word_FFFFFF02).w, d0
	jsr loc_74F6(pc, d0.w)

	bsr.w waitForVblank
	rts
; End of function sub_74E6

; ---------------------------------------------------------------------------

loc_74F6:
	bra.w   sub_752C
; ---------------------------------------------------------------------------
	bra.w   sub_769C
; ---------------------------------------------------------------------------
	bra.w   sub_7A5E
; ---------------------------------------------------------------------------
	bra.w   sub_7C6E
; ---------------------------------------------------------------------------
	bra.w   loc_7D7C
; ---------------------------------------------------------------------------
	bra.w   sub_8124
; ---------------------------------------------------------------------------
	bra.w   loc_823C
; ---------------------------------------------------------------------------
	bra.w   sub_85C8
; ---------------------------------------------------------------------------
	bra.w   *+4

; =============== S U B R O U T I N E =======================================


sub_751A:               ; CODE XREF: ROM:00007516j sub_751A+8j
	bset   #GA_DMNA, (GA_MEM_MODE).l
	beq.s  sub_751A

	move.w #$10, (word_FFFFFF00).w
	rts
; End of function sub_751A


; =============== S U B R O U T I N E =======================================


sub_752C:               ; CODE XREF: ROM:loc_74F6j
	bset  #7, (word_FFFFFF02).w
	bne.s @loc_7540

	bsr.w sub_754E
	bsr.w sub_7594
	bsr.w sub_760C

@loc_7540:
	bsr.w  sub_7A1E
	beq.s  @locret_754C

	move.w #4, (word_FFFFFF02).w

@locret_754C:
	rts
; End of function sub_752C


; =============== S U B R O U T I N E =======================================


sub_754E:               ; CODE XREF: sub_752C+8p
	bsr.w   sub_7876

	movem.w word_757C(pc), d0-d2
	bsr.w   sub_77FA

	movem.w word_7582(pc), d0-d2
	bsr.w   sub_77FA

	movem.w word_7588(pc), d0-d2
	bsr.w   sub_77FA

	movem.w word_758E(pc), d0-d2
	bsr.w   sub_77FA

	rts
; End of function sub_754E

; ---------------------------------------------------------------------------
word_757C:  dc.w $8100      ; DATA XREF: sub_754E+4w
		dc.w $286
		dc.w 0
word_7582:  dc.w $8100      ; DATA XREF: sub_754E+Ew
		dc.w $786
		dc.w 4
word_7588:  dc.w $8100      ; DATA XREF: sub_754E+18w
		dc.w $C9C
		dc.w $11
word_758E:  dc.w $8100      ; DATA XREF: sub_754E+22w
		dc.w $90
		dc.w $1F

; =============== S U B R O U T I N E =======================================


sub_7594:               ; CODE XREF: sub_752C+Cp
	lea (WordRAM_Bank0).l,a4
	btst    #0,1(a4)
	beq.s   loc_75E8
	movem.w word_75F4(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_75FA(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7600(pc),d0-d2
	bsr.w   sub_77FA
	lea $4000(a4),a0
	move.w  #$41C,d0
	moveq   #0,d1
	bsr.w   sub_783E
	move.w  #$590,d1
	move.w  4(a4),d0
	bsr.w   sub_78D8
	move.w  #$5B2,d1
	move.w  2(a4),d0
	bsr.w   sub_78D8
	rts
; ---------------------------------------------------------------------------

loc_75E8:               ; CODE XREF: sub_7594+Cj
	movem.w word_7606(pc),d0-d2
	bsr.w   sub_77FA
	rts
; End of function sub_7594

; ---------------------------------------------------------------------------
word_75F4:  dc.w $8100      ; DATA XREF: sub_7594+Ew
		dc.w $386
		dc.w 1
word_75FA:  dc.w $8100      ; DATA XREF: sub_7594+18w
		dc.w $48C
		dc.w 2
word_7600:  dc.w $8100      ; DATA XREF: sub_7594+22w
		dc.w $4AE
		dc.w 3
word_7606:  dc.w $8100      ; DATA XREF: sub_7594:loc_75E8w
		dc.w $496
		dc.w $1D

; =============== S U B R O U T I N E =======================================


sub_760C:               ; CODE XREF: sub_752C+10p
	lea (unk_210000).l,a4
	tst.w   0(a4)
	bmi.s   loc_7624
	movem.w word_7696(pc),d0-d2
	bsr.w   sub_77FA
	rts
; ---------------------------------------------------------------------------

loc_7624:               ; CODE XREF: sub_760C+Aj
	btst    #0,1(a4)
	beq.s   loc_7672
	movem.w word_767E(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7684(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_768A(pc),d0-d2
	bsr.w   sub_77FA
	lea $4000(a4),a0
	move.w  #$91C,d0
	moveq   #0,d1
	bsr.w   sub_783E
	move.w  4(a4),d0
	move.w  #$A90,d1
	bsr.w   sub_78D8
	move.w  2(a4),d0
	move.w  #$AB2,d1
	bsr.w   sub_78D8
	rts
; ---------------------------------------------------------------------------

loc_7672:               ; CODE XREF: sub_760C+1Ej
	movem.w word_7690(pc),d0-d2
	bsr.w   sub_77FA
	rts
; End of function sub_760C

; ---------------------------------------------------------------------------
word_767E:  dc.w $8100      ; DATA XREF: sub_760C+20w
		dc.w $886
		dc.w 1
word_7684:  dc.w $8100      ; DATA XREF: sub_760C+2Aw
		dc.w $98C
		dc.w 2
word_768A:  dc.w $8100      ; DATA XREF: sub_760C+34w
		dc.w $9AE
		dc.w 3
word_7690:  dc.w $8100      ; DATA XREF: sub_760C:loc_7672w
		dc.w $896
		dc.w $1D
word_7696:  dc.w $8100      ; DATA XREF: sub_760C+Cw
		dc.w $896
		dc.w $1E

; =============== S U B R O U T I N E =======================================


sub_769C:               ; CODE XREF: ROM:000074FAj
	bset    #7,(word_FFFFFF02).w
	bne.s   loc_76A8
	bsr.w   sub_76D8

loc_76A8:               ; CODE XREF: sub_769C+6j
	bsr.w   sub_77A0
	bsr.w   sub_7A1E
	beq.s   locret_76D6
	move.w  (word_FFFFFF0A).w,d0
	btst    d0,(byte_FFFFFF06).w
	bne.s   loc_76C4
	moveq   #Z80CMD_FF92,d7
	bsr.w   sendCommandToZ80
	bra.s   locret_76D6
; ---------------------------------------------------------------------------

loc_76C4:               ; CODE XREF: sub_769C+1Ej
	move.w  (word_FFFFFF0A).w,d0
	lsl.w   #2,d0
	addq.w  #8,d0
	move.w  d0,(word_FFFFFF02).w
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80

locret_76D6:                ; CODE XREF: sub_769C+14j sub_769C+26j
	rts
; End of function sub_769C


; =============== S U B R O U T I N E =======================================


sub_76D8:               ; CODE XREF: sub_769C+8p
	bsr.w   sub_7876
	lea (byte_FFFFFF06).w,a4
	movem.w word_7770(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7776(pc),d0-d2
	btst    #1,(a4)
	bne.s   loc_76FA
	addi.w  #$2000,d0

loc_76FA:               ; CODE XREF: sub_76D8+1Cj
	bsr.w   sub_77FA
	movem.w word_777C(pc),d0-d2
	btst    #2,(a4)
	bne.s   loc_770E
	addi.w  #$2000,d0

loc_770E:               ; CODE XREF: sub_76D8+30j
	bsr.w   sub_77FA
	movem.w word_7782(pc),d0-d2
	btst    #3,(a4)
	bne.s   loc_7722
	addi.w  #$2000,d0

loc_7722:               ; CODE XREF: sub_76D8+44j
	bsr.w   sub_77FA
	movem.w word_7788(pc),d0-d2
	btst    #4,(a4)
	bne.s   loc_7736
	addi.w  #$2000,d0

loc_7736:               ; CODE XREF: sub_76D8+58j
	bsr.w   sub_77FA
	movem.w word_778E(pc),d0-d2
	btst    #5,(a4)
	bne.s   loc_774A
	addi.w  #$2000,d0

loc_774A:               ; CODE XREF: sub_76D8+6Cj
	bsr.w   sub_77FA
	movem.w word_779A(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7794(pc),d0-d2
	bsr.w   sub_77FA
	move.l  #$60000,(word_FFFFFF0A).w
	clr.w   (word_FFFFFF08).w
	rts
; End of function sub_76D8

; ---------------------------------------------------------------------------
word_7770:  dc.w $8100      ; DATA XREF: sub_76D8+8w
		dc.w $396
		dc.w 5
word_7776:  dc.w $8100      ; DATA XREF: sub_76D8+12w
		dc.w $496
		dc.w 6
word_777C:  dc.w $8100      ; DATA XREF: sub_76D8+26w
		dc.w $596
		dc.w 7
word_7782:  dc.w $8100      ; DATA XREF: sub_76D8+3Aw
		dc.w $696
		dc.w 8
word_7788:  dc.w $8100      ; DATA XREF: sub_76D8+4Ew
		dc.w $796
		dc.w 9
word_778E:  dc.w $8100      ; DATA XREF: sub_76D8+62w
		dc.w $896
		dc.w $A
word_7794:  dc.w $8100      ; DATA XREF: sub_76D8+80w
		dc.w $996
		dc.w $B
word_779A:  dc.w $8100      ; DATA XREF: sub_76D8+76w
		dc.w $A4
		dc.w $24

; =============== S U B R O U T I N E =======================================


sub_77A0:               ; CODE XREF: sub_769C:loc_76A8p
	bsr.w   sub_790A
	move.w  (word_FFFFFF0A).w,d1
	bpl.s   loc_77AE
	moveq   #0,d1
	bra.s   loc_77B6
; ---------------------------------------------------------------------------

loc_77AE:               ; CODE XREF: sub_77A0+8j
	cmpi.w  #6,d1
	ble.s   loc_77B6
	moveq   #6,d1

loc_77B6:               ; CODE XREF: sub_77A0+Cj sub_77A0+12j
	move.w  d1,(word_FFFFFF0A).w
	mulu.w  #$10,d1
	addi.w  #$B8,d1 ; '┬╕'
	swap    d1
	move.w  #$D01,d1
	move.l  #$1000D8,d2
	moveq   #3,d0
	moveq   #$20,d3 ; ' '

loc_77D2:               ; CODE XREF: sub_7BBA+24p sub_7F66+A2j ...
	lea (dword_220E00).l,a0

loc_77D8:               ; CODE XREF: sub_77A0+42j
	movem.l d1-d2,(a0)
	addq.w  #8,a0
	addq.w  #1,d1
	add.w   d3,d2
	dbf d0,loc_77D8
	clr.l   (a0)
	rts
; End of function sub_77A0


; =============== S U B R O U T I N E =======================================


sub_77EA:               ; CODE XREF: sub_78D8+2Cp
	lea (WordRAM_Bank1).l, a1
	lea (word_15DC6).l,    a3

	adda.w d1, a1

	bra.s loc_7814
; End of function sub_77EA


; =============== S U B R O U T I N E =======================================

; Inputs:
;   d0:
;   d1: Byte offset into WordRAM bank 1 ($220000)
;   d2: Index into lookup table at $15920

sub_77FA:               ; CODE XREF: sub_754E+Ap sub_754E+14p ...
	lea (WordRAM_Bank1).l, a1
	lea (word_15920).l,    a2
	lea (word_15DC6).l,    a3

	adda.w d1, a1

	add.w   d2, d2
	adda.w (a2, d2.w), a2

	loc_7814:
		move.w (a2)+, d2
		bmi.s  @locret_7822

		lsl.w  #2, d2
		lea   (a3, d2.w), a0

		bsr.s sub_7824
		bra.s loc_7814
; ---------------------------------------------------------------------------

@locret_7822:                ; CODE XREF: sub_77FA+1Cj
	rts
; End of function sub_77FA


; =============== S U B R O U T I N E =======================================


sub_7824:               ; CODE XREF: sub_77FA+24p
	movem.w (a0), d1-d2

	subq.w #1, d1
	add.w  d0, d2

	@loc_782C:
		move.w d2, (a1)

		addq.w #1, d2
		move.w d2, $80(a1)

		addq.w #1, d2
		addq.w #2, a1
		dbf d1, @loc_782C

	rts
; End of function sub_7824


; =============== S U B R O U T I N E =======================================


sub_783E:               ; CODE XREF: sub_7594+36p sub_760C+48p ...
	lea (WordRAM_Bank1).l, a1
	adda.w  d0, a1

	loc_7846:               ; CODE XREF: sub_783E+12j sub_844C+58p
		moveq  #0, d0
		move.b (a0)+, d0
		beq.s  @locret_7852

		add.w  d1, d0
		move.w d0, (a1)+
		bra.s  loc_7846
; ---------------------------------------------------------------------------

@locret_7852:                ; CODE XREF: sub_783E+Cj
	rts
; End of function sub_783E


; =============== S U B R O U T I N E =======================================


sub_7854:               ; CODE XREF: sub_873A+84p
	m_loadVramWriteAddress $200

	lea (VDP_DATA).l, a0
	moveq #$FFFFFFFF, d0

	moveq #7, d1
	@loc_7868:
		moveq #7, d3
		@loc_786A:
			move.l d0, (a0)
			dbf d3, @loc_786A

		dbf d1, @loc_7868

	rts
; End of function sub_7854


; =============== S U B R O U T I N E =======================================


sub_7876:               ; CODE XREF: sub_754Ep sub_76D8p ...
	lea (dword_220E00).l, a0
	move.w #$DF, d4

loc_7880:               ; CODE XREF: sub_7B4A+18p sub_800C+18p ...
	moveq #0, d0
	moveq #0, d1
	moveq #0, d2
	moveq #0, d3

	@loc_7888:
		movem.l d0-d3, -(a0)
		dbf d4, @loc_7888

	rts
; End of function sub_7876


; =============== S U B R O U T I N E =======================================


sub_7892:               ; CODE XREF: sub_78D8+8p sub_7EA8+52p ...
	pea (a0)

	andi.l  #$FFFF, d0

	divu.w  #10000, d0
	bsr.s   sub_78CC

	divu.w  #1000, d0
	bsr.s   sub_78CC

	divu.w  #100, d0
	bsr.s   sub_78CC

	divu.w  #10, d0
	bsr.s   sub_78CC

	move.w  d0, (a0)

	movea.l (sp)+, a0

	moveq #4, d0
	@loc_78B8:
		tst.w (a0)+
		dbne d0, @loc_78B8

	bne.s   loc_78C2
	addq.w  #1, d0

loc_78C2:               ; CODE XREF: sub_7892+2Cj
	subq.w  #2, a0

@loc_78C4:
	add.w   d1, (a0)+
	dbf d0, @loc_78C4
	rts
; End of function sub_7892


; =============== S U B R O U T I N E =======================================


sub_78CC:               ; CODE XREF: sub_7892+Cp sub_7892+12p ...
	move.w d0, (a0)+
	swap   d0
	andi.l #$FFFF, d0
	rts
; End of function sub_78CC


; =============== S U B R O U T I N E =======================================


sub_78D8:               ; CODE XREF: sub_7594+42p sub_7594+4Ep ...
	move.l  d1,-(sp)
	lea (unk_FFFFFF0E).w,a0
	moveq   #$12,d1
	bsr.s   sub_7892
	move.w  #$FFFF,(a0)
	lea (unk_FFFFFF0E).w,a0
	moveq   #3,d0

loc_78EC:               ; CODE XREF: sub_78D8+1Ej
	tst.w   (a0)
	bne.s   loc_78F4
	move.w  #2,(a0)

loc_78F4:               ; CODE XREF: sub_78D8+16j
	addq.w  #2,a0
	dbf d0,loc_78EC
	move.l  (sp)+,d1
	lea (unk_FFFFFF0E).w,a2
	move.w  #$C100,d0
	bsr.w   sub_77EA
	rts
; End of function sub_78D8


; =============== S U B R O U T I N E =======================================


sub_790A:               ; CODE XREF: sub_77A0p sub_7F66p
	pea (a0)

	cmpi.b #JOYTYPE_MULTITAP, (joy1Type).w
	beq.s  loc_791E

	cmpi.b #JOYTYPE_MEGAMOUSE, (joy1Type).w
	beq.s  loc_7940

	bra.s  loc_794E
; ---------------------------------------------------------------------------

loc_791E:               ; CODE XREF: sub_790A+8j
	moveq   #3,d0
	and.b   (word_FFFFFF08).w,d0
	add.w   d0,d0
	move.w  word_7988(pc,d0.w),d0
	add.w   d0,(word_FFFFFF0A).w
	lea (multitapControllerTypes).w,a0
	moveq   #3,d0

loc_7934:               ; CODE XREF: sub_790A+2Ej
	cmpi.b  #MULTI_MOUSE,(a0)+
	dbeq    d0,loc_7934
	beq.s   loc_7966
	bra.s   loc_794E
; ---------------------------------------------------------------------------

loc_7940:               ; CODE XREF: sub_790A+10j
	move.w  (mouse1DeltaY).w,d0
	bsr.w   sub_7A16
	add.l   d0,(word_FFFFFF0A).w
	bra.s   loc_795E
; ---------------------------------------------------------------------------

loc_794E:               ; CODE XREF: sub_790A+12j sub_790A+34j
	moveq   #3,d0
	and.b   (word_FFFFFF08).w,d0
	add.w   d0,d0
	move.w  word_7988(pc,d0.w),d0
	add.w   d0,(word_FFFFFF0A).w

loc_795E:               ; CODE XREF: sub_790A+42j
	cmpi.b  #JOYTYPE_MEGAMOUSE,(joy2Type).w
	bne.s   loc_7974

loc_7966:               ; CODE XREF: sub_790A+32j
	move.w  (mouse2DeltaY).w,d0
	bsr.w   sub_7A16
	add.l   d0,(word_FFFFFF0A).w
	bra.s   loc_7984
; ---------------------------------------------------------------------------

loc_7974:               ; CODE XREF: sub_790A+5Aj
	moveq   #3,d0
	and.b   (word_FFFFFF08+1).w,d0
	add.w   d0,d0
	move.w  word_7988(pc,d0.w),d0
	add.w   d0,(word_FFFFFF0A).w

loc_7984:               ; CODE XREF: sub_790A+68j
	movea.l (sp)+,a0
	rts
; End of function sub_790A

; ---------------------------------------------------------------------------
word_7988:  dc.w 0
		dc.w $FFFF
		dc.w 1
		dc.w 0

; =============== S U B R O U T I N E =======================================


sub_7990:               ; CODE XREF: sub_7C0A+4p
	pea (a0)

	cmpi.b #JOYTYPE_MULTITAP,(joy1Type).w
	beq.s  loc_79A4

	cmpi.b #JOYTYPE_MEGAMOUSE,(joy1Type).w
	beq.s  loc_79C6

	bra.s  loc_79D4
; ---------------------------------------------------------------------------

loc_79A4:               ; CODE XREF: sub_7990+8j
	moveq   #$C,d0
	and.b   (word_FFFFFF08).w,d0
	lsr.w   #1,d0
	move.w  unk_7A0E(pc,d0.w),d0
	add.w   d0,(word_FFFFFF0A).w
	lea (multitapControllerTypes).w,a0
	moveq   #3,d0

loc_79BA:               ; CODE XREF: sub_7990+2Ej
	cmpi.b  #MULTI_MOUSE,(a0)+
	dbeq    d0,loc_79BA
	beq.s   loc_79EC
	bra.s   loc_79D4
; ---------------------------------------------------------------------------

loc_79C6:               ; CODE XREF: sub_7990+10j
	move.w  (mouse1DeltaX).w,d0
	bsr.w   sub_7A16
	add.l   d0,(word_FFFFFF0A).w
	bra.s   loc_79E4
; ---------------------------------------------------------------------------

loc_79D4:               ; CODE XREF: sub_7990+12j sub_7990+34j
	moveq   #$C,d0
	and.b   (word_FFFFFF08).w,d0
	lsr.w   #1,d0
	move.w  unk_7A0E(pc,d0.w),d0
	add.w   d0,(word_FFFFFF0A).w

loc_79E4:               ; CODE XREF: sub_7990+42j
	cmpi.b  #JOYTYPE_MEGAMOUSE,(joy2Type).w
	bne.s   loc_79FA

loc_79EC:               ; CODE XREF: sub_7990+32j
	move.w  (mouse2DeltaX).w,d0
	bsr.w   sub_7A16
	add.l   d0,(word_FFFFFF0A).w
	bra.s   loc_7A0A
; ---------------------------------------------------------------------------

loc_79FA:               ; CODE XREF: sub_7990+5Aj
	moveq   #$C,d0
	and.b   (word_FFFFFF08+1).w,d0
	lsr.w   #1,d0
	move.w  unk_7A0E(pc,d0.w),d0
	add.w   d0,(word_FFFFFF0A).w

loc_7A0A:               ; CODE XREF: sub_7990+68j
	movea.l (sp)+,a0
	rts
; End of function sub_7990

; ---------------------------------------------------------------------------
unk_7A0E:   dc.b   0
		dc.b   0
		dc.b $FF
		dc.b $FF
		dc.b   0
		dc.b   1
		dc.b   0
		dc.b   0

; =============== S U B R O U T I N E =======================================


sub_7A16:               ; CODE XREF: sub_790A+3Ap sub_790A+60p ...
	ext.l   d0
	asl.l   #8,d0
	asl.l   #2,d0
	rts
; End of function sub_7A16


; =============== S U B R O U T I N E =======================================


sub_7A1E:               ; CODE XREF: sub_752C:loc_7540p
					; sub_769C+10p ...
	movem.l d0,-(sp)
	cmpi.b  #JOYTYPE_MEGAMOUSE,(joy1Type).w
	bne.s   loc_7A32
	tst.b   (byte_FFFFFE0B).w
	bne.s   loc_7A58
	bra.s   loc_7A3A
; ---------------------------------------------------------------------------

loc_7A32:               ; CODE XREF: sub_7A1E+Aj
	moveq   #$FFFFFFF0,d0
	and.b   (joy1Triggered).w,d0
	bne.s   loc_7A58

loc_7A3A:               ; CODE XREF: sub_7A1E+12j
	cmpi.b  #JOYTYPE_MEGAMOUSE,(joy2Type).w
	bne.s   loc_7A52
	tst.b   (byte_FFFFFE17).w
	beq.s   loc_7A58
	nop
	nop
	nop
	nop
	bra.s   loc_7A58
; ---------------------------------------------------------------------------

loc_7A52:               ; CODE XREF: sub_7A1E+22j
	moveq   #$FFFFFFF0,d0
	and.b   (joy2Triggered).w,d0

loc_7A58:               ; CODE XREF: sub_7A1E+10j sub_7A1E+1Aj ...
	movem.l (sp)+,d0
	rts
; End of function sub_7A1E


; =============== S U B R O U T I N E =======================================


sub_7A5E:               ; CODE XREF: ROM:000074FEj
	bset    #7,(word_FFFFFF02).w
	bne.s   loc_7A6A
	clr.w   (word_FFFFFF04).w

loc_7A6A:               ; CODE XREF: sub_7A5E+6j
	lea (WordRAM_Bank0).l,a4
	moveq   #$7C,d0 ; '|'
	and.w   (word_FFFFFF04).w,d0
	jsr loc_7A7C(pc,d0.w)
	rts
; End of function sub_7A5E

; ---------------------------------------------------------------------------

loc_7A7C:
	bra.w   sub_7AA0
; ---------------------------------------------------------------------------
	bra.w   sub_7BBA
; ---------------------------------------------------------------------------
	bra.w   sub_7A90
; ---------------------------------------------------------------------------
	bra.w   sub_7B4A
; ---------------------------------------------------------------------------
	bra.w   sub_7C34

; =============== S U B R O U T I N E =======================================


sub_7A90:               ; CODE XREF: ROM:00007A84j
	move.w  #3,d0
	bsr.w   sub_73CA
	move.w  #$C,(word_FFFFFF04).w
	rts
; End of function sub_7A90


; =============== S U B R O U T I N E =======================================


sub_7AA0:               ; CODE XREF: ROM:loc_7A7Cj
	clr.l   (dword_220E00).l
	bsr.w   sub_7876
	movem.w word_7B26(pc),d0-d2
	bsr.w   sub_77FA
	tst.b   1(a4)
	beq.s   loc_7B04
	bgt.s   loc_7AE8
	movem.w word_7B32(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7B38(pc),d0-d2
	bsr.w   sub_77FA
	move.w  4(a4),d0
	move.w  #$690,d1
	bsr.w   sub_78D8
	move.w  2(a4),d0
	move.w  #$6B2,d1
	bsr.w   sub_78D8

loc_7AE8:               ; CODE XREF: sub_7AA0+1Aj
	movem.w word_7B2C(pc),d0-d2
	bsr.w   sub_77FA
	lea $4000(a4),a0
	move.w  #$410,d0
	moveq   #0,d1
	bsr.w   sub_783E
	bsr.w   sub_7C4C

loc_7B04:               ; CODE XREF: sub_7AA0+18j
	movem.w word_7B3E(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7B44(pc),d0-d2
	bsr.w   sub_77FA
	move.w  #4,(word_FFFFFF04).w
	move.w  #1,(word_FFFFFF0A).w
	rts
; End of function sub_7AA0

; ---------------------------------------------------------------------------
word_7B26:  dc.w $8100      ; DATA XREF: sub_7AA0+Aw
		dc.w $9A
		dc.w 5
word_7B2C:  dc.w $8100      ; DATA XREF: sub_7AA0:loc_7AE8w
		dc.w $290
		dc.w $12
word_7B32:  dc.w $8100      ; DATA XREF: sub_7AA0+1Cw
		dc.w $58C
		dc.w 2
word_7B38:  dc.w $8100      ; DATA XREF: sub_7AA0+26w
		dc.w $5AE
		dc.w 3
word_7B3E:  dc.w $8100      ; DATA XREF: sub_7AA0:loc_7B04w
		dc.w $9AC
		dc.w $E
word_7B44:  dc.w $8100      ; DATA XREF: sub_7AA0+6Ew
		dc.w $AA0
		dc.w $F

; =============== S U B R O U T I N E =======================================


sub_7B4A:               ; CODE XREF: ROM:00007A88j
					; ROM:00007C98j
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_7B94
	clr.l   (dword_220E00).l
	lea (dword_220E00).l,a0
	move.w  #$BF,d4 ; '┬┐'
	bsr.w   loc_7880
	btst    #0,1(a4)
	beq.s   loc_7B7A
	movem.w word_7BA8(pc),d0-d2
	bsr.w   sub_77FA
	bra.s   loc_7B8A
; ---------------------------------------------------------------------------

loc_7B7A:               ; CODE XREF: sub_7B4A+22j
	movem.w word_7BB4(pc),d0-d2
	bsr.w   sub_77FA
	moveq   #Z80CMD_FF92,d7
	bsr.w   sendCommandToZ80

loc_7B8A:               ; CODE XREF: sub_7B4A+2Ej
	movem.w word_7BAE(pc),d0-d2
	bsr.w   sub_77FA

loc_7B94:               ; CODE XREF: sub_7B4A+6j
	bsr.w   sub_7A1E
	beq.s   locret_7BA6
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80
	move.w  #$10,(word_FFFFFF04).w

locret_7BA6:                ; CODE XREF: sub_7B4A+4Ej
	rts
; End of function sub_7B4A

; ---------------------------------------------------------------------------
word_7BA8:  dc.w $8100      ; DATA XREF: sub_7B4A+24w
		dc.w $59A
		dc.w $10
word_7BAE:  dc.w $8100      ; DATA XREF: sub_7B4A:loc_7B8Aw
		dc.w $898
		dc.w $11
word_7BB4:  dc.w $8100      ; DATA XREF: sub_7B4A:loc_7B7Aw
		dc.w $59A
		dc.w $21

; =============== S U B R O U T I N E =======================================


sub_7BBA:               ; CODE XREF: ROM:00007A80j
					; ROM:00007C90j
	bsr.w   sub_7C0A
	moveq   #0,d2
	move.w  (word_FFFFFF0A).w,d2
	mulu.w  #$28,d2 ; '('
	addi.w  #$FC,d2 ; '├╝'
	swap    d2
	move.w  #$10,d2
	swap    d2
	move.l  #$1280D01,d1
	moveq   #0,d0
	moveq   #$20,d3 ; ' '
	bsr.w   loc_77D2
	bsr.w   sub_7A1E
	beq.s   locret_7BFA
	tst.w   (word_FFFFFF0A).w
	bne.s   loc_7BFC
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80
	move.w  #8,(word_FFFFFF04).w

locret_7BFA:                ; CODE XREF: sub_7BBA+2Cj
	rts
; ---------------------------------------------------------------------------

loc_7BFC:               ; CODE XREF: sub_7BBA+32j
	moveq   #Z80CMD_FF90,d7
	bsr.w   sendCommandToZ80
	move.w  #$10,(word_FFFFFF04).w
	rts
; End of function sub_7BBA


; =============== S U B R O U T I N E =======================================


sub_7C0A:               ; CODE XREF: sub_7BBAp sub_80FAp
	move.w  (word_FFFFFF0A).w,d2
	bsr.w   sub_7990
	move.w  (word_FFFFFF0A).w,d1
	bpl.s   loc_7C1C
	moveq   #0,d1
	bra.s   loc_7C24
; ---------------------------------------------------------------------------

loc_7C1C:               ; CODE XREF: sub_7C0A+Cj
	cmpi.w  #1,d1
	ble.s   loc_7C24
	moveq   #1,d1

loc_7C24:               ; CODE XREF: sub_7C0A+10j sub_7C0A+16j
	move.w  d1,(word_FFFFFF0A).w
	cmp.w   d1,d2
	beq.s   locret_7C32

	moveq   #Z80CMD_FF90,d7
	bsr.w   sendCommandToZ80

locret_7C32:                ; CODE XREF: sub_7C0A+20j
	rts
; End of function sub_7C0A


; =============== S U B R O U T I N E =======================================


sub_7C34:               ; CODE XREF: ROM:00007A8Cj
				; ROM:00007C9Cj ...
	move.w  #4,(word_FFFFFF00).w
	move.w  #4,(word_FFFFFF02).w
	move.w  #0,(word_FFFFFF04).w
	clr.l   (word_FFFFFF0A).w
	rts
; End of function sub_7C34


; =============== S U B R O U T I N E =======================================


sub_7C4C:               ; CODE XREF: sub_7AA0+60p
				; ROM:00007D00p
	movem.w word_7C62(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7C68(pc),d0-d2
	bsr.w   sub_77FA
	rts
; End of function sub_7C4C

; ---------------------------------------------------------------------------
word_7C62:  dc.w $8100      ; DATA XREF: sub_7C4Cw
		dc.w $890
		dc.w $C
word_7C68:  dc.w $8100      ; DATA XREF: sub_7C4C+Aw
		dc.w $990
		dc.w $D

; =============== S U B R O U T I N E =======================================


sub_7C6E:               ; CODE XREF: ROM:00007502j
	bset    #7,(word_FFFFFF02).w
	bne.s   loc_7C7A
	clr.w   (word_FFFFFF04).w

loc_7C7A:               ; CODE XREF: sub_7C6E+6j
	lea (unk_210000).l,a4
	moveq   #$7C,d0 ; '|'
	and.w   (word_FFFFFF04).w,d0
	jsr loc_7C8C(pc,d0.w)
	rts
; End of function sub_7C6E

; ---------------------------------------------------------------------------

loc_7C8C:
	bra.w   loc_7CA0
; ---------------------------------------------------------------------------
	bra.w   sub_7BBA
; ---------------------------------------------------------------------------
	bra.w   loc_7D50
; ---------------------------------------------------------------------------
	bra.w   sub_7B4A
; ---------------------------------------------------------------------------
	bra.w   sub_7C34
; ---------------------------------------------------------------------------

loc_7CA0:               ; CODE XREF: ROM:loc_7C8Cj
	clr.l   (dword_220E00).l
	bsr.w   sub_7876
	movem.w word_7D26(pc),d0-d2
	bsr.w   sub_77FA
	tst.b   1(a4)
	beq.s   loc_7D04
	bgt.s   loc_7CE8
	movem.w word_7D32(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7D38(pc),d0-d2
	bsr.w   sub_77FA
	move.w  4(a4),d0
	move.w  #$690,d1
	bsr.w   sub_78D8
	move.w  2(a4),d0
	move.w  #$6B2,d1
	bsr.w   sub_78D8

loc_7CE8:               ; CODE XREF: ROM:00007CBAj
	movem.w word_7D2C(pc),d0-d2
	bsr.w   sub_77FA
	lea $4000(a4),a0
	move.w  #$410,d0
	moveq   #0,d1
	bsr.w   sub_783E
	bsr.w   sub_7C4C

loc_7D04:               ; CODE XREF: ROM:00007CB8j
	movem.w word_7D3E(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7D44(pc),d0-d2
	bsr.w   sub_77FA
	move.w  #4,(word_FFFFFF04).w
	move.w  #1,(word_FFFFFF0A).w
	rts
; ---------------------------------------------------------------------------
word_7D26:  dc.w $8100      ; DATA XREF: ROM:00007CAAw
		dc.w $9A
		dc.w 6
word_7D2C:  dc.w $8100      ; DATA XREF: ROM:loc_7CE8w
		dc.w $290
		dc.w $17
word_7D32:  dc.w $8100      ; DATA XREF: ROM:00007CBCw
		dc.w $58C
		dc.w 2
word_7D38:  dc.w $8100      ; DATA XREF: ROM:00007CC6w
		dc.w $5AE
		dc.w 3
word_7D3E:  dc.w $8100      ; DATA XREF: ROM:loc_7D04w
		dc.w $9AC
		dc.w $E
word_7D44:  dc.w $8100      ; DATA XREF: ROM:00007D0Ew
		dc.w $AA0
		dc.w $F
		dc.w $8100
		dc.w $B1C
		dc.w $F
; ---------------------------------------------------------------------------

loc_7D50:               ; CODE XREF: ROM:00007C94j
	lea $4000(a4),a1
	move.w  #6,d0
	jsr byte_FFFFFDAE
	bcs.s   loc_7D66
	move.w  #$8081,0(a4)
	bra.s   loc_7D74
; ---------------------------------------------------------------------------

loc_7D66:               ; CODE XREF: ROM:00007D5Cj
	move.w  #0,0(a4)
	clr.w   2(a4)
	clr.w   4(a4)

loc_7D74:               ; CODE XREF: ROM:00007D64j
	move.w  #$C,(word_FFFFFF04).w
	rts
; ---------------------------------------------------------------------------

loc_7D7C:               ; CODE XREF: ROM:00007506j
	lea (WordRAM_Bank0).l,a4
	moveq   #$7C,d0 ; '|'
	and.w   (word_FFFFFF04).w,d0
	jsr loc_7D8E(pc,d0.w)
	rts
; ---------------------------------------------------------------------------

loc_7D8E:
	bra.w   loc_7DA6
; ---------------------------------------------------------------------------
	bra.w   sub_7E3E
; ---------------------------------------------------------------------------
	bra.w   sub_800C
; ---------------------------------------------------------------------------
	bra.w   sub_7DD2
; ---------------------------------------------------------------------------
	bra.w   sub_80AA
; ---------------------------------------------------------------------------
	bra.w   sub_7C34
; ---------------------------------------------------------------------------

loc_7DA6:               ; CODE XREF: ROM:loc_7D8Ej
	bsr.w   sub_7DE2
	movem.w word_7DC6(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7DCC(pc),d0-d2
	bsr.w   sub_77FA
	move.w  #4,(word_FFFFFF04).w
	rts
; ---------------------------------------------------------------------------
word_7DC6:  dc.w $8100      ; DATA XREF: ROM:00007DAAw
		dc.w $96
		dc.w 7
word_7DCC:  dc.w $8100      ; DATA XREF: ROM:00007DB4w
		dc.w $290
		dc.w $12

; =============== S U B R O U T I N E =======================================


sub_7DD2:               ; CODE XREF: ROM:00007D9Aj
	move.w  #8,d0
	bsr.w   sub_73CA
	move.w  #$10,(word_FFFFFF04).w
	rts
; End of function sub_7DD2


; =============== S U B R O U T I N E =======================================


sub_7DE2:               ; CODE XREF: ROM:loc_7DA6p sub_814Ep ...
	clr.l   (dword_220E00).l
	clr.l   (word_FFFFFF0A).w
	bsr.w   sub_7876
	movem.w word_7E26(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7E2C(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7E32(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_7E38(pc),d0-d2
	bsr.w   sub_77FA
	lea $4000(a4),a0
	move.w  #$410,d0
	moveq   #0,d1
	bra.w   sub_783E
; End of function sub_7DE2

; ---------------------------------------------------------------------------
word_7E26:  dc.w $8100      ; DATA XREF: sub_7DE2+Ew
		dc.w $58A
		dc.w $18
word_7E2C:  dc.w $8100      ; DATA XREF: sub_7DE2+18w
		dc.w $5A4
		dc.w $18
word_7E32:  dc.w $8100      ; DATA XREF: sub_7DE2+22w
		dc.w $5B8
		dc.w $23
word_7E38:  dc.w $8100      ; DATA XREF: sub_7DE2+2Cw
		dc.w $68A
		dc.w $13

; =============== S U B R O U T I N E =======================================


sub_7E3E:               ; CODE XREF: ROM:00007D92j
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_7E56
	clr.w   $A(a4)
	clr.w   $C(a4)
	bsr.w   sub_7EA8
	clr.w   (word_FFFFFF08).w

loc_7E56:               ; CODE XREF: sub_7E3E+6j
	bsr.s   sub_7E6C
	bsr.w   sub_7A1E
	beq.s   locret_7E6A
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80
	move.w  #8,(word_FFFFFF04).w

locret_7E6A:                ; CODE XREF: sub_7E3E+1Ej
	rts
; End of function sub_7E3E


; =============== S U B R O U T I N E =======================================


sub_7E6C:               ; CODE XREF: sub_7E3E:loc_7E56p
					; sub_82F2:loc_8306p
	bsr.w   sub_7F66
	move.w  (word_FFFFFF0C).w,d0
	bmi.s   loc_7E8A
	beq.s   loc_7E98
	moveq   #$A,d1
	add.w   $A(a4),d1
	cmp.w   4(a4),d1
	beq.s   loc_7E98
	add.w   d0,$A(a4)
	bra.s   loc_7E94
; ---------------------------------------------------------------------------

loc_7E8A:               ; CODE XREF: sub_7E6C+8j
	add.w   $A(a4),d0
	bmi.s   loc_7E98
	move.w  d0,$A(a4)

loc_7E94:               ; CODE XREF: sub_7E6C+1Cj
	bsr.w   sub_7EA8

loc_7E98:               ; CODE XREF: sub_7E6C+Aj sub_7E6C+16j ...
	move.w  $A(a4),d0
	move.w  (word_FFFFFF0A).w,d1
	add.w   d1,d0
	move.w  d0,$C(a4)
	rts
; End of function sub_7E6C


; =============== S U B R O U T I N E =======================================


sub_7EA8:               ; CODE XREF: sub_7E3E+10p
					; sub_7E6C:loc_7E94p ...
	lea $80(a4),a0
	moveq   #9,d0

loc_7EAE:               ; CODE XREF: sub_7EA8+Ej
	clr.l   (a0)+
	clr.l   (a0)+
	clr.l   (a0)+
	clr.l   (a0)+
	dbf d0,loc_7EAE
	move.w  #4,d0
	bsr.w   sub_73CA
	lea $80(a4),a0
	bsr.w   sub_7F40

loc_7ECA:               ; CODE XREF: sub_81FC+30j
	lea $80(a4),a2
	moveq   #$A,d7
	cmp.w   4(a4),d7
	ble.s   loc_7EDA
	move.w  4(a4),d7

loc_7EDA:               ; CODE XREF: sub_7EA8+2Cj
	subq.w  #1,d7
	move.w  $A(a4),d6
	moveq   #0,d5

loc_7EE2:               ; CODE XREF: sub_7EA8+82j
	moveq   #1,d0
	add.w   d6,d0
	lea (WordRAM_Bank1).l,a0
	move.w  d5,d2
	lsl.w   #7,d2
	addi.w  #$806,d2
	adda.w  d2,a0
	move.w  #$A030,d1
	bsr.w   sub_7892
	move.w  #$8000,d1
	lea (a2),a1
	adda.w  #$E,a0
	move.w  #$A000,d1
	bsr.w   sub_7F30
	moveq   #0,d0
	move.w  $E(a2),d0
	adda.w  #2,a0
	move.w  #$A030,d1
	bsr.w   sub_7892
	lea $10(a2),a2
	addq.w  #1,d5
	addq.w  #1,d6
	dbf d7,loc_7EE2
	rts
; End of function sub_7EA8


; =============== S U B R O U T I N E =======================================


sub_7F30:               ; CODE XREF: sub_7EA8+64p
	moveq   #$A,d2

loc_7F32:               ; CODE XREF: sub_7F30+Aj
	moveq   #0,d0
	move.b  (a1)+,d0
	add.w   d1,d0
	move.w  d0,(a0)+
	dbf d2,loc_7F32
	rts
; End of function sub_7F30


; =============== S U B R O U T I N E =======================================


sub_7F40:               ; CODE XREF: sub_7EA8+1Ep sub_81FC+2Cp
	moveq   #9,d0

loc_7F42:               ; CODE XREF: sub_7F40+20j
	lea (a0),a1
	move.w  d0,-(sp)
	moveq   #$A,d0

loc_7F48:               ; CODE XREF: sub_7F40+16j
	moveq   #$7F,d1 ; ''
	and.b   (a1),d1
	cmpi.b  #$20,d1 ; ' '
	bcc.s   loc_7F54
	moveq   #$20,d1 ; ' '

loc_7F54:               ; CODE XREF: sub_7F40+10j
	move.b  d1,(a1)+
	dbf d0,loc_7F48
	lea $10(a0),a0
	move.w  (sp)+,d0
	dbf d0,loc_7F42
	rts
; End of function sub_7F40


; =============== S U B R O U T I N E =======================================


sub_7F66:               ; CODE XREF: sub_7E6Cp sub_81C0p
	bsr.w   sub_790A
	moveq   #0,d1
	move.w  (word_FFFFFF0A).w,d1
	cmpi.w  #$A,4(a4)
	blt.s   loc_7F9C
	tst.w   d1
	bmi.s   loc_7F92
	cmpi.w  #9,d1
	bgt.s   loc_7F88
	clr.w   (word_FFFFFF0C).w
	bra.s   loc_7FC4
; ---------------------------------------------------------------------------

loc_7F88:               ; CODE XREF: sub_7F66+1Aj
	moveq   #9,d1
	move.w  #1,(word_FFFFFF0C).w
	bra.s   loc_7FC4
; ---------------------------------------------------------------------------

loc_7F92:               ; CODE XREF: sub_7F66+14j
	moveq   #0,d1
	move.w  #$FFFF,(word_FFFFFF0C).w
	bra.s   loc_7FC4
; ---------------------------------------------------------------------------

loc_7F9C:               ; CODE XREF: sub_7F66+10j
	tst.w   d1
	bmi.s   loc_7FAC
	cmp.w   4(a4),d1
	bge.s   loc_7FB4
	clr.w   (word_FFFFFF0C).w
	bra.s   loc_7FC4
; ---------------------------------------------------------------------------

loc_7FAC:               ; CODE XREF: sub_7F66+38j
	moveq   #0,d1
	clr.w   (word_FFFFFF0C).w
	bra.s   loc_7FC4
; ---------------------------------------------------------------------------

loc_7FB4:               ; CODE XREF: sub_7F66+3Ej
	move.w  4(a4),d1
	subq.w  #1,d1
	clr.w   (word_FFFFFF0C).w
	bra.s   loc_7FC4
; ---------------------------------------------------------------------------
	clr.w   (word_FFFFFF0C).w

loc_7FC4:               ; CODE XREF: sub_7F66+20j sub_7F66+2Aj ...
	move.w  d1,(word_FFFFFF0A).w
	lsl.w   #4,d1
	lea $80(a4),a0
	adda.w  d1,a0
	pea (a0)
	lea $120(a4),a1
	moveq   #$A,d0

loc_7FD8:               ; CODE XREF: sub_7F66+74j
	move.b  (a0)+,(a1)+
	dbf d0,loc_7FD8
	movea.l (sp)+,a0
	move.w  $E(a0),$12C(a4)
	move.b  $B(a0),$12B(a4)
	moveq   #0,d1
	move.w  (word_FFFFFF0A).w,d1
	lsl.w   #3,d1
	addi.w  #$100,d1
	swap    d1
	move.w  #$C01,d1

loc_7FFE:
	move.l  #$1000A8,d2
	moveq   #6,d0
	moveq   #$20,d3 ; ' '
	bra.w   loc_77D2
; End of function sub_7F66


; =============== S U B R O U T I N E =======================================


sub_800C:               ; CODE XREF: ROM:00007D96j
					; ROM:0000813Ej
	bset  #7, (word_FFFFFF04).w
	bne.s loc_8066

	clr.l (dword_220E00).l

	lea    (dword_220E00).l, a0
	move.w #$8F, d4
	bsr.w  loc_7880

	movem.w word_8092(pc), d0-d2
	bsr.w   sub_77FA

	movem.w word_8098(pc), d0-d2
	bsr.w   sub_77FA

	movem.w word_809E(pc), d0-d2
	bsr.w   sub_77FA

	movem.w word_80A4(pc), d0-d2
	bsr.w   sub_77FA

	lea    $120(a4), a0
	move.w #$71E, d0
	move.w #(loc_7FFE+2), d1
	bsr.w  sub_783E

	move.w #1, (word_FFFFFF0A).w

loc_8066:               ; CODE XREF: sub_800C+6j
	bsr.w sub_80FA

	bsr.w sub_7A1E
	beq.s locret_8082

	tst.w (word_FFFFFF0A).w
	bne.s loc_8084

	moveq #Z80CMD_FF91, d7
	bsr.w sendCommandToZ80

	move.w #$C, (word_FFFFFF04).w

locret_8082:                ; CODE XREF: sub_800C+62j
	rts
; ---------------------------------------------------------------------------

loc_8084:               ; CODE XREF: sub_800C+68j
	moveq #Z80CMD_FF90, d7
	bsr.w sendCommandToZ80

	move.w #$14, (word_FFFFFF04).w
	rts
; End of function sub_800C

; ---------------------------------------------------------------------------
word_8092:
	dc.w $8100
	dc.w $692
	dc.w $18

word_8098:
	dc.w $8100
	dc.w $594
	dc.w $14

word_809E:
	dc.w $8100
	dc.w $6B8
	dc.w $15

word_80A4:
	dc.w $8100
	dc.w $79A
	dc.w $F

; =============== S U B R O U T I N E =======================================


sub_80AA:               ; CODE XREF: ROM:00007D9Ej
					; ROM:00008146j
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_80DA
	clr.l   (dword_220E00).l
	lea (dword_220E00).l,a0
	move.w  #$BF,d4 ; '┬┐'
	bsr.w   loc_7880

	movem.w word_80EE(pc),d0-d2
	bsr.w   sub_77FA

	movem.w word_80F4(pc),d0-d2
	bsr.w   sub_77FA

loc_80DA:               ; CODE XREF: sub_80AA+6j
	bsr.w   sub_7A1E
	beq.s   locret_80EC

	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80

	move.w  #$14,(word_FFFFFF04).w

locret_80EC:                ; CODE XREF: sub_80AA+34j
	rts
; End of function sub_80AA

; ---------------------------------------------------------------------------
word_80EE:  dc.w $8100      ; DATA XREF: sub_80AA+1Cw
		dc.w $398
		dc.w $16
word_80F4:  dc.w $8100      ; DATA XREF: sub_80AA+26w
		dc.w $698
		dc.w $11

; =============== S U B R O U T I N E =======================================


sub_80FA:               ; CODE XREF: sub_800C:loc_8066p
					; sub_834E:loc_83B2p
	bsr.w   sub_7C0A
	moveq   #0,d2
	move.w  (word_FFFFFF0A).w,d2
	mulu.w  #$28,d2 ; '('
	addi.w  #$E4,d2 ; '├ñ'
	swap    d2
	move.w  #$10,d2
	swap    d2
	move.l  #$F80D01,d1
	moveq   #0,d0
	moveq   #$20,d3 ; ' '
	bsr.w   loc_77D2
	rts
; End of function sub_80FA


; =============== S U B R O U T I N E =======================================


sub_8124:               ; CODE XREF: ROM:0000750Aj
	lea (unk_210000).l,a4
	moveq   #$7C,d0 ; '|'
	and.w   (word_FFFFFF04).w,d0
	jsr loc_8136(pc,d0.w)
	rts
; End of function sub_8124

; ---------------------------------------------------------------------------

loc_8136:
	bra.w   sub_814E
; ---------------------------------------------------------------------------
	bra.w   sub_8192
; ---------------------------------------------------------------------------
	bra.w   sub_800C
; ---------------------------------------------------------------------------
	bra.w   sub_817A
; ---------------------------------------------------------------------------
	bra.w   sub_80AA
; ---------------------------------------------------------------------------
	bra.w   sub_7C34

; =============== S U B R O U T I N E =======================================


sub_814E:               ; CODE XREF: ROM:loc_8136j
	bsr.w   sub_7DE2
	movem.w word_816E(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_8174(pc),d0-d2
	bsr.w   sub_77FA
	move.w  #4,(word_FFFFFF04).w
	rts
; End of function sub_814E

; ---------------------------------------------------------------------------
word_816E:  dc.w $8100      ; DATA XREF: sub_814E+4w
		dc.w $96
		dc.w 8
word_8174:  dc.w $8100      ; DATA XREF: sub_814E+Ew
		dc.w $290
		dc.w $17

; =============== S U B R O U T I N E =======================================


sub_817A:               ; CODE XREF: ROM:00008142j
					; sub_82A4:loc_82E6p
	clr.b   $12B(a4)
	lea $120(a4),a0
	move.w  #5,d0
	jsr byte_FFFFFDAE
	move.w  #$10,(word_FFFFFF04).w
	rts
; End of function sub_817A


; =============== S U B R O U T I N E =======================================


sub_8192:               ; CODE XREF: ROM:0000813Aj
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_81AA
	clr.w   $A(a4)
	clr.w   $C(a4)
	bsr.w   sub_81FC
	clr.w   (word_FFFFFF08).w

loc_81AA:               ; CODE XREF: sub_8192+6j
	bsr.s   sub_81C0
	bsr.w   sub_7A1E
	beq.s   locret_81BE
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80
	move.w  #8,(word_FFFFFF04).w

locret_81BE:                ; CODE XREF: sub_8192+1Ej
	rts
; End of function sub_8192


; =============== S U B R O U T I N E =======================================


sub_81C0:               ; CODE XREF: sub_8192:loc_81AAp
					; sub_866A:loc_867Ep
	bsr.w   sub_7F66
	move.w  (word_FFFFFF0C).w,d0
	bmi.s   loc_81DE
	beq.s   loc_81EC
	moveq   #$A,d1
	add.w   $A(a4),d1
	cmp.w   4(a4),d1
	beq.s   loc_81EC
	add.w   d0,$A(a4)
	bra.s   loc_81E8
; ---------------------------------------------------------------------------

loc_81DE:               ; CODE XREF: sub_81C0+8j
	add.w   $A(a4),d0
	bmi.s   loc_81EC
	move.w  d0,$A(a4)

loc_81E8:               ; CODE XREF: sub_81C0+1Cj
	bsr.w   sub_81FC

loc_81EC:               ; CODE XREF: sub_81C0+Aj sub_81C0+16j ...
	move.w  $A(a4),d0
	move.w  (word_FFFFFF0A).w,d1
	add.w   d1,d0
	move.w  d0,$C(a4)
	rts
; End of function sub_81C0


; =============== S U B R O U T I N E =======================================


sub_81FC:               ; CODE XREF: sub_8192+10p
				; sub_81C0:loc_81E8p ...
	lea $80(a4),a0
	moveq   #9,d0

loc_8202:               ; CODE XREF: sub_81FC+Ej
	clr.l   (a0)+
	clr.l   (a0)+
	clr.l   (a0)+
	clr.l   (a0)+
	dbf d0,loc_8202
	move.w  $A(a4),d1
	swap    d1
	move.w  #$A,d1
	lea $80(a4),a1
	lea sub_8230(pc),a0
	move.w  #7,d0
	jsr byte_FFFFFDAE
	bsr.w   sub_7F40
	bra.w   loc_7ECA
; End of function sub_81FC


; =============== S U B R O U T I N E =======================================


sub_8230:               ; DATA XREF: sub_81FC+20o
	move.l  $2A2A(a2),d5
	move.l  $2A2A(a2),d5
	move.l  $2A00(a2),d5

loc_823C:               ; CODE XREF: ROM:0000750Ej
	lea (unk_210000).l,a3
	lea (WordRAM_Bank0).l,a4
	moveq   #$7C,d0
	and.w   (word_FFFFFF04).w,d0
	jsr loc_8254(pc,d0.w)
	rts
; End of function sub_8230

; ---------------------------------------------------------------------------

loc_8254:
	bra.w   sub_8278
; ---------------------------------------------------------------------------
	bra.w   sub_82F2
; ---------------------------------------------------------------------------
	bra.w   sub_834E
; ---------------------------------------------------------------------------
	bra.w   sub_82A4
; ---------------------------------------------------------------------------
	bra.w   sub_83FC
; ---------------------------------------------------------------------------
	bra.w   sub_7C34
; ---------------------------------------------------------------------------
	bra.w   sub_844C
; ---------------------------------------------------------------------------
	bra.w   sub_84DC
; ---------------------------------------------------------------------------
	bra.w   sub_8562

; =============== S U B R O U T I N E =======================================


sub_8278:               ; CODE XREF: ROM:loc_8254j
	bsr.w   sub_7DE2
	movem.w word_8298(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_829E(pc),d0-d2
	bsr.w   sub_77FA
	move.w  #4,(word_FFFFFF04).w
	rts
; End of function sub_8278

; ---------------------------------------------------------------------------
word_8298:  dc.w $8100      ; DATA XREF: sub_8278+4w
		dc.w $92
		dc.w 9
word_829E:  dc.w $8100      ; DATA XREF: sub_8278+Ew
		dc.w $290
		dc.w $12

; =============== S U B R O U T I N E =======================================


sub_82A4:               ; CODE XREF: ROM:00008260j
	move.w  #5,d0
	bsr.w   sub_73CA
	moveq   #2,d7

loc_82AE:               ; CODE XREF: sub_82A4+2Cj
	lea $120(a4),a0
	lea $130(a4),a1
	move.w  #4,d0
	jsr byte_FFFFFDAE
	bcs.s   loc_82DE
	lea $120(a4),a0
	lea $130(a4),a1
	move.w  #8,d0
	jsr byte_FFFFFDAE
	dbcc    d7,loc_82AE
	bcs.s   loc_82E6
	move.w  #$10,(word_FFFFFF04).w
	rts
; ---------------------------------------------------------------------------

loc_82DE:               ; CODE XREF: sub_82A4+1Aj
	move.w  #$18,(word_FFFFFF04).w
	rts
; ---------------------------------------------------------------------------

loc_82E6:               ; CODE XREF: sub_82A4+30j
	bsr.w   sub_817A
	move.w  #$20,(word_FFFFFF04).w ; ' '
	rts
; End of function sub_82A4


; =============== S U B R O U T I N E =======================================


sub_82F2:               ; CODE XREF: ROM:00008258j
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_8306
	clr.w   $A(a4)
	clr.w   $C(a4)
	bsr.w   sub_7EA8

loc_8306:               ; CODE XREF: sub_82F2+6j
	bsr.w   sub_7E6C
	bsr.w   sub_7A1E
	bne.s   loc_8312
	rts
; ---------------------------------------------------------------------------

loc_8312:               ; CODE XREF: sub_82F2+1Cj
	lea $120(a4),a0
	move.w  #2,d0
	clr.b   $12B(a4)
	jsr byte_FFFFFDAE
	bcs.s   loc_832C
	move.w  #$1C,(word_FFFFFF04).w
	rts
; ---------------------------------------------------------------------------

loc_832C:               ; CODE XREF: sub_82F2+30j sub_866A+30j
	move.w  $12C(a4),d0
	move.w  2(a3),d1
	cmp.w   d0,d1
	bge.s   loc_8340
	move.w  #$18,(word_FFFFFF04).w
	rts
; ---------------------------------------------------------------------------

loc_8340:               ; CODE XREF: sub_82F2+44j
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80
	move.w  #8,(word_FFFFFF04).w
	rts
; End of function sub_82F2


; =============== S U B R O U T I N E =======================================


sub_834E:               ; CODE XREF: ROM:0000825Cj
				; ROM:000085E8j
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_83B2
	clr.l   (dword_220E00).l
	lea (unk_220D00).l,a0
	move.w  #$87,d4 ; 'ΓÇí'
	bsr.w   loc_7880
	movem.w word_83DE(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_83E4(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_83EA(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_83F0(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_83F6(pc),d0-d2
	bsr.w   sub_77FA
	lea $120(a4),a0
	move.w  #$71E,d0
	move.w  #(loc_7FFE+2),d1
	bsr.w   sub_783E
	move.w  #1,(word_FFFFFF0A).w

loc_83B2:               ; CODE XREF: sub_834E+6j
	bsr.w   sub_80FA
	bsr.w   sub_7A1E
	beq.s   locret_83CE
	tst.w   (word_FFFFFF0A).w
	bne.s   loc_83D0
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80
	move.w  #$C,(word_FFFFFF04).w

locret_83CE:                ; CODE XREF: sub_834E+6Cj
	rts
; ---------------------------------------------------------------------------

loc_83D0:               ; CODE XREF: sub_834E+72j
	moveq   #Z80CMD_FF90,d7
	bsr.w   sendCommandToZ80
	move.w  #$14,(word_FFFFFF04).w
	rts
; End of function sub_834E

; ---------------------------------------------------------------------------
word_83DE:  dc.w $8100      ; DATA XREF: sub_834E+1Cw
		dc.w $692
		dc.w $18
word_83E4:  dc.w $8100      ; DATA XREF: sub_834E+26w
		dc.w $594
		dc.w $20
word_83EA:  dc.w $8100      ; DATA XREF: sub_834E+30w
		dc.w $6B8
		dc.w $15
word_83F0:  dc.w $8100      ; DATA XREF: sub_834E+3Aw
		dc.w $79A
		dc.w $F
word_83F6:  dc.w $8100      ; DATA XREF: sub_834E+44w
		dc.w $998
		dc.w $11

; =============== S U B R O U T I N E =======================================


sub_83FC:               ; CODE XREF: ROM:00008264j
					; ROM:000085F0j
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_842C
	clr.l   (dword_220E00).l
	lea (dword_220E00).l,a0
	move.w  #$BF,d4 ; '┬┐'
	bsr.w   loc_7880
	movem.w word_8440(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_8446(pc),d0-d2
	bsr.w   sub_77FA

loc_842C:               ; CODE XREF: sub_83FC+6j
	bsr.w   sub_7A1E
	beq.s   locret_843E
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80
	move.w  #$14,(word_FFFFFF04).w

locret_843E:                ; CODE XREF: sub_83FC+34j
	rts
; End of function sub_83FC

; ---------------------------------------------------------------------------
word_8440:  dc.w $8100      ; DATA XREF: sub_83FC+1Cw
		dc.w $398
		dc.w $1C
word_8446:  dc.w $8100      ; DATA XREF: sub_83FC+26w
		dc.w $698
		dc.w $11

; =============== S U B R O U T I N E =======================================


sub_844C:               ; CODE XREF: ROM:0000826Cj
					; ROM:000085F8j
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_84AE
	clr.l   (dword_220E00).l
	lea (dword_220E00).l,a0
	move.w  #$B7,d4 ; '┬╖'
	bsr.w   loc_7880
	movem.w word_84C2(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_84C8(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_84CE(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_84D4(pc),d0-d2
	bsr.w   sub_77FA
	lea $120(a4),a0
	move.w  #$512,d0
	move.w  #(loc_7FFE+2),d1
	bsr.w   sub_783E
	lea word_84DA(pc),a0
	bsr.w   loc_7846
	moveq   #Z80CMD_FF92,d7
	bsr.w   sendCommandToZ80

loc_84AE:               ; CODE XREF: sub_844C+6j
	bsr.w   sub_7A1E
	beq.s   locret_84C0
	move.w  #$14,(word_FFFFFF04).w
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80

locret_84C0:                ; CODE XREF: sub_844C+66j
	rts
; End of function sub_844C

; ---------------------------------------------------------------------------
word_84C2:  dc.w $8100      ; DATA XREF: sub_844C+1Cw
		dc.w $290
		dc.w $19
word_84C8:  dc.w $8100      ; DATA XREF: sub_844C+26w
		dc.w $390
		dc.w $22
word_84CE:  dc.w $8100      ; DATA XREF: sub_844C+30w
		dc.w $690
		dc.w $1A
word_84D4:  dc.w $8100      ; DATA XREF: sub_844C+3Aw
		dc.w $898
		dc.w $11
word_84DA:  dc.w $2E00      ; DATA XREF: sub_844C+54o

; =============== S U B R O U T I N E =======================================


sub_84DC:               ; CODE XREF: ROM:00008270j
					; ROM:000085FCj
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_8536
	clr.l   (dword_220E00).l
	lea (dword_220E00).l,a0
	move.w  #$B7,d4 ; '┬╖'
	bsr.w   loc_7880
	movem.w word_854A(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_8550(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_8556(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_855C(pc),d0-d2
	bsr.w   sub_77FA
	lea $120(a4),a0
	move.w  #$412,d0
	move.w  #(loc_7FFE+2),d1
	bsr.w   sub_783E
	moveq   #Z80CMD_FF92,d7
	bsr.w   sendCommandToZ80

loc_8536:               ; CODE XREF: sub_84DC+6j
	bsr.w   sub_7A1E
	beq.s   locret_8548
	move.w  #$14,(word_FFFFFF04).w
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80

locret_8548:                ; CODE XREF: sub_84DC+5Ej
	rts
; End of function sub_84DC

; ---------------------------------------------------------------------------
word_854A:  dc.w $8100      ; DATA XREF: sub_84DC+1Cw
		dc.w $290
		dc.w $1B
word_8550:  dc.w $8100      ; DATA XREF: sub_84DC+26w
		dc.w $490
		dc.w $25
word_8556:  dc.w $8100      ; DATA XREF: sub_84DC+30w
		dc.w $790
		dc.w $1A
word_855C:  dc.w $8100      ; DATA XREF: sub_84DC+3Aw
		dc.w $998
		dc.w $11

; =============== S U B R O U T I N E =======================================


sub_8562:               ; CODE XREF: ROM:00008274j
					; ROM:00008600j
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_85A8
	clr.l   (dword_220E00).l
	lea (dword_220E00).l,a0
	move.w  #$B7,d4 ; '┬╖'
	bsr.w   loc_7880
	movem.w word_85BC(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_85C2(pc),d0-d2
	bsr.w   sub_77FA
	lea $120(a4),a0
	move.w  #$410,d0
	move.w  #(loc_7FFE+2),d1
	bsr.w   sub_783E
	moveq   #Z80CMD_FF92,d7
	bsr.w   sendCommandToZ80

loc_85A8:               ; CODE XREF: sub_8562+6j
	bsr.w   sub_7A1E
	beq.s   locret_85BA
	move.w  #$14,(word_FFFFFF04).w
	moveq   #Z80CMD_FF91,d7
	bsr.w   sendCommandToZ80

locret_85BA:                ; CODE XREF: sub_8562+4Aj
	rts
; End of function sub_8562

; ---------------------------------------------------------------------------
word_85BC:  dc.w $8100      ; DATA XREF: sub_8562+1Cw
		dc.w $590
		dc.w $1A
word_85C2:  dc.w $8100      ; DATA XREF: sub_8562+26w
		dc.w $798
		dc.w $11

; =============== S U B R O U T I N E =======================================


sub_85C8:               ; CODE XREF: ROM:00007512j
	lea (WordRAM_Bank0).l,a3
	lea (unk_210000).l,a4
	moveq   #$7C,d0 ; '|'
	and.w   (word_FFFFFF04).w,d0
	jsr loc_85E0(pc,d0.w)
	rts
; End of function sub_85C8

; ---------------------------------------------------------------------------

loc_85E0:
	bra.w   sub_8604
; ---------------------------------------------------------------------------
	bra.w   sub_866A
; ---------------------------------------------------------------------------
	bra.w   sub_834E
; ---------------------------------------------------------------------------
	bra.w   sub_8630
; ---------------------------------------------------------------------------
	bra.w   sub_83FC
; ---------------------------------------------------------------------------
	bra.w   sub_7C34
; ---------------------------------------------------------------------------
	bra.w   sub_844C
; ---------------------------------------------------------------------------
	bra.w   sub_84DC
; ---------------------------------------------------------------------------
	bra.w   sub_8562

; =============== S U B R O U T I N E =======================================


sub_8604:               ; CODE XREF: ROM:loc_85E0j
	bsr.w   sub_7DE2
	movem.w word_8624(pc),d0-d2
	bsr.w   sub_77FA
	movem.w word_862A(pc),d0-d2
	bsr.w   sub_77FA
	move.w  #4,(word_FFFFFF04).w
	rts
; End of function sub_8604

; ---------------------------------------------------------------------------
word_8624:  dc.w $8100      ; DATA XREF: sub_8604+4w
		dc.w $92
		dc.w $A
word_862A:  dc.w $8100      ; DATA XREF: sub_8604+Ew
		dc.w $290
		dc.w $17

; =============== S U B R O U T I N E =======================================


sub_8630:               ; CODE XREF: ROM:000085ECj
	lea $120(a4),a0
	lea $130(a4),a1
	clr.b   $12B(a4)
	move.w  #3,d0
	jsr byte_FFFFFDAE
	move.w  d0,$12C(a4)
	move.b  d1,$12B(a4)
	move.w  #6,d0
	bsr.w   sub_73CA
	tst.w   $12E(a3)
	bmi.s   loc_8662
	move.w  #$10,(word_FFFFFF04).w
	rts
; ---------------------------------------------------------------------------

loc_8662:               ; CODE XREF: sub_8630+28j
	move.w  #$20,(word_FFFFFF04).w ; ' '
	rts
; End of function sub_8630


; =============== S U B R O U T I N E =======================================


sub_866A:               ; CODE XREF: ROM:000085E4j
	bset    #7,(word_FFFFFF04).w
	bne.s   loc_867E
	clr.w   $A(a4)
	clr.w   $C(a4)
	bsr.w   sub_81FC

loc_867E:               ; CODE XREF: sub_866A+6j
	bsr.w   sub_81C0
	bsr.w   sub_7A1E
	bne.s   loc_868A
	rts
; ---------------------------------------------------------------------------

loc_868A:               ; CODE XREF: sub_866A+1Cj
	clr.b   $12B(a4)
	move.w  #7,d0
	bsr.w   sub_73CA
	tst.w   $12E(a3)
	bne.w   loc_832C
	move.w  #$1C,(word_FFFFFF04).w
	rts
; End of function sub_866A


; =============== S U B R O U T I N E =======================================


; V-blank handler for state_7374
sub_86A6:               ; DATA XREF: sub_873A+20o
	btst  #GA_RET, (GA_MEM_MODE).l
	beq.s @loc_86E2

	m_loadVramWriteAddress $F400

	lea (dword_220E00).l, a0
	lea (VDP_DATA).l,     a1

	moveq #39, d0
	@loc_86C8:
		move.l (a0)+, (a1)
		dbeq   d0, @loc_86C8

	m_loadVramWriteAddress $C000, d0
	move.l #WordRAM_Bank1, d1
	move.w #$700, d2
	bsr.w  dmaTransferToVramWithRewrite

@loc_86E2:
	moveq #0, d0
	lea   (word_FFFFFF08).w, a1
	jsr   handleDpadRepeat

	moveq #1, d0
	lea   (byte_FFFFFF09).w, a1
	jsr   handleDpadRepeat

	lea   (joy1MouseData).w, a0
	bsr.s sub_8704

	lea   (joy2MouseData).w, a0
	bsr.s sub_8704

	rts
; End of function sub_86A6


; =============== S U B R O U T I N E =======================================


sub_8704:               ; CODE XREF: sub_86A6+54p
					; sub_86A6:loc_8700p
	moveq  #3, d0

	and.b  1(a0), d0
	beq.s  @loc_871E

	cmpi.b #$C, $A(a0)
	bcs.s  @loc_8734

	clr.b  $A(a0)
	st     $B(a0)
	rts
; ---------------------------------------------------------------------------

@loc_871E:
	clr.b      $B(a0)
	addq.b #1, $A(a0)

	cmpi.b #$40, $A(a0)
	bcs.s  @loc_8734

	move.b #$40, $A(a0)

@loc_8734:
	clr.b $B(a0)
	rts
; End of function sub_8704


; =============== S U B R O U T I N E =======================================


sub_873A:               ; CODE XREF: state_7374p
	st  (byte_FFFFFE28).w
	bsr.w   displayOff

	m_waitForWordRam2M
	m_giveWordRamToSubCpu

	bsr.w   waitForWordRam

	lea sub_86A6, a1
	jsr setVblankUserRoutine

	move.l  #0,(mainCommData+8).w

	lea vdpReg_87FE(pc),a1
	bsr.w   loadVdpRegs

	bsr.w   clearAllVram

	bsr.w   sub_7876

	clr.l   (dword_220E00).l

	m_loadVramWriteAddress $2000
	lea (unk_15300).l,a1
	jsr decompressNemesis(pc)

	m_loadVramWriteAddress $21C0
	lea (unk_1546E).l,a1
	jsr decompressNemesis(pc)

	m_loadVramWriteAddress $400, d0
	move.w  #0,(fontTileOffset).w
	move.l  #$EE0EE,d1
	bsr.w   loc_1952

	bsr.w   sub_7854

	lea palette_881E(pc),a1
	bsr.w   loadPalettesToBuffer

	bsr.w   sendE3ToZ80

	lea (word_FFFFFF00).w,a0
	moveq   #0,d0
	moveq   #3,d1
loc_87D6:               ; CODE XREF: sub_873A+9Ej
	move.l  d0,(a0)+
	dbf d1,loc_87D6

	clr.w   (byte_FFFFFE0A).w
	clr.w   (byte_FFFFFE16).w
	clr.b   (byte_FFFFFE28).w
	bra.w   displayOn
; End of function sub_873A


; =============== S U B R O U T I N E =======================================


sub_87EC:               ; CODE XREF: ROM:000073ACj
	moveq #59, d7
	@loc_87EE:
		bsr.w   waitForVblank
		dbf d7, @loc_87EE

	move.w #$FFFF, (word_FFFFFF00).w
	rts
; End of function sub_87EC

; ---------------------------------------------------------------------------
vdpReg_87FE:
	dc.w $8004 ; Reg #00: H-int off, H/V counter active
	dc.w $8124 ; Reg #01: Display/DMA off, V-int on, V28-cell (NTSC) mode
	dc.w $8230 ; Reg #02: Scroll A pattern table $C000
	dc.w $8334 ; Reg #03: Window pattern table $D000
	dc.w $8407 ; Reg #04: Scroll B pattern table $E000
	dc.w $857A ; Reg #05: Sprite attribute table $F400
	dc.w $8700 ; Reg #07: Background color palette 0, color 0
	dc.w $8A00 ; Reg #10: H-interrupt timing set to 0
	dc.w $8B02 ; Reg #11: Ext. Int off, H full scroll, V 2-cell scroll
	dc.w $8C81 ; Reg #12: H40-cell mode, Shadow/hilight off, no interlace
	dc.w $8D3C ; Reg #13: H-scroll data table $F000
	dc.w $8F02 ; Reg #15: Auto-increment VDP set to 2
	dc.w $9001 ; Reg #16: Scroll plane size 32V x 64H cells
	dc.w $9100 ; Reg #17: Window H position set to 0
	dc.w $9200 ; Reg #18: Window V position set to 0
	dc.w 0

palette_881E:
	dc.b 0
	dc.b 47

palette_8820:
	dc.w $000
	dc.w $000
	dc.w $C86
	dc.w $CCC
	dc.w $888
	dc.w $444
	dc.w $222
	dc.w $EEE
	dc.w $0AC
	dc.w $666
	dc.w $000
	dc.w $444
	dc.w $888
	dc.w $EEE
	dc.w $EEE
	dc.w $A40

palette_8840:
	dc.w $000
	dc.w $000
	dc.w $C86
	dc.w $888
	dc.w $666
	dc.w $222
	dc.w $000
	dc.w $AAA
	dc.w $0AC
	dc.w $666
	dc.w $000
	dc.w $222
	dc.w $444
	dc.w $666
	dc.w $4EE
	dc.w $000

palette_8860:
	dc.w $000
	dc.w $666
	dc.w $444
	dc.w $888
	dc.w $444
	dc.w $000
	dc.w $000
	dc.w $004
	dc.w $068
	dc.w $000
	dc.w $000
	dc.w $288
	dc.w $4AA
	dc.w $6CC
	dc.w $4EE
	dc.w $000

byte_8880:
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   1
	dc.b   1
	dc.b   1
	dc.b   0
	dc.b   1

unk_8888:
	dc.b $57
	dc.b $A6
	dc.b $71
	dc.b $4B
	dc.b $C6
	dc.b $19

unk_888E:
	dc.b $A7
	dc.b $72
	dc.b $4C
	dc.b $C7
	dc.b $1A
	dc.b   1

byte_8894:
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   0
	dc.b   1
	dc.b   1

unk_889A:
	dc.b $14
	dc.b $3A
	dc.b $38
	dc.b $12
	dc.b $1A
	dc.b   6

unk_88A0:
	dc.b $3B
	dc.b $39
	dc.b $13
	dc.b $1B
	dc.b   7
	dc.b   1

asc_88A6:    ; DATA XREF: ROM:00008F18o
	dc.b '___________', 0
	dc.b 0
	dc.b 0
	dc.b 0
	dc.b $40

asc_88B6:    ; DATA XREF: ROM:00008F6Eo
	dc.b 'SEGA_CD_ROM', 0
	dc.b 1
	dc.b 0
	dc.b 0
	dc.b 0

asc_88C6:
	dc.b 'RAM_CARTRIDGE___'

off_88D6:   dc.l unk_600000     ; DATA XREF: sub_98B2+38r sub_9922+Cr
off_88DA:   dc.l unk_7FFFFF     ; DATA XREF: ROM:00008F10r sub_9922+4r

sub_88DE:
	move.l off_88EC(pc), 2(a0)
	move.w word_88EA(pc), (a0)
	rts

word_88EA:
	dc.w INST_JMP

off_88EC:
	dc.l sub_88F0

; =============== S U B R O U T I N E =======================================


sub_88F0:
	movem.l a2/a5, -(sp)

	movea.l #$FFFFFE80, a5
	add.w d0, d0
	add.w d0, d0
	jsr loc_8910(pc, d0.w)

	movea.l off_88DA(pc), a2
	bclr #0, (a2)

	movem.l (sp)+, a2/a5
	rts
; End of function sub_88F0

; ---------------------------------------------------------------------------

loc_8910:
	bra.w sub_897C
; ---------------------------------------------------------------------------
	bra.w sub_8AFC
; ---------------------------------------------------------------------------
	bra.w sub_8B3C
; ---------------------------------------------------------------------------
	bra.w sub_8C36
; ---------------------------------------------------------------------------
	bra.w sub_8C9A
; ---------------------------------------------------------------------------
	bra.w sub_8DD8
; ---------------------------------------------------------------------------
	bra.w sub_8EFC
; ---------------------------------------------------------------------------
	bra.w sub_8F92
; ---------------------------------------------------------------------------
	bra.w sub_8BB6
; ---------------------------------------------------------------------------
	bra.w sub_893C
; ---------------------------------------------------------------------------
	bra.w sub_894C
; ---------------------------------------------------------------------------


; =============== S U B R O U T I N E =======================================


sub_893C:
	movea.l off_88D6(pc), a1
	move.w #$40, d1
	exg a0, a1
	bsr.w sub_94FC
	rts
; End of function sub_893C


; =============== S U B R O U T I N E =======================================


sub_894C:
	movem.l a2/a3, -(sp)

	movea.l off_88DA(pc), a2
	bset #0, (a2)
	movea.l a0, a3

	movea.l off_88D6(pc), a1
	movea.l a1, a2
	move.w #$40, d1
	exg a0, a1
	bsr.w sub_965A

	movep.l 0(a2), d0
	cmp.l (a3), d0
	beq.s @locret_8976

	move.w #1, ccr

@locret_8976:
	movem.l (sp)+, a2/a3
	rts
; End of function sub_894C


; =============== S U B R O U T I N E =======================================


sub_897C:
	movem.l d2/a2-a4, -(sp)
	movem.l a1, -(sp)

	move.l a0, 0(a5)

	lea $200(a0), a0
	move.l a0, 4(a5)

	lea $40(a0), a0
	move.l a0, 8(a5)

	lea $100(a0), a0
	move.l a0, $C(a5)

	lea $100(a0), a0
	move.l a0, $10(a5)

	lea $40(a0), a0
	move.l a0, $14(a5)

	lea $40(a0), a0
	move.l a0, $18(a5)

	lea $100(a0), a0
	move.l a0, $5A(a5)

	lea $40(a0), a0
	move.l a0, $6A(a5)

	movea.l 0(a5), a0
	bsr.w sub_920C

	move.l #$80100, d2
	movea.l $18(a5), a0

	lea byte_8880(pc), a1
	movea.l 8(a5), a3
	movea.l $C(a5), a4
	bsr.w sub_9234

	move.l #$60040, d2
	movea.l $18(a5), a0

	lea byte_8894(pc), a1
	movea.l $10(a5), a3
	movea.l $14(a5), a4
	bsr.w sub_9234

	clr.l $30(a5)
	clr.l $34(a5)
	clr.l $66(a5)

	movem.l (sp)+, a1

	bsr.w sub_98B2
	bcs.w loc_8AAA

	movea.l a1, a2
	movea.l $5A(a5), a1
	movea.l $38(a5), a0

	lea $60(a0), a0

	move.w #$10, d1
	bsr.w sub_94FC

	movea.l a2, a1
	movea.l $5A(a5), a2

	lea asc_88C6(pc), a0

	cmpm.l (a0)+, (a2)+
	beq.s @loc_8A4A

	cmpm.l (a0)+, (a2)+
	beq.s @loc_8A4A

	cmpm.l (a0)+, (a2)+
	bne.w loc_8AA4

@loc_8A4A:
	movea.l a1, a2
	movea.l $38(a5), a0

	lea $40(a0), a0
	move.w #$C, d1
	move.w d1, d2
	bsr.w sub_94FC

	movea.l a2, a1
	lea asc_88B6(pc), a2

	move.w d2, d1
	bsr.w sub_9680
	bne.w sub_8AC4

	move.l $30(a5), d0
	asr.l #8, d0
	asr.l #5, d0

	move.w #0, ccr

loc_8A7A:
	movem.l (sp)+, d2/a2-a4
	rts
; End of function sub_897C


; =============== S U B R O U T I N E =======================================


sub_8A80:
	movea.l a1, a2
	move.w d1, d2
	add.w d2, d2
	add.w d2, d2

	lea dword_8ADC(pc), a1
	movea.l 0(a1, d2.w), a1
	move.w d1, d2
	move.w #$D, d1
	bsr.w sub_96B6

	movea.l a2, a1
	move.w d2, d1

loc_8A9E:
	move.w #1, ccr
	bra.s loc_8A7A

loc_8AA4:
	bsr.w sub_9922
	bcc.s loc_8AB4

loc_8AAA:
	moveq #0, d0
	move.w #0, d1
	bra.w sub_8A80

loc_8AB4:
	move.w #1, d1
	move.l $30(a5), d0
	asr.l #8, d0
	asr.l #5, d0
	bra.w sub_8A80
; End of function sub_8A80

sub_8AC4:
	move.w #$B, d1
	bsr.w sub_9968
	bcs.s loc_8AB4

	move.l $30(a5), d0
	asr.l #8, d0
	asr.l #5, d0
	move.w #2, d1
	bra.s loc_8A9E

dword_8ADC:
	dc.l $8AE4
	dc.l $8AF0
	dc.b 'NOT_EXIST__',0
	dc.b 'UNFORMAT___',0

; =============== S U B R O U T I N E =======================================


sub_8AFC:
	movem.l d2-d3/a2, -(sp)

	moveq #0, d0
	bsr.w sub_985A
	bcs.s loc_8B2E

	move.w d0, d3
	bsr.w sub_9886
	bcs.s loc_8B2E

	tst.w d0
	bge.s loc_8B16

	moveq #0, d0

loc_8B16:
	movea.l a1, a2

	lea asc_88B6(pc), a1
	move.w #$C, d1
	bsr.w sub_96B6

	movea.l a2, a1
	move.w d3, d1

loc_8B28:
	movem.l (sp)+, d2-d3/a2
	rts

loc_8B2E:
	move.w #$FFFF, d0
	move.w #$FFFF, d1
	move.w #1, ccr
	bra.s loc_8B28
; End of function sub_8AFC


; =============== S U B R O U T I N E =======================================


sub_8B3C:
	movem.l d2-d3/a2-a4/a6, -(sp)

	movea.l a0, a3
	bsr.w sub_985A

	move.w d0, d1
	ble.s @loc_8BB0

	movea.l $38(a5), a0

	subq.w #1, d1
	@loc_8B50:
		suba.l #$40, a0
		dbf d1, @loc_8B50

	move.w d0, d2
	subq.w #1, d2

	movea.l $5A(a5), a2
	lea $1C(a5), a6
	move.l (a6), d3
	clr.l (a6)

	@loc_8B6A:
		movea.l a2, a1
		move.w #$20, d1
		bsr.w sub_93B4
		bcs.s @loc_8B82

		move.w #$B, d1
		movea.l a3, a1
		bsr.w sub_9680
		beq.s @loc_8B8A

	@loc_8B82:
		move.l d3, (a6)
		dbf d2, @loc_8B6A

	bra.s @loc_8BB0

@loc_8B8A:
	movea.l off_88D6(pc), a0

	move.w $C(a2), d2
	ble.w @loc_8BB0

	subq.w #1, d2
	@loc_8B98:
		adda.l #$80, a0
		dbf d2, @loc_8B98

	move.b $B(a2), d1
	move.w $E(a2), d0

@loc_8BAA:
	movem.l (sp)+, d2-d3/a2-a4/a6
	rts

@loc_8BB0:
	move.w #1, ccr
	bra.s @loc_8BAA
; End of function sub_8B3C


; =============== S U B R O U T I N E =======================================


sub_8BB6:
	movem.l d2/a3/a6, -(sp)
	movea.l a1, a2
	bsr.w sub_8B3C
	bcs.w @loc_8C26

	tst.b d1
	beq.w @loc_8BF8

	lea $1C(a5), a6
	clr.l (a6)
	subq.w #1, d0
	move.w d0, d2
	movea.l $5A(a5), a3

	@loc_8BD8:
		movea.l a3, a1
		move.w #$40, d1
		bsr.w sub_93B4

		movea.l a3, a1
		move.w #$20, d1
		bsr.w sub_9680
		bne.w @loc_8C2C

		adda.w d1, a2
		dbf d0, @loc_8BD8

	bra.s @loc_8C1C

@loc_8BF8:
	movea.l $5A(a5), a3
	subq.w #1, d0

	@loc_8BFE:
		move.w #$40, d1
		movea.l a3, a1
		bsr.w sub_94FC

		move.w #$40, d1
		movea.l a3, a1
		bsr.w sub_9680
		bne.s @loc_8C2C

		adda.w #$40, a2
		dbf d0, @loc_8BFE

@loc_8C1C:
	move.w #0, ccr

@loc_8C20:
	movem.l (sp)+, d2/a3/a6
	rts

@loc_8C26:
	move.w #0, d0
	bra.s @loc_8C30

@loc_8C2C:
	move.w #$FFFF, d0

@loc_8C30:
	move.w #1, ccr
	bra.s @loc_8C20
; End of function sub_8BB6


; =============== S U B R O U T I N E =======================================


sub_8C36:
	movem.l d2/a6, -(sp)

	movem.l a1, -(sp)
	bsr.w sub_8B3C
	movem.l (sp)+, a1

	movem.w d0-d1, -(sp)
	bcs.w @loc_8C94

	tst.b d1
	beq.w @loc_8C78

	lea $1C(a5), a6
	clr.l (a6)

	subq.w #1, d0
	move.w d0, d2
	@loc_8C5E:
		move.w #$40, d1
		bsr.w sub_93B4
		dbf d0, @loc_8C5E

	lea $1C(a5), a0
	btst #7, 0(a0)
	beq.s @loc_8C86
	bra.s @loc_8C94

@loc_8C78:
	subq.w #1, d0
	@loc_8C7A:
		move.w #$40, d1
		bsr.w sub_94FC
		dbf d0, @loc_8C7A

@loc_8C86:
	move.w #0, ccr

@loc_8C8A:
	movem.w (sp)+, d0-d1
	movem.l (sp)+, d2/a6
	rts

@loc_8C94:
	move.w #1, ccr
	bra.s @loc_8C8A
; End of function sub_8C36


; =============== S U B R O U T I N E =======================================


sub_8C9A:
	movem.l d2-d7/a2-a4/a6, -(sp)
	movea.l off_88DA,a2
	bset    #0,(a2)
	move.l  a0,$42(a5)
	move.l  a1,$46(a5)
	bsr.w   sub_9886
	bcs.w   @loc_8DD2
	move.w  d0,d5
	bsr.w   sub_8B3C
	bcs.s   @loc_8CD2
	add.w   d0,d5
	movea.l $42(a5),a0
	cmp.w   $C(a0),d5
	blt.w   @loc_8DD2
	bsr.w   sub_8DD8
	bra.s   @loc_8CDE
; ---------------------------------------------------------------------------

@loc_8CD2:
	movea.l $42(a5),a0
	cmp.w   $C(a0),d5
	blt.w   @loc_8DD2

@loc_8CDE:
	bsr.w   sub_985A
	bcs.w   @loc_8DD2
	movea.l $38(a5),a0
	move.w  d0,d1
	bgt.s   @loc_8CF2
	moveq   #1,d6
	bra.s   @loc_8D1E
; ---------------------------------------------------------------------------

@loc_8CF2:
	subq.w  #1,d1

@loc_8CF4:
	suba.l  #$40,a0 ; '@'
	dbf     d1,@loc_8CF4
	movea.l $5A(a5),a1
	lea     $1C(a5),a6
	clr.l   (a6)
	movea.l a1,a2
	move.w  #$20,d1 ; ' '
	bsr.w   sub_93B4
	bcs.w   @loc_8DD2
	move.w  $C(a2),d6
	add.w   $E(a2),d6

@loc_8D1E:
	movea.l off_88D6,a0
	move.w  d6,d2
	ble.s   @loc_8D32
	subq.w  #1,d2

@loc_8D28:
	adda.l  #$80,a0 ; '├ç'
	dbf     d2,@loc_8D28

@loc_8D32:
	movea.l $42(a5),a2
	movea.l $46(a5),a1
	move.w  $C(a2),d0
	ble.w   @loc_8DD2
	tst.b   $B(a2)
	beq.w   @loc_8D5E
	subq.w  #1,d0
	move.w  #$40,d1 ; '@'

@loc_8D50:
	bsr.w   sub_9522
	bcs.w   @loc_8DD2
	dbf     d0,@loc_8D50
	bra.s   @loc_8D6C
; ---------------------------------------------------------------------------

@loc_8D5E:
	subq.w  #1,d0

@loc_8D60:
	move.w  #$40,d1 ; '@'
	bsr.w   sub_965A
	dbf     d0,@loc_8D60

@loc_8D6C:
	bsr.w   sub_985A
	bcs.w   @loc_8DD2
	addq.w  #1,d0
	movea.l $38(a5),a0
	move.w  d0,d1
	subq.w  #1,d1

@loc_8D7E:
	suba.l  #$40,a0 ; '@'
	dbf     d1,@loc_8D7E
	movea.l $42(a5),a1
	lea     $4A(a5),a2
	lea     0(a1),a1
	lea     0(a2),a2
	move.w  #$B,d1
	bsr.w   sub_96B6
	movea.l $42(a5),a2
	lea     $4A(a5),a1
	move.b  $B(a2),$B(a1)
	move.w  d6,$C(a1)
	move.w  $C(a2),$E(a1)
	move.w  #$20,d1 ; ' '
	bsr.w   sub_9522
	bcs.s   @loc_8DD2
	lea     $4A(a5),a1
	moveq   #0,d0
	bsr.w   sub_96F2

@loc_8DCC:
	movem.l (sp)+, d2-d7/a2-a4/a6
	rts
; ---------------------------------------------------------------------------

@loc_8DD2:
	move.w #1, ccr
	bra.s @loc_8DCC
; End of function sub_8C9A


; =============== S U B R O U T I N E =======================================


sub_8DD8:
	movem.l d2-d4/a2-a6, -(sp)
		dc.b $24 ; $
		dc.b $7A ; z
		dc.b $FA ; ├║
		dc.b $FC ; ├╝
		dc.b   8
		dc.b $D2 ; ├Æ
		dc.b   0
		dc.b   0
		dc.b $26 ; &
		dc.b $48 ; H
		dc.b $61 ; a
		dc.b   0
		dc.b  $A
		dc.b $72 ; r
		dc.b $4A ; J
		dc.b $40 ; @
		dc.b $6F ; o
		dc.b   0
		dc.b   1
		dc.b   8
		dc.b $20
		dc.b $6D ; m
		dc.b   0
		dc.b $38 ; 8
		dc.b $32 ; 2
		dc.b   0
		dc.b $53 ; S
		dc.b $41 ; A
		dc.b $91 ; ΓÇÿ
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $40 ; @
		dc.b $51 ; Q
		dc.b $C9 ; ├ë
		dc.b $FF
		dc.b $F8 ; ├╕
		dc.b $34 ; 4
		dc.b   0
		dc.b $53 ; S
		dc.b $42 ; B
		dc.b $24 ; $
		dc.b $6D ; m
		dc.b   0
		dc.b $5A ; Z
		dc.b $4D ; M
		dc.b $ED ; ├¡
		dc.b   0
		dc.b $1C
		dc.b $42 ; B
		dc.b $96 ; ΓÇô
		dc.b $22 ; "
		dc.b $4A ; J
		dc.b $32 ; 2
		dc.b $3C ; <
		dc.b   0
		dc.b $20
		dc.b $61 ; a
		dc.b   0
		dc.b   5
		dc.b $9C ; ┼ô
		dc.b $65 ; e
		dc.b  $C
		dc.b $32 ; 2
		dc.b $3C ; <
		dc.b   0
		dc.b  $B
		dc.b $22 ; "
		dc.b $4B ; K
		dc.b $61 ; a
		dc.b   0
		dc.b   8
		dc.b $5C ; \
		dc.b $67 ; g
		dc.b   8
		dc.b $51 ; Q
		dc.b $CA ; ├è
		dc.b $FF
		dc.b $E6 ; ├ª
		dc.b $60 ; `
		dc.b   0
		dc.b   0
		dc.b $C8 ; ├ê
		dc.b $22 ; "
		dc.b $4A ; J
		dc.b $48 ; H
		dc.b $E7 ; ├º
		dc.b $80 ; Γé¼
		dc.b $20
		dc.b $45 ; E
		dc.b $ED ; ├¡
		dc.b   0
		dc.b $4A ; J
		dc.b $32 ; 2
		dc.b $3C ; <
		dc.b   0
		dc.b $10
		dc.b $61 ; a
		dc.b   0
		dc.b   8
		dc.b $76 ; v
		dc.b $4C ; L
		dc.b $DF ; ├ƒ
		dc.b   4
		dc.b   1
		dc.b $36 ; 6
		dc.b   0
		dc.b $96 ; ΓÇô
		dc.b $42 ; B
		dc.b $55 ; U
		dc.b $43 ; C
		dc.b $65 ; e
		dc.b   0
		dc.b   0
		dc.b $96 ; ΓÇô
		dc.b $26 ; &
		dc.b $7A ; z
		dc.b $FA ; ├║
		dc.b $84 ; ΓÇ₧
		dc.b $34 ; 4
		dc.b $2A ; *
		dc.b   0
		dc.b  $C
		dc.b $53 ; S
		dc.b $42 ; B
		dc.b $D7 ; ├ù
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $80 ; Γé¼
		dc.b $51 ; Q
		dc.b $CA ; ├è
		dc.b $FF
		dc.b $F8 ; ├╕
		dc.b $4D ; M
		dc.b $ED ; ├¡
		dc.b   0
		dc.b $1C
		dc.b $42 ; B
		dc.b $96 ; ΓÇô
		dc.b $91 ; ΓÇÿ
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $80 ; Γé¼
		dc.b $22 ; "
		dc.b $4A ; J
		dc.b $32 ; 2
		dc.b $3C ; <
		dc.b   0
		dc.b $20
		dc.b $61 ; a
		dc.b   0
		dc.b   5
		dc.b $3C ; <
		dc.b $65 ; e
		dc.b   0
		dc.b   0
		dc.b $7A ; z
		dc.b $28 ; (
		dc.b $7A ; z
		dc.b $FA ; ├║
		dc.b $56 ; V
		dc.b $34 ; 4
		dc.b $2A ; *
		dc.b   0
		dc.b  $C
		dc.b $53 ; S
		dc.b $42 ; B
		dc.b $D9 ; ├Ö
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b $80 ; Γé¼
		dc.b $51 ; Q
		dc.b $CA ; ├è
		dc.b $FF
		dc.b $F8 ; ├╕
		dc.b $74 ; t
		dc.b   0
		dc.b $34 ; 4
		dc.b $2A ; *
		dc.b   0
		dc.b  $E
		dc.b $C4 ; ├ä
		dc.b $FC ; ├╝
		dc.b   0
		dc.b $40 ; @
		dc.b $D4 ; ├ö
		dc.b $42 ; B
		dc.b $22 ; "
		dc.b  $B
		dc.b $92 ; ΓÇÖ
		dc.b $BA ; ┬║
		dc.b $FA ; ├║
		dc.b $34 ; 4
		dc.b $82 ; ΓÇÜ
		dc.b $FC ; ├╝
		dc.b   0
		dc.b $80 ; Γé¼
		dc.b $48 ; H
		dc.b $41 ; A
		dc.b $4A ; J
		dc.b $41 ; A
		dc.b $67 ; g
		dc.b   6
		dc.b   6
		dc.b $81 ; ┬ü
		dc.b   0
		dc.b   1
		dc.b   0
		dc.b   0
		dc.b $48 ; H
		dc.b $41 ; A
		dc.b $35 ; 5
		dc.b $41 ; A
		dc.b   0
		dc.b  $C
		dc.b $48 ; H
		dc.b $E7 ; ├º
		dc.b   0
		dc.b $80 ; Γé¼
		dc.b $22 ; "
		dc.b $4A ; J
		dc.b $32 ; 2
		dc.b $3C ; <
		dc.b   0
		dc.b $20
		dc.b $61 ; a
		dc.b   0
		dc.b   6
		dc.b $5C ; \
		dc.b $65 ; e
		dc.b $2C ; ,
		dc.b $35 ; 5
		dc.b $44 ; D
		dc.b   0
		dc.b  $C
		dc.b $C7 ; ├ç
		dc.b $4A ; J
		dc.b $22 ; "
		dc.b $4C ; L
		dc.b $32 ; 2
		dc.b   2
		dc.b $61 ; a
		dc.b   0
		dc.b   7
		dc.b $FC ; ├╝
		dc.b $C7 ; ├ç
		dc.b $4A ; J
		dc.b $D6 ; ├û
		dc.b $C2 ; ├é
		dc.b $4C ; L
		dc.b $DF ; ├ƒ
		dc.b   1
		dc.b   0
		dc.b $51 ; Q
		dc.b $CB ; ├ï
		dc.b $FF
		dc.b $88 ; ╦å
		dc.b $10
		dc.b $3C ; <
		dc.b   0
		dc.b   1
		dc.b $43 ; C
		dc.b $ED ; ├¡
		dc.b   0
		dc.b $4A ; J
	bsr.w sub_96F2

@loc_8EF0:
	movem.l (sp)+, d2-d4/a2-a6
	rts

@loc_8EF6:
	move #1, ccr
	bra.s @loc_8EF0
; End of function sub_8DD8


; =============== S U B R O U T I N E =======================================


sub_8EFC:
	movem.l a3,-(sp)
	bsr.w   sub_98B2
	bcs.w   loc_8F8C
	bsr.w   sub_9922
	bcs.w   loc_8F8C
	movea.l off_88DA,a3
	bset    #0,(a3)
	lea asc_88A6,a1 ; "___________"
	movea.l $38(a5),a0
	move.w  #$10,d1
	bsr.w   sub_965A
	moveq   #0,d0
	movea.l $38(a5),a0
	lea $30(a0),a0
	move.w  d0,d0
	move.w  d0,-(sp)
	swap    d0
	move.w  (sp)+,d0
	movea.l a0,a0
	movep.l d0,1(a0)
	adda.l  #8,a0
	movep.l d0,1(a0)
	move.w  $2E(a5),d0
	movea.l $38(a5),a0
	lea $20(a0),a0
	move.w  d0,d0
	move.w  d0,-(sp)
	swap    d0
	move.w  (sp)+,d0
	movea.l a0,a0
	movep.l d0,1(a0)
	adda.l  #8,a0
	movep.l d0,1(a0)
	lea asc_88B6,a1 ; "SEGA_CD_ROM"
	movea.l $38(a5),a0
	lea $40(a0),a0
	move.w  #$20,d1 ; ' '
	bsr.w   sub_965A
	move    #0,ccr

loc_8F86:               ; CODE XREF: ROM:00008F90j
	movem.l (sp)+,a3
	rts
; ---------------------------------------------------------------------------

loc_8F8C:               ; CODE XREF: ROM:00008F04j
				; ROM:00008F0Cj
	move    #1,ccr
	bra.s   loc_8F86
; ---------------------------------------------------------------------------

sub_8F92:
	movem.l d2-d5/a2-a4/a6,-(sp)
	movea.l a1,a4
	move.w  d1,d4
	swap    d1
	move.w  d1,d5
	moveq   #0,d2
	moveq   #$A,d3
	movea.l a0,a2

loc_8FA4:               ; CODE XREF: ROM:00008FACj
	cmpi.b  #$2A,(a2)+ ; '*'
	beq.s   loc_8FB0
	addq.w  #1,d2
	dbf d3,loc_8FA4

loc_8FB0:               ; CODE XREF: ROM:00008FA8j
	movea.l a0,a2
	bsr.w   sub_985A
	move.w  d0,d3
	ble.w   loc_9012
	subq.w  #1,d3
	movea.l $38(a5),a0
	suba.l  #$40,a0 ; '@'
	movea.l $5A(a5),a1
	lea $1C(a5),a6
	clr.l   (a6)
	movea.l a1,a3

loc_8FD4:               ; CODE XREF: ROM:loc_900Ej
	tst.w   d4
	ble.s   loc_901C
	move.w  #$20,d1 ; ' '
	bsr.w   sub_93B4
	movea.l a3,a1
	move.w  d2,d1
	beq.s   loc_8FEC
	bsr.w   sub_9680
	bne.s   loc_900A

loc_8FEC:               ; CODE XREF: ROM:00008FE4j
	tst.w   d5
	ble.s   loc_8FF4
	subq.w  #1,d5
	bra.s   loc_9004
; ---------------------------------------------------------------------------

loc_8FF4:               ; CODE XREF: ROM:00008FEEj
	move.w  #$10,d1
	exg a2,a4
	bsr.w   sub_96B6
	exg a2,a4
	adda.w  d1,a4
	subq.w  #1,d4

loc_9004:               ; CODE XREF: ROM:00008FF2j
	cmpi.w  #$B,d2
	beq.s   loc_9012

loc_900A:               ; CODE XREF: ROM:00008FEAj
	suba.w  #$80,a0 ; 'Γé¼'

loc_900E:
	dbf d3,loc_8FD4

loc_9012:               ; CODE XREF: ROM:00008FB8j
				; ROM:00009008j
	move    #0,ccr

loc_9016:               ; CODE XREF: ROM:00009020j
	movem.l (sp)+,d2-d5/a2-a4/a6
	rts
; ---------------------------------------------------------------------------

loc_901C:               ; CODE XREF: ROM:00008FD6j
	move    #1,ccr
	bra.s   loc_9016
; ---------------------------------------------------------------------------
sub_9022:
	movem.l d2/d7,-(sp)
	move.w  d2,-(sp)
	move.w  d1,d0
	move.w  #$10,d2
	move.w  #$1F,d7
	bsr.s   sub_905C
	move.w  #1,d7
	movea.l sp,a0
	bsr.s   sub_905C
	addq.w  #2,sp

loc_903E:               ; CODE XREF: ROM:00009040j
	bsr.s   sub_9050
	bhi.s   loc_903E
	clr.l   (a1)+
	clr.l   (a1)+
	clr.l   (a1)+
	clr.l   (a1)+
	movem.l (sp)+,d2/d7
	rts

; =============== S U B R O U T I N E =======================================


sub_9050:               ; CODE XREF: ROM:loc_903Ep sub_905Cp
	move.w  d0,d1
	lsr.w   #8,d1
	move.b  d1,(a1)+
	lsl.w   #6,d0
	subq.w  #6,d2
	rts
; End of function sub_9050


; =============== S U B R O U T I N E =======================================


sub_905C:               ; CODE XREF: ROM:00009032p
				; ROM:0000903Ap ...
	bsr.s   sub_9050
	cmpi.w  #8,d2
	bcc.s   sub_905C
	moveq   #8,d1
	sub.w   d2,d1
	lsr.w   d1,d0
	move.b  (a0)+,d0
	lsl.w   d1,d0
	addq.w  #8,d2
	subq.w  #1,d7
	bcc.s   sub_905C
	rts
; End of function sub_905C


; =============== S U B R O U T I N E =======================================


sub_9076:               ; CODE XREF: sub_93B4+C0p
	movem.l d2/d7,-(sp)
	move.b  (a1)+,d0
	lsl.w   #6,d0
	move.b  (a1)+,d0
	lsl.w   #2,d0
	move.w  d0,$2A(a5)
	lsl.w   #4,d0
	move.b  (a1)+,d0
	ror.w   #4,d0
	move.b  d0,$2B(a5)
	move.w  #$2A,d7 ; '*'
	moveq   #2,d2
	bsr.s   sub_90C0
	bsr.s   sub_90B4
	lsr.w   #4,d0
	move.b  (a1)+,d0
	lsl.w   #4,d0
	move.w  d0,$2C(a5)
	lsl.w   #2,d0
	move.b  (a1)+,d0
	lsr.w   #2,d0
	move.b  d0,$2D(a5)
	movem.l (sp)+,d2/d7
	rts
; End of function sub_9076


; =============== S U B R O U T I N E =======================================


sub_90B4:               ; CODE XREF: sub_9076+22p
				; sub_90C0:loc_90C2p
	move.w  d0,d1
	lsr.w   #8,d1
	move.b  d1,(a0)+
	lsl.w   #8,d0
	subq.w  #8,d2
	rts
; End of function sub_90B4


; =============== S U B R O U T I N E =======================================


sub_90C0:               ; CODE XREF: sub_9076+20p
	bra.s   loc_90C4
; ---------------------------------------------------------------------------

loc_90C2:               ; CODE XREF: sub_90C0+8j
	bsr.s   sub_90B4

loc_90C4:               ; CODE XREF: sub_90C0j sub_90C0+1Aj
	cmpi.w  #8,d2
	bhi.s   loc_90C2
	move.w  #8,d1
	sub.w   d2,d1
	lsr.w   d1,d0
	move.b  (a1)+,d0
	lsl.w   d1,d0
	addq.w  #6,d2
	subq.w  #1,d7
	bcc.s   loc_90C4
	rts
; End of function sub_90C0


; =============== S U B R O U T I N E =======================================


sub_90DE:               ; CODE XREF: sub_93B4+62p
	movem.l d6-d7,-(sp)
	movea.l 4(a5),a0
	adda.w  d0,a0
	lea $20(a5),a1
	moveq   #7,d7

loc_90EE:               ; CODE XREF: sub_90DE+2Aj
	movem.l a1,-(sp)
	move.b  (a0),d0
	moveq   #7,d6

loc_90F6:               ; CODE XREF: sub_90DE:loc_90FEj
	move.b  (a1),d1
	lsl.b   #1,d0
	roxl.b  #1,d1
	move.b  d1,(a1)+

loc_90FE:
	dbf d6,loc_90F6
	movem.l (sp)+,a1
	addq.w  #8,a0
	dbf d7,loc_90EE
	movem.l (sp)+,d6-d7
	rts
; End of function sub_90DE


; =============== S U B R O U T I N E =======================================


sub_9112:               ; CODE XREF: sub_93B4+6Cp
	movem.l d6-d7,-(sp)
	movea.l 4(a5),a0
	adda.w  d0,a0
	lea $20(a5),a1
	moveq   #7,d7

loc_9122:               ; CODE XREF: sub_9112+2Aj
	movem.l a0,-(sp)
	move.b  (a1)+,d0
	moveq   #7,d6

loc_912A:               ; CODE XREF: sub_9112+22j
	move.b  (a0),d1
	lsl.b   #1,d0
	roxl.b  #1,d1
	move.b  d1,(a0)
	addq.w  #8,a0
	dbf d6,loc_912A
	movem.l (sp)+,a0
	dbf d7,loc_9122
	movem.l (sp)+,d6-d7
	rts
; End of function sub_9112


; =============== S U B R O U T I N E =======================================


sub_9146:               ; CODE XREF: sub_93B4+98p
	movea.l 4(a5),a0
	lea $20(a5),a1
	movem.l d0/a0,-(sp)
	adda.w  d0,a0
	moveq   #4,d1

loc_9156:               ; CODE XREF: sub_9146+18j
	move.b  (a0)+,d0
	lsr.b   #2,d0
	move.b  d0,(a1)+
	addq.w  #8,a0
	dbf d1,loc_9156
	movem.l (sp)+,d0/a0
	moveq   #0,d1
	move.b  loc_9186(pc,d0.w),d1
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
; End of function sub_9146

; ---------------------------------------------------------------------------

loc_9186:
	move.l  $2F08(a6),-(a6)
	move.b  (a2)+,-(a0)

loc_918C:               ; CODE XREF: sub_93B4+A2p
	move.l  $206D(a4),-(a1)
	dc.w $4
	dc.w $43ED
	dc.w $20
	dc.w $48E7
	or.l    d0,d0
	adda.w  d0,a0
	moveq   #4,d1

loc_919E:               ; CODE XREF: ROM:000091A6j
	move.b  (a1)+,d0
	lsl.b   #2,d0
	move.b  d0,(a0)+
	addq.w  #8,a0
	dbf d1,loc_919E
	movem.l (sp)+,d0/a0
	move.w  d0,-(sp)
	moveq   #0,d1
	move.b  loc_9186(pc,d0.w),d1
	move.b  (a1)+,d0
	lsl.b   #2,d0
	move.b  d0,(a0,d1.w)
	move.w  (sp)+,d0

sub_91C0:
	movea.l 4(a5),a0
	move.b  $26(a5),d1
	lsl.b   #2,d1
	move.b  d1,$30(a0,d0.w)
	move.b  $27(a5),d1
	lsl.b   #2,d1
	move.b  d1,$38(a0,d0.w)
	rts

; =============== S U B R O U T I N E =======================================


sub_91DA:               ; CODE XREF: sub_93B4+C6p
	movem.l d7/a2,-(sp)
	movea.l 0(a5),a2
	moveq   #0,d1
	moveq   #$1F,d7

loc_91E6:               ; CODE XREF: sub_91DA+10j
	move.b  (a0)+,d0
	bsr.s   sub_91F8
	dbf d7,loc_91E6
	move.w  d1,d2
	not.w   d2
	movem.l (sp)+,d7/a2
	rts
; End of function sub_91DA


; =============== S U B R O U T I N E =======================================


sub_91F8:               ; CODE XREF: sub_91DA+Ep
	rol.w   #8,d1
	clr.w   d2
	move.b  d0,d2
	eor.b   d1,d2

loc_9200:
	add.w   d2,d2
	clr.b   d1
	move.w  (a2,d2.w),d2
	eor.w   d2,d1
	rts
; End of function sub_91F8


; =============== S U B R O U T I N E =======================================


sub_920C:
	movem.l d7, -(sp)
	moveq   #0, d7

	@loc_9212:
		move.w  d7, d0
		lsl.w   #8, d0

		moveq   #7, d1
		@loc_9218:
			lsl.w  #1, d0
			bcc.s  @loc_9220

			eori.w #$1021, d0

		@loc_9220:
			dbf d1, @loc_9218

		move.w  d0, (a0)+
		addq.w  #1, d7
		cmpi.w  #$100, d7
		bcs.s   @loc_9212

	movem.l (sp)+, d7
	rts
; End of function sub_920C


; =============== S U B R O U T I N E =======================================


sub_9234:
	movem.l d6-d7,-(sp)
	swap    d2
	moveq   #0,d7
	move.b  d7,(a3)
	move.b  d7,(a0)
	move.b  d7,(a4)
	moveq   #1,d0
	moveq   #1,d7

loc_9246:               ; CODE XREF: ROM:00009258j
	move.b  d0,(a3,d7.w)
	move.b  d0,(a0,d7.w)
	lsl.b   #1,d0
	move.b  d7,(a4,d7.w)
	addq.w  #1,d7
	cmp.w   d7,d2
	bcc.s   loc_9246
	swap    d2

loc_925C:               ; CODE XREF: ROM:00009290j
	clr.b   (a3,d7.w)
	swap    d2
	moveq   #0,d6

loc_9264:               ; CODE XREF: ROM:0000927Ej
	moveq   #0,d0
	tst.b   (a1,d6.w)
	beq.s   loc_927A
	move.w  d7,d1
	sub.w   d6,d1
	subq.w  #1,d1
	move.b  (a3,d1.w),d0
	eor.b   d0,(a3,d7.w)

loc_927A:               ; CODE XREF: ROM:0000926Aj
	addq.w  #1,d6
	cmp.w   d2,d6
	bcs.s   loc_9264
	swap    d2
	move.b  (a3,d7.w),(a0,d7.w)
	move.b  d7,(a4,d7.w)
	addq.w  #1,d7
	cmp.w   d2,d7
	bcs.s   loc_925C
	move.w  d2,d1
	subq.w  #1,d1
	moveq   #0,d7

loc_9298:               ; CODE XREF: ROM:000092C8j
	move.w  d7,d6
	addq.w  #1,d6

loc_929C:               ; CODE XREF: ROM:000092C2j
	move.b  (a0,d7.w),d0
	cmp.b   (a0,d6.w),d0
	bcs.s   loc_92BE
	move.b  (a0,d6.w),(a0,d7.w)
	move.b  d0,(a0,d6.w)
	move.b  (a4,d7.w),d0
	move.b  (a4,d6.w),(a4,d7.w)
	move.b  d0,(a4,d6.w)

loc_92BE:               ; CODE XREF: ROM:000092A4j
	addq.w  #1,d6
	cmp.w   d2,d6
	bcs.s   loc_929C
	addq.w  #1,d7
	cmp.w   d1,d7
	bcs.s   loc_9298
	movem.l (sp)+,d6-d7
	rts
; ---------------------------------------------------------------------------
sub_92D0:
	movem.l d2/d7,-(sp)
	lea $20(a5),a0
	clr.w   $26(a5)
	subq.w  #1,d2
	moveq   #0,d7

loc_92E0:               ; CODE XREF: ROM:00009308j
	moveq   #0,d0
	moveq   #0,d1
	move.b  (a0,d7.w),d0
	tst.w   d0
	beq.s   loc_9302
	move.b  (a4,d0.w),d1
	subq.w  #1,d1
	bsr.s   sub_9310
	eor.b   d0,$26(a5)
	dc.w $C549
	bsr.s   sub_9310
	eor.b   d0,$27(a5)
	dc.w $C549

loc_9302:               ; CODE XREF: ROM:000092EAj
	addq.w  #1,d7
	cmpi.w  #6,d7
	bcs.s   loc_92E0
	movem.l (sp)+,d2/d7
	rts

; =============== S U B R O U T I N E =======================================


sub_9310:               ; CODE XREF: ROM:000092F2p
				; ROM:000092FAp
	move.b  (a1,d7.w),d0
	add.w   d1,d0
	bra.s   loc_931A
; ---------------------------------------------------------------------------

loc_9318:               ; CODE XREF: sub_9310+Cj
	sub.w   d2,d0

loc_931A:               ; CODE XREF: sub_9310+6j
	cmp.w   d2,d0
	bcc.s   loc_9318
	addq.w  #1,d0
	move.b  (a3,d0.w),d0
	rts
; End of function sub_9310


; =============== S U B R O U T I N E =======================================


sub_9326:               ; CODE XREF: sub_93B4+66p sub_93B4+9Cp
	movem.l d2/d7,-(sp)
	lea $20(a5),a0
	subq.w  #1,d2
	clr.w   $28(a5)
	moveq   #0,d7

loc_9336:               ; CODE XREF: sub_9326+3Ej
	moveq   #0,d0
	move.b  (a0,d7.w),d0
	eor.b   d0,$28(a5)
	tst.b   d0
	beq.s   loc_935E
	move.b  (a4,d0.w),d0
	addq.w  #6,d0
	sub.w   d7,d0
	bra.s   loc_9350
; ---------------------------------------------------------------------------

loc_934E:               ; CODE XREF: sub_9326+2Cj
	sub.w   d2,d0

loc_9350:               ; CODE XREF: sub_9326+26j
	cmp.w   d2,d0
	bcc.s   loc_934E
	addq.w  #1,d0
	move.b  (a3,d0.w),d0
	eor.b   d0,$29(a5)

loc_935E:               ; CODE XREF: sub_9326+1Cj
	addq.w  #1,d7
	cmpi.w  #8,d7
	bcs.s   loc_9336
	tst.w   $28(a5)
	beq.s   loc_93AE
	moveq   #0,d1
	move.w  d2,d0
	move.b  $29(a5),d1
	move.b  (a4,d1.w),d1
	add.w   d1,d0
	move.b  $28(a5),d1
	move.b  (a4,d1.w),d1
	sub.w   d1,d0
	bra.s   loc_9388
; ---------------------------------------------------------------------------

loc_9386:               ; CODE XREF: sub_9326+64j
	sub.w   d2,d0

loc_9388:               ; CODE XREF: sub_9326+5Ej
	cmp.w   d2,d0
	bcc.s   loc_9386
	cmpi.w  #8,d0
	bcc.s   loc_93AA
	moveq   #7,d1
	sub.w   d0,d1
	move.b  $28(a5),d0
	eor.b   d0,(a0,d1.w)
	bset    #3,0(a6)
	addq.b  #1,$6F(a5)
	bra.s   loc_93AE
; ---------------------------------------------------------------------------

loc_93AA:               ; CODE XREF: sub_9326+6Aj
	bset    #4,(a6)

loc_93AE:               ; CODE XREF: sub_9326+44j sub_9326+82j
	movem.l (sp)+,d2/d7
	rts
; End of function sub_9326


; =============== S U B R O U T I N E =======================================


sub_93B4:               ; CODE XREF: ROM:00008FDCp
	movem.l d0-d3/d7/a2-a4,-(sp)
	movem.l d1/a0-a1,-(sp)
	moveq   #0,d0
	move.w  a0,d0
	move.l  a0,d2
	move.w  #0,d2
	divu.w  #$80,d0 ; 'Γé¼'
	mulu.w  #$80,d0 ; 'Γé¼'
	add.w   d0,d2
	movea.l d2,a0
	cmpa.l  $66(a5),a0
	beq.w   loc_94C4
	move.l  a0,$66(a5)
	movea.l a0,a1
	movea.l $6A(a5),a0
	clr.b   $6E(a5)
	move.l  a0,-(sp)
	movea.l 4(a5),a0
	move.w  #$40,d1 ; '@'
	exg a0,a1
	bsr.w   sub_94FC
	exg a0,a1
	movea.l (sp)+,a0
	move.l  a1,-(sp)
	move.l  a0,-(sp)
	move.w  #$100,d2
	movea.l 8(a5),a3
	movea.l $C(a5),a4
	clr.b   $6F(a5)
	moveq   #7,d7
	moveq   #0,d3

loc_9414:               ; CODE XREF: sub_93B4+72j
	move.w  d3,d0
	bsr.w   sub_90DE
	bsr.w   sub_9326
	move.w  d3,d0
	bsr.w   sub_9112
	addq.w  #1,d3
	dbf d7,loc_9414
	tst.b   $6F(a5)
	beq.s   loc_9436
	move.b  $6F(a5),1(a6)

loc_9436:               ; CODE XREF: sub_93B4+7Aj
	move.w  #$40,d2 ; '@'
	movea.l $10(a5),a3
	movea.l $14(a5),a4
	clr.b   $6F(a5)
	moveq   #7,d7
	moveq   #0,d3

loc_944A:               ; CODE XREF: sub_93B4+A8j
	move.w  d3,d0
	bsr.w   sub_9146
	bsr.w   sub_9326
	move.w  d3,d0
	bsr.w   loc_918C+2
	addq.w  #1,d3
	dbf d7,loc_944A
	tst.b   $6F(a5)
	beq.s   loc_946C
	move.b  $6F(a5),1(a6)

loc_946C:               ; CODE XREF: sub_93B4+B0j
	movea.l (sp)+,a0
	move.l  a0,-(sp)
	movea.l 4(a5),a1
	bsr.w   sub_9076
	movea.l (sp)+,a0
	bsr.w   sub_91DA
	cmp.w   $2A(a5),d1
	beq.s   loc_9490
	bset    #5,0(a6)
	bset    #5,$6E(a5)

loc_9490:               ; CODE XREF: sub_93B4+CEj
	cmp.w   $2C(a5),d2
	beq.s   loc_94A2
	bset    #6,0(a6)
	bset    #6,$6E(a5)

loc_94A2:               ; CODE XREF: sub_93B4+E0j
	movea.l (sp)+,a1
	btst    #5,$6E(a5)
	beq.s   loc_94C4
	btst    #6,$6E(a5)
	beq.s   loc_94C4
	bset    #7,0(a6)
	bset    #7,$6E(a5)
	addq.w  #1,2(a6)

loc_94C4:               ; CODE XREF: sub_93B4+22j sub_93B4+F6j ...
	movem.l (sp)+,d1/a0-a1
	movea.l a1,a2
	move.w  $68(a5),d3
	move.w  a0,d2
	sub.w   d3,d2
	asr.w   #2,d2
	movea.l $6A(a5),a1
	adda.w  d2,a1
	asr.w   #1,d1
	bsr.w   sub_96B6
	movea.l a2,a1
	adda.w  d1,a1
	add.w   d1,d1
	adda.w  d1,a0
	adda.w  d1,a0
	btst    #7,$6E(a5)
	beq.s   loc_94F6
	move    #1,ccr

loc_94F6:               ; CODE XREF: sub_93B4+13Cj
	movem.l (sp)+,d0-d3/d7/a2-a4
	rts
; End of function sub_93B4


; =============== S U B R O U T I N E =======================================


sub_94FC:               ; CODE XREF: sub_93B4+40p sub_985A+18p
	movem.l d2,-(sp)

loc_9500:               ; CODE XREF: sub_94FC+10j
	subq.w  #4,d1
	blt.s   loc_950E
	movep.l 1(a0),d2
	move.l  d2,(a1)+
	addq.l  #8,a0
	bra.s   loc_9500
; ---------------------------------------------------------------------------

loc_950E:               ; CODE XREF: sub_94FC+6j
	addq.w  #4,d1

loc_9510:               ; CODE XREF: sub_94FC+1Ej
	subq.w  #1,d1
	blt.s   loc_951C
	move.b  1(a0),(a1)+
	addq.l  #2,a0
	bra.s   loc_9510
; ---------------------------------------------------------------------------

loc_951C:               ; CODE XREF: sub_94FC+16j
	movem.l (sp)+,d2
	rts
; End of function sub_94FC


; =============== S U B R O U T I N E =======================================


sub_9522:               ; CODE XREF: sub_8C9A:loc_8D50p
					; sub_8C9A+122p ...
	movem.l d0-d3/d7/a2-a4, -(sp)
	movem.l d1/a0-a1, -(sp)

	cmpi.w  #$40, d1
	bge.w   @loc_95B8

	movem.l d1/a1, -(sp)

	move.l  a0, d2
	move.l  a0, d3

	moveq   #0, d0
	move.w  a0, d0

	move.w  #0, d3
	divu.w  #$80, d0
	mulu.w  #$80, d0
	add.w   d0, d3

	movea.l d3, a0
	sub.l   a0, d2
	asr.l   #2, d2

	move.w  #$40, d1
	movea.l $6A(a5), a1
	movea.l a1, a2
	movea.l a0, a3
	lea     $1C(a5), a6
	move.l  (a6), d3
	clr.l   (a6)
	moveq   #0, d0
	bsr.w   sub_985A

	tst.w   d0
	ble.s   @loc_9590

	divu.w  #2, d0
	move.w  d0, d1
	swap    d0
	tst.w   d0
	beq.s   @loc_957E

	addq.w  #1, d1

@loc_957E:
	mulu.w  #$80, d1
	move.l  $38(a5), d0
	sub.l   d1, d0
	cmp.l   a0, d0
	bgt.s   @loc_9590
	bsr.w   sub_93B4

@loc_9590:
	move.b  0(a6), d0
	move.l  d3, (a6)
	clr.l   $66(a5)
	movem.l (sp)+, d1/a1
	btst    #7, d0
	bne.w   @loc_9654

	adda.w  d2, a2
	add.w   d2, d2
	asr.w   #1, d1
	bsr.w   sub_96B6

	add.w   d1, d1
	movea.l $6A(a5), a1
	movea.l a3, a0

@loc_95B8:
	exg     a0, a1
	move.l  a1, -(sp)
	move.l  a0, -(sp)
	bsr.w   sub_91DA

	movea.l (sp)+, a0
	movea.l 4(a5), a1
	bsr.w   sub_9022

	move.w  #$40, d2
	lea     unk_88A0, a2
	movea.l $10(a5), a3
	movea.l $14(a5), a4

	moveq   #7, d7
	moveq   #0, d3

	@loc_95E0:
		move.w  d3, d0
		bsr.w   sub_9146

		lea     unk_889A, a1
		bsr.w   sub_92D0

		move.w  d3, d0
		bsr.w   sub_91C0

		addq.w  #1, d3
		dbf d7, @loc_95E0

	move.w  #$100, d2
	lea     unk_888E, a2
	movea.l 8(a5), a3
	movea.l $C(a5), a4
	moveq   #7, d7
	moveq   #0, d3

	@loc_960E:
		move.w  d3, d0
		bsr.w   sub_90DE

		lea     unk_8888, a1
		bsr.w   sub_92D0

		move.w  d3, d0
		bsr.w   sub_9112

		addq.w  #1, d3
		dbf d7, @loc_960E

	movea.l (sp)+, a1
	movea.l 4(a5), a0
	move.w  #$40, d1
	exg     a0, a1
	bsr.w   sub_965A

	exg  a0, a1
	move #0, ccr

@loc_963E:
	movem.l (sp)+, d1/a0-a1
	move    sr, -(sp)

	adda.w  d1, a0
	adda.w  d1, a0
	asr.w   #1, d1
	adda.w  d1, a1

	move    (sp)+, sr
	movem.l (sp)+, d0-d3/d7/a2-a4
	rts
; ---------------------------------------------------------------------------

@loc_9654:
	move  #1, ccr
	bra.s @loc_963E
; End of function sub_9522


; =============== S U B R O U T I N E =======================================


sub_965A:               ; CODE XREF: ROM:00008F24p
					; ROM:00008F7Ep
	movem.l d2,-(sp)

loc_965E:               ; CODE XREF: sub_965A+10j
	subq.w  #4,d1
	blt.s   loc_966C
	move.l  (a1)+,d2
	movep.l d2,1(a0)
	addq.l  #8,a0
	bra.s   loc_965E
; ---------------------------------------------------------------------------

loc_966C:               ; CODE XREF: sub_965A+6j
	addq.w  #4,d1

loc_966E:               ; CODE XREF: sub_965A+1Ej
	subq.w  #1,d1
	blt.s   loc_967A
	move.b  (a1)+,1(a0)
	addq.l  #2,a0
	bra.s   loc_966E
; ---------------------------------------------------------------------------

loc_967A:               ; CODE XREF: sub_965A+16j
	movem.l (sp)+,d2
	rts
; End of function sub_965A


; =============== S U B R O U T I N E =======================================


sub_9680:               ; CODE XREF: ROM:00008FE6p
	movem.l d1/a1-a2,-(sp)

loc_9684:               ; CODE XREF: sub_9680+Cj
	subq.w  #4,d1
	blt.s   loc_968E
	cmpm.l  (a1)+,(a2)+
	bne.s   loc_969E
	bra.s   loc_9684
; ---------------------------------------------------------------------------

loc_968E:               ; CODE XREF: sub_9680+6j
	addq.w  #4,d1

loc_9690:               ; CODE XREF: sub_9680+18j
	subq.w  #1,d1
	blt.s   loc_969A
	cmpm.b  (a1)+,(a2)+
	bne.s   loc_969E
	bra.s   loc_9690
; ---------------------------------------------------------------------------

loc_969A:               ; CODE XREF: sub_9680+12j
	move    #4,ccr

loc_969E:               ; CODE XREF: sub_9680+Aj sub_9680+16j
	movem.l (sp)+,d1/a1-a2
	rts
; End of function sub_9680


; =============== S U B R O U T I N E =======================================


sub_96A4:
	movem.l d1/a1-a2, -(sp)

	subq.w #1, d1
	@loc_96AA:
		move.b (a1)+, (a2)+
		dbf d1, @loc_96AA
	movem.l (sp)+, d1/a1-a2

	rts
; End of function sub_96A4


; =============== S U B R O U T I N E =======================================


sub_96B6:               ; CODE XREF: ROM:00008FFAp
					; sub_93B4+128p
	movem.l d1/a1-a2,-(sp)

loc_96BA:               ; CODE XREF: sub_96B6+Aj
	subq.w  #4,d1
	blt.s   loc_96C2
	move.l  (a1)+,(a2)+
	bra.s   loc_96BA
; ---------------------------------------------------------------------------

loc_96C2:               ; CODE XREF: sub_96B6+6j
	addq.w  #4,d1

loc_96C4:               ; CODE XREF: sub_96B6+14j
	subq.w  #1,d1
	blt.s   loc_96CC
	move.b  (a1)+,(a2)+
	bra.s   loc_96C4
; ---------------------------------------------------------------------------

loc_96CC:               ; CODE XREF: sub_96B6+10j
	movem.l (sp)+,d1/a1-a2
	rts
; End of function sub_96B6


; =============== S U B R O U T I N E =======================================


sub_96D2:
	movem.l d1/a1-a2, -(sp)

	adda.l #1, a1
	adda.l #1, a2

	@loc_96E2:
		move.b (a1), (a2)
		addq.w #2, a1
		addq.w #2, a2

		subq.w #2, d1
		bgt.s @loc_96E2

	movem.l (sp)+, d1/a1-a2
	rts
; End of function sub_96D2


; =============== S U B R O U T I N E =======================================


sub_96F2:
	movem.l d0-d4/a0-a2, -(sp)
		dc.b $4A ; J
		dc.b   0
		dc.b $67 ; g
		dc.b   0
		dc.b   0
		dc.b $76 ; v
		dc.b $76 ; v
		dc.b   0
		dc.b $61 ; a
		dc.b   0
		dc.b   1
		dc.b $5A ; Z
		dc.b $65 ; e
		dc.b   0
		dc.b   0
		dc.b $E8 ; ├¿
		dc.b $36 ; 6
		dc.b   0
		dc.b $53 ; S
		dc.b $40 ; @
		dc.b $20
		dc.b $6D ; m
		dc.b   0
		dc.b $38 ; 8
		dc.b $45 ; E
		dc.b $E8 ; ├¿
		dc.b   0
		dc.b $30 ; 0
		dc.b $38 ; 8
		dc.b   0
		dc.b $61 ; a
		dc.b   0
		dc.b   1
		dc.b $70 ; p
		dc.b $65 ; e
		dc.b   0
		dc.b   0
		dc.b $D2 ; ├Æ
		dc.b $86 ; ΓÇá
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   2
		dc.b $48 ; H
		dc.b $43 ; C
		dc.b $4A ; J
		dc.b $43 ; C
		dc.b $66 ; f
		dc.b   2
		dc.b $52 ; R
		dc.b $40 ; @
		dc.b $D0 ; ├É
		dc.b $69 ; i
		dc.b   0
		dc.b  $E
		dc.b $20
		dc.b $6D ; m
		dc.b   0
		dc.b $38 ; 8
		dc.b $41 ; A
		dc.b $E8 ; ├¿
		dc.b   0
		dc.b $20
		dc.b $40 ; @
		dc.b $E7 ; ├º
		dc.b $46 ; F
		dc.b $FC ; ├╝
		dc.b $27 ; '
		dc.b   0
		dc.b $30 ; 0
		dc.b   0
		dc.b $3F ; ?
		dc.b   0
		dc.b $48 ; H
		dc.b $40 ; @
		dc.b $30 ; 0
		dc.b $1F
		dc.b $20
		dc.b $48 ; H
		dc.b   1
		dc.b $C8 ; ├ê
		dc.b   0
		dc.b   1
		dc.b $D1 ; ├æ
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   8
		dc.b   1
		dc.b $C8 ; ├ê
		dc.b   0
		dc.b   1
		dc.b $30 ; 0
		dc.b   4
		dc.b $3F ; ?
		dc.b   4
		dc.b $48 ; H
		dc.b $40 ; @
		dc.b $30 ; 0
		dc.b $1F
		dc.b $20
		dc.b $4A ; J
		dc.b   1
		dc.b $C8 ; ├ê
		dc.b   0
		dc.b   1
		dc.b $D1 ; ├æ
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   8
		dc.b   1
		dc.b $C8 ; ├ê
		dc.b   0
		dc.b   1
		dc.b $46 ; F
		dc.b $DF ; ├ƒ
		dc.b $60 ; `
		dc.b   0
		dc.b   0
		dc.b $74 ; t
		dc.b $76 ; v
		dc.b   0
		dc.b $61 ; a
		dc.b   0
		dc.b   0
		dc.b $E6 ; ├ª
		dc.b $65 ; e
		dc.b   0
		dc.b   0
		dc.b $74 ; t
		dc.b $36 ; 6
		dc.b   0
		dc.b $52 ; R
		dc.b $40 ; @
		dc.b $52 ; R
		dc.b $43 ; C
		dc.b $20
		dc.b $6D ; m
		dc.b   0
		dc.b $38 ; 8
		dc.b $45 ; E
		dc.b $E8 ; ├¿
		dc.b   0
		dc.b $30 ; 0
		dc.b $38 ; 8
		dc.b   0
		dc.b $61 ; a
		dc.b   0
		dc.b   0
		dc.b $FA ; ├║
		dc.b $65 ; e
		dc.b   0
		dc.b   0
		dc.b $5C ; \
		dc.b $86 ; ΓÇá
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   2
		dc.b $48 ; H
		dc.b $43 ; C
		dc.b $4A ; J
		dc.b $43 ; C
		dc.b $66 ; f
		dc.b   2
		dc.b $53 ; S
		dc.b $40 ; @
		dc.b $90 ; ┬É
		dc.b $69 ; i
		dc.b   0
		dc.b  $E
		dc.b $20
		dc.b $6D ; m
		dc.b   0
		dc.b $38 ; 8
		dc.b $41 ; A
		dc.b $E8 ; ├¿
		dc.b   0
		dc.b $20
		dc.b $40 ; @
		dc.b $E7 ; ├º
		dc.b $46 ; F
		dc.b $FC ; ├╝
		dc.b $27 ; '
		dc.b   0
		dc.b $30 ; 0
		dc.b   0
		dc.b $3F ; ?
		dc.b   0
		dc.b $48 ; H
		dc.b $40 ; @
		dc.b $30 ; 0
		dc.b $1F
		dc.b $20
		dc.b $48 ; H
		dc.b   1
		dc.b $C8 ; ├ê
		dc.b   0
		dc.b   1
		dc.b $D1 ; ├æ
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   8
		dc.b   1
		dc.b $C8 ; ├ê
		dc.b   0
		dc.b   1
		dc.b $30 ; 0
		dc.b   4
		dc.b $3F ; ?
		dc.b   4
		dc.b $48 ; H
		dc.b $40 ; @
		dc.b $30 ; 0
		dc.b $1F
		dc.b $20
		dc.b $4A ; J
		dc.b   1
		dc.b $C8 ; ├ê
		dc.b   0
		dc.b   1
		dc.b $D1 ; ├æ
		dc.b $FC ; ├╝
		dc.b   0
		dc.b   0
		dc.b   0
		dc.b   8
		dc.b   1
		dc.b $C8 ; ├ê
		dc.b   0
		dc.b   1
		dc.b $46 ; F
		dc.b $DF ; ├ƒ
	move.w #0, ccr

@loc_97E6:
	movem.l (sp)+, d0-d4/a0-a2
	rts

@loc_97EC:
	move.w #1, ccr
	bra.s @loc_97E6
; End of function sub_96F2


; =============== S U B R O U T I N E =======================================


sub_97F2:               ; CODE XREF: sub_985A+22p
	movem.l d1-d5/a1-a4, -(sp)

	moveq #0, d2
	moveq #1, d3
	moveq #2, d4

	movea.l a1, a2

@loc_97FE:
	movea.l a2, a3

@loc_9800:
	adda.l  #2, a3
	movea.l a3, a4

@loc_9808:
	adda.l #2, a4

	move.w (a3), d0
	cmp.w  (a2), d0
	bne.s  @loc_981E

	move.w (a4), d0
	cmp.w  (a2), d0
	bne.s  @loc_981E

	move.w (a2), d0
	bra.s  @loc_9846
; ---------------------------------------------------------------------------

@loc_981E:
	addq.w #1, d4

	cmp.w  d4, d1
	bgt.w  @loc_9808

	addq.w #1, d3
	move.w d3, d5
	addq.w #1, d5

	cmp.w  d5, d1
	bgt.w  @loc_9800

	adda.l #2, a2
	addq.w #1, d2
	move.w d2, d5
	addq.w #2, d5

	cmp.w  d5, d1
	bgt.w  @loc_97FE
	bra.s  @loc_9850
; ---------------------------------------------------------------------------

@loc_9846:
	move #0, ccr

@loc_984A:
	movem.l (sp)+, d1-d5/a1-a4
	rts
; ---------------------------------------------------------------------------

@loc_9850:
	move.w #$FFFF, d0
	move   #1, ccr
	bra.s  @loc_984A
; End of function sub_97F2


; =============== S U B R O U T I N E =======================================


sub_985A:               ; CODE XREF: ROM:00008FB2p
	movem.l d1-d2/a0-a2, -(sp)

	move.w  #8, d1
	move.w  d1, d2

	movea.l $38(a5), a0
	lea     $30(a0), a0
	lea     $5E(a5), a1
	movea.l a1, a2
	bsr.w   sub_94FC

	move.w  d2, d1
	asr.w   #1, d1
	movea.l a2, a1
	bsr.w   sub_97F2

	movem.l (sp)+, d1-d2/a0-a2
	rts
; End of function sub_985A


; =============== S U B R O U T I N E =======================================


sub_9886:
	movem.l d2/a0-a2, -(sp)

	move.w #8, d1
	move.w d1, d2

	movea.l $38(a5), a0

	lea $20(a0), a0
	lea $5E(a5), a1

	movea.l a1, a2
	bsr.w sub_94FC

	move.w d2, d1
	asr.w #1, d1
	movea.l a2, a1
	bsr.w sub_97F2

@loc_98AC:
	movem.l (sp)+, d2/a0-a2
	rts
; End of function sub_9886


; =============== S U B R O U T I N E =======================================


sub_98B2:               ; CODE XREF: ROM:00008F00p
	movem.l d0-d1,-(sp)
	moveq   #0,d0
	move.b  (byte_400001).l,d0
	btst    #7,d0
	bne.w   loc_991C
	move.l  #$2000,d1
	andi.b  #7,d0

loc_98D0:               ; CODE XREF: sub_98B2+20j
	asl.l   #1,d1
	dbf d0,loc_98D0
	cmp.l   $30(a5),d1
	bne.s   loc_98E2
	cmp.l   $34(a5),d1
	beq.s   loc_9916

loc_98E2:               ; CODE XREF: sub_98B2+28j
	move.l  d1,$30(a5)
	move.l  d1,$34(a5)
	move.l  off_88D6,$3C(a5)
	add.l   d1,$3C(a5)
	move.l  $3C(a5),$38(a5)
	subi.l  #$80,$38(a5) ; 'Γé¼'
	move.w  #$FFFD,$2E(a5)
	asr.l   #1,d1

loc_990A:               ; CODE XREF: sub_98B2+62j
	addq.w  #1,$2E(a5)
	subi.l  #$40,d1 ; '@'
	bgt.s   loc_990A

loc_9916:               ; CODE XREF: sub_98B2+2Ej sub_98B2+6Ej
	movem.l (sp)+,d0-d1
	rts
; ---------------------------------------------------------------------------

loc_991C:               ; CODE XREF: sub_98B2+10j
	move    #1,ccr
	bra.s   loc_9916
; End of function sub_98B2


; =============== S U B R O U T I N E =======================================


sub_9922:               ; CODE XREF: ROM:00008F08p
	movem.l d0/a1-a2,-(sp)
	movea.l off_88DA,a2
	bset    #0,(a2)
	movea.l off_88D6,a1
	adda.l  #1,a1
	move.b  (a1),d0
	move.b  #$5A,(a1) ; 'Z'
	cmpi.b  #$5A,(a1) ; 'Z'
	bne.s   loc_9962
	move.b  #$A5,(a1)
	cmpi.b  #$A5,(a1)
	bne.s   loc_9962
	move.b  d0,(a1)
	move    #0,ccr

loc_9954:               ; CODE XREF: sub_9922+44j
	m_saveStatusRegister
	bclr    #0,(a2)
	m_restoreStatusRegister
	movem.l (sp)+,d0/a1-a2
	rts
; ---------------------------------------------------------------------------

loc_9962:               ; CODE XREF: sub_9922+20j sub_9922+2Aj
	move    #1,ccr
	bra.s   loc_9954
; End of function sub_9922


; =============== S U B R O U T I N E =======================================


sub_9968:
	movem.l d0-d2/a0-a1, -(sp)

	subq.w #1, d1

	@loc_996E:
		move.b (a1)+, d2

		lea word_9998(pc), a0
		move.w (a0)+, d0
		@loc_9976:
			cmp.b (a0)+, d2
			bcs.s @loc_9992

			cmp.b (a0)+, d2
			bls.s @loc_9984

			dbf d0, @loc_9976

		bra.s @loc_9992

	@loc_9984:
		dbf d1, @loc_996E

	move.w #0, ccr

@loc_998C:
	movem.l (sp)+, d0-d2/a0-a1
	rts

@loc_9992:
	move.w #1, ccr
	bra.s @loc_998C
; End of function sub_9968

word_9998:
	dc.w 2
	dc.b '09AZ__'

fill_99A0:
	dcb.b 608, $FF

planet_tiles:
	incbin "tilesets\nemesis_planetscape.bin"

planet_tilemap:
	incbin "tilemaps\enigma_planetscape.bin"

unk_BAAE:
	incbin "misc\nemesis_BAAE.bin"

unk_BAC8:
	incbin "misc\enigma_BAC8.bin"

unk_BAEC:
	incbin "misc\enigma_BAEC.bin"

unk_BB06:
	incbin "misc\enigma_BB06.bin"

dword_BB46:
	incbin "tilesets\tileset_BB46.bin"

dword_D046:
	incbin "tilesets\tileset_D046.bin"

dword_D09E:
	incbin "tilesets\tileset_D09E.bin"
	incbin "tilesets\tileset_D0C6.bin"

dword_E61E:
	incbin "tilesets\tileset_E61E.bin"
	incbin "tilesets\tileset_E69E.bin"

unk_E6A6:
	incbin "misc\nemesis_E6A6.bin"

unk_E7A8:
	incbin "misc\nemesis_E7A8.bin"

unk_E882:
	incbin "misc\nemesis_E882.bin"

unk_E9F2:
	incbin "misc\nemesis_E9F2.bin"

word_EB12:
	incbin "misc\unk_EB12.bin"

dword_EC72:
	incbin "misc\unk_EC72.bin"

word_ECF2:
	incbin "misc\unk_ECF2.bin"

fill_EE32:
	dcb.b 462, $FF

Z80_PRG_Base0:
	incbin "programs\z80_prog0.bin"

Z80_PRG_Base1:
	incbin "programs\z80_prog1.bin"

Z80_PRG_Base2:
	incbin "programs\z80_prog2.bin"

fill_102D4:
	dcb.b 1324, $FF

data_10800:
	incbin "misc\nemesis_10800.bin"
data_10890:
	incbin "misc\nemesis_10890.bin"
data_12626:
	incbin "misc\nemesis_12626.bin"

font_12674:
	incbin "fonts\font_12674.bin"

unk_126FC:
		dc.l 0
		dc.l 0

enigma_12704:
	incbin "misc\enigma_12704.bin"
	incbin "misc\enigma_127B0.bin"
	incbin "misc\enigma_12862.bin"
	incbin "misc\enigma_129C2.bin"
	incbin "misc\enigma_12A0E.bin"
	incbin "misc\enigma_12A78.bin"
	incbin "misc\enigma_12A86.bin"
	incbin "misc\enigma_12A9E.bin"
	incbin "misc\enigma_12AB4.bin"
	incbin "misc\enigma_12B6C.bin"

unk_12BBE:
	dc.b   0
	dc.b   0
	dc.b   5
	dc.b $47
	dc.b $EF
	dc.b   0
	dc.b $F0
	dc.b $10
	dc.b   0
	dc.b $47
	dc.b $F3
	dc.b   8
	dc.b $F0
	dc.b   8
	dc.b   0
	dc.b $47
	dc.b $F4
	dc.b $10
	dc.b $E8
	dc.b   0

unk_12BD2:
	dc.b   1
	dc.b   0
	dc.b $FC
	dc.b   8
	dc.b $47
	dc.b $F5
	dc.b $FE
	dc.b $EA
	dc.b   4
	dc.b   8
	dc.b $57
	dc.b $F5
	dc.b $FE
	dc.b $EA

font_12BE0:
	incbin "fonts\font_12BE0.bin"

fill_12BF8:
	dcb.b 2056, $FF

SubCPU_Prog1:
	incbin "programs\sub_cpu_prog1.bin"

defaultFontData:
	incbin "fonts\font_15000.bin"
word_15070:
	incbin "fonts\font_15070.bin"
word_15108:
	incbin "fonts\font_15108.bin"

unk_15300:
	incbin "misc\nemesis_15300.bin"

unk_1546E:
	incbin "misc\nemesis_1546E.bin"

word_15920:
	dc.w (word_1596C - word_15920)  ; $0
	dc.w (word_15998 - word_15920)  ; $1
	dc.w (word_159B0 - word_15920)  ; $2
	dc.w (word_159CC - word_15920)  ; $3
	dc.w (word_159E4 - word_15920)  ; $4
	dc.w (word_15A12 - word_15920)  ; $5
	dc.w (word_15A24 - word_15920)  ; $6
	dc.w (word_15A36 - word_15920)  ; $7
	dc.w (word_15A50 - word_15920)  ; $8
	dc.w (word_15A6A - word_15920)  ; $9
	dc.w (word_15A82 - word_15920)  ; $A
	dc.w (word_15A9A - word_15920)  ; $B
	dc.w (word_15AA4 - word_15920)  ; $C
	dc.w (word_15AD8 - word_15920)  ; $D
	dc.w (word_15AF2 - word_15920)  ; $E
	dc.w (word_15B02 - word_15920)  ; $F
	dc.w (word_15B12 - word_15920)  ; $10
	dc.w (word_15B32 - word_15920)  ; $11
	dc.w (word_15B54 - word_15920)  ; $12
	dc.w (word_15B76 - word_15920)  ; $13
	dc.w (word_15BB0 - word_15920)  ; $14
	dc.w (word_15BD4 - word_15920)  ; $15
	dc.w (word_15BD8 - word_15920)  ; $16
	dc.w (word_15BFA - word_15920)  ; $17
	dc.w (word_15C1C - word_15920)  ; $18
	dc.w (word_15C26 - word_15920)  ; $19
	dc.w (word_15C80 - word_15920)  ; $1A
	dc.w (word_15C9A - word_15920)  ; $1B
	dc.w (word_15CE6 - word_15920)  ; $1C
	dc.w (word_15D02 - word_15920)  ; $1D
	dc.w (word_15D1E - word_15920)  ; $1E
	dc.w (word_15D3E - word_15920)  ; $1F
	dc.w (word_15D70 - word_15920)  ; $20
	dc.w (word_15D92 - word_15920)  ; $21
	dc.w (word_15C58 - word_15920)  ; $22
	dc.w (word_15DAE - word_15920)  ; $23
	dc.w (word_15DBC - word_15920)  ; $24
	dc.w (word_15CC6 - word_15920)  ; $25

word_1596C:
	dc.w $36
	dc.w $2A
	dc.w $27
	dc.w $02
	dc.w $24
	dc.w $37
	dc.w $2B
	dc.w $2E
	dc.w $36
	dc.w $0F
	dc.w $2B
	dc.w $30
	dc.w $02
	dc.w $2F
	dc.w $27
	dc.w $2F
	dc.w $31
	dc.w $34
	dc.w $3B
	dc.w $02
	dc.w $00
	dc.w $FFFF

word_15998:
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $02
	dc.w $2B
	dc.w $35
	dc.w $1C
	dc.w $02
	dc.w $FFFF

word_159B0:
	dc.w $35
	dc.w $23
	dc.w $38
	dc.w $27
	dc.w $26
	dc.w $02
	dc.w $2B
	dc.w $36
	dc.w $27
	dc.w $2F
	dc.w $0A
	dc.w $35
	dc.w $0B
	dc.w $FFFF

word_159CC:
	dc.w $28
	dc.w $34
	dc.w $27
	dc.w $27
	dc.w $02
	dc.w $2F
	dc.w $27
	dc.w $2F
	dc.w $31
	dc.w $34
	dc.w $3B
	dc.w $FFFF

word_159E4:
	dc.w $36
	dc.w $2A
	dc.w $27
	dc.w $02
	dc.w $25
	dc.w $23
	dc.w $34
	dc.w $36
	dc.w $34
	dc.w $2B
	dc.w $26
	dc.w $29
	dc.w $27
	dc.w $02
	dc.w $2F
	dc.w $27
	dc.w $2F
	dc.w $31
	dc.w $34
	dc.w $3B
	dc.w $02
	dc.w $01
	dc.w $FFFF

word_15A12:
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $02
	dc.w $00
	dc.w $FFFF

word_15A24:
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $02
	dc.w $01
	dc.w $FFFF

word_15A36:
	dc.w $27
	dc.w $34
	dc.w $23
	dc.w $35
	dc.w $27
	dc.w $02
	dc.w $2B
	dc.w $36
	dc.w $27
	dc.w $2F
	dc.w $02
	dc.w $00
	dc.w $FFFF

word_15A50:
	dc.w $27
	dc.w $34
	dc.w $23
	dc.w $35
	dc.w $27
	dc.w $02
	dc.w $2B
	dc.w $36
	dc.w $27
	dc.w $2F
	dc.w $02
	dc.w $01
	dc.w $FFFF

word_15A6A:
	dc.w $25
	dc.w $31
	dc.w $32
	dc.w $3B
	dc.w $02
	dc.w $00
	dc.w $02
	dc.w $36
	dc.w $31
	dc.w $02
	dc.w $01
	dc.w $FFFF

word_15A82:
	dc.w $25
	dc.w $31
	dc.w $32
	dc.w $3B
	dc.w $02
	dc.w $01
	dc.w $02
	dc.w $36
	dc.w $31
	dc.w $02
	dc.w $00
	dc.w $FFFF

word_15A9A:
	dc.w $27
	dc.w $3A
	dc.w $2B
	dc.w $36
	dc.w $FFFF

word_15AA4:
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $36
	dc.w $2B
	dc.w $30
	dc.w $29
	dc.w $02
	dc.w $39
	dc.w $2B
	dc.w $2E
	dc.w $2E
	dc.w $02
	dc.w $27
	dc.w $34
	dc.w $23
	dc.w $35
	dc.w $27
	dc.w $02
	dc.w $23
	dc.w $2E
	dc.w $2E
	dc.w $FFFF

word_15AD8:
	dc.w $35
	dc.w $23
	dc.w $38
	dc.w $27
	dc.w $26
	dc.w $02
	dc.w $2B
	dc.w $36
	dc.w $27
	dc.w $2F
	dc.w $35
	dc.w $03
	dc.w $FFFF

word_15AF2:
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $21
	dc.w $FFFF

word_15B02:
	dc.w $3B
	dc.w $27
	dc.w $35
	dc.w $02
	dc.w $02
	dc.w $30
	dc.w $31
	dc.w $FFFF

word_15B12:
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $02
	dc.w $25
	dc.w $31
	dc.w $2F
	dc.w $32
	dc.w $2E
	dc.w $27
	dc.w $36
	dc.w $27
	dc.w $FFFF

word_15B32:
	dc.w $32
	dc.w $34
	dc.w $27
	dc.w $35
	dc.w $35
	dc.w $02
	dc.w $23
	dc.w $30
	dc.w $3B
	dc.w $02
	dc.w $24
	dc.w $37
	dc.w $36
	dc.w $36
	dc.w $31
	dc.w $30
	dc.w $FFFF

word_15B54:
	dc.w $36
	dc.w $2A
	dc.w $27
	dc.w $02
	dc.w $00
	dc.w $02
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $02
	dc.w $2B
	dc.w $35
	dc.w $1C
	dc.w $FFFF

word_15B76:
	dc.w $30
	dc.w $37
	dc.w $2F
	dc.w $24
	dc.w $27
	dc.w $34
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $30
	dc.w $23
	dc.w $2F
	dc.w $27
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $02
	dc.w $37
	dc.w $35
	dc.w $27
	dc.w $26
	dc.w $FFFF

word_15BB0:
	dc.w $2B
	dc.w $35
	dc.w $02
	dc.w $2B
	dc.w $36
	dc.w $02
	dc.w $31
	dc.w $2D
	dc.w $02
	dc.w $36
	dc.w $31
	dc.w $02
	dc.w $27
	dc.w $34
	dc.w $23
	dc.w $35
	dc.w $27
	dc.w $FFFF

word_15BD4:
	dc.w $21
	dc.w $FFFF

word_15BD8:
	dc.w $27
	dc.w $34
	dc.w $23
	dc.w $35
	dc.w $37
	dc.w $34
	dc.w $27
	dc.w $02
	dc.w $25
	dc.w $31
	dc.w $2F
	dc.w $32
	dc.w $2E
	dc.w $27
	dc.w $36
	dc.w $27
	dc.w $FFFF

word_15BFA:
	dc.w $36
	dc.w $2A
	dc.w $27
	dc.w $02
	dc.w $01
	dc.w $02
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $02
	dc.w $2B
	dc.w $35
	dc.w $1C
	dc.w $FFFF

word_15C1C:
	dc.w $2B
	dc.w $36
	dc.w $27
	dc.w $2F
	dc.w $FFFF

word_15C26:
	dc.w $36
	dc.w $2A
	dc.w $27
	dc.w $34
	dc.w $27
	dc.w $02
	dc.w $2B
	dc.w $35
	dc.w $02
	dc.w $30
	dc.w $31
	dc.w $36
	dc.w $02
	dc.w $27
	dc.w $30
	dc.w $31
	dc.w $37
	dc.w $29
	dc.w $2A
	dc.w $02
	dc.w $28
	dc.w $34
	dc.w $27
	dc.w $27
	dc.w $FFFF

word_15C58:
	dc.w $2F
	dc.w $27
	dc.w $2F
	dc.w $31
	dc.w $34
	dc.w $3B
	dc.w $02
	dc.w $36
	dc.w $31
	dc.w $02
	dc.w $25
	dc.w $31
	dc.w $32
	dc.w $3B
	dc.w $02
	dc.w $2B
	dc.w $36
	dc.w $27
	dc.w $2F
	dc.w $FFFF

word_15C80:
	dc.w $25
	dc.w $23
	dc.w $30
	dc.w $30
	dc.w $31
	dc.w $36
	dc.w $02
	dc.w $25
	dc.w $31
	dc.w $32
	dc.w $3B
	dc.w $10
	dc.w $FFFF

word_15C9A:
	dc.w $23
	dc.w $30
	dc.w $02
	dc.w $2B
	dc.w $36
	dc.w $27
	dc.w $2F
	dc.w $02
	dc.w $39
	dc.w $2B
	dc.w $36
	dc.w $2A
	dc.w $02
	dc.w $36
	dc.w $2A
	dc.w $27
	dc.w $02
	dc.w $30
	dc.w $23
	dc.w $2F
	dc.w $27
	dc.w $FFFF

word_15CC6:
	dc.w $23
	dc.w $2E
	dc.w $34
	dc.w $27
	dc.w $23
	dc.w $26
	dc.w $3B
	dc.w $02
	dc.w $27
	dc.w $3A
	dc.w $2B
	dc.w $35
	dc.w $36
	dc.w $35
	dc.w $10
	dc.w $FFFF

word_15CE6:
	dc.w $25
	dc.w $31
	dc.w $32
	dc.w $3B
	dc.w $02
	dc.w $25
	dc.w $31
	dc.w $2F
	dc.w $32
	dc.w $2E
	dc.w $27
	dc.w $36
	dc.w $27
	dc.w $FFFF

word_15D02:
	dc.w $32
	dc.w $2E
	dc.w $27
	dc.w $23
	dc.w $35
	dc.w $27
	dc.w $02
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $FFFF

word_15D1E:
	dc.w $2B
	dc.w $35
	dc.w $02
	dc.w $30
	dc.w $31
	dc.w $36
	dc.w $02
	dc.w $32
	dc.w $34
	dc.w $27
	dc.w $35
	dc.w $27
	dc.w $30
	dc.w $36
	dc.w $10
	dc.w $FFFF

word_15D3E:
	dc.w $26
	dc.w $23
	dc.w $36
	dc.w $23
	dc.w $02
	dc.w $35
	dc.w $36
	dc.w $31
	dc.w $34
	dc.w $23
	dc.w $29
	dc.w $27
	dc.w $02
	dc.w $2B
	dc.w $30
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $2B
	dc.w $31
	dc.w $30
	dc.w $FFFF

word_15D70:
	dc.w $2B
	dc.w $35
	dc.w $02
	dc.w $2B
	dc.w $36
	dc.w $02
	dc.w $31
	dc.w $2D
	dc.w $02
	dc.w $36
	dc.w $31
	dc.w $02
	dc.w $25
	dc.w $31
	dc.w $32
	dc.w $3B
	dc.w $FFFF

word_15D92:
	dc.w $25
	dc.w $23
	dc.w $30
	dc.w $30
	dc.w $31
	dc.w $36
	dc.w $02
	dc.w $28
	dc.w $31
	dc.w $34
	dc.w $2F
	dc.w $23
	dc.w $36
	dc.w $FFFF

word_15DAE:
	dc.w $2F
	dc.w $27
	dc.w $2F
	dc.w $31
	dc.w $34
	dc.w $3B
	dc.w $FFFF

word_15DBC:
	dc.w $2F
	dc.w $27
	dc.w $30
	dc.w $37
	dc.w $FFFF

word_15DC6:
	dc.w 4, $00
	dc.w 3, $08
	dc.w 1, $0E
	dc.w 1, $10
	dc.w 1, $12
	dc.w 1, $14
	dc.w 1, $16
	dc.w 1, $18
	dc.w 1, $1A
	dc.w 1, $1C
	dc.w 1, $1E
	dc.w 1, $20
	dc.w 1, $22
	dc.w 1, $24
	dc.w 1, $26
	dc.w 1, $28
	dc.w 1, $2A
	dc.w 1, $2C
	dc.w 1, $2E
	dc.w 1, $30
	dc.w 1, $32
	dc.w 1, $34
	dc.w 1, $36
	dc.w 1, $38
	dc.w 1, $3A
	dc.w 1, $3C
	dc.w 1, $3E
	dc.w 1, $40
	dc.w 1, $42
	dc.w 1, $44
	dc.w 1, $46
	dc.w 1, $48
	dc.w 1, $4A
	dc.w 1, $4C
	dc.w 1, $4E
	dc.w 1, $50
	dc.w 1, $52
	dc.w 1, $54
	dc.w 1, $56
	dc.w 1, $58
	dc.w 1, $5A
	dc.w 1, $5C
	dc.w 1, $5E
	dc.w 1, $60
	dc.w 1, $62
	dc.w 1, $64
	dc.w 1, $66
	dc.w 1, $68
	dc.w 1, $6A
	dc.w 1, $6C
	dc.w 1, $6E
	dc.w 1, $70
	dc.w 1, $72
	dc.w 1, $74
	dc.w 1, $76
	dc.w 1, $78
	dc.w 1, $7A
	dc.w 1, $7C
	dc.w 1, $7E
	dc.w 1, $80
	dc.w 1, $82
	dc.w 1, $84
	dc.w 1, $86
	dc.w 1, $88
	dc.w 1, $8A
	dc.w 1, $8C

fill_15ECE:
	dcb.b 306, $FF

SubCPU_Prog0:          ; DATA XREF: loadSubCpuPrg+18o
	incbin "programs\sub_cpu_prog0.bin"

SubCPU_Prog2:          ; DATA XREF: loadSubCpuPrg+38o
	incbin "programs\sub_cpu_prog2.bin"

	END
