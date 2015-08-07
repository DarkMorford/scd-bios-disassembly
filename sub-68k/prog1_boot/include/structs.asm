;   ======================================================================
;       Structure definitions
;   ======================================================================

	include "structs\cdbstat.asm"
	include "structs\timecode.asm"

;   Structure initialized in initGfxObject
;   Size is <= $A0 bytes
GFXOBJ.word0 equ 0

;   Provided by main CPU
GFXOBJ.word2 equ 2
GFXOBJ.word4 equ 4
GFXOBJ.word6 equ 6
GFXOBJ.word8 equ 8
GFXOBJ.wordA equ $A

GFXOBJ.word20 equ $20
GFXOBJ.word22 equ $22
GFXOBJ.word24 equ $24
GFXOBJ.word26 equ $26
GFXOBJ.word30 equ $30
GFXOBJ.word32 equ $32
GFXOBJ.word34 equ $34
GFXOBJ.word36 equ $36
GFXOBJ.word38 equ $38
GFXOBJ.word3C equ $3C
GFXOBJ.word40 equ $40
GFXOBJ.word44 equ $44
GFXOBJ.dword48 equ $48
GFXOBJ.dword4C equ $4C
GFXOBJ.dword50 equ $50
GFXOBJ.dword54 equ $54
GFXOBJ.divisor equ $58
GFXOBJ.dword5C equ $5C
GFXOBJ.dword60 equ $60
