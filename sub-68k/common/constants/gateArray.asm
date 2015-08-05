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
	GA_MAINBUSY:   equ 0
	GA_MAINACK:    equ 1
	GA_MAINRAMREQ: equ 2
	GA_MAINSYNC:   equ 3
	GA_MAINFLAG4:  equ 4
	GA_MAINFLAG5:  equ 5
	GA_MAINFLAG6:  equ 6
	GA_MAINFLAG7:  equ 7
GA_COMM_SUBFLAGS    equ $FFFF800F
	GA_SUBBUSY:    equ 0
	GA_SUBACK:     equ 1
	GA_SUBRAMREQ:  equ 2
	GA_SUBSYNC:    equ 3
	GA_SUBFLAG4:   equ 4
	GA_SUBFLAG5:   equ 5
	GA_SUBFLAG6:   equ 6
	GA_SUBFLAG7:   equ 7
GA_COMM_MAINDATA    equ $FFFF8010   ; Read-only
	GA_MAINDATA0:  equ 0
	GA_MAINDATA1:  equ 4
	GA_MAINDATA2:  equ 8
	GA_MAINDATA3:  equ $C
GA_COMM_SUBDATA     equ $FFFF8020
	GA_SUBDATA0:   equ 0
	GA_SUBDATA1:   equ 4
	GA_SUBDATA2:   equ 8
	GA_SUBDATA3:   equ $C

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
	GA_CDDS_STAH:   equ $FFFF8038
	GA_CDDS_STAL:   equ $FFFF8039
	GA_CDDS_MINH:   equ $FFFF803A
	GA_CDDS_MINL:   equ $FFFF803B
	GA_CDDS_SECH:   equ $FFFF803C
	GA_CDDS_SECL:   equ $FFFF803D
	GA_CDDS_FRAH:   equ $FFFF803E
	GA_CDDS_FRAL:   equ $FFFF803F
	GA_CDDS_CHKH:   equ $FFFF8040
	GA_CDDS_CHKL:   equ $FFFF8041
GA_CDD_COMMAND      equ $FFFF8042
	GA_CDDC_CMDH:   equ $FFFF8042
	GA_CDDC_CMDL:   equ $FFFF8043
	GA_CDDC_MINH:   equ $FFFF8044
	GA_CDDC_MINL:   equ $FFFF8045
	GA_CDDC_SECH:   equ $FFFF8046
	GA_CDDC_SECL:   equ $FFFF8047
	GA_CDDC_FRAH:   equ $FFFF8048
	GA_CDDC_FRAL:   equ $FFFF8049
	GA_CDDC_CHKH:   equ $FFFF804A
	GA_CDDC_CHKL:   equ $FFFF804B

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
