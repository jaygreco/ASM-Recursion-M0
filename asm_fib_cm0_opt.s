
#########################################################################
#                                                                       #
# ARM Cortex M0 ASM for demonstrating register-only optimization for    #
# recursive code. This code is optimized to use no recursion, but       #
# performs the same operations in less time with little to no resource  #
# usage. It calculates the fibonacci number for any input from 1-40.    #
#                                                                       #
#########################################################################

 	.syntax unified
 	.cpu cortex-m0
 	.align	2
 	.global	asm_fib
 	.thumb
 	.thumb_func
 asm_fib:
   		push	{r7, lr}
  		#r0 holds value of n and return
  		#check to see if n is 0, 1, 2, or greater than 20
  		cmp r0, # n=0
  		beq end0
  		cmp r0, # n=1
  		beq end1
  		cmp r0, # n=2
  		beq end1
  		cmp r0, # n>20
  		beq end1
  		#loop to calculate i.
  		#r0=n, r1=i, r2=i1, r3=i2, r4=j
  		movs r1, #0
  		movs r2, #1
  		movs r3, #1
  		movs r4, #3
  		adds r0, #1
loop:
		#loop to calculate the value of fib for n
		adds r1, r2, r3
		mov r3, r2
		mov r2, r1
		adds r4, r4, #1
		cmp r0, r4
		ble endYes
		b loop
 end0:
 		movs r0, #Return 0
 		b end
 end1:
 		movs r0, #Return 1
 		b end
 endYes:     #General case return value
 		mov r0, r1
 end:
  		pop	{r7, pc}
