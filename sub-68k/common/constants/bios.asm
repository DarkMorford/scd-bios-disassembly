;   ======================================================================
;       BIOS Constants
;   ======================================================================

_CDSTAT     equ $5E80
_BOOTSTAT   equ $5EA0
_USERMODE   equ $5EA6

;   CD types
CD_NOTREADY     equ $FF
CD_NODISC       equ 0
CD_MUSIC        equ 1
CD_ROM          equ 2
CD_MIXED        equ 3
CD_GAMESYSTEM   equ 4
CD_GAMEDATA     equ 5
CD_GAMEBOOT     equ 6
CD_GAMEDISC     equ 7

;   LED modes
LEDREADY    equ 0
LEDDISCIN   equ 1
LEDACCESS   equ 2
LEDSTANDBY  equ 3
LEDERROR    equ 4
LEDMODE5    equ 5
LEDMODE6    equ 6
LEDMODE7    equ 7
LEDSYSTEM   equ $FFFF

;   CDBIOS commands
MSCSTOP     equ 2
MSCPAUSEON  equ 3
MSCPAUSEOFF equ 4
MSCSCANFF   equ 5
MSCSCANFR   equ 6
MSCSCANOFF  equ 7
ROMPAUSEON  equ 8
ROMPAUSEOFF equ 9
DRVOPEN     equ $A
DRVINIT     equ $10
MSCPLAY     equ $11
MSCPLAY1    equ $12
MSCPLAYR    equ $13
MSCPLAYT    equ $14
MSCSEEK     equ $15
MSCSEEKT    equ $16
ROMREAD     equ $17
ROMSEEK     equ $18
MSCSEEK1    equ $19
ROMREADN    equ $20
ROMREADE    equ $21
CDBCHK      equ $80
CDBSTAT     equ $81
CDBTOCWRITE equ $82
CDBTOCREAD  equ $83
CDBPAUSE    equ $84
FDRSET      equ $85
FDRCHG      equ $86
CDCSTART    equ $87
CDCSTARTP   equ $88
CDCSTOP     equ $89
CDCSTAT     equ $8A
CDCREAD     equ $8B
CDCTRN      equ $8C
CDCACK      equ $8D
SCDINIT     equ $8E
SCDSTART    equ $8F
SCDSTOP     equ $90
SCDSTAT     equ $91
SCDREAD     equ $92
SCDPQ       equ $93
SCDPQL      equ $94
LEDSET      equ $95
CDCSETMODE  equ $96
WONDERREQ   equ $97
WONDERCHK   equ $98

;   CDBOOT commands
CBTINIT     equ 0
CBTINT      equ 1
CBTOPENDISC equ 2
CBTOPENSTAT equ 3
CBTCHKDISC  equ 4
CBTCHKSTAT  equ 5
CBTIPDISK   equ 6
CBTIPSTAT   equ 7
CBTSPDISC   equ 8
CBTSPSTAT   equ 9

;   BURAM commands
BRMINIT     equ 0
BRMSTAT     equ 1
BRMSERCH    equ 2
BRMREAD     equ 3
BRMWRITE    equ 4
BRMDEL      equ 5
BRMFORMAT   equ 6
BRMDIR      equ 7
BRMVERIFY   equ 8
