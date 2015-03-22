
#########################################################################
#                                                                       #
# ARM Cortex M0 ASM for demonstrating register-only optimization for    #
# recursive code. This code is unoptimized.                             #
# It calculated the fibonacci number using recursion, and can easily    #
# take 30s-1min to calculate for higher values of n on an ARM M0.       #
#                                                                       #
#########################################################################

 	.syntax unified
 	.cpu cortex-m0
 	.align	2
 	.global	asm_fib
 	.thumb
 	.thumb_func

 asm_fib:
 		#store critical registers on stack
 		#r0: parameters and return values
 		#r1: frame pointer
 		#r2: scratch register (not on stack)
 		#r3: return values and maths register
   		push	{r1, r3, lr}

   		#adjust stack pointed and
   		#put n onto the stack for when it's needed
   		sub sp, #12
   		mov r1, sp
   		str r0, [r1, #4]

   		#r0 holds value of passed and return variables
  		#check to see if n is 0, 1, or greater than 20
  		cmp r0, #0
  		beq end0
  		cmp r0, #1
  		beq end1
  		cmp r0, #21
  		bge end1

 recurse:
 		#load the value of n into r2
 		ldr r2, [r1, #4]
 		#subtract 1 from n
 		subs r2, #1
 		mov r0, r2
 		#call fib(n-1)
 		bl asm_fib
 		#take teh return value and put it in r3
 		mov r3, r0
 		#move n into r2 again
 		ldr r2, [r1, #4]
 		#subtract 2 from n
 		subs r2, #2
 		mov r0, r2
 		#call fib(n-2)
 		bl asm_fib
 		#take teh return value and put it in r2
 		mov r2, r0
 		#return fib(n-1)+fib(n-2)
 		adds r0, r2, r3
 		b end
 end0:
 		#return 0
 		movs r0, #0
 		b end
 end1:
 		#return 1
 		movs r0, #1
 		b end
 end:
 		#restore stack pointer and pop variables off stack
 		mov sp, r1
 		add sp, #12
        pop {r1, r3, pc}
