; Copyright (c) 2023 Carsten Elton Sørensen
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

	IFND	F256_I_
F256_I_ = 1

FLASH:	MACRO
	MMU_ENABLE_IO_PAGE IO
.spin\@	inc	VKY_BKG_\1
	bra	.spin\@
	ENDM

HALT:	MACRO
.halt\@	bra	.halt\@
	ENDM

; ---------------------------------------------------------------------------
; -- MMU registers in zero page
; ---------------------------------------------------------------------------

; Register #0 - MMU_MEM_CTRL
MMU_MEM_CTRL	EQU	$00

MMU_EDIT_EN	EQU	$80
MMU_EDIT_LUT_0	EQU	$00
MMU_EDIT_LUT_1	EQU	$10
MMU_EDIT_LUT_2	EQU	$20
MMU_EDIT_LUT_3	EQU	$30
MMU_EDIT_LUT_MASK EQU	$30
MMU_ACT_LUT_0	EQU	$00
MMU_ACT_LUT_1	EQU	$01
MMU_ACT_LUT_2	EQU	$02
MMU_ACT_LUT_3	EQU	$03
MMU_ACT_LUT_MASK EQU	$03

; Register #1 - MMU_IO_CTRL
MMU_IO_CTRL	EQU	$01

MMU_IO_ENABLE	EQU	$00
MMU_IO_DISABLE	EQU	$04
MMU_IO_PAGE_0	EQU	$00
MMU_IO_PAGE_1	EQU	$01
MMU_IO_PAGE_2	EQU	$02
MMU_IO_PAGE_3	EQU	$03
MMU_IO_PAGE_IO		EQU	$00
MMU_IO_PAGE_FONT_GLUT	EQU	$01
MMU_IO_PAGE_TEXT_CHARS	EQU	$02
MMU_IO_PAGE_TEXT_COLOR	EQU	$03

MMU_EDIT_BASE	EQU	$08

MMU_PUSH_CTRL:	MACRO
		ldy	MMU_IO_CTRL
		phy
		ENDM

MMU_POP_CTRL:	MACRO
		ply
		sty	MMU_IO_CTRL
		ENDM

MMU_ENABLE_IO_PAGE:	MACRO
		IF	MMU_IO_PAGE_\1==0
		stz	MMU_IO_CTRL
		ELSE
		ldy	#MMU_IO_ENABLE|MMU_IO_PAGE_\1
		sty	MMU_IO_CTRL
		ENDC
		ENDM

IO_WINDOW	EQU	$C000


; ---------------------------------------------------------------------------
; -- Registers in IO bank #0
; ---------------------------------------------------------------------------


; ---------------------------------------------------------------------------
; -- TinyVicky master control registers
; ---------------------------------------------------------------------------

; Vicky Master Control Register 0
VKY_MSTR_CTRL0		EQU	$D000 

MSTR_CTRL0_GAMMA	EQU	$40
MSTR_CTRL0_SPRITE	EQU	$20
MSTR_CTRL0_TILE		EQU	$10
MSTR_CTRL0_BITMAP	EQU	$08
MSTR_CTRL0_GRAPH	EQU	$04
MSTR_CTRL0_OVRLY	EQU	$02
MSTR_CTRL0_TEXT		EQU	$01

; Vicky Master Control Register 1
VKY_MSTR_CTRL1		EQU	$D001

MSTR_CTRL1_FON_SET	EQU	$20
MSTR_CTRL1_FON_OVRLY	EQU	$10
MSTR_CTRL1_MON_SLP	EQU	$08
MSTR_CTRL1_DBL_Y	EQU	$04
MSTR_CTRL1_DBL_X	EQU	$02
MSTR_CTRL1_CLK_70	EQU	$01


; ---------------------------------------------------------------------------
; -- Background and border color
; ---------------------------------------------------------------------------

; Vicky Border Control Registers
VKY_BRDR_CTRL	EQU	$D004

BRDR_SCROLL_X_MASK	EQU	$70
BRDR_ENABLE		EQU	$01

VKY_BDR_BLUE	EQU	$D005 ; Border Color Blue
VKY_BDR_GREEN	EQU	$D006 ; Border Color Green
VKY_BDR_RED	EQU	$D007 ; Border Color Red

