from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

# Llave de 16 bytes (AES-128), 24 bytes (AES-192) o 32 bytes (AES-256)
key = 0x2b7e151628aed2a6abf7158809cf4f3c

# Mensaje a cifrar
data = 0x3243f6a8885a308d313198a2e0370734

# Cifrado AES en modo ECB
cipher = AES.new(key, AES.MODE_ECB)

print(f'cipher: {cipher}')

print(f'con pad: {len(pad(data, AES.block_size))}')

# Asegúrate de que los datos estén alineados con el tamaño de bloque (16 bytes para AES)
ciphertext = cipher.encrypt(pad(data, AES.block_size))

print(f'Cifrado: {ciphertext}')

# Descifrado AES en modo ECB
decipher = AES.new(key, AES.MODE_ECB)
plaintext = unpad(decipher.decrypt(ciphertext), AES.block_size)

print(f'Descifrado: {plaintext}')
