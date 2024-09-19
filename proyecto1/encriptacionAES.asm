.section .data
    s_box: .byte 0x63,0x7c,0x77,0x7b,0xf2,0x6b,0x6f,0xc5,0x30,0x01,0x67,0x2b,0xfe,0xd7,0xab
    .byte 0x76,0xca,0x82,0xc9,0x7d,0xfa,0x59,0x47,0xf0,0xad,0xd4,0xa2,0xaf,0x9c,0xa4
    .byte 0x72,0xc0,0xb7,0xfd,0x93,0x26,0x36,0x3f,0xf7,0xcc,0x34,0xa5,0xe5,0xf1,0x71
    .byte 0xd8,0x31,0x15,0x04,0xc7,0x23,0xc3,0x18,0x96,0x05,0x9a,0x07,0x12,0x80,0xe2
    .byte 0xeb,0x27,0xb2,0x75,0x09,0x83,0x2c,0x1a,0x1b,0x6e,0x5a,0xa0,0x52,0x3b,0xd6
    # Inverso S-box para InvSubBytes
    inv_s_box: .byte 0x52,0x09,0x6a,0xd5,0x30,0x36,0xa5,0x38,0xbf,0x40,0xa3,0x9e,0x81,0xf3,0xd7
    .byte 0xfb,0x7c,0xe3,0x39,0x82,0x9b,0x2f,0xff,0x87,0x34,0x8e,0x43,0x44,0xc4,0xde
    .byte 0xe9,0xcb,0x54,0x7b,0x94,0x32,0xa6,0xc2,0x23,0x3d,0xee,0x4c,0x95,0x0b,0x42
    .byte 0xfa,0xc3,0x4e,0x08,0x2e,0xa1,0x66,0x28,0xd9,0x24,0xb2,0x76,0x5b,0xa2,0x49
    .byte 0x6d,0x8b,0xd1,0x25,0x72,0xf8,0xf6,0x64,0x86,0x68,0x98,0x16,0xd4,0xa4,0x5c
    .byte 0xcc,0x5d,0x65,0x5e,0x47,0xf1,0x8b,0x29,0x97,0x7d,0x28,0x5b,0x1f,0x72,0x73
    .byte 0x68,0x24,0xd1,0x33,0x5d,0x93,0x6b,0x91,0x27,0x1b,0x98,0x46,0xc4,0x73,0x25

.section .bss
    state: .space 16
    key: .space 16
    roundkeys: .space 176  # 11 rondas * 16 bytes

.section .text
.global _start

_start:
    # Inicialización del estado (16 bytes)
    la t0, state
    li t1, 0x32
    sb t1, 0(t0)
    li t1, 0x88
    sb t1, 1(t0)
    li t1, 0x31
    sb t1, 2(t0)
    li t1, 0x43
    sb t1, 3(t0)
    li t1, 0x85
    sb t1, 4(t0)
    li t1, 0x74
    sb t1, 5(t0)
    li t1, 0x7a
    sb t1, 6(t0)
    li t1, 0x9c
    sb t1, 7(t0)
    li t1, 0x7f
    sb t1, 8(t0)
    li t1, 0x8a
    sb t1, 9(t0)
    li t1, 0x84
    sb t1, 10(t0)
    li t1, 0x39
    sb t1, 11(t0)
    li t1, 0x20
    sb t1, 12(t0)
    li t1, 0x14
    sb t1, 13(t0)
    li t1, 0xd6
    sb t1, 14(t0)
    li t1, 0x32
    sb t1, 15(t0)

    # Inicialización de la clave (16 bytes)
    la t0, key
    li t1, 0x2b
    sb t1, 0(t0)
    li t1, 0x7e
    sb t1, 1(t0)
    li t1, 0x15
    sb t1, 2(t0)
    li t1, 0x16
    sb t1, 3(t0)
    li t1, 0x28
    sb t1, 4(t0)
    li t1, 0xae
    sb t1, 5(t0)
    li t1, 0xd2
    sb t1, 6(t0)
    li t1, 0xa6
    sb t1, 7(t0)
    li t1, 0xab
    sb t1, 8(t0)
    li t1, 0x3a
    sb t1, 9(t0)
    li t1, 0x7c
    sb t1, 10(t0)
    li t1, 0x08
    sb t1, 11(t0)
    li t1, 0x3e
    sb t1, 12(t0)
    li t1, 0x9e
    sb t1, 13(t0)
    li t1, 0x6c
    sb t1, 14(t0)
    li t1, 0x62
    sb t1, 15(t0)

    # Expansión de clave
    call key_expansion

    # Ejecutar AES
    call add_round_key
    li t0, 9  # Número de rondas restantes

