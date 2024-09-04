from operaciones import print_hex

def addRoundKey(matriz, key):
    for i, fila in enumerate(matriz):
        for j, col in enumerate(fila):
            matriz[i][j] = xor(matriz[i][j], key[i][j])

def xor(num1, num2):
    return num1 ^ num2


def test():

    matriz = [[0x47, 0x40, 0xa3, 0x4c], [0x37, 0xd4, 0x70, 0x9f], [0x94, 0xe4, 0x3a, 0x42], [0xed, 0xa5, 0xa6, 0xbc]]
    key = [[0xac, 0x19, 0x28, 0x57], [0x77, 0xfa, 0xd1, 0x5c], [0x66, 0xdc, 0x29, 0x00], [0xf3, 0x21, 0x41, 0x6a]]

    print("Original")
    print_hex(matriz)
    print("key")
    print_hex(key)

    print("Resultado")
    addRoundKey(matriz, key)
    print_hex(matriz)

#test()