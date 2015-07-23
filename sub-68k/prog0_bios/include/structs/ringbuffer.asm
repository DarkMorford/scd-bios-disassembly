;   ======================================================================
;       Ring buffer structure
;   ======================================================================

RINGBUFFER.readStep         equ $0
RINGBUFFER.writeStep        equ $2
RINGBUFFER.readPtr          equ $4
RINGBUFFER.writePtr         equ $6
RINGBUFFER.minFreeBytes     equ $8
RINGBUFFER.bufferSize       equ $A
RINGBUFFER.tag              equ $C
RINGBUFFER.structSize       equ $10
