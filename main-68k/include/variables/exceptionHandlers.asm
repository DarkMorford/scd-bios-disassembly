;   ======================================================================
;       Exception-handling routines
;   ======================================================================

_EXCPT  equ $FFFFFD00
_LEVEL6 equ $FFFFFD06   ; V-blank
_LEVEL4 equ $FFFFFD0C   ; H-blank
_LEVEL2 equ $FFFFFD12   ; External interrupt
_TRAP00 equ $FFFFFD18
_TRAP01 equ $FFFFFD1E
_TRAP02 equ $FFFFFD24
_TRAP03 equ $FFFFFD2A
_TRAP04 equ $FFFFFD30
_TRAP05 equ $FFFFFD36
_TRAP06 equ $FFFFFD3C
_TRAP07 equ $FFFFFD42
_TRAP08 equ $FFFFFD48
_TRAP09 equ $FFFFFD4E
_TRAP10 equ $FFFFFD54
_TRAP11 equ $FFFFFD5A
_TRAP12 equ $FFFFFD60
_TRAP13 equ $FFFFFD66
_TRAP14 equ $FFFFFD6C
_TRAP15 equ $FFFFFD72
_CHKERR equ $FFFFFD78
_CODERR equ $FFFFFD7E
_DEVERR equ $FFFFFD84
_TRPERR equ $FFFFFD8A
_NOCOD0 equ $FFFFFD90
_NOCOD1 equ $FFFFFD96
_SPVERR equ $FFFFFD9C
_TRACE  equ $FFFFFDA2
