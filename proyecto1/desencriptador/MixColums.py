from operaciones import print_hex


def mixColumnsAux_decrypt(a, b, c, d):
    valor1 = gmul(a, 0x0e) ^ gmul(b, 0x0b) ^ gmul(c, 0x0d) ^ gmul(d, 0x09)
    valor2 = gmul(a, 0x09) ^ gmul(b, 0x0e) ^ gmul(c, 0x0b) ^ gmul(d, 0x0d)
    valor3 = gmul(a, 0x0d) ^ gmul(b, 0x09) ^ gmul(c, 0x0e) ^ gmul(d, 0x0b)
    valor4 = gmul(a, 0x0b) ^ gmul(b, 0x0d) ^ gmul(c, 0x09) ^ gmul(d, 0x0e)
    return [valor1, valor2, valor3, valor4]

def gmul(a, b):
    if b == 1:
        return a
    elif b == 2:
        tmp = (a << 1) & 0xff
        return tmp if a < 128 else tmp ^ 0x1b
    elif b == 3:
        return gmul(a, 2) ^ a
    elif b == 0x09:
        return gmul(gmul(gmul(a, 2), 2), 2) ^ a
    elif b == 0x0b:
        return gmul(gmul(gmul(a, 2), 2), 2) ^ gmul(a, 2) ^ a
    elif b == 0x0d:
        return gmul(gmul(gmul(a, 2), 2), 2) ^ gmul(gmul(a, 2), 2) ^ a
    elif b == 0x0e:
        return gmul(gmul(gmul(a, 2), 2), 2) ^ gmul(gmul(a, 2), 2) ^ gmul(a, 2)
    else:
        return 0  # En caso de que b no sea válido




def mixColums_decrypt(matriz_hex):
    result = []
    for j, fila in enumerate(matriz_hex):
        result.append(mixColumnsAux_decrypt(matriz_hex[0][j], matriz_hex[1][j], matriz_hex[2][j], matriz_hex[3][j]))
    result = [[result[j][i] for j in range(len(result))] for i in range(len(result[0]))]
    return result


def test():
    print("Original")
    matriz = [[0x47, 0x40, 0xa3, 0x4c], [0x37, 0xd4, 0x70, 0x9f], [0x94, 0xe4, 0x3a, 0x42], [0xed, 0xa5, 0xa6, 0xbc]]
    print_hex(matriz)

    print("Resultado descifrado")
    matriz = mixColums_decrypt(matriz)
    print_hex(matriz)


#test()