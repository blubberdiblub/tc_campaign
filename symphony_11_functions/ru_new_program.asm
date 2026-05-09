; Соглашение о вызовах:
; r1 и r2 используются для аргументов, r1 — результат функции
; Кроме r1 и r2, функция должна возвращать все регистры в исходном состоянии

; Даём имена регистрам, чтобы было проще читать
const RES   = r1
const ARG_1 = r1
const ARG_2 = r2

; Загружаем два числа, которые даёт уровень
in ARG_1 ; Первый вход — 2
in ARG_2 ; Второй вход — 5

call power ; Вычисляем 2 в степени 5
out RES ; Должно вывести 32

multiply:

    ; Помещаем r3 в стек, чтобы можно было использовать его внутри функции,
    ; но перед возвратом восстановить прежнее значение
    push r3

    const LHS = r1 ; Левая часть умножения
    const RHS = r2 ; Оставшаяся правая часть умножения
    const ACC = r3 ; Аккумулятор

    mov ACC, 0

    jmp mul_condition
    mul_start:
    sub RHS, RHS, 1
    add ACC, ACC, LHS
    mul_condition:
    cmp RHS, 0
    jne mul_start

    mov RES, ACC

    ; Восстанавливаем значение снаружи
    pop r3

    ret

power:

    ; Помещаем r3 и r4 в стек, чтобы можно было использовать их внутри функции,
    ; но перед возвратом восстановить прежние значения
    push r3
    push r4

    const BASE = r3
    const REM_POW = r4 ; Оставшаяся степень

    mov BASE, ARG_1
    sub REM_POW, ARG_2, 1

    ; Продолжаем умножать, пока «оставшаяся степень» не станет 0
    pow_start:
    sub REM_POW, REM_POW, 1

    mov ARG_2, BASE

    call multiply

    pow_condition:
    cmp REM_POW, 0
    jne pow_start

    ; Восстанавливаем значения снаружи
    pop r4
    pop r3

    ret ; Последний вызов multiply уже поместил результат в r1
#57ecf6ff5327f0cf797c279eb69f88ad