# Introduction

This repository contains a version of the TEDMON machine code monitor for the Foenix F256 series of computers. A number of functions useful for simple debugging are also included.

This is not meant for use by end-users, rather it is a tool a programmer may include in their own programs to call and inspect program state.

# Commands

The following TEDMON commands are available. Please consult TEDMON documentation for further details.

|Command|Argument|Function|
|---|---|---|
|A|address instruction|Assembles an instruction and places it in memory|
|C|start thru with|Compares memory ranges|
|D|address|Disassembles code at address|
|F|start to value|Fills memory with byte value|
|G|address|Go (jump) to address|
|H|start to value|Hunt for bytes or string|
|J|address|JSR to subroutine|
|M|address|Dump memory|
|R| N/A |Display registers|
|T|start thru to|Copy memory range|
|X| N/A |Exit|
|$| number |Evaluate hexadecimal number|
|+| number |Evaluate decimal number|
|&| number |Evaluate octal number|
|%| number |Evaluate binary number|
|.|address instruction|Alter disassembly|
| >|address bytes|Alter memory|
|;|registers|Alter registers|

## Addresses and banks
The F256 series provide 512 KiB of RAM, but the 65C02 can only address 64 KiB at a time. An MMU is present to provide the 65C02 with access to all RAM. This MMU has four "LUTs" or configurations where one may be active at a time. The monitor uses five-digit hexdecimal addresses, where the most significant digit is the LUT number. For instance, the address `$2ABCD` refers to the virtual address `$ABCD` as configured by LUT #2.

# Instructions

Two binaries are needed, `monitor.bin` and `trampoline.bin`. These must be included in the user program. The monitor takes up an 8 KiB bank of memory and may be placed anywhere in physical memory. The trampoline must be loaded at virtual address `$FE00`, but the physical location is irrelevant. It is up to the programmer to set this up.

The monitor will assume ownership of MMU LUT #3.

It is up to the programmer to handle interrupts and enter the monitor at the appropriate time.

A test program is also provided, the `test.bin` program can be loaded at address `$2000`. It will enter the monitor so the various monitor functions can be tested.

## Monitor functions
Several functions are available to the programmer:

|Name|Vector|Function|
|---|---|---|
|Initialize| N/A | Initializes the monitor state|
|BRK|$02|Not yet implemented|
|NMI|$04|Not yet implemented|
|Enter|$06|Enter the monitor|
|SetLUT|$08|Set up a basic text screen color LUT|
|SetFont|$0A|Copies an embedded font to the text screen font memory|
|ShowScreen|$0C|Show monitor/debug screen|
|HideScreen|$0E|Hide monitor/debug screen|
|ClearScreen|$10|Clear screen and reset cursor position|
|CharOut|$12|Print a character to the debug screen|
|ShowCursor|$14|Enable cursor|
|HideCursor|$16|Disable cursor|
|ReadChar|$18|Read a character from the keyboard (wait)|
|TryReadChar|$1A|Read a character from the keyboard (return immediatly if none available)
|EditLine|$1C|Use the full screen editor to return a line of input|
|EnterIfChar|$1E|Enter the monitor if key pressed|

## Calling functions
Functions must be called through the trampoline. The trampoline provides two entry points to the programmer - `Initialize` and `Call`. All monitor functions except Initialize must be called using the `Call` entry point.

|Name|Vector|Function|
|---|---|---|
|Initialize|$FE06|Initialize monitor system|
|Call|$FE09|Call monitor function|

## Trampoline function descriptions

### Initialize
Initializes internal state and sets up MMU LUT #3 for monitor use.

Parameters:

`A - monitor physical bank #`

### Call
Call monitor function.

Parameters:

`X - monitor function vector`

See monitor function description for any other parameters.


## Monitor function descriptions

### Enter
Enters the monitor. The monitor will keep running until the user issues the `X` command.

### SetLUT
The monitor assumes a working text screen LUT has been set up by the programmer, but if it hasn't, the LUT may be initialized with this call.

### SetFont
The monitor assumes a working text screen font has been set up by the programmer, but if it hasn't, an embedded font may be copied to text screen font memory by calling this function.

### ShowScreen
Enables the text screen on top of all other graphics.

### HideScreen
Removes the text screen from view.

### ClearScreen
Clears the text mode screen (fills it with space characters) and resets the cursor position to the top left corner.

### CharOut
Prints a single character to the cursor's position and advances the cursor.

Parameters:

`A - character to print`

Special character codes:

|Code|Function|
|---|---|
|5|Delete to the left|
|10|New line|
|13|New line|
|28|Cursor left|
|29|Cursor right|
|30|Cursor up|
|31|Cursor down|

### ShowCursor
Enables cursor display.

### HideCursor
Disables cursor display.

### ReadChar
Reads a character from the keyboard. Waits until one is available.

Returns:

`A - character`

### TryReadChar
Reads a character from the keyboard. Returns immediatly if none is available.

Returns:

`A - character or zero if none is available`

### EditLine
Returns a line of text from the screen editor. Characters are returned one by one and terminated with the `CR` character (`$0C`)

Returns:

`A - character or $0C when no more characters are available`

### EnterIfChar
Enters the monitor if the specified character has been input from the keyboard. Returns immediatly if not.

Input:

`A - character`

# License
Portions of this software is covered by the MIT license. The source files to which the license applies are clearly.