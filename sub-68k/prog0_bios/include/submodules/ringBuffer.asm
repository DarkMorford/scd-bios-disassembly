;   ======================================================================
;       Ring buffer subroutines
;   ======================================================================

; =============== S U B R O U T I N E =======================================

; Input:
;   a4: Structure address

initRingBuffer:                ; CODE XREF: initCdc+42p sub_1F1E+6p
	clr.l      RINGBUFFER.readPtr(a4)
	move.l d0, RINGBUFFER.readStep(a4)
	move.l d1, RINGBUFFER.minFreeBytes(a4)
	move.l a0, RINGBUFFER.tag(a4)
	rts
; End of function initRingBuffer


; =============== S U B R O U T I N E =======================================

; Input:
;   a4: Structure address
;
; Output:
;   a1: Data write address
;   d1: Buffer usable/full

writeRingBuffer:                ; CODE XREF: sub_1E6Ap sub_203E+82p ...
	movem.l d2-d4, -(sp)

	move.w RINGBUFFER.readPtr(a4), d2
	move.w RINGBUFFER.writePtr(a4), d3
	move.w RINGBUFFER.bufferSize(a4), d4

	lea RINGBUFFER.structSize(a4, d3.w), a1

	add.w RINGBUFFER.writeStep(a4), d3

	cmp.w d4, d3
	bcs.s @loc_76C

	sub.w d4, d3

@loc_76C:
	move.w d3, RINGBUFFER.writePtr(a4)

	moveq  #0, d1

	; Calculate bytes available
	move.w d2, d0

	sub.w  d3, d0
	bcc.s  @loc_77A

	add.w  d4, d0

@loc_77A:
	cmp.w RINGBUFFER.minFreeBytes(a4), d0
	bcc.s @loc_790

	; Signal that the buffer's full
	moveq #1, d1
	
	; Bump the read pointer up
	add.w RINGBUFFER.writeStep(a4), d2

	cmp.w d4, d2
	bcs.s @loc_78C

	sub.w d4, d2

@loc_78C:
	move.w d2, RINGBUFFER.readPtr(a4)

@loc_790:
	movem.l (sp)+, d2-d4
	rts
; End of function writeRingBuffer


; =============== S U B R O U T I N E =======================================

; Input:
;   a4: Structure address

rewindRingBuffer:                ; CODE XREF: updateSubcode+7Ap
	move.w RINGBUFFER.writePtr(a4), d0

	sub.w RINGBUFFER.writeStep(a4), d0
	bcc.s @loc_7A4

	add.w RINGBUFFER.bufferSize(a4), d0

@loc_7A4:
	move.w d0, RINGBUFFER.writePtr(a4)
	rts
; End of function rewindRingBuffer


; =============== S U B R O U T I N E =======================================

; Input:
;   a4: Structure address
;
; Output:
;   a0: Data read address
;   eq/ne: No more data/Data remaining

readRingBuffer:                ; CODE XREF: _cdcread+24p
	movem.l d2/d4, -(sp)

	move.w RINGBUFFER.readPtr(a4), d2
	move.w RINGBUFFER.bufferSize(a4), d4

	lea RINGBUFFER.structSize(a4, d2.w), a0

	add.w RINGBUFFER.readStep(a4), d2

	cmp.w d4, d2
	bcs.s @loc_7C4

	sub.w d4, d2

@loc_7C4:
	move.w d2, RINGBUFFER.readPtr(a4)
	cmp.w  RINGBUFFER.writePtr(a4), d2

	movem.l (sp)+, d2/d4
	rts
; End of function readRingBuffer
