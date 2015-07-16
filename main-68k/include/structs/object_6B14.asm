;   ======================================================================
;       OBJ6B14 structure
;   ======================================================================

; Index of update function
OBJ6B14.word0       equ $0

; Flag/control bits
; 1: Update not needed
; 7: Flip horizontal
OBJ6B14.flags2      equ $2

; Sprite data
OBJ6B14.addr4       equ $4

; Horizontal position
OBJ6B14.word8       equ $8

; Vertical position
OBJ6B14.wordC       equ $C

; Horizontal position increment
OBJ6B14.dword10     equ $10

; Vertical position increment
OBJ6B14.dword14     equ $14

; Priority/palette/flip flags
OBJ6B14.byte18      equ $18

OBJ6B14.byte19      equ $19
OBJ6B14.byte20      equ $20
OBJ6B14.byte21      equ $21
OBJ6B14.byte23      equ $23
OBJ6B14.word24      equ $24
OBJ6B14.byte26      equ $26
OBJ6B14.word28      equ $28
OBJ6B14.word30      equ $30
OBJ6B14.word32      equ $32
OBJ6B14.word34      equ $34
OBJ6B14.word3C      equ $3C
