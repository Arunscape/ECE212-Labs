/* DO NOT MODIFY THIS --------------------------------------------*/
.text

.global AssemblyProgram

AssemblyProgram:
lea      -40(%a7),%a7 /*Backing up data and address registers */
movem.l %d2-%d7/%a2-%a5,(%a7)
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab1a.s *********************************************/
/* Names of Students: Arun Woosaree and Navras Kamal             **/
/* Date: 1/29/2018                                               **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/

/*Write your program here******************************************/

movea.l #0x2300000, %a1 	/* save input address to a1*/
movea.l #0x2310000, %a2 	/* save output address to a2*/

/* let a value in quotation marks be the ASCII value of the character enclosed by the quotation marks*/

loop: /* the looping function*/
 move.l (%a1), %d2 			/* move the value at address a1 to d2, call this 'inval' from henceforth*/

 cmp.l #0x0D, %d2			/* Check if the inval is the enter code*/
 beq end					/* if it is, go to the end of the program (breaking the loop)*/

 cmp.l #0x2F, %d2			/* compare inval to the hex value of "0"*/
 blt err					/* if inval is less than ASCII zero it is not valid, throw an error*/

 cmp.l #0x3A, %d2 			/* compare the inval to the hex value of ":", which is one ASCII value higher than "9"*/
 blt zeronine				/* if it is less than the value of ":" then it must be a value between "0" and "9"*/
 							/* 	   thus go to the proper part of the code to handle this value*/

 cmp.l #0x41, %d2 			/* compare the inval to "A"*/
 blt err					/* if it is less than the "A" than it is invalid, throw an error*/

 cmp.l #0x47, %d2 			/* compare the inval to "G"*/
 blt bigathruf				/* if it is less than the value of "G" then it must be in the range "A" through "F"*/
 							/*	 thus go to the part of the code to handle these values*/

 cmp.l #0x61, %d2 			/* compare the inval to "a"*/
 blt err					/* if it is in this range it is invalid, thus throw an error*/

 cmp.l #0x67, %d2 			/* compare the inval to "g"*/
 blt littleathruf			/* if it is less than "g" then it must be in the range "a" through "F"*/
 							/*	 thus go to the part of the code to handle these values*/

err:						/* if the inval is equal to or above "g" then the code will naturally continue here*/
 move.l #0xFFFFFFFF, (%a2) 	/* throw the error code to the output address location*/
 bra endloop				/* go to the end of the loop before restarting the loop*/

zeronine:					/* inval is between "0" and "9"*/
 sub.l #0x30, %d2 			/* subtract the hex value of "0" from inval, which will leave a value from 0x0 to 0x9, for "0" to "9" respectively*/
 move.l %d2, (%a2) 			/* move this calculted hex value to the output address location*/
 bra endloop				/* go to the end of the loop before restarting the loop*/

bigathruf:					/* inval is between "A" and "F"*/
 sub.l #0x41, %d2   			/* subtracts the hex value of "A" d2. This is the difference between d2 and the character and "A"*/
 add.l #0xA, %d2  			/* adds the value of "A" to d2, which will make it into the hex representation of the original ASCII value*/
 move.l %d2, (%a2)			/* move this value to the output address location*/
 bra endloop				/* go to the end of the loop before restarting the loop*/

littleathruf:				/* inval is between "a" and "f"*/
 sub.l #0x61, %d2   			/* subtracts the hex value of "a" d2. This is the difference between d2 and the character and "a"*/
 add.l #0xA, %d2  			/* adds the value of "a" to d2, which will make it into the hex representation of the original ASCII value*/
 move.l %d2, (%a2)			/* move this value to the output address location*/
 bra endloop				/* go to the end of the loop before restarting the loop*/

endloop:					/* handles code to be executed before the start of a new loop*/
 add.l #0x4, %a1 			/* increment the input address by 4*/
 add.l #0x4, %a2 			/* increment the output address by 4*/
 bra loop					/* restart the loop*/

end:						/* end the custom part of the program*/

/*End of program **************************************************/

/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 /*Restore data and address registers */
lea      40(%a7),%a7
rts
/*----------------------------------------------------------------*/
