;   ======================================================================
;       User Header structure
;   ======================================================================

USERHEADER.name         equ $0
USERHEADER.bootFlag     equ $B
USERHEADER.version      equ $C
USERHEADER.type         equ $E
USERHEADER.nextModule   equ $10
USERHEADER.size         equ $14
USERHEADER.startAddress equ $18
USERHEADER.ramSize      equ $1C
USERHEADER.usercall0    equ $20
USERHEADER.usercall1    equ $22
USERHEADER.usercall2    equ $24
USERHEADER.usercall3    equ $26
