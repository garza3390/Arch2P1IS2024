import copy

from ShiftRows import colocar_final
from SubBytes import digitos_SBOX
from operaciones import texto_a_matriz_hex, print_hex, fila_hex

# Constantes de Rcon
RCON = [
    0x00000000, 0x01000000, 0x02000000, 0x04000000, 0x08000000,
    0x10000000, 0x20000000, 0x40000000, 0x80000000, 0x1b000000, 0x36000000
]

def gfun(col, cons):
    value = RCON[cons]
    xor_value = (value >> 24) & 0xFF
    col[0] = col[0] ^ xor_value
    return col

def xor(col1, col2):
    result = []
    for i in range(len(col1)):
        result.append(col1[i] ^ col2[i])
    return result


def gensubkey(key, rep):
    #print("inicio")
    #key = [[key[j][i] for j in range(len(key))] for i in range(len(key[0]))]
    #print_hex(key)

    #print("paso 1")
    keyg = copy.deepcopy(key[3])
    fila_hex(keyg)
    colocar_final(keyg)

    #print("paso 2")
    for j, col in enumerate(keyg):
        keyg[j] = digitos_SBOX(col)
    #print_hex(key)

    #print("paso 3")
    keyg = gfun(keyg, rep)
    #print_hex(key)

    #fila_hex(keyg)
    #print("antes")

    #print_hex(key)

    print("SubKey" + str(rep))
    key[0] = xor(key[0], keyg) #w4
    key[1] = xor(key[0], key[1]) #w5
    key[2] = xor(key[1], key[2]) #w6
    key[3] = xor(key[2], key[3]) #w7

    print_hex(key)
    return key


def test():
    pas = "Thats my Kung Fu"

    key = texto_a_matriz_hex(pas)

    #key = [[0x24,0x75,0xa2,0xb3], [0x34, 0x75, 0x56, 0x88], [0x31, 0xe2, 0x12, 0x00], [0x13, 0xaa, 0x54, 0x87]]
    key = [[key[j][i] for j in range(len(key))] for i in range(len(key[0]))]


    print("key")
    print_hex(key)
    for i in range(10):
        key = gensubkey(key, i+1)
#test()