aes_rounds:
    call subbytes
    call shiftrows
    call mix_columns
    call add_round_key
    addi t0, t0, -1
    bnez t0, aes_rounds

    # Última ronda (sin MixColumns)
    call subbytes
    call shiftrows
    call add_round_key

    # Salir del programa
    li a7, 93  # Código de salida para ecall
    ecall

# Función SubBytes
subbytes:
    la t2, s_box
    li t1, 0
subbytes_loop:
    la t0, state
    add t3, t1, t0
    lb t4, 0(t3)
    lb t5, 0(t4)  # Cargar el valor de S-box usando el valor del estado como índice
    sb t5, 0(t3)  # Reemplazar el valor en el estado
    addi t1, t1, 1
    li t6, 16
    blt t1, t6, subbytes_loop
    ret

# Función ShiftRows
shiftrows:
    la t0, state
    # Fila 1 desplazamiento hacia la izquierda por 1 byte
    lb t1, 4(t0)
    lb t2, 5(t0)
    lb t3, 6(t0)
    lb t4, 7(t0)
    sb t1, 0(t0)
    sb t2, 4(t0)
    sb t3, 8(t0)
    sb t4, 12(t0)

    # Fila 2 desplazamiento hacia la izquierda por 2 bytes
    lb t1, 8(t0)
    lb t2, 9(t0)
    lb t3, 10(t0)
    lb t4, 11(t0)
    sb t1, 8(t0)
    sb t2, 9(t0)
    sb t3, 10(t0)
    sb t4, 11(t0)

    # Fila 3 desplazamiento hacia la izquierda por 3 bytes
    lb t1, 12(t0)
    lb t2, 13(t0)
    lb t3, 14(t0)
    lb t4, 15(t0)
    sb t1, 12(t0)
    sb t2, 13(t0)
    sb t3, 14(t0)
    sb t4, 15(t0)

    ret

# Función MixColumns
mix_columns:
    la t0, state
    li t1, 4
mix_columns_loop:
    # Cargar una columna
    lb t2, 0(t0)
    lb t3, 1(t0)
    lb t4, 2(t0)
    lb t5, 3(t0)
    
    # Multiplicación por 2 en GF(2^8) y XOR
    call mix_column_mult
    addi t0, t0, 4
    addi t1, t1, -1
    bnez t1, mix_columns_loop
    ret

# Función mix_column_mult
mix_column_mult:
    la t0, state
    lb t1, 0(t0)
    lb t2, 1(t0)
    lb t3, 2(t0)
    lb t4, 3(t0)
    
    # Multiplicación por 2
    slli t5, t1, 1
    andi t5, t5, 0xff
    beq t1, t5, no_xor
    xor t5, t5, 0x1b  # Si el bit más alto estaba encendido, se aplica el polinomio irreducible
no_xor:
    # Guardar los resultados
    la t1, state
    sb t5, 0(t1)
    
    # Repetir para otros bytes
    lb t1, 1(t0)
    slli t5, t1, 1
    andi t5, t5, 0xff
    beq t1, t5, no_xor
    xor t5, t5, 0x1b
    sb t5, 1(t1)
    
    lb t1, 2(t0)
    slli t5, t1, 1
    andi t5, t5, 0xff
    beq t1, t5, no_xor
    xor t5, t5, 0x1b
    sb t5, 2(t1)
    
    lb t1, 3(t0)
    slli t5, t1, 1
    andi t5, t5, 0xff
    beq t1, t5, no_xor
    xor t5, t5, 0x1b
    sb t5, 3(t1)
    
    ret

# Función AddRoundKey
add_round_key:
    la t0, state
    la t1, roundkeys
    # Aplicar XOR entre estado y clave de ronda
    li t2, 16
add_round_key_loop:
    lb t3, 0(t0)
    lb t4, 0(t1)
    xor t5, t3, t4
    sb t5, 0(t0)
    addi t0, t0, 1
    addi t1, t1, 1
    addi t2, t2, -1
    bnez t2, add_round_key_loop
    ret

# Función Key Expansion
key_expansion:
    la t0, key
    la t1, roundkeys
    li t2, 16
key_expansion_loop:
    lb t3, 0(t0)
    sb t3, 0(t1)
    addi t0, t0, 1
    addi t1, t1, 1
    addi t2, t2, -1
    bnez t2, key_expansion_loop
    ret
