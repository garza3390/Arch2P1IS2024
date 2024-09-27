Add_1 r2 r2
nop
Add_1 r6 r2 
nop
Add_1 r10 r10
nop
Add_1 r10 r10
nop
Add_1 r10 r10
nop
Add_1 r10 r10
nop
Add_1 r10 r10
nop
Add_1 r10 r10
nop
Add_1 r10 r10
nop
Add_1 r10 r10
nop
Add_1 r10 r10
nop
vldr vr1 r1
nop
vldr vr2 r2
nop
nop
nop
nop
nop
AddRoundKey vr3 vr2 vr1
nop
nop
nop
main_loop:
RoundKey vr2 vr2
nop
nop
nop
ShiftRows vr3 vr3
nop
nop
nop
MixColumns vr3 vr3
nop
nop
nop
AddRoundKey vr3 vr2 vr3
nop
nop
nop
Add_1 r9 r9 
nop
nop
nop
nop
bne 21 r10 r9
SubBytes vr3 vr3
nop
nop
nop
ShiftRows vr3 vr3
nop
nop
nop
AddRoundKey vr3 vr2 vr3
nop
nop
nop
nop
vstr vr3 r6
