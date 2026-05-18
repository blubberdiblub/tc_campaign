imm 5 ; 将 5 写入 reg 0
jmp   ; 跳转到 reg 0 中的值对应的地址（第 5 字节）

; 请翻阅指令集以查看更多的跳转指令

my_label:    ; 以冒号结尾的行是标签（label）
imm my_label ; 你可以像这样将标签所在的地址写入 reg 0
#1295e7df0ee93eac1792de00743e4b00