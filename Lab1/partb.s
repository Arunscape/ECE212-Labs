/* DO NOT MODIFY THIS --------------------------------------------*/
.text

.global AssemblyProgram

AssemblyProgram:
lea      -40(%a7),%a7 /*Backing up data and address registers */
movem.l %d2-%d7/%a2-%a5,(%a7)
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab1b.s *********************************************/
/* Names of Students: Arun Woosaree and Navras Kamal             **/
/* Date: 1/29/2018                                               **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/

/*Write your program here******************************************/

movea.l #0x2300000, %a1     /* save input address to a1           */
movea.l #0x2320000, %a2     /* save output address to a2          */

/* let a value in quotation marks be the ASCII value of the       */
/* character enclosed by the quotation marks                      */

loop:                       /* the looping function               */
 move.l (%a1), %d2          /* move the value at address a1 to d2 */
                            /* Call this 'inval' from henceforth  */

 cmp.l #0x0D, %d2           /* Check if the inval is enter code   */
 beq end                    /* if it is, go to the end of the     */
                            /* program (breaking the loop)        */

 cmp.l #0x41, %d2           /* compare the inval to "A"           */
 blt err                    /* if it is less than the "A" than it */
                            /* is invalid, throw an error         */

 cmp.l #0x5B, %d2           /* compare the inval to "["           */
 blt bigathruz              /* if it is less than the value of    */
                            /* "[" then it must be in the range   */
							/* "A" through "Z"                    */
                            /* thus go to the part of the code to */
                            /* handle these values                */

 cmp.l #0x61, %d2           /* compare the inval to "a"           */
 blt err                    /* if it is in this range it is       */
                            /* invalid, thus throw an error       */

 cmp.l #0x7B, %d2           /* compare the inval to "{"           */
 blt littleathruz           /* if it is less than "{" then it is  */
                            /* in the range "a" through "z"       */
                            /* thus go to the part of the code to */
                            /* handle these values                */

bigathruz:                  /* inval is between "A" and "Z"       */
 add.l #0x20, %d2           /* adds the hex difference between    */
                            /* "A" and "a", making it into the    */
                            /* lowercase equivalent               */
 move.l %d2, (%a2)          /* move this value to the output      */
                            /* address location                   */
 bra endloop                /* go to the end of the loop before   */
                            /* restarting the loop                */

littleathruz:               /* inval is between "a" and "z"       */
 sub.l #0x20, %d2           /* subtracts the hex difference       */
                            /* between "a" and "A", changing it   */
                            /* into the uppercase equivalent      */
 move.l %d2, (%a2)          /* move this value to the output      */
                            /* address location                   */
 bra endloop                /* go to the end of the loop before   */
                            /* restarting the loop                */

 /* if inval isn't a valid character then code will continue here */
err:						
 move.l #0xFFFFFFFF, (%a2) 	/* throw the error code to the output */
                            /* address location                   */
 bra endloop                /* go to the end of the loop before   */
                            /* restarting the loop                */

endloop:                    /* handles code to be executed before */
                            /* the start of a new loop            */
 add.l #0x4, %a1            /* increment the input address by 4   */
 add.l #0x4, %a2            /* increment the output address by 4  */
 bra loop                   /* restart the loop                   */

end:                        /* end of custom program section      */


/*End of program **************************************************/

/* DO NOT MODIFY THIS --------------------------------------------*/
movem.l (%a7),%d2-%d7/%a2-%a5 /*Restore data and address registers */
lea      40(%a7),%a7
rts
/*----------------------------------------------------------------*/
