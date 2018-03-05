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


move.l 0x2300000, %d0 /* Stores total number of points to d0 */
sub.l #1, %d0         /* Subtracts one from this value, as one point will be 
                         used in initialization */
move.l 0x2300004, %a0 /* Stores the location of the first x element in a0 */
move.l 0x2300008, %a1 /* Stores the location of the first y element in a1 */
move.l 0x2300010, %a2 /* Stores output location ot a2 */

clr.l %d1 /* Resets counter variable to 0 */
clr.l %d7 /* Resets total area to 0       */

/* The area of the trapezoid will be calculated with the formula 
((x1-x0)*(y0+y1))/2 */

move.l (%a0)+, %d2 /* Move the first x0 to d2, then increment a0 by 4 */
move.l (%a1)+, %d3 /* Move the first y0 to d3, then increment a1 by 4 */

mainloop:      /* The main loop of this function       */
cmp.l %d0, %d1 /* Check if all points have been used   */
beq endloop    /* If they have been, end the loop      */
add.l #1, %d1  /* Otherwise increment the counter by 1 */

move.l (%a0)+, %d4 /* Store the next x1 into d4, then increment a0 by 4 */
move.l (%a1)+, %d5 /* Store the next y1 into d5, then increment a1 by 4 */

add.l %d5, %d3  /* y0 + y1, overwriting the value in d3 */
sub.l %d4, %d2  /* x0 - x1, overwriting the value in d2 */
neg.l %d2       /* Changes the result of the above operation to x1 - x0, 
                   stored in d2 */
cmp.l #2, %d2   /* The value of (x1-x0) can only be 1 or 2.  Compare 
                   the value in d2 to 2 */
bne skp         /* If (x1-x0) is not 2 it is 1, so skip the below operation */
asl.l #1, %d3   /* If (x1-x0) is 2 multiply the value in d3 by 2 using an 
                   arithmetic shift left by 1 */

skp:            /* Jump here to avoid executing the multiplication, or just
                   continue here naturally */
add.l %d3, %d7  /* Add the value stored in d3 to the total sum stored in d7 */
move.l %d4, %d2 /* Set current x1 to be used as the next x0, stored in d2 */
move.l %d5, %d3 /* Set current y1 to be used as the next y0, stored in d3 */

bra mainloop    /* Restart the main loop */

endloop: /* Go here once the above loop is complete */

/* The code below was a test to make sure the result rounded up.  It is not 
tested and not refined.  At the request of the TAs it is here in the code but 
commented out and will not run, as such it is not neccessarily part of our 
final answer for this part of the lab */

/*
move.l %d7, %d6 /* Copy the final answer to d6 */
and.l #0b1, %d6 /* Reduce it to its least significant bit */
cmpl #0, %d6    /* Compare that bit to 0 */
bne skppy       /* If it is zero the number is even, so skip the next line */
add.l #1, %d7   /* If the value is odd then add 1 to the value in d7, this will 
                   make it the next highest nearest number, which when divided 
                   by one will be equivalent to rounding up the division 
                   of the odd value */
skppy:          /* Code will continue here */
*/

asr.l #1, %d7     /* Divide the overall sum by 2, using an arethmetic shift 
                     right by 1, completing the sum of trapezoidal areas */
move.l %d7, (%a2) /* Store the final answer at the appropriate location */





/*End of program **************************************************/

/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 /*Restore data and address registers */
lea      40(%a7),%a7 
rts
/*----------------------------------------------------------------*/
