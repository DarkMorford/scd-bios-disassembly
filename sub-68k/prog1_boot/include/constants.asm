;   ======================================================================
;       Constants
;   ======================================================================

	; Gate Array registers
	include "constants\gateArray.asm"

	include "constants\bios.asm"
	include "constants\common.asm"
	include "constants\memoryMap.asm"

RAM_BASE equ $833C

;   Gate array registers (long-address form)
GAL_MEMORY_MODE     equ $FF8003
GAL_BUFFER_VDOTS    equ $FF8064
GAL_BUFFER_VCELLS   equ $FF805C
GAL_BUFFER_ADDRESS  equ $FF805E
GAL_TRACE_VECTORS   equ $FF8066
