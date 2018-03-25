 /* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global Display
.extern iprintf
.extern cr
.extern value
.extern getstring
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab3c.s **************************************/
/* Names of Students: Arun Woosaree and Navras Kamal             **/
/* Date: March 16 2018                                           **/
/* General Description:                                          **/
/* Prints the results of calculation from the stats subroutine   **/
/******************************************************************/
Display:
/*Write your program here******************************************/
/* backup values */
suba.l #60, %sp
movem.l %a0-%a6/%d0-%d7, (%sp)


lea 0x2300000, %a2 /* numbers are here */
lea 0x2310000, %a3 /*divisible numbers stored here*/

move.l 72(%sp) , %d7 /* divisor*/
move.l 76(%sp), %d6/* numentries*/
move.l 80(%sp), %d5/*numdivisible*/

jsr cr
/* tell user numentries*/
pea numentries
jsr iprintf
move.l %d6, -(%sp)
jsr value
jsr cr
jsr cr
adda.l #8, %sp

/* print numbers */
pea numbers
jsr iprintf
adda.l #4, %sp
jsr cr

loopnumbers:
move.l (%a2)+, -(%sp)
jsr value
jsr cr
adda.l #4, %sp
subq.l #1, %d6
bne loopnumbers

jsr cr
/*min*/
pea min
jsr iprintf
move.l (%a3)+, -(%sp)
jsr value
jsr cr
jsr cr
adda.l #8, %sp

/*max*/
pea max
jsr iprintf
move.l (%a3)+, -(%sp)
jsr value
jsr cr
jsr cr
adda.l #8, %sp

/*mean*/
pea mean
jsr iprintf
move.l (%a3)+, -(%sp)
jsr value
jsr cr
jsr cr
adda.l #8, %sp

/*print num divisible*/
pea numdivisible
jsr iprintf
move.l %d5, -(%sp)
jsr value
pea numdivisible2
jsr iprintf
move.l %d7, -(%sp)
jsr value
jsr cr
adda.l #16, %sp

loopdivisible:
move.l (%a3)+, -(%sp)
jsr value
jsr cr
adda.l #4, %sp

subq.l #1, %d5
bne loopdivisible

/*restore values*/
movem.l (%sp), %a0-%a6/%d0-%d7
adda.l #60 , %sp
rts

/*End of Subroutine **************************************************/
.data
/*All Strings placed here **************************************************/
numentries:
.string "The number of entries was: "

numbers:
.string "The entered number(s) were: "

min:
.string "Min number: "

max:
.string "Max number: "

mean:
.string "Mean number: "

numdivisible:
.string "There are "
numdivisible2:
.string " number(s) divisible by "

endprogram:
.string "End of program"



/*End of Strings **************************************************/
