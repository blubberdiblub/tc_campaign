
imm 5

my_label: ; (31337_67381454058237, `This is a label`)

imm 5

imm my_label ; (31337_22407883879470, `Store offset of my_label to r0`)
jmp ; (31337_51776605295507, `Jump to my_label`)

; (31337_78380513477546, `Click the spec.isa tab to see the other jump instructions`)