VKY_BDR_WIDTH	EQU	$D008 ; Border Width 0-31
VKY_BDR_HEIGHT	EQU	$D009 ; Border Width 0-31

; Background color
VKY_BKG_BLUE	EQU	$D00D ; Background Color Blue
VKY_BKG_GREEN	EQU	$D00E ; Background Color Green
VKY_BKG_RED	EQU	$D00F ; Background Color Red


; ---------------------------------------------------------------------------
; -- Text cursor
; ---------------------------------------------------------------------------

; Control register

VKY_CRSR_CTRL	EQU	$D010

CRSR_FLASH_DIS		EQU	$08
CRSR_FLASH_RATE_0	EQU	$00
CRSR_FLASH_RATE_1	EQU	$02
CRSR_FLASH_RATE_2	EQU	$04
CRSR_FLASH_RATE_3	EQU	$06
CRSR_ENABLE		EQU	$01

VKY_CRSR_CHAR	EQU	$D012
VKY_CRSR_X_LO	EQU	$D014
VKY_CRSR_X_HI	EQU	$D015
VKY_CRSR_Y_LO	EQU	$D016
VKY_CRSR_Y_HI	EQU	$D017


; ---------------------------------------------------------------------------
; -- Raster beam
; ---------------------------------------------------------------------------

; Line interrupt
VKY_LINT_CTRL_W	EQU	$D018 ; Write only
VKY_LINT_LO_W	EQU	$D019 ; Write only
VKY_LINT_HI_W	EQU	$D01A ; Write only

LINT_ENABLE	EQU	$01

; Raster position
VKY_RAST_X_LO_R	EQU	$D018 ; Read only
VKY_RAST_X_HI_R	EQU	$D019 ; Read only
VKY_RAST_Y_LO_R	EQU	$D01A ; Read only
VKY_RAST_Y_HI_R	EQU	$D01B ; Read only


; ---------------------------------------------------------------------------
; -- Keyboard and mouse
; ---------------------------------------------------------------------------

PS2_CTRL	EQU	$D640	; R/W
PS2_OUT		EQU	$D641	; R/W
PS2_KBD_IN	EQU	$D642	; Read only
PS2_MS_IN	EQU	$D643	; Read only
PS2_STAT	EQU	$D644	; Read only

PS2_CTRL_K_WR	EQU	$02	; set to 1 then 0 to send a byte written on PS2_OUT to the keyboard
PS2_CTRL_M_WR	EQU	$08	; set to 1 then 0 to send a byte written on PS2_OUT to the mouse
PS2_CTRL_KCLR	EQU	$10	; set to 1 then 0 to clear the keyboard input FIFO queue.
PS2_CTRL_MCLR	EQU	$20	; set to 1 then 0 to clear the mouse input FIFO queue.

PS_STAT_K_AK	EQU	$80	; when 1, the code sent to the keyboard has been acknowledged
PS_STAT_K_NK	EQU	$40	; when 1, the code sent to the keyboard has resulted in an error
PS_STAT_M_AK	EQU	$20	; when 1, the code sent to the mouse has been acknowledged
PS_STAT_M_NK	EQU	$10	; when 1, the code sent to the mouse has resulted in an error
PS_STAT_MEMP	EQU	$02	; when 1, the mouse input FIFO is empty
PS_STAT_KEMP	EQU	$01	; when 1, the keyboard input FIFO is empty


; ---------------------------------------------------------------------------
; -- Interupt controller
; ---------------------------------------------------------------------------

INT_PENDING_0	EQU	$D660
INT_POLARITY_0	EQU	$D664
INT_EDGE_0	EQU	$D668
INT_MASK_0	EQU	$D66C

INT_PENDING_1	EQU	$D661
INT_POLARITY_1	EQU	$D665
INT_EDGE_1	EQU	$D669
INT_MASK_1	EQU	$D66D

INT_PENDING_2	EQU	$D662
INT_POLARITY_2	EQU	$D666
INT_EDGE_2	EQU	$D66A
INT_MASK_2	EQU	$D66E

; Group 0 interrupts
INT_VKY_SOF	EQU	$01	; TinyVicky Start Of Frame interrupt.
INT_VKY_SOL	EQU	$02	; TinyVicky Start Of Line interrupt
INT_PS2_KBD	EQU	$04	; PS/2 keyboard event
INT_PS2_MOUSE	EQU	$08	; PS/2 mouse event
INT_TIMER_0	EQU	$10	; TIMER0 has reached its target value
INT_TIMER_1	EQU	$20	; TIMER1 has reached its target value
INT_CART	EQU	$80	; Interrupt asserted by the cartidge

