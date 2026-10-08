imm 0
imm 1
my_label: ; (31337_67381454058237, `The address of this label is 2`)
imm 2
imm 3
imm 4
imm my_label ; (31337_22407883879470, `Stores 2 to r0`)
jmp ; (31337_51776605295507, `Jump to my_label at address 2`)

; (31337_78380513477546, `Click the spec.isa tab to see the other jump instructions`)
