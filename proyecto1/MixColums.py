from operaciones import print_hex


def mixColumnsAux(a, b, c, d):
    valor1 = gmul(a, 2) ^ gmul(b, 3) ^ gmul(c, 1) ^ gmul(d, 1)
    valor2 = gmul(a, 1) ^ gmul(b, 2) ^ gmul(c, 3) ^ gmul(d, 1)
    valor3 = gmul(a, 1) ^ gmul(b, 1) ^ gmul(c, 2) ^ gmul(d, 3)
    valor4 = gmul(a, 3) ^ gmul(b, 1) ^ gmul(c, 1) ^ gmul(d, 2)
    return [valor1, valor2, valor3,valor4]

def gmul(a, b):
    if b == 1:
        return a
    tmp = (a << 1) & 0xff
    if b == 2:
        return tmp if a < 128 else tmp ^ 0x1b
    if b == 3:
        return gmul(a, 2) ^ a


def mixColums(matriz_hex):
    result = []
    for j, fila in enumerate(matriz_hex):
        result.append(mixColumnsAux(matriz_hex[0][j], matriz_hex[1][j], matriz_hex[2][j], matriz_hex[3][j]))
    result = [[result[j][i] for j in range(len(result))] for i in range(len(result[0]))]
    return result


def test():
    print("Original")
    matriz = [[0x87, 0xf2, 0x4d, 0x97], [0x6e, 0x4c, 0x90, 0xec], [0x46, 0xe7, 0x4a, 0xc3], [0xa6, 0x8c, 0xd8, 0x95]]
    print_hex(matriz)

    print("Resultado")
    matriz = mixColums(matriz)
    print_hex(matriz)
