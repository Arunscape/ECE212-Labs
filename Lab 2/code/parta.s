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
/*                                                               **/
/******************************************************************/

/*Write your program here******************************************/

/*
1.  0x2300000 - Size of array
2.  0x2300004 - address of first array
3.  0x2300008 - address of second array
4.  0x230000C - address of where to store the sum with Register Indirect With Offset
5.  0x2300010 - address of where to store the sum with Indexed Register Indirect
6.  0x2300014 - address of where to store the sum with Postincrement Register Indirect
*/

/*Part A **********************************************************/
/* adding with register indirect with offset*/

lea 0x230000C, %a1 /* location of where result will be stored */
lea 0x2300004, %a2 /* location of the array where address of first array */
lea 0x2300008, %a3 /* location of the array where address of second array */
move.l (%a1), %a1
move.l (%a2), %a2
move.l (%a3), %a3

move.l (%a2), %d3
add.l (%a3), %d3
move.l %d3, (%a1)

move.l (0x4,%a2), %d3
add.l (0x4,%a3), %d3
move.l %d3, (0x4,%a1)

move.l (0x8,%a2), %d3
add.l (0x8,%a3), %d3
move.l %d3, (0x8,%a1)



/*Part B **********************************************************/
/* indexed register indirect */


lea 0x2300010, %a1 /* where result will be stored */
lea 0x2300004, %a2 /* address of first array */
lea 0x2300008, %a3 /* address of second array */
move.l (%a1), %a1
move.l (%a2), %a2
move.l (%a3), %a3

clr.l %d1 /* offset */
clr.l %d2 /* counter starts at 0  */

loopb:

move.l (%d1,%a2), %d3
add.l (%d1,%a3), %d3
move.l %d3, (%d1,%a1)

add.l #4, %d1 /* increment offset */
add.l #1, %d2 /* increment counter */
cmp.l 0x2300000, %d2
blt loopb




/*Part C **********************************************************/
/* post increment register indirect*/


lea 0x2300014, %a1 /* where result will be stored */
lea 0x2300004, %a2 /* address of first array */
lea 0x2300008, %a3 /* address of second array */
move.l (%a1), %a1
move.l (%a2), %a2
move.l (%a3), %a3

clr.l %d2 /* counter starts at 0  */

loopc:

move.l (%a2)+, %d3
add.l (%a3)+, %d3
move.l %d3, (%a1)+

add.l #1, %d2 /* increment counter */
cmp.l 0x2300000, %d2
bge end
bra loopc





/*End of program **************************************************/
end:
/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 /*Restore data and address registers */
lea      40(%a7),%a7
rts
/*----------------------------------------------------------------*/
