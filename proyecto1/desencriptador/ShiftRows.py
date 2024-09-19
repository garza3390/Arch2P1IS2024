from operaciones import print_hex


def colocar_primero(lista):
    # Extraer el último elemento
    ultimo_elemento = lista.pop(-1)

    # Añadir el último elemento al principio
    lista.insert(0, ultimo_elemento)


def shiftRows(matriz_hex):
    for offset, fila in enumerate(matriz_hex):
        for i in range(offset):
            colocar_primero(fila)



def test():
    print("Original")
    matriz = [[0x87, 0xf2, 0x4d, 0x97], [0x6e, 0xec, 0x4c, 0x90], [0x46, 0xe7, 0x4a, 0xc3], [0xa6, 0x8c, 0xd8, 0x95]]
    print_hex(matriz)

    print("Resultado")
    shiftRows(matriz)
    print_hex(matriz)

#test()
