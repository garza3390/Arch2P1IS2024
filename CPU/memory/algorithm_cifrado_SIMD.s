//r1: dirección de memoria del texto a cifrar almacenada en el registro r1 (la dirección es cero)
//r2: dirección de memoria de la llave almacenada en el registro r2 (la direcciones 1)
//r6: dirección de memoria para guardar el texto cifrado (la dirección es 2)
//inicializar direcciones de memoria en los registros
Add_1 r2 r2
nop
Add_1 r6 r2 
nop
//cargar el registro r10 con la condición de parada del loop principal r10=9
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
//cargar los vectores
vldr vr1 r1
nop
vldr vr2 r2
nop
nop
nop
nop
nop
//aplica la operacion entre matrices y la guarda en vr3
AddRoundKey vr3 vr2 vr1
nop
nop
nop
//main_loop:
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
//incrementar en 1 el contador
Add_1 r9 r9 
nop
nop
nop
nop
//se devuelve n instrucciones (PC - 21(main_loop)) si
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