; Group 1 interrupts
INT_UART	EQU	$01	; The UART is ready to receive or send data
INT_RTC		EQU	$10	; Event from the real time clock chip
INT_VIA0	EQU	$20	; Event from the 65C22 VIA chip
INT_VIA1	EQU	$40	; F256k Only: Local keyboard
INT_SDC_INS	EQU	$80 	; User has inserted an SD card

; Group 2 interrupts
IEC_DATA_i	EQU	$01	; IEC Data In
IEC_CLK_i	EQU	$02	; IEC Clock In
IEC_ATN_i	EQU	$04	; IEC ATN In
IEC_SREQ_i	EQU	$08	; IEC SREQ In


; ---------------------------------------------------------------------------
; -- System control
; ---------------------------------------------------------------------------

; System Control #0
SYS_CTRL0	EQU	$D6A0

SYS_CTRL0_SD_LED	EQU	$02
SYS_CTRL0_POWER_LED	EQU	$01

; System Control #1
SYS_CTRL1	EQU	$D6A1


; ---------------------------------------------------------------------------
; -- Random number generator
; ---------------------------------------------------------------------------

RND_SEED_L	EQU	$D6A4	; Write
RND_SEED_H	EQU	$D6A5	; Write
RND_CTRL	EQU	$D6A6	; Write

RND_CTRL_LOAD	EQU	$02	; load seed
RND_CTRL_ENABLE	EQU	$01

RND_RND_L	EQU	$D6A4	; Read
RND_RND_H	EQU	$D6A4	; Read
RND_STAT	EQU	$D6A4	; Read

RND_STAT_DONE	EQU	$80


; ---------------------------------------------------------------------------
; -- Text LUT
; ---------------------------------------------------------------------------

TXT_FGND_LUT	EQU	$D800
TXT_BGND_LUT	EQU	$D840

; ---------------------------------------------------------------------------
; -- Sprites
; ---------------------------------------------------------------------------

; Sprite registers
VKY_SPRITE_BASE	EQU	$D900

		RSRESET
SPR_CTRL	RB	1
SPR_ADDR_L	RB	1
SPR_ADDR_M	RB	1
SPR_ADDR_H	RB	1
SPR_X_L		RB	1
SPR_X_H		RB	1
SPR_Y_L		RB	1
SPR_Y_H		RB	1
SPR_SIZEOF	RB	0

SPR_CTRL_ENABLE		EQU	$01
SPR_CTRL_LUT_0		EQU	$00
SPR_CTRL_LUT_1		EQU	$02
SPR_CTRL_LUT_2		EQU	$04
SPR_CTRL_LUT_3		EQU	$06
SPR_CTRL_LAYER_0	EQU	$00
SPR_CTRL_LAYER_1	EQU	$08
SPR_CTRL_LAYER_2	EQU	$10
SPR_CTRL_LAYER_3	EQU	$18
SPR_CTRL_SIZE_32	EQU	$00
SPR_CTRL_SIZE_24	EQU	$20
SPR_CTRL_SIZE_16	EQU	$40
SPR_CTRL_SIZE_8		EQU	$60

VKY_TOTAL_SPRITES	EQU	64

		RSSET	VKY_SPRITE_BASE
