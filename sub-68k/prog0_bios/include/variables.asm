;   ======================================================================
;       Variables
;   ======================================================================

	include "variables\biosRoutines.asm"
	include "variables\unknown.asm"

;   LED control
ledBitfield     equ $5800
ledStatus       equ $5801
ledMode         equ $5802
userLedMode     equ $5804
lastLedMode     equ $5806
greenBlinkTimer equ $5808
redBlinkTimer   equ $5809

;   Volume control
volumeBitfield  equ $5AB6
masterVolume    equ $5AB8
systemVolume    equ $5ABA
volumeSlope     equ $5AC6

; CDBOOT variables
bootBitfield            equ $5B24
cbtInterruptHandler     equ $5B26
cbtInterruptData        equ $5B2A
cbtReturnAddress        equ $5B2E
word_5B32               equ $5B32
readSectorStart         equ $5B34
readSectorCount         equ $5B38
readSectorLoopCount     equ $5B3C
bootHeaderAddress       equ $5B3E
ipDstAddress            equ $5B42
spDstAddress            equ $5B46
dataBufferAddress       equ $5B4A
headerBuffer            equ $5B4E
frameCheckValue         equ $5B52

JumpTable equ $5EE0
tempJumpTarget equ $5AD4
vBlankFlag equ $5EA4

cdcBitfield0 equ $5A06
cdcBitfield1 equ $5A07
cdcFrameHeader equ $5A3A
cdcRegisterCache equ $5A08
cdcStat0 equ $5A40
cdcStatus equ $5A38

cddAbsFrameTime equ $59EC
cddArg1Cache equ $5AE2
cddArg2Cache equ $5AE6
cddCommand equ $5AC8
cddCommandBuffer equ $583A
cddCommandCache equ $5AE0
cddControlStatus equ $5AD2
cddFirstTrack equ $5850
cddLastTrack equ $5851
cddLeadOutTime equ $5854
cddRelFrameTime equ $59F0
cddSpindownDelay equ $5B0C
cddStatusCache equ $5844
cddTocTable equ $5858
cddVersion equ $5852

currentTrackNumber equ $59F4
