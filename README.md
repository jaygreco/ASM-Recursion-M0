# ASM-Recursion-M0
ARM Cortex M0 assembly code demonstrating clever optimization to avoid using recursive loops in low power processors.

The code consists of two ARM Cortex M0 .s assembly files. One is an unoptimized fibonacci sequence calculator which uses recursive loops. As expected, this method of calculation works fine for smaller vales of n, but quickly baloons in processing time and resource usage. In fact, it's possible to crash the Cortex M0 by passing values of n greater than ~30 (DO THIS AT YOUR OWN RISK!). 

The second file demonstrates general purpose register only calculations. The code works as an optimized for loop with clever return conditions. This code can theoratically handle any value of n as long as the return and intermediate values are less than uint_32_max (2^31, or 2,147,483,648). In fact, processing time is relatively linear, as opposed to the recursive method, and resource usage remains constant, as no intermediate values are being stored on the stack.