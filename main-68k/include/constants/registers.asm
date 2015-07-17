;   ======================================================================
;       SEGA Genesis registers
;   ======================================================================

;   Graphics
VDP_DATA    equ $C00000
VDP_CONTROL equ $C00004
	VDP_EMPT:   equ 9
	VDP_FULL:   equ 8
	VDP_F:      equ 7
	VDP_SOVR:   equ 6
	VDP_C:      equ 5
	VDP_ODD:    equ 4
	VDP_VB:     equ 3
	VDP_HB:     equ 2
	VDP_DMA:    equ 1
	VDP_PAL:    equ 0
VDP_COUNTER equ $C00008

;   System I/O (Joypad)
MD_VERSION  equ $A10001
	MDV_MODE: equ 7         ; 0: Domestic (JP) model, 1: Overseas model
	MDV_VMOD: equ 6         ; 0: NTSC (7.67 MHz),     1: PAL (7.60 MHz)
	MDV_DISK: equ 5         ; 0: Unit connected,      1: Unit not connected
	MDV_RSV:  equ 4         ; Unused
	MDV_VER3: equ 3
	MDV_VER2: equ 2
	MDV_VER1: equ 1
	MDV_VER0: equ 0

JOYDATA1    equ $A10003
JOYDATA2    equ $A10005
JOYDATA3    equ $A10007
	JOYDATA_PD7:    equ 7
	JOYDATA_PD6:    equ 6
	JOYDATA_TH:     equ 6
	JOYDATA_PD5:    equ 5
	JOYDATA_TR:     equ 5
	JOYDATA_PD4:    equ 4
	JOYDATA_TL:     equ 4
	JOYDATA_PD3:    equ 3
	JOYDATA_PD2:    equ 2
	JOYDATA_PD1:    equ 1
	JOYDATA_PD0:    equ 0

JOYCTRL1    equ $A10009
JOYCTRL2    equ $A1000B
JOYCTRL3    equ $A1000D
	JOYCTRL_INT:    equ 7
	JOYCTRL_PC6:    equ 6
	JOYCTRL_PC5:    equ 5
	JOYCTRL_PC4:    equ 4
	JOYCTRL_PC3:    equ 3
	JOYCTRL_PC2:    equ 2
	JOYCTRL_PC1:    equ 1
	JOYCTRL_PC0:    equ 0

JOYTXDATA1  equ $A1000F
JOYRXDATA1  equ $A10011
JOYSCTRL1   equ $A10013
	JOYSCTRL_BPS1:  equ 7
	JOYSCTRL_BPS0:  equ 6
	JOYSCTRL_SIN:   equ 5
	JOYSCTRL_SOUT:  equ 4
	JOYSCTRL_RINT:  equ 3
	JOYSCTRL_RERR:  equ 2
	JOYSCTRL_RRDY:  equ 1
	JOYSCTRL_TFUL:  equ 0

JOYTXDATA2  equ $A10015
JOYRXDATA2  equ $A10017
JOYSCTRL2   equ $A10019

JOYTXDATA3  equ $A1001B
JOYRXDATA3  equ $A1001D
JOYSCTRL3   equ $A1001F

;   D-RAM dev cartridge
DRAM_MODE   equ $A11000     ; 0: ROM mode, $100: D-RAM mode

;   Z80 subprocessor
Z80_BUSREQ  equ $A11100     ; 0: BUSREQ cancel, $100: BUSREQ request
Z80_RESET   equ $A11200     ; 0: RESET request, $100: RESET cancel
Z80_BANKSEL equ $A06000

;   Audio hardware
FM1_REGSEL  equ $A04000
FM1_DATA    equ $A04001
FM2_REGSEL  equ $A04002
FM2_DATA    equ $A04003
PSG_CTRL    equ $C00011
