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

	IFND	MONITORVECTORS_I_
MONITORVECTORS_I_ = 1

MONITOR_BASE		EQU	$0000
MONITOR_VECTOR_BASE	EQU	MONITOR_BASE+$0200
TRAMPOLINE_BASE		EQU	$FE00	; must be page aligned

MONITOR_VECTOR_SIZE	EQU	2

			RSRESET
monitor_Initialize	RB	MONITOR_VECTOR_SIZE
monitor_BRK		RB	MONITOR_VECTOR_SIZE
monitor_NMI		RB	MONITOR_VECTOR_SIZE
monitor_Enter		RB	MONITOR_VECTOR_SIZE
monitor_SetLUT		RB	MONITOR_VECTOR_SIZE
monitor_SetFont		RB	MONITOR_VECTOR_SIZE
monitor_ShowScreen	RB	MONITOR_VECTOR_SIZE
monitor_HideScreen	RB	MONITOR_VECTOR_SIZE
monitor_ClearScreen	RB	MONITOR_VECTOR_SIZE
monitor_CharOut		RB	MONITOR_VECTOR_SIZE
monitor_ShowCursor	RB	MONITOR_VECTOR_SIZE
monitor_HideCursor	RB	MONITOR_VECTOR_SIZE
monitor_ReadChar	RB	MONITOR_VECTOR_SIZE
monitor_TryReadChar	RB	MONITOR_VECTOR_SIZE
monitor_EditLine	RB	MONITOR_VECTOR_SIZE

	ENDC