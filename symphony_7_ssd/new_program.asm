
in r1
in r2
in r3
in r4
in r5
in r6
in r7
in r8
in r9
in r10
in r11
in r12
in r13
in sp
in flags

in r5
pload r12, [4]
pload r10, [4]
pload sp, [492]
in r2
pstore [782], r6
store_32 [10630], r5
pstore [492], r7
label_9:
pload r12, [4]
in r3
in r9
cmp r3, r9
jle label_9
pstore [4], zr
out r5
pload zr, [4]
load_8 r8, [10630]
pload r5, [494]
pstore [782], r7
in r9
pstore [782], sp
pstore [494], r4
pstore [492], r8
pload r10, [494]
pstore [4], r5
pstore [782], r13
pload zr, [494]
out r1
label_27:
add r3, zr, flags
in r1
in r12
cmp r1, r12
ja label_27
pstore [782], r9
out r12
pload r11, [4]
load_32 r13, [10630]
nand r5, sp, 49505
pload r13, [782]
jmp label_36
out r6
label_36:
pload r1, [4]
pstore [782], r5
in r12
jmp label_42
or r1, r11, 56137
label_42:
jl label_45
pload r13, [492]
label_45:
pstore [492], r1
pstore [494], r8
pload zr, [4]
jl label_51
pstore [4], r7
label_51:
pstore [782], r13
pload r8, [4]
pstore [492], r3
pload r8, [782]
jg label_58
pload r8, [4]
label_58:
out sp
pload r6, [492]
pload zr, [782]
out r13
pstore [782], r12
pstore [494], r13
store_8 [10380], zr
pstore [782], r10
pload flags, [492]
pload r12, [782]
pstore [782], r5
pload r4, [492]
pload sp, [492]
pstore [782], r7
or flags, r5, 39789
pstore [492], r9
pload r8, [494]
label_78:
store_8 [10882], r10
in r6
in r13
cmp r6, r13
jne label_78
pload r2, [782]
pstore [782], zr
label_83:
pload r8, [494]
in r12
in r8
cmp r12, r8
jne label_83
pstore [494], r9
in zr
pstore [782], r2
pload r12, [492]
pload r13, [494]
out r12
pload r12, [492]
pload r9, [492]
pstore [492], sp
lsr r10, r13, 16033
pstore [4], r10
pstore [782], r11
pstore [782], r12
pstore [494], r3
nand r9, r9, r1
pload r12, [494]
pstore [494], r6
pstore [494], r9
pload r5, [494]
pstore [494], r2
store_16 [10380], zr
pload r2, [4]
pload r6, [782]
pload r10, [4]
pstore [782], r4
pstore [782], r8
load_16 r10, [10380]
jmp label_113
out flags
label_113:
jl label_116
pload r13, [4]
label_116:
pstore [492], r13
in r11
pstore [492], zr
load_32 r6, [10380]
nor r7, r11, r8
pload r2, [782]
pstore [494], r9
pstore [4], r2
pstore [494], r3
jge label_128
pload flags, [494]
label_128:
lsr r9, r8, 33159
in r6
in r5
pload r8, [4]
store_16 [10630], r3
in r10
sub r1, r3, flags
load_16 r10, [10630]
jb label_139
pstore [492], r9
label_139:
pload r4, [494]
pstore [782], sp
pload r2, [494]
pstore [492], r11
pstore [492], r5
pstore [492], sp
lsr r2, r6, sp
pstore [492], r2
pstore [4], r6
pstore [492], r6
pload r13, [494]
pstore [494], sp
pstore [492], r12
jmp label_155
je label_156
pload r12, [494]
label_156:
label_155:
pload r3, [494]
pstore [492], r1
pload r5, [494]
pstore [4], zr
pload r12, [4]
or r3, r2, zr
load_32 r9, [10882]
pload r13, [782]
jg label_168
pload zr, [494]
label_168:
pload zr, [494]
pload r4, [494]
pload r11, [4]
pload r8, [492]
pstore [494], r8
pstore [492], r5
pstore [782], r3
pstore [492], flags
pstore [494], r9
pstore [4], r1
pstore [492], r13
pload r10, [492]
xor r4, r9, r7
pload r6, [782]
pload r9, [492]
out r12
pstore [4], r4
pload r3, [494]
pload sp, [782]
pload r11, [492]
add r2, r13, 50235
pload r4, [782]
pload r9, [494]
in r4
pstore [4], r6
store_8 [10882], r11
in r2
pstore [4], flags
pload r7, [492]
jae label_200
in r5
label_200:
jmp label_203
pload r2, [494]
label_203:
pload r9, [782]
pstore [492], r9
pstore [782], sp
pload r9, [4]
jne label_210
pstore [782], r3
label_210:
pstore [4], r8
out r13
and r4, r6, r12
pstore [4], r10
jg label_217
pload r9, [492]
label_217:
lsr r4, sp, r12
pload r4, [492]
pload r13, [492]
nor r3, r3, r9
pload r5, [782]
pload r8, [4]
pload r11, [494]
pstore [782], zr
and zr, flags, 1322
jmp label_229
pload r10, [4]
label_229:
pstore [492], sp
pstore [4], r3
pload r1, [494]
pstore [782], r2
pload r6, [494]
pstore [782], r11
pstore [492], r9
in r9
jl label_240
pstore [492], r11
label_240:
pstore [4], r9
store_16 [10132], r12
pstore [782], r11
pstore [494], r4
store_32 [10630], r3
pload r2, [492]
jne label_249
pload zr, [4]
label_249:
je label_252
pload flags, [4]
label_252:
out r7
or r11, r7, r5
label_257:
xor r10, zr, 6430
in r13
in r8
cmp r13, r8
jge label_257
pload r6, [782]
pstore [782], zr
pstore [782], r1
pstore [494], r1
out zr
sub flags, r9, r13
store_8 [10380], r2
pstore [4], r4
pstore [4], r8
pstore [4], r5
jae label_270
pstore [782], flags
label_270:
in r4
in r3
pload flags, [494]
pload r4, [494]
jmp label_277
jg label_278
load_16 sp, [10132]
label_278:
label_277:
out sp
load_32 r3, [10630]
in r7
in flags
jmp label_286
jl label_287
pstore [4], r6
label_287:
label_286:
pload r9, [492]
pload r10, [494]
pload r13, [492]
pload flags, [494]
or r5, r4, 24099
add r12, flags, 58962
jmp label_297
jl label_298
pload r12, [492]
label_298:
label_297:
pstore [4], r11
pstore [782], r5
pstore [4], r12
in r1
load_16 r3, [10882]
pstore [492], r13
or zr, r11, 18925
pload sp, [4]
pstore [492], r13
pload r6, [782]
pload r3, [492]
label_313:
pstore [492], r6
in r7
in r12
cmp r7, r12
jne label_313
pload r8, [4]
store_8 [10132], sp
pstore [4], r9
pstore [782], r9
jle label_320
pstore [4], sp
label_320:
pload r4, [4]
store_32 [10630], r4
pstore [494], r2
pload r8, [494]
pstore [4], r11
pload flags, [492]
pload r2, [494]
pstore [494], r2
pload r9, [4]
pload r1, [4]
xor r1, r2, zr
store_8 [10132], r7
pload r11, [782]
pstore [4], r12
pload r9, [4]
pload r3, [782]
pload r7, [782]
jae label_340
load_8 r1, [10882]
label_340:
pstore [494], r11
xor flags, r7, r12
pstore [494], r6
out r13
lsr r1, r9, r9
pstore [4], r10
pload r13, [782]
load_32 r10, [10630]
pstore [4], flags
pload r3, [494]
pload flags, [782]
pload r12, [494]
pload r12, [4]
pload r9, [4]
pstore [782], r5
lsl r9, r10, 46353
pstore [782], r4
label_360:
jae label_361
pstore [494], r3
label_361:
in r7
in r4
cmp r7, r4
jg label_360
pstore [782], r6
load_8 r8, [10132]
pstore [494], r13
pload sp, [494]
store_8 [10380], r5
jmp label_370
pload flags, [494]
label_370:
or r10, r10, r9
out sp
pstore [782], r12
pload r6, [4]
in r9
pload r12, [4]
pstore [494], r1
pstore [492], r4
pload r8, [4]
pstore [494], sp
pstore [782], r3
label_384:
out r2
in r1
in r12
cmp r1, r12
jb label_384
pstore [782], r2
label_388:
load_8 r5, [10132]
in r12
in r5
cmp r12, r5
jbe label_388
pload r12, [492]
add r1, r13, 45012
pstore [494], r7
pstore [4], r3
out r4
xor r4, r4, 52487
lsl r1, zr, r12
pload r3, [782]
pload r2, [494]
pload zr, [782]
pstore [782], sp
in r6
pstore [782], r3
pload r2, [782]
pstore [782], r13
out flags
out r11
pload r1, [4]
lsr r10, r10, r5
lsr sp, r6, 64540
jle label_411
load_32 r12, [10630]
label_411:
pstore [492], flags
pload zr, [492]
pload flags, [494]
pstore [4], r13
pload r10, [4]
pstore [494], r2
in r12
pstore [782], zr
add r12, r4, 48931
jmp label_423
pload r11, [4]
label_423:
pload flags, [782]
pstore [492], r12
pload sp, [492]
pstore [494], flags
pstore [4], r5
pload r5, [782]
pstore [494], r3
store_32 [10380], r7
jb label_434
pload r12, [494]
label_434:
pstore [4], r7
pstore [492], r11
pstore [782], r4
nor r2, r7, 11076
nand r10, zr, r3
pload r13, [782]
pstore [4], flags
pstore [4], r7
add r6, sp, zr
pstore [4], r10
pstore [492], r13
label_448:
pstore [492], r13
in r5
in r1
cmp r5, r1
jae label_448
load_16 r8, [10380]
jmp label_452
lsr r9, r1, r10
label_452:
pstore [492], r13
pload r2, [782]
or r12, r4, r7
pload sp, [492]
pload r10, [494]
label_460:
store_16 [10882], r2
in r13
in sp
cmp r13, sp
jne label_460
pstore [494], r6
pstore [494], r9
pload r5, [4]
pload r11, [782]
pload r10, [494]
pload r13, [782]
pstore [782], r4
or r10, r10, 48221
store_8 [10630], r13
in r12
nor r13, flags, r1
pload r9, [494]
pload r8, [782]
pload r11, [492]
pload zr, [4]
pload r11, [782]
pstore [492], r13
pload r3, [4]
pstore [782], r4
pstore [494], r4
pstore [782], flags
pstore [494], r10
pload r12, [782]
pload r2, [782]
pstore [492], r8
pload r6, [782]
pload r1, [782]
jbe label_490
pstore [4], sp
label_490:
nand sp, r12, 29606
pstore [782], r9
pload r9, [494]
store_8 [10882], r3
pstore [494], r8
pload r8, [492]
pstore [492], flags
pload r10, [782]
load_8 r4, [10882]
pstore [494], r9
pstore [4], r8
pload r8, [494]
pstore [494], r7
pstore [492], zr
out r4
pload r10, [492]
load_16 r13, [10630]
pload r6, [4]
pload r10, [494]
in r12
pstore [782], r4
in zr
pload r10, [494]
pload sp, [494]
pload zr, [492]
pload r13, [494]
pstore [494], r1
jmp label_520
pstore [4], r8
label_520:
pstore [4], zr
store_32 [10380], r11
pstore [492], r5
label_526:
pstore [494], r3
in r10
in r2
cmp r10, r2
je label_526
pstore [492], r2
pload r3, [4]
pstore [492], r12
pstore [782], r10
pload zr, [492]
pstore [494], r7
in r5
pload r11, [782]
store_16 [10380], r7
pstore [492], sp
nand sp, r8, 23544
pstore [4], sp
pstore [782], zr
store_16 [10380], r2
pstore [492], zr
out r3
pload r4, [782]
pload r3, [494]
pstore [494], r12
pload zr, [494]
store_16 [10380], r10
pload r6, [492]
pstore [492], r6
pload sp, [782]
pstore [494], r13
pstore [492], r12
pstore [782], r5
pload r6, [4]
pload r11, [494]
store_8 [10132], r10
pload zr, [492]
pstore [494], r3
pstore [494], r1
pstore [492], flags
pstore [4], r13
add r5, r10, r12
pstore [4], r2
pstore [492], r7
in r10
add r11, r6, sp
xor r10, r5, 6413
lsl r11, r10, 24027
pload r12, [782]
nand r13, r3, 55048
label_573:
lsl r10, r11, zr
in r5
in r6
cmp r5, r6
je label_573
pstore [782], r1
pload r13, [494]
pstore [4], r9
label_579:
pload zr, [494]
in r10
in r2
cmp r10, r2
jg label_579
pload flags, [782]
load_8 r1, [10132]
nand r8, r12, sp
load_16 flags, [10630]
pstore [4], sp
store_8 [10630], sp
add r3, sp, r12
in r3
jge label_590
ja label_591
pstore [494], flags
label_591:
label_590:
pload r5, [782]
nand r1, r6, r4
pload r1, [492]
pload r10, [494]
pstore [494], r12
pstore [782], r9
pload r6, [494]
out flags
pstore [492], r4
pload r10, [4]
pload zr, [4]
pstore [494], r12
pstore [492], r10
pstore [4], r12
pload r11, [782]
pstore [782], r1
pstore [492], r8
lsr sp, flags, r6
jge label_613
pstore [782], r6
label_613:
pstore [782], r12
out r8
pload r5, [494]
pload r13, [492]
pstore [492], r1
pload r11, [492]
pstore [782], r2
pstore [782], r13
pstore [4], r11
pload r10, [492]
pload r3, [782]
pstore [494], r12
label_628:
pstore [4], r12
in r10
in r4
cmp r10, r4
jae label_628
jg label_631
in r11
label_631:
pload r9, [494]
pload sp, [4]
pload zr, [494]
out zr
pstore [492], r12
out r7
pstore [492], sp
pstore [494], r3
store_8 [10380], flags
pload r10, [492]
add r5, r8, 30242
store_8 [10380], r2
store_16 [10132], r6
pload r2, [494]
pload zr, [494]
pstore [492], r4
load_32 r8, [10380]
pstore [492], r1
pstore [494], r8
pstore [494], r8
pload r2, [782]
add sp, r13, r4
pstore [782], r6
pstore [494], r1
load_32 r8, [10630]
pstore [4], zr
jle label_660
pstore [4], r12
label_660:
pload r12, [4]
pstore [4], r7
lsr sp, r11, 21889
out r8
lsl r2, r3, r4
pload r4, [782]
pstore [492], r11
pstore [494], flags
jmp label_671
in r9
label_671:
add r11, r12, r3
load_8 r13, [10380]
pload r12, [782]
out r8
pstore [4], sp
pload r11, [4]
pload r4, [494]
pload zr, [4]
pload r8, [4]
pstore [782], r12
pstore [782], r11
pload r10, [492]
pstore [4], zr
pstore [492], r9
pload r4, [492]
pload r11, [4]
pstore [4], r6
out r4
pload zr, [492]
pload sp, [492]
jne label_694
pstore [4], r5
label_694:
nor r8, r2, 11137
pstore [782], r1
pload r13, [4]
pload r5, [492]
pstore [782], r8
pload sp, [4]
xor flags, zr, 43399
pstore [4], r9
pload r5, [492]
sub r13, r6, 825
pstore [494], r11
pstore [782], flags
pload r7, [4]
pload sp, [494]
pstore [494], r13
load_32 r11, [10630]
pstore [492], r6
pload r2, [494]
load_16 r11, [10630]
pload r2, [4]
pload r2, [494]
pstore [782], r3
jmp label_720
pstore [492], r6
label_720:
pstore [494], r12
pstore [492], r5
pload r12, [4]
store_16 [10630], sp
out r8
pstore [492], r4
pload r9, [494]
pstore [782], r4
pload r6, [782]
load_8 sp, [10380]
pload r1, [782]
in r4
pstore [4], r1
pload r7, [782]
lsl r7, r13, 44108
pstore [782], r12
jbe label_739
pstore [4], r12
label_739:
pstore [4], r1
pstore [782], zr
pstore [492], r3
label_745:
pload r2, [494]
in r12
in r11
cmp r12, r11
jg label_745
pstore [494], r12
pstore [492], r2
pstore [494], r10
pload r6, [492]
pload r12, [4]
pstore [782], r4
pstore [494], r12
pload r8, [4]
pstore [4], r10
pload r11, [4]
pload r10, [782]
pload r7, [4]
pstore [494], r11
pload r1, [4]
pload sp, [492]
jge label_764
pload r2, [4]
label_764:
and r13, r4, 21560
pload r5, [4]
lsl r5, r5, 39271
pstore [4], r5
pstore [4], r12
label_772:
store_16 [10132], r3
in r3
in r9
cmp r3, r9
jne label_772
pstore [782], r9
out r1
pstore [492], r1
jae label_778
pload r9, [494]
label_778:
pstore [782], r2
pload r5, [4]
in r13
sub r11, r12, zr
pstore [4], r13
pstore [782], r7
label_787:
pload r9, [492]
in r9
in r12
cmp r9, r12
jne label_787
label_790:
pload r12, [492]
in sp
in r2
cmp sp, r2
jbe label_790
pload r6, [492]
pload r4, [494]
out r8
pstore [492], r1
load_8 r3, [10380]
label_798:
out r8
in r4
in r8
cmp r4, r8
jae label_798
label_801:
pload r12, [494]
in sp
in r13
cmp sp, r13
jae label_801
or r4, r11, 6381
jge label_805
pstore [492], flags
label_805:
store_32 [10882], r13
jbe label_809
pload r1, [782]
label_809:
in r11
label_813:
pload r9, [492]
in r4
in r12
cmp r4, r12
jge label_813
load_16 r11, [10882]
pstore [4], r5
pstore [492], r6
label_819:
pload r12, [4]
in r8
in r9
cmp r8, r9
ja label_819
ja label_822
in r8
label_822:
pstore [494], zr
lsr r9, r4, 36204
nand zr, r10, 45218
label_828:
je label_829
label_830:
pstore [4], r10
in r6
in r12
cmp r6, r12
jne label_830
label_829:
in r8
in r4
cmp r8, r4
jl label_828
out r3
in r7
pload r5, [4]
pload r3, [492]
pstore [4], r4
load_8 sp, [10882]
jae label_841
pstore [494], r4
label_841:
pstore [492], r9
pload r6, [4]
pload r11, [494]
out sp
pload r2, [4]
jge label_849
pload r1, [4]
label_849:
pstore [4], r12
pstore [4], r3
add r4, zr, r7
pload r3, [782]
pstore [494], sp
pload r5, [782]
add r12, r13, 44654
pload r12, [492]
pload r6, [4]
pstore [494], flags
pload r3, [492]
sub r13, flags, 16522
pload r4, [4]
in r7
label_867:
pstore [492], r13
in r11
in r9
cmp r11, r9
jae label_867
store_16 [10380], r4
jne label_871
pload sp, [4]
label_871:
je label_874
pload r9, [4]
label_874:
pload r3, [492]
label_878:
pload r9, [494]
in r6
in r1
cmp r6, r1
jg label_878
in zr
pstore [494], r9
pload sp, [782]
pstore [492], zr
or r4, r4, r6
store_16 [10882], r13
pstore [4], r13
out zr
load_8 r4, [10380]
pstore [782], zr
load_8 r13, [10380]
store_32 [10882], r3
pload r8, [494]
xor r3, r1, r7
pload r7, [782]
load_16 r3, [10380]
pstore [494], r7
pstore [492], r2
pstore [4], r8
store_16 [10380], zr
lsl r12, zr, r2
pload r9, [4]
pload r11, [494]
pload r7, [494]
pload zr, [492]
pstore [4], r3
and r8, r5, 23081
load_16 r9, [10630]
or r2, r13, r10
pstore [4], r8
pstore [494], r8
pstore [4], r7
pload r9, [492]
jle label_916
pstore [4], r7
label_916:
label_919:
pload r7, [492]
in r6
in r10
cmp r6, r10
jle label_919
jbe label_922
out flags
label_922:
pstore [782], r4
jb label_926
jge label_927
pstore [782], flags
label_927:
label_926:
store_32 [10630], r8
pload r11, [494]
in r8
pstore [4], sp
pload r6, [494]
pload r13, [782]
pstore [782], r11
pstore [782], r11
jl label_939
pstore [494], sp
label_939:
store_8 [10132], r9
pload r12, [494]
pstore [782], r11
and r1, r1, 26181
pload r8, [492]
pstore [782], r5
store_8 [10380], sp
pload r11, [492]
pload flags, [4]
pload r13, [494]
lsl r2, r4, r2
pstore [494], r10
pload r9, [494]
load_16 r8, [10132]
pload r11, [492]
pstore [782], r7
pstore [782], r5
pload sp, [4]
pstore [494], r1
in r5
pstore [4], r13
pstore [4], r3
pload r2, [782]
load_8 zr, [10380]
or r1, r3, flags
load_16 r6, [10380]
nor r4, sp, 1104
label_969:
pstore [782], r3
in r13
in r5
cmp r13, r5
je label_969
in r12
label_973:
nor flags, flags, r6
in r9
in r8
cmp r9, r8
jge label_973
in r2
pstore [494], zr
store_32 [10630], r9
pstore [492], flags
in r5
pstore [782], r7
in r10
pload zr, [494]
jae label_984
pload r7, [492]
label_984:
pload r2, [782]
pstore [494], r5
pload r3, [492]
pload r5, [782]
pstore [492], r8
pstore [492], r11
pstore [494], r1
label_994:
lsr r3, r6, 58983
in r1
in r8
cmp r1, r8
jge label_994
pload r8, [4]
xor r9, r12, 38805
label_1000:
nand r3, r2, 24232
in r7
in r1
cmp r7, r1
jle label_1000
jmp 0
