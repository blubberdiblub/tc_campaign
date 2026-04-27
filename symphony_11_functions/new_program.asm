; Calling convention:
; r1 and r2 are used for arguments, r1 is the function result
; Except for r1 and r2, a function should return with all registers having the original value

; Give names to registers to make things easier to read
const RES   = r1
const ARG_1 = r1
const ARG_2 = r2

; Load two numbers given from the level
in ARG_1 ; First input is 2
in ARG_2 ; Second input is 5

call power ; Calculate 2 to the power 5
out RES ; Should output 32

multiply:

    ; Push r3 so we can use it within the function but still restore it before returning
    push r3

    const LHS = r1 ; Left hand side of the multiply
    const RHS = r2 ; Remaining right hand side of the multiply
    const ACC = r3 ; Accumulator

    mov ACC, 0

    jmp mul_condition
    mul_start:
    sub RHS, RHS, 1
    add ACC, ACC,LHS
    mul_condition:
    cmp RHS, 0
    jne mul_start

    mov RES, ACC

    ; Restore outside value
    pop r3

    ret

power:

    ; Push r3 and r4 so we can use them within the function but still restore them before returning
    push r3
    push r4

    const BASE = r3
    const REM_POW = r4 ; Remaining power

    mov BASE, ARG_1
    sub REM_POW, ARG_2, 1

    ; Keep multiplying until "remaining power" is 0
    pow_start:
    sub REM_POW, REM_POW, 1

    mov ARG_2, BASE

    call multiply

    pow_condition:
    cmp REM_POW, 0
    jne pow_start

    ; Restore outside values
    pop r4
    pop r3

    ret ; The last multiply call already put the result in r1

