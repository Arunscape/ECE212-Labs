/* DO NOT MODIFY THIS --------------------------------------------*/
.text

.global AssemblyProgram

AssemblyProgram:
lea      -40(%a7),%a7 /*Backing up data and address registers */
movem.l %d2-%d7/%a2-%a5,(%a7)
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab2.s *********************************************/
/* Names of Students: Arun Woosaree and Navras Kamal             **/
/* Date: February 12, 2018                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/

/*Write your program here******************************************/


move.l 0x2300000, %d0 /*total # of points*/
sub.l #1, %d0
move.l 0x2300004, %a0 /*address of x points*/
move.l 0x2300008, %a1 /*address of y points*/
move.l 0x2300010, %a2 /*output final answer here*/
clr.l %d1 /*reset counter*/
clr.l %d7 /*reset total area*/

move.l (%a0)+, %d2 /*store initial x0*/
move.l (%a1)+, %d3 /*store initial y0*/

mainloop:
cmp.l %d0, %d1 /*check if all points have been used*/
beq endloop /*if they have been, end*/
add.l #1, %d1 /*otherwise increment counter variable*/

move.l (%a0)+, %d4 /*store x1*/
move.l (%a1)+, %d5 /*store y1*/

add.l %d5, %d3 /*a+b*/

sub.l %d4, %d2 /*h*/
neg.l %d2
cmp.l #2, %d2 /*is h 2??*/
bne skp
asl.l #1, %d3 /*multiply by 2 if it is*/

skp:
add.l %d3, %d7 /*add result to final answer*/
move.l %d4, %d2 /*set x0 to current x1*/
move.l %d5, %d3 /*set y0 to current y1*/

bra mainloop /*restart mainloop*/

endloop:
/*
move.l %d7, %d6
and.l #0b1, %d6
cmpl #0, %d6
bne skppy
add.l #1, %d7
*/
skppy:
asr.l #1, %d7
move.l %d7, (%a2)
/*End of program **************************************************/

/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 /*Restore data and address registers */
lea      40(%a7),%a7 
rts
/*----------------------------------------------------------------*/
