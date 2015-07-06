;   ======================================================================
;       Gate Array registers
;   ======================================================================

GA_INTERRUPT    equ $A12000
GA_RESET_HALT   equ $A12001
GA_PROTECT      equ $A12002
GA_MEM_MODE     equ $A12003

;   CDC
GA_CDC_MODE     equ $A12004 ; Read-only
GA_HINT_VECTOR  equ $A12006
GA_CDC_DATA     equ $A12008 ; Read-only
GA_STOPWATCH    equ $A1200C ; Read-only

;   Communication
GA_COMM_MAINFLAGS   equ $A1200E
GA_COMM_SUBFLAGS    equ $A1200F ; Read-only
GA_COMM_MAINDATA    equ $A12010
GA_COMM_SUBDATA     equ $A12020 ; Read-only
