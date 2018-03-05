/* DO NOT MODIFY THIS --------------------------------------------*/
.text

.global AssemblyProgram

AssemblyProgram:
lea      -40(%a7),%a7 /*Backing up data and address registers */
movem.l %d2-%d7/%a2-%a5,(%a7)
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab2a.s *********************************************/
/* Names of Students: Arun Woosaree and Navras Kamal             **/
/* Date: February 12, 2018                                       **/
/* General Description:                                          **/
/* Exploring different methods of indirect memory address modes  **/
/******************************************************************/

/*Write your program here******************************************/

/*
1.  0x2300000 - Size of array
2.  0x2300004 - address of first array
3.  0x2300008 - address of second array
4.  0x230000C - address of where to store the sum with
                Register Indirect With Offset
5.  0x2300010 - address of where to store the sum with
                Indexed Register Indirect
6.  0x2300014 - address of where to store the sum with
                Postincrement Register Indirect
*/

/*Part A **********************************************************/
/* adding with register indirect with offset */

lea 0x230000C, %a1 /* Location of the array where result will be stored */
lea 0x2300004, %a2 /* Location of the array where address of first array */
lea 0x2300008, %a3 /* Location of the array where address of second array */
move.l (%a1), %a1  /* Set a1 to the location where the result is to be held */
move.l (%a2), %a2  /* Set a2 to the location where the first array begins */
move.l (%a3), %a3  /* Set a3 to the locaiton where the second array begins */

move.l (%a2), %d3 /* Move the first element in the first array to
                     data register d3 */
add.l (%a3), %d3  /* Add the first element in the second array to
                     data register d3 */
move.l %d3, (%a1) /* Move the sum to the first location of the result array */

move.l (0x4,%a2), %d3 /* Move the second element in the first array to d3 */
add.l (0x4,%a3), %d3  /* Add second element in second array to d3 */
move.l %d3, (0x4,%a1) /* Move sum to second location of result array */

move.l (0x8,%a2), %d3 /* Move the third element in the first array to d3 */
add.l (0x8,%a3), %d3  /* Move the third element in the second array to d3 */
move.l %d3, (0x8,%a1) /* Move sum to third location of result array */

/* Continue to the next part */



/*Part B **********************************************************/
/* indexed register indirect */


lea 0x2300010, %a1 /* Where result will be stored */
lea 0x2300004, %a2 /* Address of first array      */
lea 0x2300008, %a3 /* Address of second array     */
move.l (%a1), %a1  /* Set a1 to the location of the result array */
move.l (%a2), %a2  /* Set a2 to the locaiton of the first array  */
move.l (%a3), %a3  /* Set a3 to the locaiton of the second array */

clr.l %d1 /* Reset offset amount to 0     */
clr.l %d2 /* Reset counter to 0           */

loopb:    /* Beginning of loop for part b */

/* At the end of each loop, increments the offset value by 4*n where n is the
number of iterations (0 <= n < [number of elements in array]) */

move.l (%d1,%a2), %d3  /* Move the nth element of the first array to d3 */
add.l (%d1,%a3), %d3   /* Add the nth element of the second array to d3 */
move.l %d3, (%d1,%a1)  /* Move sum to the nth element of the output array */

add.l #4, %d1        /* Increment offset amount by 4 */
add.l #1, %d2        /* Increment counter value by 1 */
cmp.l 0x2300000, %d2 /* Compare counter to # of elements in the array */
blt loopb            /* If it is less than # of elements, repeat the loop */
                     /* Otherwise continue to the next part */




/*Part C **********************************************************/
/* post increment register indirect*/


lea 0x2300014, %a1 /* Where result will be stored             */
lea 0x2300004, %a2 /* Address of first array                  */
lea 0x2300008, %a3 /* Address of second array                 */
move.l (%a1), %a1  /* Set address to location of result array */
move.l (%a2), %a2  /* Set address to location of first array  */
move.l (%a3), %a3  /* Set address to location of second array */

clr.l %d2 /* Reset counter to 0           */

loopc:    /* Beginning of loop for part c */

move.l (%a2)+, %d3 /* Move the value at the location pointed at by a2 to d3,
                      then increment the address in a2 by the size of
                      a long word (4) */
add.l (%a3)+, %d3  /* Add the value at the location pointed at by a3, then
                      increment the address in a3 by the size of a long word*/
move.l %d3, (%a1)+ /* Move the sum to the location pointed at by a1, then
                      increment the address in a1 by the size of a long word*/

add.l #1, %d2        /* Increment counter by 1 */
cmp.l 0x2300000, %d2 /* Compare the counter to the number of elements */
bge end              /* If the counter is greater than or equal to the number
                        of elements, quit the loop and continue
                        to the next part */
bra loopc            /* Otherwise repeat the loop */





/*End of program **************************************************/
end:
/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 /*Restore data and address registers */
lea      40(%a7),%a7
rts
/*----------------------------------------------------------------*/
