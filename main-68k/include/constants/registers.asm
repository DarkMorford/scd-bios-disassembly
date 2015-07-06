;   ======================================================================
;       SEGA Genesis registers
;   ======================================================================

;   Graphics
VDP_DATA    equ $C00000
VDP_CONTROL equ $C00004
VDP_COUNTER equ $C00008

;   System I/O (Joypad)
MD_VERSION  equ $A10001
JOYDATA1    equ $A10003
JOYDATA2    equ $A10005
JOYDATA3    equ $A10007
JOYCTRL1    equ $A10009
JOYCTRL2    equ $A1000B
JOYCTRL3    equ $A1000D

;   Z80 subprocessor
Z80_BUSREQ  equ $A11100
Z80_RESET   equ $A11200
Z80_BANKSEL equ $A06000

;   Audio hardware
FM1_REGSEL  equ $A04000
FM1_DATA    equ $A04001
FM2_REGSEL  equ $A04002
FM2_DATA    equ $A04003
PSG_CTRL    equ $C00011
