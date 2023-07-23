.data
# please don't change these!
n: .word 2
exp: .word 10

.text
main:
    # load the value of n into a0
    la a0 n
    lw a0 0(a0)

    # load the value of exp into a1
    la a1 exp
    lw a1 0(a1)

    # call ex3
    jal ex3

    # prints the output of ex3
    mv a1 a0
    li a0 1
    ecall # Print Result

    # exits the program
    li a0 17
    li a1 0
    ecall

ex3:
    # this function is a recursive pow function
    # a0 contains the base
    # a1 contains the power to raise to
    # the return value should be the result of a0^a1
    #     where ^ is the exponent operator, not XOR

    # return 1 if a1 == 0
    beq a1 x0 ex3_zero_case

    # otherwise, return ex3(a0, a1-1) * a0
    mv t0 a0      # save a0 in t0
    addi a1 a1 -1 # decrement a1
    addi sp sp -4
    sw t0 0(sp)
    jal ex3       # call ex3(a0, a1-1)
    lw t0 0(sp)
    addi sp sp 4
    mul a0 a0 t0  # multiply ex3(a0, a1-1) by t0
                  # (which contains the value of a0)

    j ex3_end

# please don't change anything after this line!
ex3_zero_case:
    li a0 1

ex3_end:
    ret
