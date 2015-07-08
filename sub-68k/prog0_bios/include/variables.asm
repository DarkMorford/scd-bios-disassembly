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

JumpTable equ $5EE0
tempJumpTarget equ $5AD4
vBlankFlag equ $5EA4

bootBitfield equ $5B24

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
