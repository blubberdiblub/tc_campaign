imm 63
mov r1, r0
top:
imm label_jz
jz
mov out, r3
label_jz:
imm label_jnz
jnz
mov out, r3
label_jnz:
imm label_jge
jge
mov out, r3
label_jge:
imm label_jle
jle
mov out, r3
label_jle:
imm label_jg
jg
mov out, r3
label_jg:
imm pass
jl
mov out, r3
mov r2, r3
add
imm top
jmp
pass:
mov r0, in
mov r1, in
mov r2, in
mov r3, in
mov r4, in
mov r5, in
mov r0, r0
mov r1, r0
mov r2, r0
mov r3, r0
mov r4, r0
mov r5, r0
mov r0, r1
mov r1, r1
mov r2, r1
mov r3, r1
mov r4, r1
mov r5, r1
mov r0, r2
mov r1, r2
mov r2, r2
mov r3, r2
mov r4, r2
mov r5, r2
mov r0, r3
mov r1, r3
mov r2, r3
mov r3, r3
mov r4, r3
mov r5, r3
mov r0, r4
mov r1, r4
mov r2, r4
mov r3, r4
mov r4, r4
mov r5, r4
mov r0, r5
mov r1, r5
mov r2, r5
mov r3, r5
mov r4, r5
mov r5, r5
mov out, r0
mov out, r1
mov out, r2
mov out, r3
mov out, r4
mov out, r5
imm 17
mov r1, in
mov r2, in
and
mov r1, in
mov r2, in
or
mov r1, in
mov r2, in
nand
mov r1, in
mov r2, in
nor
mov r1, in
mov r2, in
add
mov r1, in
mov r2, in
sub
