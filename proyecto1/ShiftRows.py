from operaciones import print_hex


def colocar_final(lista):
    # Extraer el primer elemento
    primer_elemento = lista.pop(0)

    # Añadir el primer elemento al final
    lista.append(primer_elemento)


def shiftRows(matriz_hex):
    for offset, fila in enumerate(matriz_hex):
        for i in range(offset):
            colocar_final(fila)



def test():
    print("Original")
    matriz = [[0x87, 0xf2, 0x4d, 0x97], [0xec, 0x6e, 0x4c, 0x90], [0x4a, 0xc3, 0x46, 0xe7], [0x8c, 0xd8, 0x95, 0xa6]]
    print_hex(matriz)

    print("Resultado")
    shiftRows(matriz)
    print_hex(matriz)
