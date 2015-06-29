;=======================================================================
;	cdbios.i -- include file of CD-BIOS define
;	Copyright(c) 1991 eMuKei
;	Written by eMuKei			on Mar.13,1991(Ver.0.10)
;	Updated					on Apr. 5,1991(Ver.0.20)
;	Updated					on Apr.11,1991(Ver.0.30)
;	Updated					on Apr.15,1991(Ver.0.31)
;	Updated (BOOT)				on Jul.27,1991(Ver.0.40)
;	Updated (MSCSEEK1)			on Spt.18,1991(Ver.0.50)
;	Updated (BRM___)			on Spt.30,1991(Ver.0.60)
;	Updated (SCD___)			on Oct. 3,1991(Ver.0.70)
;	Updated (LED___)			on Oct.11,1991(Ver.0.80)
;	Updated (CDBPAUSE)			on Oct.17,1991(Ver.0.81)
;	Updated (CDCSTARTM)			on Oct.24,1991(Ver.0.82)
;	Updated (SCDINIT)			on Oct.27,1991(Ver.0.83)
;	Updated (WONDER___)			on Oct.30,1991(Ver.0.84)
;=======================================================================
;-----------------------------------------------------------------------
;	CONSTANT
;-----------------------------------------------------------------------
ENDOFTOCTBL	equ	-1
LEDREADY	equ	0
LEDDISCIN	equ	1
LEDACCESS	equ	2
LEDSTANDBY	equ	3
LEDERROR	equ	4
LEDMODE5	equ	5
LEDMODE6	equ	6
LEDMODE7	equ	7
LEDSYSTEM	equ	-1
SCDSCRATCHSIZE	equ	$750
BRMSCRATCHSIZE	equ	$640
;-----------------------------------------------------------------------
;	REQUEST CODE
;-----------------------------------------------------------------------
MSCSTOP		equ	$0002		;
MSCPAUSEON	equ	$0003		;
MSCPAUSEOFF	equ	$0004		;
MSCSCANFF	equ	$0005		;
MSCSCANFR	equ	$0006		;
MSCSCANOFF	equ	$0007		;
ROMPAUSEON	equ	$0008		;
ROMPAUSEOFF	equ	$0009		;
DRVOPEN		equ	$000a		;
;
DRVINIT		equ	$0010		;(N)
MSCPLAY		equ	$0011		;(N)
MSCPLAY1	equ	$0012		;(N)
MSCPLAYR	equ	$0013		;(N)
MSCPLAYT	equ	$0014		;(T)
MSCSEEK		equ	$0015		;(N)
MSCSEEKT	equ	$0016		;(T)
ROMREAD		equ	$0017		;(S)
ROMSEEK		equ	$0018		;(S)
MSCSEEK1	equ	$0019		;(N)
;
TESTENTRY	equ	$001e
TESTENTRYLOOP	equ	$001f
ROMREADN	equ	$0020		;(S,N)
ROMREADE	equ	$0021		;(S,S)
;-----------------------------------------------------------------------
CDBCHK		equ	$0080		;
CDBSTAT		equ	$0081		;
CDBTOCWRITE	equ	$0082		;
CDBTOCREAD	equ	$0083		;
CDBPAUSE	equ	$0084		;
FDRSET		equ	$0085		;
FDRCHG		equ	$0086		;
CDCSTART	equ	$0087		;
CDCSTARTM	equ	$0088		;
CDCSTOP		equ	$0089		;
CDCSTAT		equ	$008a		;
CDCREAD		equ	$008b		;
CDCTRN		equ	$008c		;
CDCACK		equ	$008d		;
SCDINIT		equ	$008e		;
SCDSTART	equ	$008f		;
SCDSTOP		equ	$0090		;
SCDSTAT		equ	$0091		;
SCDREAD		equ	$0092		;
SCDPQ		equ	$0093		;
SCDPQL		equ	$0094		;
LEDSET		equ	$0095		;
CDCSETMODE	equ	$0096		;
WONDERREQ	equ	$0097		;
WONDERCHK	equ	$0098		;
;-----------------------------------------------------------------------
CBTINIT		equ	$0000		;
CBTINT		equ	$0001		;
CBTOPENDISC	equ	$0002		;
CBTOPENSTAT	equ	$0003		;
CBTCHKDISC	equ	$0004		;
CBTCHKSTAT	equ	$0005		;
CBTIPDISC	equ	$0006		;
CBTIPSTAT	equ	$0007		;
CBTSPDISC	equ	$0008		;
CBTSPSTAT	equ	$0009		;
;-----------------------------------------------------------------------
BRMINIT		equ	$0000		;
BRMSTAT		equ	$0001		;
BRMSERCH	equ	$0002		;
BRMREAD		equ	$0003		;
BRMWRITE	equ	$0004		;
BRMDEL		equ	$0005		;
BRMFORMAT	equ	$0006		;
BRMDIR		equ	$0007		;
BRMVERIFY	equ	$0008		;
;-----------------------------------------------------------------------
;	JUMP TABLE
;-----------------------------------------------------------------------
_adrerr         equ              $00005F40
_bootstat       equ              $00005EA0
_buram          equ              $00005F16
_cdbios         equ              $00005F22
_cdboot         equ              $00005F1C
_cdstat         equ              $00005E80
_chkerr         equ              $00005F52
_coderr         equ              $00005F46
_deverr         equ              $00005F4C
_level1         equ              $00005F76
_level2         equ              $00005F7C
_level3         equ              $00005F82	;timer interrupt
_level4         equ              $00005F88
_level5         equ              $00005F8E
_level6         equ              $00005F94
_level7         equ              $00005F9A
_nocod0         equ              $00005F6A
_nocod1         equ              $00005F70
_setjmptbl      equ              $00005F0A
_spverr         equ              $00005F5E
_trace          equ              $00005F64
_trap00         equ              $00005FA0
_trap01         equ              $00005FA6
_trap02         equ              $00005FAC
_trap03         equ              $00005FB2
_trap04         equ              $00005FB8
_trap05         equ              $00005FBE
_trap06         equ              $00005FC4
_trap07         equ              $00005FCA
_trap08         equ              $00005FD0
_trap09         equ              $00005FD6
_trap10         equ              $00005FDC
_trap11         equ              $00005FE2
_trap12         equ              $00005FE8
_trap13         equ              $00005FEE
_trap14         equ              $00005FF4
_trap15         equ              $00005FFA
_trperr         equ              $00005F58
_usercall0      equ              $00005F28	;init
_usercall1      equ              $00005F2E	;main
_usercall2      equ              $00005F34	;Vint
_usercall3      equ              $00005F3A	;not define
_usermode       equ              $00005EA6
_waitvsync	equ		 $00005F10
	.end
;=======================================================================
;	end of file
;=======================================================================
