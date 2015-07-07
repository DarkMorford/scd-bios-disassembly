;   ======================================================================
;       CDC register addresses
;   ======================================================================

;   Read
CDC_READ_COMIN   equ $0
CDC_READ_IFSTAT  equ $1
CDC_READ_DBCL    equ $2
CDC_READ_DBCH    equ $3
CDC_READ_HEAD0   equ $4
CDC_READ_HEAD1   equ $5
CDC_READ_HEAD2   equ $6
CDC_READ_HEAD3   equ $7
CDC_READ_PTL     equ $8
CDC_READ_PTH     equ $9
CDC_READ_WAL     equ $A
CDC_READ_WAH     equ $B
CDC_READ_STAT0   equ $C
CDC_READ_STAT1   equ $D
CDC_READ_STAT2   equ $E
CDC_READ_STAT3   equ $F

;   Write
CDC_WRITE_SBOUT  equ $0
CDC_WRITE_IFCTRL equ $1
CDC_WRITE_DBCL   equ $2
CDC_WRITE_DBCH   equ $3
CDC_WRITE_DACL   equ $4
CDC_WRITE_DACH   equ $5
CDC_WRITE_DTTRG  equ $6
CDC_WRITE_DTACK  equ $7
CDC_WRITE_WAL    equ $8
CDC_WRITE_WAH    equ $9
CDC_WRITE_CTRL0  equ $A
CDC_WRITE_CTRL1  equ $B
CDC_WRITE_PTL    equ $C
CDC_WRITE_PTH    equ $D
CDC_WRITE_CTRL2  equ $E
CDC_WRITE_RESET  equ $F
