from desencriptador.AddRoundKey import addRoundKey
from KeySchedule import gensubkey
from desencriptador.MixColums import mixColums_decrypt
from desencriptador.ShiftRows import shiftRows
from desencriptador.SubBytes import SubBytes
from operaciones import texto_a_matriz_hex, print_hex


keys= []



def keyGen(key):


    for i in range(10):
        key = [[key[j][i] for j in range(len(key))] for i in range(len(key[0]))]
        key = gensubkey(key, i+1)
        key = [[key[j][i] for j in range(len(key))] for i in range(len(key[0]))]
        keys.insert(0, key)


def main(matriz_hex, key):



    keyGen(key)

    print("key 10")
    print_hex(keys[0])
    print("text")
    print_hex(matriz_hex)



    print("add")
    addRoundKey(matriz_hex, keys[0])
    print_hex(matriz_hex)
    print("----")

    for i in range(9):

        print("shift")
        shiftRows(matriz_hex)
        print_hex(matriz_hex)
        print("----")


        print("sub")
        SubBytes(matriz_hex)
        print_hex(matriz_hex)
        print("----")


        print("add")
        addRoundKey(matriz_hex, keys[i+1])
        print_hex(matriz_hex)
        print("----")



        print("mix")
        matriz_hex = mixColums_decrypt(matriz_hex)
        print_hex(matriz_hex)
        print("----")



    print("shift")
    shiftRows(matriz_hex)
    print_hex(matriz_hex)
    print("----")

    print("sub")
    SubBytes(matriz_hex)
    print_hex(matriz_hex)
    print("----")

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
    matriz_hex = mixColums_decrypt(matriz_hex)
    print_hex(matriz_hex)

    print("Add Round Key")
    key = [[0xac, 0x19, 0x28, 0x57], [0x77, 0xfa, 0xd1, 0x5c], [0x66, 0xdc, 0x29, 0x00], [0xf3, 0x21, 0x41, 0x6a]]
    addRoundKey(matriz_hex, key)
    print_hex(matriz_hex)


def test2():
    matriz_hex = [[0x29, 0x57, 0x40, 0x1a], [0xc3, 0x14, 0x22, 0x02], [0x50, 0x20, 0x99, 0xd7], [0x5f, 0xf6, 0xb3, 0x3a]]
    key = [[0x54, 0x73, 0x20, 0x67], [0x68, 0x20, 0x4b, 0x20], [0x61, 0x6d, 0x75, 0x46], [0x74, 0x79, 0x6e, 0x75]]

    main(matriz_hex, key)
    #keyGen(key)


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


test2()




