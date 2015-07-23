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

;   CDBOOT variables
cbtFlags            equ $5B24
cbtResumeAddress        equ $5B26
cbtResumeData           equ $5B2A
cbtDeferredAddress        equ $5B2E
dataStartSector         equ $5B32
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
cdbResumeAddress equ $5AD4
vBlankFlag equ $5EA4

cdcFlags0 equ $5A06
cdcFlags1 equ $5A07
cdcFrameHeader equ $5A3A
cdcRegisterCache equ $5A08
cdcStat0 equ $5A40
cdcStatus equ $5A38

cddAbsFrameTime equ $59EC
cdbArg1Cache equ $5AE2
cdbArg2Cache equ $5AE6
cdbCommand equ $5AC8
cddCommandBuffer equ $583A
cdbCommandCache equ $5AE0
cdbControlStatus equ $5AD2
cddFirstTrack equ $5850
cddLastTrack equ $5851
cddLeadOutTime equ $5854
cddRelFrameTime equ $59F0
cdbSpindownDelay equ $5B0C
cddStatusCache equ $5844
cddTocTable equ $5858
cddVersion equ $5852

currentTrackNumber equ $59F4
