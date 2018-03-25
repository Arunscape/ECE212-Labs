/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global Stats
.extern iprintf
.extern cr
.extern value
.extern getstring
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3b.s **************************************/
/* Names of Students: Arun Woosaree and Navras Kamal **/
/* Date: March 5, 2018                                           **/
/* General Description:                                          **/
/* Computes stats on the numbers entered (min mean max)          **/
/******************************************************************/
Stats:
/*Write your program here******************************************/

/* backup values */
suba.l #60, %sp
 movem.l %a0-%a6/%d0-%d7, (%sp)

/*divisor is at 4sp
jsr value
jsr cr
*/
/*numentries is at 8sp*/
/*
move.l 68(%sp), -(%sp)
jsr value
jsr cr
addq.l #4, %sp
*/
move.l 64(%sp), %d0 /* divisor */
move.l 68(%sp) ,%d1 /* numentries */

lea 0x2300000, %a2 /* numbers are here */
lea 0x2310000, %a3 /*divisible numbers stored here*/

move.l %d1, %d7 /*counter*/
move.l (%a2)+, %d5 /*first number*/
findmin:
	loopmin:
	move.l (%a2)+, %d6
	cmp.l %d5, %d6
		bge nochangemin
		move.l %d6, %d5 /* new min */
	nochangemin:
	subq.l #1, %d7
	cmp.l #1, %d7
	bne loopmin
/* min is stored in d5*/
move.l %d5, (%a3)+


/*
move.l %d5, -(%sp)
jsr value
jsr cr
addq.l #4, %sp
*/

lea 0x2300000, %a2 /* numbers are here */

move.l %d1, %d7 /*counter*/
move.l (%a2)+, %d6 /*first number*/
findmax:
	loopmax:
	move.l (%a2)+, %d4
	cmp.l %d6, %d4
		ble nochangemax
		move.l %d4, %d6 /* new max */
	nochangemax:
	subq.l #1, %d7
	cmp.l #1, %d7
	bne loopmax
/*max is stored in d6*/
move.l %d6, (%a3)+
/*
move.l %d6, -(%sp)
jsr value
jsr cr
addq.l #4, %sp
*/


findmean:
	clr.l %d4
	lea 0x2300000, %a2 /* numbers are here */
	move.l %d1, %d7 /*counter*/
	loopaddvalues:
	move.l (%a2)+, %d3
	add.l %d3, %d4
	subq.l #1, %d7
	cmp.l #0, %d7
	bne loopaddvalues
	/* sum in d4*/

	/*divide d4 by numentries*/
	divs.l %d1, %d4

	/* mean should be in d4*/
	move.l %d4, (%a3)+
/*move.l %d4, -(%sp)
jsr value
jsr cr
addq.l #4, %sp
*/


finddivisible:
	lea 0x2300000, %a2 /* numbers are here */

	/* at this point, d6, d5 , d4 store values and therefore should not be touched*/
	/* this is the last time using the numentries, so will modify d1 directly */
	/* ok so d7, d3, and d2 are left free to use*/
	clr.l %d7
	loopdivisible:
	move.l (%a2)+, %d3
	/* copy d3*/
	move.l %d3, %d4

	/* check if it's divisible, divisor is d0*/
	divs.w %d0, %d3
	/* get remainder*/
	lsr.l #8, %d3
	lsr.l #8, %d3
	/*if 0, divisible*/
	bne notdivisible
	/*it is divisible, move copy*/
	move.l %d4 , (%a3)+
	/*increment counter for divisible numbers*/
	addq.l #1, %d7

	notdivisible:
	subq.l #1, %d1
	cmp.l #0, %d1
	bne loopdivisible

	/* d7 holds number of divisible numbers*/

/*move.l %d7, -(%sp)
jsr value
jsr cr
addq.l #4, %sp
*/

move.l %d7, 72(%sp)

movem.l (%sp), %a0-%a6/%d0-%d7
adda.l #60 , %sp
rts
/*End of Subroutine **************************************************/
.data
/*All Strings placed here **************************************************/



/*End of Strings **************************************************/
