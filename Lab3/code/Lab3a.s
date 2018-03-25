/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global WelcomePrompt
.extern iprintf
.extern cr
.extern value
.extern getstring
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3a.s *********************************************/
/* Names of Students: Arun Woosaree and Navras Kamal             **/
/* Date: March 5, 2018                                           **/
/* General Description:                                          **/
/* Takes in values with prompts for the statistics calculator    **/
/******************************************************************/
WelcomePrompt:
/*Write your program here******************************************/

/* getstr stores value in d0*/
/* iprintf pops last thing on stack and prints it */

/* allocate 44 bytes because we are using up to 11 registers*/
/* 11*44 = 44 bytes*/
suba.l #44, %sp

/* back up register contents  onto the stack*/
movem.l %a2-%a6/%d2-%d7, (%sp)

lea 0x2300000, %a2

/*----------------------------------*/
pea WelcomeMessage
/*print the welcome message*/
jsr iprintf
jsr cr
/*clean up stack*/
addq.l #4 , %sp
bra numentries
/*------------------------------
----------------------------------
-----------------------------------
/*---------------------------------*/
failnumentries:
pea INVALIDENTRY
jsr iprintf
jsr cr
/*clean up stack*/
addq.l #4 , %sp
bra numentries

numentries:
/*prompt number of entries*/
pea Plztellusnumentries
jsr iprintf
jsr cr
/*clean up stack*/
addq.l #4, %sp
jsr getstring


/*sanitize input*/
cmp.l #15, %d0
bgt failnumentries
cmp.l #3, %d0
blt failnumentries

/*success, replace value on stack*/
move.l %d0, 52(%sp)

/*counter used for loop*/
move.l %d0, %d7

/*print what user entered*/
move.l %d0, -(%sp)
jsr value
jsr cr
addq.l #4, %sp
bra divisor
/*----------------------------------------------
----------------------------------------------------
-----------------------------------------------------
/*-----------------------------------------------*/
faildivisor:
pea INVALIDENTRY
jsr iprintf
jsr cr
/*clean up stack*/
addq.l #4 , %sp

divisor:
/*divisor*/
pea Plztellusdivisor
jsr iprintf
jsr cr
/*cleanup stack*/
addq.l #4, %sp
/*get the string*/
jsr getstring
/*sanitize input*/

cmp.l #5, %d0
bgt faildivisor
cmp.l #2, %d0
blt faildivisor

/*success, replace value on stack*/
move.l %d0, 48(%sp)

/*print what user entered*/
move.l %d0, -(%sp)
jsr value
jsr cr
addq.l #4, %sp

bra loopvals
/*---------------------------------------------------
------------------------------------------------------
-------------------------------------------------------
/*----------------------------------------------------*/
failloopvals:
pea INVALIDENTRY
jsr iprintf
jsr cr
/*clean up stack*/
addq.l #4 , %sp

loopvals:
/*get first n-1 numbers*/
pea Plzenternumber
jsr iprintf
jsr cr
/*clean up stack*/
addq.l #4, %sp

/*get the string and push onto stack*/
jsr getstring
/*sanitize input*/
/*positive only*/
cmp.l #1, %d0
blt failloopvals
/*success,  move to memory location*/
move.l %d0, (%a2)+
sub.l #1, %d7


/*print what user entered*/
move.l %d0, -(%sp)
jsr value
jsr cr
addq.l #4, %sp

cmp.l #1, %d7
beq lastnum
bra loopvals
/*---------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
/*-----------------------------------------------------------*/
faillastnum:
pea INVALIDENTRY
jsr iprintf
jsr cr
/*clean up stack*/
addq.l #4 , %sp

lastnum:
/*get the last number*/
pea Plzenterlastnum
jsr iprintf
jsr cr
/*clean up stack*/
addq.l #4, %sp

/*get the string and push onto stack*/
jsr getstring
/*sanitize input*/

cmp.l #1, %d0
blt faillastnum

/*success, move to memory location*/
move.l %d0, (%a2)+

/*print what user entered*/
move.l %d0, -(%sp)
jsr value
jsr cr
addq.l #4, %sp

/* restore values */
movem.l (%sp), %a2-%a6/%d2-%d7
add.l #44, %sp

/* return to original program */
rts

/*End of Subroutine **************************************************/

/*All Strings placed here **************************************************/
.data

WelcomeMessage:
.string "Welcome to our amazing statistics program"

Plztellusnumentries:
.string "Please enter the number (3min-15max) of entries followed by enter"

Plztellusdivisor:
.string "Please enter the divisor (2min-5max) followed by enter"

Plzenternumber:
.string "Please enter a number(positive only)"

Plzenterlastnum:
.string "Please enter the last number (positive only)"

INVALIDENTRY:
.string "Invalid entry, please enter proper value."
/*End of Strings **************************************************/
