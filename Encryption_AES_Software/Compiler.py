import os
registers = {
    'r1':  '00001', 'r2':  '00010', 'r3':  '00011', 'r4':  '00100', 'r5':  '00101', 'r6':  '00110',
    'r7':  '00111', 'r8':  '01000', 'r9':  '01001', 'r10': '01010', 'r11': '01011', 'r12': '01100',
    'r13': '01101', 'r14': '01110', 'r15': '01111', 'r16': '10000', 'r17': '10001', 'r18': '10010',
    'r19': '10011', 'r20': '10100', 'r21': '10101', 'r22': '10110', 'r23': '10111', 'r24': '11000',
    'r25': '11001', 'r26': '11010', 'r27': '11011', 'r28': '11100', 'r29': '11101', 'r30': '11110',
    'r31': '11111', 'r32': '100000',
    'vr1':  '00001', 'vr2':  '00010', 'vr3':  '00011', 'vr4':  '00100', 'vr5':  '00101', 'vr6':  '00110',
    'vr7':  '00111', 'vr8':  '01000', 'vr9':  '01001', 'vr10': '01010', 'vr11': '01011', 'vr12': '01100',
    'vr13': '01101', 'vr14': '01110', 'vr15': '01111', 'vr16': '10000', 'vr17': '10001', 'vr18': '10010',
    'vr19': '10011', 'vr20': '10100', 'vr21': '10101', 'vr22': '10110', 'vr23': '10111', 'vr24': '11000',
    'vr25': '11001', 'vr26': '11010', 'vr27': '11011', 'vr28': '11100', 'vr29': '11101', 'vr30': '11110',
    'vr31': '11111', 'vr32': '100000'
}

instructions = {
    'str': '00001', 'ldr': '00010', 'Add_1': '00100', 'add': '00101', 'xor': '00110', 'mul': '00111',
    'bne': '00011',
    'vstr': '10001', 'vldr': '10010', 'AddRoundKey': '10011', 'ShiftRows': '10100', 'MixColumns': '10101',
    'RotWord': '10110', 'Rcon': '10111', 'SubBytes': '11000', 'RoundKey': '11001', 'XorColumns': '11010',
    'InverseMixColumns': '11100', 'InverseShiftRows': '11101', 'InverseSubBytes': '11110', 'nop': '0'*20
}


def eliminar_comentarios(archivo_entrada, archivo_salida):
    try:
        with open(os.path.join(os.getcwd(),"CPU","memory",archivo_entrada), 'r') as entrada, open(os.path.join(os.getcwd(),"CPU","memory",archivo_salida), 'w') as salida:
            for linea in entrada:
                linea_sin_comentario = linea.split('//')[0]
                if linea_sin_comentario.strip():
                    salida.write(linea_sin_comentario)
            entrada.close()
            salida.close()
        print(f"Archivo procesado exitosamente. Resultado guardado en: {archivo_salida}")
    except FileNotFoundError:
        print(f"El archivo {archivo_entrada} no se encontró.")
    except Exception as e:
        print(f"Error: {e}")

def compiler(file_name,outfile):
    if os.path.exists(os.path.join(os.getcwd(),"CPU","memory",outfile)):
        nf = open(os.path.join(os.getcwd(),"CPU","memory",outfile),"w")
        nf.close()
        pass
    with open(os.path.join(os.getcwd(),"CPU","memory",file_name),"r") as f, open(os.path.join(os.getcwd(),"CPU","memory",outfile),"w") as of:
        cc = 0
        for line in f:
            
            parts = line.strip().split(" ")
            
            print(parts)
            command = parts[0]
            if ":" not in command:
                if command == "nop":
                    of.write(str(cc)+":"+instructions[command]+";"+"\n")
                elif command in ["str","vstr"]:
                    of.write(str(cc)+":"+instructions[command]+"0"*5+ registers[parts[1]] + registers[parts[2]]+";"+"\n")
                elif command in ["ldr","Add_1","vldr","ShiftRows","MixColumns","RotWord","SubBytes","RoundKey","XorColumns","InverseMixColumns","InverseShiftRows","InverseSubBytes"]:
                    of.write(str(cc)+":"+instructions[command]+registers[parts[1]] + "0"*5 + registers[parts[2].replace("\n","")]+";"+"\n")
                elif command in ["add","xor","mul","AddRoundKey","Rcon"]:
                    of.write(str(cc)+":"+instructions[command]+registers[parts[1]] + registers[parts[2]] + registers[parts[3]]+";"+"\n")
                elif command in ["bne"]:
                    of.write(str(cc)+":"+instructions[command]+ str(format(int(parts[1]),"05b")) + registers[parts[2]]+registers[parts[3]]+";"+"\n")
                cc += 1
        of.close()
        f.close()
                

infile = "Encriptacion_AES_SIMD.s"
tempfile = "Encriptacion_AES_SIMDwc.s"
outfile = "instructions.mif"

eliminar_comentarios(infile,tempfile)
compiler(tempfile,outfile)


