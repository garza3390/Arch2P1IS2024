//r1: dirección de memoria del texto cifrado almacenada en el registro r1 (la dirección es 2

//r2: dirección de memoria de la llave almacenada en el registro r2 (la direcciones 1)

//r6: dirección de memoria para guardar el texto desencriptado (la dirección es 0)


//inicializar direcciones de memoria en los registros
Add_1 r2 r2
nop
Add_1 r1 r2 
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
vldr  vr1 r1  
nop
vldr vr2 r2
nop
nop
nop
nop
nop

//Aplicar la primera AddRoundKey usando la última round key (ya que en desencriptación se aplican en orden inverso)
AddRoundKey vr3 vr2 vr1
nop
nop
nop

// Inverse ShiftRows 
InverseShiftRows vr3 vr3
nop
nop
nop

//Inverse SubBytes
InverseSubBytes vr3 vr3
nop
nop
nop

//Aplica la última clave del ciclo (antes de entrar en el loop de desencriptación)
AddRoundKey vr3 vr2 vr3
nop
nop
nop

//main_loop (- 25): # 9 iteraciones para el loop de desencriptación

// Round key
RoundKey vr2 vr2
nop
nop
nop

// Inverse MixColumns
InverseMixColumns vr3 vr3
nop
nop
nop

// Inverse ShiftRows
InverseShiftRows vr3 vr3
nop
nop
nop

// Inverse SubBytes
InverseSubBytes vr3 vr3
nop
nop
nop

// AddRoundKey
AddRoundKey vr3 vr2 vr3
nop
nop
nop

// Incrementar en 1 el contador
Add_1 r9 r9 
nop
nop
nop
nop

// Se devuelve n instrucciones (PC - 25 (main_loop)) si r9 != 9
bne 25 r10 r9

// Guardar el resultado final desencriptado
vstr vr3 r6


