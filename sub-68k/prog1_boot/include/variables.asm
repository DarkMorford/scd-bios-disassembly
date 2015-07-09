;   ======================================================================
;       Variables
;   ======================================================================

	include "variables\biosRoutines.asm"

byte_1801C equ $1801C
byte_18022 equ $18022
sub_18000 equ $18000
sub_18004 equ $18004
unk_90000 equ $90000
unk_99C00 equ $99C00
unk_99C02 equ $99C02
unk_99C0C equ $99C0C
unk_99C16 equ $99C16
unk_99C18 equ $99C18
unk_99E80 equ $99E80
unk_CE000 equ $CE000
unk_CE080 equ $CE080
unk_CE082 equ $CE082
unk_CE084 equ $CE084
unk_F700 equ $F700
word_CE002 equ $CE002
word_CE0FC equ $CE0FC

;   ======================================================================
;       Unless and until otherwise noted, all variables following
;       this statement are relative to RAM_BASE ($833C).
;   ======================================================================
word_0 equ 0
byte_3 equ 3
word_4 equ 4
byte_6 equ 6
mainCommCache equ $E
subCommBuffer  equ $1E
word_2E equ $2E
word_32 equ $32
flags_3E equ $3E
byte_3F equ $3F
word_40 equ $40
discType equ $42
byte_43 equ $43
word_44 equ $44
byte_58 equ $58
byte_59 equ $59
word_5A equ $5A
dword_5C equ $5C
dword_60 equ $60
byte_63 equ $63
unk_64 equ $64
chkdiskScratch equ $E4 ; (through $8E3)
unk_BE4 equ $BE4
subcodeScratch equ $C0A ; (through $1359)
word_20EA equ $20EA
;   ======================================================================
