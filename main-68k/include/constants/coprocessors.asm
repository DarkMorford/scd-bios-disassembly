;   ======================================================================
;       Coprocessor memory locations
;   ======================================================================

;   Sub-CPU (SEGA CD)
SubCPU_Bank     equ $20000  ; Sub-CPU memory bank mapped to $20000-$40000
SubCPU_Base0    equ $20000
SubCPU_Base1    equ $26000
SubCPU_Base2    equ $38000

;   Word RAM
WordRAM_Bank0   equ $200000 ; 2 Mbit, real memory in 1 Mbit mode
WordRAM_Bank1   equ $220000 ; VRAM image in 1 Mbit mode

dword_220E00    equ $220E00
unk_200080      equ $200080
unk_201880      equ $201880
unk_20E002      equ $20E002
unk_20E0FC      equ $20E0FC
unk_210000      equ $210000
unk_210022      equ $210022
unk_21A000      equ $21A000
unk_21B7C0      equ $21B7C0
unk_21CF80      equ $21CF80
unk_21E740      equ $21E740
unk_220C02      equ $220C02
unk_220D00      equ $220D00
unk_230024      equ $230024
unk_23F002      equ $23F002
word_200400     equ $200400
word_20E080     equ $20E080
word_20E082     equ $20E082
word_219C00     equ $219C00
word_219C02     equ $219C02
word_219C04     equ $219C04
word_219C06     equ $219C06
word_219C08     equ $219C08
word_219C0A     equ $219C0A
word_219C0C     equ $219C0C
word_219C0E     equ $219C0E
word_219C10     equ $219C10
word_219C12     equ $219C12
word_219C14     equ $219C14
word_219C16     equ $219C16
word_219C18     equ $219C18

;   Z80
Z80_Bank        equ $A00000 ; Z80 program RAM mapped to $A00000-$A02000
Z80_RAM_Base0   equ $A00000
Z80_RAM_Base1   equ $A00D00
Z80_RAM_Base2   equ $A01100
byte_A01C0A     equ $A01C0A
unk_A00150      equ $A00150

;   Cartridge memory space ($400000-$800000)
byte_400001 equ $400001
byte_400020 equ $400020
cartBoot    equ $400200
unk_4C0078  equ $4C0078
unk_600000  equ $600000
unk_7FFFFF  equ $7FFFFF
