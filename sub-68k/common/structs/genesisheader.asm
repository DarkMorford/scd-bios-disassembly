;   ======================================================================
;       Genesis Header structure
;   ======================================================================

GENHEADER.system        equ $0
GENHEADER.copyright     equ $10
GENHEADER.jpTitle       equ $20
GENHEADER.intlTitle     equ $50
GENHEADER.productCode   equ $80
GENHEADER.checksum      equ $8E
GENHEADER.controls      equ $90
GENHEADER.romStart      equ $A0
GENHEADER.romEnd        equ $A4
GENHEADER.ramStart      equ $A8
GENHEADER.ramEnd        equ $AC
GENHEADER.backupRam     equ $B0
GENHEADER.modem         equ $BC
GENHEADER.memo          equ $C8
GENHEADER.region        equ $F0