VKY_SPRITE_0	RB	SPR_SIZEOF
VKY_SPRITE_1	RB	SPR_SIZEOF
VKY_SPRITE_2	RB	SPR_SIZEOF
VKY_SPRITE_3	RB	SPR_SIZEOF
VKY_SPRITE_4	RB	SPR_SIZEOF
VKY_SPRITE_5	RB	SPR_SIZEOF
VKY_SPRITE_6	RB	SPR_SIZEOF
VKY_SPRITE_7	RB	SPR_SIZEOF
VKY_SPRITE_8	RB	SPR_SIZEOF
VKY_SPRITE_9	RB	SPR_SIZEOF
VKY_SPRITE_10	RB	SPR_SIZEOF
VKY_SPRITE_11	RB	SPR_SIZEOF
VKY_SPRITE_12	RB	SPR_SIZEOF
VKY_SPRITE_13	RB	SPR_SIZEOF
VKY_SPRITE_14	RB	SPR_SIZEOF
VKY_SPRITE_15	RB	SPR_SIZEOF
VKY_SPRITE_16	RB	SPR_SIZEOF
VKY_SPRITE_17	RB	SPR_SIZEOF
VKY_SPRITE_18	RB	SPR_SIZEOF
VKY_SPRITE_19	RB	SPR_SIZEOF
VKY_SPRITE_20	RB	SPR_SIZEOF
VKY_SPRITE_21	RB	SPR_SIZEOF
VKY_SPRITE_22	RB	SPR_SIZEOF
VKY_SPRITE_23	RB	SPR_SIZEOF
VKY_SPRITE_24	RB	SPR_SIZEOF
VKY_SPRITE_25	RB	SPR_SIZEOF
VKY_SPRITE_26	RB	SPR_SIZEOF
VKY_SPRITE_27	RB	SPR_SIZEOF
VKY_SPRITE_28	RB	SPR_SIZEOF
VKY_SPRITE_29	RB	SPR_SIZEOF
VKY_SPRITE_30	RB	SPR_SIZEOF
VKY_SPRITE_31	RB	SPR_SIZEOF
VKY_SPRITE_32	RB	SPR_SIZEOF
VKY_SPRITE_33	RB	SPR_SIZEOF
VKY_SPRITE_34	RB	SPR_SIZEOF
VKY_SPRITE_35	RB	SPR_SIZEOF
VKY_SPRITE_36	RB	SPR_SIZEOF
VKY_SPRITE_37	RB	SPR_SIZEOF
VKY_SPRITE_38	RB	SPR_SIZEOF
VKY_SPRITE_39	RB	SPR_SIZEOF
VKY_SPRITE_40	RB	SPR_SIZEOF
VKY_SPRITE_41	RB	SPR_SIZEOF
VKY_SPRITE_42	RB	SPR_SIZEOF
VKY_SPRITE_43	RB	SPR_SIZEOF
VKY_SPRITE_44	RB	SPR_SIZEOF
VKY_SPRITE_45	RB	SPR_SIZEOF
VKY_SPRITE_46	RB	SPR_SIZEOF
VKY_SPRITE_47	RB	SPR_SIZEOF
VKY_SPRITE_48	RB	SPR_SIZEOF
VKY_SPRITE_49	RB	SPR_SIZEOF
VKY_SPRITE_50	RB	SPR_SIZEOF
VKY_SPRITE_51	RB	SPR_SIZEOF
VKY_SPRITE_52	RB	SPR_SIZEOF
VKY_SPRITE_53	RB	SPR_SIZEOF
VKY_SPRITE_54	RB	SPR_SIZEOF
VKY_SPRITE_55	RB	SPR_SIZEOF
VKY_SPRITE_56	RB	SPR_SIZEOF
VKY_SPRITE_57	RB	SPR_SIZEOF
VKY_SPRITE_58	RB	SPR_SIZEOF
VKY_SPRITE_59	RB	SPR_SIZEOF
VKY_SPRITE_60	RB	SPR_SIZEOF
VKY_SPRITE_61	RB	SPR_SIZEOF
VKY_SPRITE_62	RB	SPR_SIZEOF
VKY_SPRITE_63	RB	SPR_SIZEOF



; ---------------------------------------------------------------------------
; -- Registers in IO bank #1 (Font sets and graphics LUTs)
; ---------------------------------------------------------------------------

DB_RGB:		MACRO
		DB	\3,\2,\1,0
		ENDM

VKY_FONT_0	EQU	$C000
VKY_FONT_1	EQU	$C800
VKY_GR_CLUT_0	EQU	$D000
VKY_GR_CLUT_1	EQU	$D400
VKY_GR_CLUT_2	EQU	$D800
VKY_GR_CLUT_3	EQU	$DC00


; ---------------------------------------------------------------------------
; -- Registers in IO bank #2 (Text character matrix)
; ---------------------------------------------------------------------------

VKY_TEXT_CHARS	EQU	$C000

; ---------------------------------------------------------------------------
; -- Registers in IO bank #3 (Text color matrix)
; ---------------------------------------------------------------------------

VKY_TEXT_COLOR	EQU	$C000


	ENDC
