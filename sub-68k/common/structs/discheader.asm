;   ======================================================================
;       Disc ID structure
;   ======================================================================

DISCHEADER.hardware         equ $0
DISCHEADER.companyCode      equ $10
DISCHEADER.domesticTitle    equ $20
DISCHEADER.intlTitle        equ $50
DISCHEADER.productCode      equ $80
DISCHEADER.ioInfo           equ $90
DISCHEADER.modemInfo        equ $BC
DISCHEADER.region           equ $F0
