.section .data
    # S-box para la función SubBytes
    s_box: .byte 0x63,0x7c,0x77,0x7b,0xf2,0x6b,0x6f,0xc5,0x30,0x01,0x67,0x2b,0xfe,0xd7,0xab
    .byte 0x76,0xca,0x82,0xc9,0x7d,0xfa,0x59,0x47,0xf0,0xad,0xd4,0xa2,0xaf,0x9c,0xa4
    .byte 0x72,0xc0,0xb7,0xfd,0x93,0x26,0x36,0x3f,0xf7,0xcc,0x34,0xa5,0xe5,0xf1,0x71
    .byte 0xd8,0x31,0x15,0x04,0xc7,0x23,0xc3,0x18,0x96,0x05,0x9a,0x07,0x12,0x80,0xe2
    .byte 0xeb,0x27,0xb2,0x75,0x09,0x83,0x2c,0x1a,0x1b,0x6e,0x5a,0xa0,0x52,0x3b,0xd6

.section .bss
    state: .space 16        # Espacio para el estado (16 bytes)
    key: .space 16          # Espacio para la clave (16 bytes)
    roundkeys: .space 176   # Espacio para las claves de ronda (11 rondas * 16 bytes)

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

    # Generar claves de ronda
    call key_expansion

    # Ejecutar AES
    call add_round_key
    li t0, 9          # Número de rondas restantes

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
    li a7, 93          # Código de salida para ecall
    ecall

# Función SubBytes
subbytes:
    la t2, s_box
    li t1, 0
subbytes_loop:
    la t0, state
    add t3, t1, t0
    lb t4, 0(t3)
    andi t4, t4, 0x0F    # Obtener el índice de la columna
    slli t4, t4, 1       # Multiplicador para la tabla
    lb t4, 0(t4)         # Obtener el valor de la tabla
    andi t3, t1, 0xF0    # Obtener el índice de la fila
    srli t3, t3, 4       # Desplazar el índice de la fila
    add t3, t4, t3       # Obtener el valor final
    la t4, state
    sb t3, 0(t4)
    addi t1, t1, 1
    li t5, 16
    blt t1, t5, subbytes_loop
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
    # Implementa MixColumns aquí
    # Esta función mezcla las columnas del estado
    # Implementa las operaciones con la matriz de mezcla (en función del algoritmo AES)
    ret

# Función AddRoundKey
add_round_key:
    la t0, state
    la t1, key
    li t2, 0
add_round_key_loop:
    lb t3, 0(t0)
    lb t4, 0(t1)
    xor t3, t3, t4
    sb t3, 0(t0)
    addi t0, t0, 1
    addi t1, t1, 1
    addi t2, t2, 1
    li t5, 16
    blt t2, t5, add_round_key_loop
    ret

# Función Key Expansion
key_expansion:
    # Implementa la expansión de claves aquí
    # Utiliza Rcon para la generación de claves de ronda
    ret
