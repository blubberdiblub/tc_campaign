; (31337_43461252553161, `Calling convention:`)
; (31337_42717933764735, `r1 and r2 are used for arguments, r1 is the function result`)
; (31337_10902022971046, `Except for r1 and r2, a function should return with all registers having the original value`)

; (31337_68500361393623, `Give names to registers to make things easier to read`)
const RES   = r1
const ARG_1 = r1
const ARG_2 = r2

; (31337_21707356398727, `Load two numbers given from the level`)
in ARG_1 ; (31337_18457350783754, `First input is 2`)
in ARG_2 ; (31337_27592840036827, `Second input is 5`)

call power ; (31337_33479507858734, `Calculate 2 to the power 5`)
out RES ; (31337_59000482794872, `Should output 32`)

multiply:

    ; (31337_70634976221207, `Push r3 so we can use it within the function but still restore it before returning`)
    push r3

    const LHS = r1 ; (31337_30769341721428, `Left hand side of the multiply`)
    const RHS = r2 ; (31337_27088227324511, `Remaining right hand side of the multiply`)
    const ACC = r3 ; (31337_21553876748933, `Accumulator`)

    mov ACC, 0

    jmp mul_condition
    mul_start:
    sub RHS, RHS, 1
    add ACC, ACC, LHS
    mul_condition:
    cmp RHS, 0
    jne mul_start

    mov RES, ACC

    ; (31337_32724600358227, `Restore outside value`)
    pop r3

    ret

power:

    ; (31337_14412657671278, `Push r3 and r4 so we can use them within the function but still restore them before returning`)
    push r3
    push r4

    const BASE = r3
    const REM_POW = r4 ; (31337_42740851915963, `Remaining power`)

    mov BASE, ARG_1
    sub REM_POW, ARG_2, 1

    ; (31337_63878589013500, `Keep multiplying until "remaining power" is 0`)
    pow_start:
    sub REM_POW, REM_POW, 1

    mov ARG_2, BASE

    call multiply

    pow_condition:
    cmp REM_POW, 0
    jne pow_start

    ; (31337_65068280556611, `Restore outside values`)
    pop r4
    pop r3

    ret ; (31337_11016773181609, `The last multiply call already put the result in r1`)

