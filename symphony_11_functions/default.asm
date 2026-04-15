; Calling convention:
; r1 and r2 are used for arguments, r1 is the function result
; Except for r1 and r2, a function should return with 
; all registers having the original value

in r1
in r2

call power
out r1

multiply:

    push r3

    mov r3, 0

    jmp mul_condition
    mul_start:
    sub r2, r2, 1
    add r3, r3, r1
    mul_condition:
    cmp r2, 0
    jne mul_start

    mov r1, r3
    pop r3

    ret

power:

    push r3
    push r4

    mov r3, r1
    mov r4, r2

    pow_start:
    sub r4, r4, 1

    mov r2, r3

    call multiply

    pow_condition:
    cmp r4, 0
    jne pow_start

    pop r4
    pop r3

    ret

