;   ======================================================================
;       Gate Array registers
;   ======================================================================

;   General
GA_LED_STATUS       equ $FFFF8000
GA_RESET            equ $FFFF8001
GA_WRITE_PROTECT    equ $FFFF8002
GA_MEMORY_MODE      equ $FFFF8003
GA_INT3_TIMER       equ $FFFF8031
GA_INT_MASK         equ $FFFF8033

;   CDC
GA_CDC_TRANSFER     equ $FFFF8004
GA_CDC_ADDRESS      equ $FFFF8005
GA_CDC_REGISTER     equ $FFFF8007
GA_CDC_DATA         equ $FFFF8008
GA_CDC_DMA_ADDRESS  equ $FFFF800A
GA_STOPWATCH        equ $FFFF800C

;   Communication
GA_COMM_MAINFLAGS   equ $FFFF800E
GA_COMM_SUBFLAGS    equ $FFFF800F
GA_COMM_MAINDATA    equ $FFFF8010
GA_COMM_SUBDATA     equ $FFFF8020

;   CDD
GA_CDD_FADER        equ $FFFF8034
GA_CDD_CONTROL      equ $FFFF8036
GA_CDD_STATUS       equ $FFFF8038
GA_CDD_COMMAND      equ $FFFF8042

;   Font
GA_FONT_COLOR       equ $FFFF804D
GA_FONT_BITS        equ $FFFF804E
GA_FONT_DATA        equ $FFFF8050

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
GA_SUBCODE_BUFFER   equ $FFFF8100
GA_SUBCODE_IMAGE    equ $FFFF8180
