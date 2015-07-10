;   ======================================================================
;       CD-BIOS status structure
;   ======================================================================

CDBSTAT.bios_status equ 0

CDBSTAT.led     equ 2
CDBSTAT.ledMode equ 3

CDBSTAT.cdd_status  equ 4
CDBSTAT.statusCode      equ 4
CDBSTAT.reportCode      equ 5
CDBSTAT.discControlCode equ 6
CDBSTAT.currentTrack    equ 7
CDBSTAT.absTimeCode     equ 8
CDBSTAT.relTimeCode     equ $C
CDBSTAT.firstTrack      equ $10
CDBSTAT.lastTrack       equ $11
CDBSTAT.driveVersion    equ $12
CDBSTAT.flags           equ $13
CDBSTAT.leadOut         equ $14

CDBSTAT.volume  equ $18
CDBSTAT.masterVolume    equ $18
CDBSTAT.systemVolume    equ $1A

CDBSTAT.header  equ $1C
