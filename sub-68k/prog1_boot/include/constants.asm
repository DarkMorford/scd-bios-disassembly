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

GAL_STAMP_SIZE      equ $FF8058
GAL_STAMP_MAP_ADDR  equ $FF805A
GAL_BUFFER_OFFSET   equ $FF8060
GAL_BUFFER_HDOTS    equ $FF8062
GAL_BUFFER_VDOTS    equ $FF8064
GAL_BUFFER_VCELLS   equ $FF805C
GAL_BUFFER_ADDRESS  equ $FF805E
GAL_TRACE_VECTORS   equ $FF8066

;   CDD status codes
CDD_PLAY    equ $1
CDD_SEEK    equ $2
CDD_SCAN    equ $3
CDD_READY   equ $4
CDD_OPEN    equ $5
CDD_STOP    equ $9
CDD_NODISC  equ $B
CDD_END     equ $C
