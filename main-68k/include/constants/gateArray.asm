;   ======================================================================
;       Gate Array registers
;   ======================================================================

GA_INTERRUPT    equ $A12000
	GA_IFL2: equ 0
GA_RESET_HALT   equ $A12001
	GA_SRES: equ 0
	GA_SBRQ: equ 1
GA_PROTECT      equ $A12002
GA_MEM_MODE     equ $A12003
	GA_MODE:   equ 2
	GA_DMNA:   equ 1
	GA_RET:    equ 0

;   CDC
GA_CDC_MODE     equ $A12004 ; Read-only
GA_HINT_VECTOR  equ $A12006
GA_CDC_DATA     equ $A12008 ; Read-only
GA_STOPWATCH    equ $A1200C ; Read-only

;   Communication
GA_COMM_MAINFLAGS   equ $A1200E
	GA_MAINFLAG0: equ 0
	GA_MAINFLAG1: equ 1
	GA_MAINFLAG2: equ 2
	GA_MAINFLAG3: equ 3
	GA_MAINFLAG4: equ 4
	GA_MAINFLAG5: equ 5
	GA_MAINFLAG6: equ 6
	GA_MAINFLAG7: equ 7
GA_COMM_SUBFLAGS    equ $A1200F ; Read-only
	GA_SUBFLAG0:  equ 0
	GA_SUBFLAG1:  equ 1
	GA_SUBFLAG2:  equ 2
	GA_SUBFLAG3:  equ 3
	GA_SUBFLAG4:  equ 4
	GA_SUBFLAG5:  equ 5
	GA_SUBFLAG6:  equ 6
	GA_SUBFLAG7:  equ 7
GA_COMM_MAINDATA    equ $A12010
	GA_MAINDATA0: equ 0
	GA_MAINDATA1: equ 4
	GA_MAINDATA2: equ 8
	GA_MAINDATA3: equ $C
GA_COMM_SUBDATA     equ $A12020 ; Read-only
	GA_SUBDATA0:  equ 0
	GA_SUBDATA1:  equ 4
	GA_SUBDATA2:  equ 8
	GA_SUBDATA3:  equ $C
