def texto_a_matriz_hex(texto):
    # Asegurarse de que el texto tenga al menos 16 caracteres, si no, rellenar con espacios
    while len(texto) < 16:
        texto += ' '

    # Tomar solo los primeros 16 caracteres en caso de que el texto sea más largo
    texto = texto[:16]

    # Convertir cada carácter a su valor hexadecimal y organizar en una matriz 4x4
    matriz = [[ord(c) for c in texto[i:i + 4]] for i in range(0, 16, 4)]

    matriz = [[matriz[j][i] for j in range(len(matriz))] for i in range(len(matriz[0]))]

    return matriz


def print_hex(matriz):
    for fila in matriz:
        fila_hex = [f"{valor:02X}" for valor in fila]  # Convertir cada valor a formato hexadecimal
        print(fila_hex)
def fila_hex(fila):
    fila_hex = [f"{valor:02X}" for valor in fila]  # Convertir cada valor a formato hexadecimal
    print(fila_hex)