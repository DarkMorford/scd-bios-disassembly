;   ======================================================================
;       VDP variables
;   ======================================================================

; VDP register cache (registers 0-18)
vdpRegCache equ $FFFFFDB4

; Bitfield (I think) declaring what to do during V-blank
vblankCode  equ $FFFFFE26

; User routine called during V-blank
vblankJumpTarget    equ $FFFFFDA8

; Buffer for all 4 color palettes
paletteBuffer0  equ $FFFFFB80
paletteBuffer1  equ $FFFFFBA0
paletteBuffer2  equ $FFFFFBC0
paletteBuffer3  equ $FFFFFBE0

; Buffer for sprite attribute table
spriteTable equ $FFFFF900

; Increment to step to next line in VRAM
vdpLineIncrement    equ $FFFFFE2E

; Flags to indicate needed updates
vdpUpdateFlags  equ $FFFFFE29

; Font offset from beginning of VRAM
fontTileOffset  equ $FFFFFE2C
