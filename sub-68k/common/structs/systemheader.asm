;   ======================================================================
;       System ID structure
;   ======================================================================

SYSTEMHEADER.attribute      equ $0
SYSTEMHEADER.volumeName     equ $10
SYSTEMHEADER.volumeSystem   equ $1C
SYSTEMHEADER.volumeType     equ $1E
SYSTEMHEADER.systemName     equ $20
SYSTEMHEADER.systemVer      equ $2C
SYSTEMHEADER.ipAddress      equ $30
SYSTEMHEADER.ipSize         equ $34
SYSTEMHEADER.ipEntry        equ $38
SYSTEMHEADER.ipRam          equ $3C
SYSTEMHEADER.spAddress      equ $40
SYSTEMHEADER.spSize         equ $44
SYSTEMHEADER.spEntry        equ $48
SYSTEMHEADER.spRam          equ $4C
