; 函数调用的约定：
; 寄存器 r1 和 r2 用于传递参数，其中 r1 还用于存储返回值
; 除 r1 和 r2 外，函数返回时应该保证其它所有寄存器都恢复到调用前的状态

; 为寄存器取名可以提高代码可读性
const RES   = r1
const ARG_1 = r1
const ARG_2 = r2

; 从关卡输入中读取两个参数
in ARG_1 ; 第一个输入为 2
in ARG_2 ; 第二个输入为 5

call power ; 计算 2 的 5 次方
out RES ; 结果应为 32

multiply:

    ; 将 r3 的值压栈。此后我们可以随意使用 r3 寄存器，直到函数返回时再将保存的值恢复到 r3 中
    push r3

    const LHS = r1 ; 被乘数
    const RHS = r2 ; 乘数
    const ACC = r3 ; 积

    mov ACC, 0

    jmp mul_condition
    ; 反复将乘数减 1，并将被乘数加到乘积上
    mul_start:
    sub RHS, RHS, 1
    add ACC, ACC, LHS
    mul_condition:
    cmp RHS, 0
    jne mul_start

    mov RES, ACC

    ; 恢复函数调用之前 r3 的值
    pop r3

    ret

power:

    ; 将 r3 和 r4 压栈。此后我们可以随意使用它们，直到函数返回时再将保存的值恢复到这两个寄存器中。
    push r3
    push r4

    const BASE = r3
    const REM_POW = r4 ; 剩余的指数

    mov BASE, ARG_1
    sub REM_POW, ARG_2, 1

    ; 直到剩余指数为 0 以前，反复将结果乘 2，并将指数减 1
    pow_start:
    sub REM_POW, REM_POW, 1

    mov ARG_2, BASE

    call multiply ; 计算 r1 * r2，即 RES * BASE，并将新结果保存到 RES 中

    pow_condition:
    cmp REM_POW, 0
    jne pow_start

    ; 恢复函数调用前的寄存器值
    pop r4
    pop r3

    ret ; 最后一次乘法函数调用的结果已存储在 r1 中，直接返回即可
#57ecf6ff5327f0cf797c279eb69f88ad