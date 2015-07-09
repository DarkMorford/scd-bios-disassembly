;   ======================================================================
;       Gate Array registers
;   ======================================================================

;   General
GA_LED_STATUS       equ $FFFF8000
	GA_LEDR: equ 0
	GA_LEDG: equ 1
GA_RESET            equ $FFFF8001
	GA_RES0: equ 0
GA_WRITE_PROTECT    equ $FFFF8002   ; Read-only
GA_MEMORY_MODE      equ $FFFF8003
	GA_PM1:  equ 4
	GA_PM0:  equ 3
	GA_MODE: equ 2
	GA_DMNA: equ 1
	GA_RET:  equ 0
GA_INT3_TIMER       equ $FFFF8031
GA_INT_MASK         equ $FFFF8033
	GA_IEN1: equ 1
	GA_IEN2: equ 2
	GA_IEN3: equ 3
	GA_IEN4: equ 4
	GA_IEN5: equ 5
	GA_IEN6: equ 6

;   CDC
GA_CDC_TRANSFER     equ $FFFF8004
GA_CDC_ADDRESS      equ $FFFF8005
GA_CDC_REGISTER     equ $FFFF8007
GA_CDC_DATA         equ $FFFF8008   ; Read-only
GA_CDC_DMA_ADDRESS  equ $FFFF800A
GA_STOPWATCH        equ $FFFF800C

;   Communication
GA_COMM_MAINFLAGS   equ $FFFF800E   ; Read-only
GA_COMM_SUBFLAGS    equ $FFFF800F
GA_COMM_MAINDATA    equ $FFFF8010   ; Read-only
GA_COMM_SUBDATA     equ $FFFF8020

;   CDD
GA_CDD_FADER        equ $FFFF8034
	GA_SSF:  equ  1
	GA_DEF0: equ  2
	GA_DEF1: equ  3
	GA_EFDT: equ $F
GA_CDD_DATAMUSIC    equ $FFFF8036
GA_CDD_CONTROL      equ $FFFF8037
	GA_DTS:  equ 0
	GA_DRS:  equ 1
	GA_HOCK: equ 2
GA_CDD_STATUS       equ $FFFF8038
GA_CDD_COMMAND      equ $FFFF8042

;   Font
GA_FONT_COLOR       equ $FFFF804D
GA_FONT_BITS        equ $FFFF804E
GA_FONT_DATA        equ $FFFF8050   ; Read-only

;   Rotation/Compression
GA_STAMP_SIZE       equ $FFFF8059
GA_STAMP_MAP_ADDR   equ $FFFF805A
GA_BUFFER_VCELLS    equ $FFFF805D
GA_BUFFER_ADDRESS   equ $FFFF805E
GA_BUFFER_OFFSET    equ $FFFF8061
GA_BUFFER_HDOTS     equ $FFFF8062
GA_BUFFER_VDOTS     equ $FFFF8065
GA_TRACE_VECTORS    equ $FFFF8066

;   Subcodes
GA_SUBCODE_ADDRESS  equ $FFFF8069
GA_SUBCODE_BUFFER   equ $FFFF8100   ; Read-only
GA_SUBCODE_IMAGE    equ $FFFF8180   ; Read-only
