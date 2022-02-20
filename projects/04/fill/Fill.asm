// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(KEYPRESS)

    @KBD
    D=M

    // if nothing is pressed
    @BLANK
    D;JEQ

    // if a key is pressed
    @BLACK
    D;JGT

    @KEYPRESS
    0;JMP

(BLANK)
    @R0
    M=0
    @FILL
    0;JMP

(BLACK)
    @R0
    M=-1
    @FILL
    0;JMP

(FILL)

    // set address to keyboard (screen memory goes to KBD-1)
    @KBD
    D=A-1

    // store current address in @addr
    @addr
    M=D

(FILL_LOOP)

    // get the fill or clear
    @R0
    D=M
    // M=M-1 // address - 1

    @addr
    A=M     // get the address stored
    M=D     // value in that position gets set to fill or clear

    @addr
    D=M     // store current position in D
    M=M-1   // decrement

    // Make sure we only loop while within screen memory
    @SCREEN
    D=D-A
    @FILL_LOOP
    D;JGT

    // look for more keypresses
    @KEYPRESS
    0;JMP
