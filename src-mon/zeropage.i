	IFND	ZEROPAGE_I_INCLUDED_
ZEROPAGE_I_INCLUDED_ = 1

		RSSET 16
pcb		RB 1
pch		RB 1
pcl		RB 1
flgs		RB 1
acc		RB 1
xr		RB 1
yr		RB 1
sp		RB 1

monsp		RB 1

t0		RB 3
t1		RB 3
t2		RB 3

txtptr		RB 1	; = $7a

mode		RB 1	; = $d7
ndx		RB 1	; = $d0
tmpc		RB 1	; = $9f
verck		RB 1	; = $93

;kernal definitions
;fa	RB 1	; = $ba
;fnadr	RB 2	; = $bb
;fnlen	RB 1	; = $b7
;sa	RB 1	; = $b9
;status	RB 1	; = $90
;ba	RB 1	; = $c6
;fnbnk	RB 1	; = $c7

; temp registers

r0		RB 1
r1		RB 1
r2		RB 1
r3		RB 1

kbd_StopDown	RB 1
kbd_State	RB 1	; 0 = normal, 1 = ignore next, 2 = next is extended table
kbd_Shift	RB 1

text_CurrentLine RW 1
text_CursorX RB 1
text_CursorY RB 1

kbd_Sending	RB 1	; %0xxxxxxx = sending
kbd_LineLength	RB 1


	ENDC