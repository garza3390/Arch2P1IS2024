from AddRoundKey import addRoundKey
from KeySchedule import gensubkey
from MixColums import mixColums
from ShiftRows import shiftRows
from SubBytes import SubBytes
from operaciones import texto_a_matriz_hex, print_hex


def main(matriz_hex, key):

    print("add")
    addRoundKey(matriz_hex, key)
    print_hex(matriz_hex)
    print("----")

    for i in range(9):
        print("sub")
        SubBytes(matriz_hex)
        print_hex(matriz_hex)
        print("----")


        print("shift")
        shiftRows(matriz_hex)
        print_hex(matriz_hex)
        print("----")

        print("mix")
        matriz_hex = mixColums(matriz_hex)
        print_hex(matriz_hex)
        print("----")

        print_hex(key)

        key = [[key[j][i] for j in range(len(key))] for i in range(len(key[0]))]
        key = gensubkey(key, i+1)
        key = [[key[j][i] for j in range(len(key))] for i in range(len(key[0]))]

        print("add")
        addRoundKey(matriz_hex, key)
        print_hex(matriz_hex)
        print("----")

    print("sub")
    SubBytes(matriz_hex)
    print_hex(matriz_hex)
    print("----")

    print("shift")
    shiftRows(matriz_hex)
    print_hex(matriz_hex)
    print("----")

    key = [[key[j][i] for j in range(len(key))] for i in range(len(key[0]))]
    key = gensubkey(key, 10)
    key = [[key[j][i] for j in range(len(key))] for i in range(len(key[0]))]

    print("add")
    addRoundKey(matriz_hex, key)
    print_hex(matriz_hex)
    print("----")

    print_hex(matriz_hex)

def test():

    matriz_hex = [[0xea, 0x04, 0x65, 0x85], [0x83, 0x45, 0x5d, 0x96], [0x5c, 0x33, 0x98, 0xb0],
                  [0xf0, 0x2d, 0xad, 0xc5]]
    print("Original")
    print_hex(matriz_hex)

    print("Sub Bytes")
    SubBytes(matriz_hex)
    print_hex(matriz_hex)

    print("shift Rows")
    shiftRows(matriz_hex)
    print_hex(matriz_hex)

    print("Mix Columns")
    matriz_hex = mixColums(matriz_hex)
    print_hex(matriz_hex)

    print("Add Round Key")
    key = [[0xac, 0x19, 0x28, 0x57], [0x77, 0xfa, 0xd1, 0x5c], [0x66, 0xdc, 0x29, 0x00], [0xf3, 0x21, 0x41, 0x6a]]
    addRoundKey(matriz_hex, key)
    print_hex(matriz_hex)


def test2():
    matriz_hex = [[0xea, 0x04, 0x65, 0x85], [0x83, 0x45, 0x5d, 0x96], [0x5c, 0x33, 0x98, 0xb0],
                  [0xf0, 0x2d, 0xad, 0xc5]]
    key = [[0xac, 0x19, 0x28, 0x57], [0x77, 0xfa, 0xd1, 0x5c], [0x66, 0xdc, 0x29, 0x00], [0xf3, 0x21, 0x41, 0x6a]]

    main(matriz_hex, key)

def test3():
    texto = "Two One Nine TwoTwo One Nine Two"
    pas = "Thats my Kung Fu"

    matriz_hex = texto_a_matriz_hex(texto)
    key = texto_a_matriz_hex(pas)

    print("texto")
    print_hex(matriz_hex)
    print("key")
    print_hex(key)
    print("resultado")
    main(matriz_hex, key)


test3()




