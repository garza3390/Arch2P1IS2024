from operaciones import print_hex

def addRoundKey(matriz, key):
    for i, fila in enumerate(matriz):
        for j, col in enumerate(fila):
            matriz[i][j] = xor(matriz[i][j], key[i][j])

def xor(num1, num2):
    return num1 ^ num2


def test():

    matriz = [[0xeb, 0x59, 0x8b, 0x1b], [0x40, 0x2e, 0xa1, 0xc3], [0xf2, 0x38, 0x13, 0x42], [0x1e, 0x84, 0xe7, 0xd6]]
    key = [[0xac, 0x19, 0x28, 0x57], [0x77, 0xfa, 0xd1, 0x5c], [0x66, 0xdc, 0x29, 0x00], [0xf3, 0x21, 0x41, 0x6a]]

    print("Original")
    print_hex(matriz)
    print("key")
    print_hex(key)

    print("Resultado")
    addRoundKey(matriz, key)
    print_hex(matriz)

#test()