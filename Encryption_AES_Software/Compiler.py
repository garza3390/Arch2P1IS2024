import os

registers = {   # Dictionary with the 8 scalar registers to use.
                'Rn1':   '000',
                'Rn2':   '001',
                'Rn3':   '010',
                'Rn4':   '011',
                'Rn5':   '100',
                'Rn6':   '101',
                'Rn7':   '110',
                'Rn8':   '111'
            }

instructions =  { # Dictionary with the 15 instructions to use.
                'mov': '0000',
                'inc': '0001',
                'add': '0010',
                'cmp': '0011',
                'b': '0100',
                'bnq': '0101',
                'load_8x8': '0110',
                'store_8x8': '0111',
                'mods_8x8': '1000',
                'inc_4x16': '1001',
                'norm': '1010',
                'get_8x8': '1011',
                'end': '1100'
                }

def compiler(expression):
    opcode = ""
    condition = ""
    reg_vd = ""
    reg_vs = ""
    reg_dest = ""
    reg_source_a = ""
    reg_source_b = ""
    immediate = ""
    
    if expression == "end":
        command = expression
        opcode = "1110"
        condition = "0"
        reg_vd = reg_vs = "0"
        reg_dest = reg_source_a = reg_source_b = "000"
        immediate = 16 * "0"
        final_result = opcode + condition + reg_vd + reg_vs + reg_dest + reg_source_a + reg_source_b + immediate
    else:
        i = 0
        while expression[i] != " ":
            i += 1
        command = expression[:i]
        opcode = instructions[command]  # Getting the operation code

        condition = "1" if command == "bnq" else "0"  # Only "branch not equal" has a condition.
        
        expression = expression.replace(" ", "")

        if command == "mov":  # movRnx,YY
            reg_vd = reg_vs = "0"
            reg_dest = registers[expression[i:i+3]]
            reg_source_a = reg_source_b = "000"
            j = 7
            while expression[j] != "/":
                j += 1
            immediate = bin(int(expression[7:j]))[2:]
            immediate = ((16 - len(immediate)) * "0") + immediate
        elif command == "inc":
            reg_vd = reg_vs = "0"
            reg_dest = registers[expression[i:i+3]]
            reg_source_a = reg_source_b = "000"
            immediate = 16 * "0"
        elif command == "add":  # addRnx,Rny,ZZ
            reg_vd = reg_vs = "0"
            reg_dest = registers[expression[i:i+3]]
            reg_source_a = registers[expression[i+4:i+7]]
            reg_source_b = "000"
            j = 11
            while expression[j] != "/":
                j += 1
            immediate = bin(int(expression[11:j]))[2:]
            immediate = ((16 - len(immediate)) * "0") + immediate
        elif command == "cmp":  # cmpRnx,Rny
            reg_vd = reg_vs = "0"
            reg_dest = "000"
            reg_source_a = registers[expression[i:i+3]]
            reg_source_b = registers[expression[i+4:i+7]]
            immediate = 16 * "0"
        elif command == "b":  # b_BuildHistogram or bnq_BuildHistogram
            reg_vd = reg_vs = "0"
            reg_dest = reg_source_a = reg_source_b = "000"
            if expression[2] == "E":
                immediate = bin(41)[2:]
            else:
                if expression[7] == "H":  # b_BuildHistogram
                    immediate = bin(14)[2:]
                elif expression[7] == "l":  # b_Normalize
                    immediate = bin(28)[2:]
                else:  # b_BuildImg
                    immediate = bin(33)[2:]
            immediate = ((16 - len(immediate)) * "0") + immediate
        elif command == "bnq":  # bnq_BuildHistogram or bnq_BuildHistogram
            reg_vd = reg_vs = "0"
            reg_dest = reg_source_a = reg_source_b = "000"
            if expression[2] == "E":
                immediate = bin(41)[2:]
            else:
                if expression[9] == "H":  # bnq_BuildHistogram
                    immediate = bin(14)[2:]
                elif expression[9] == "l":  # bnq_Normalize
                    immediate = bin(28)[2:]
                else:  # BuildImg
                    immediate = bin(33)[2:]
            immediate = ((16 - len(immediate)) * "0") + immediate
        elif command == "load_8x8":  # load_8x8Rn1,Rv1
            reg_vd = "0" if expression[12:15] == "Rv1" else "1"
            reg_vs = "0"
            reg_dest = reg_source_b = "000"
            reg_source_a = registers[expression[8:11]]
            immediate = 16 * "0"
        elif command == "store_8x8":  # store_8x8Rn1,Rv1
            reg_vd = "0"
            reg_vs = "0" if expression[13:16] == "Rv1" else "1"
            reg_dest = registers[expression[9:12]]
            reg_source_a = reg_source_b = "000"
            immediate = 16 * "0"
        elif command == "mods_8x8":  # divs_8x8Rv1,Rv0,4
            reg_vd = "0" if expression[8:11] == "Rv1" else "1"
            reg_vs = "0" if expression[12:15] == "Rv1" else "1"
            reg_dest = reg_source_a = reg_source_b = "000"
            j = 16
            while expression[j] != "/":
                j += 1
            immediate = bin(int(expression[16:j]))[2:]
            immediate = ((16 - len(immediate)) * "0") + immediate
        elif command == "inc_4x16":  # inc_4x16Rv1,4
            reg_vd = "0"
            reg_vs = "0" if expression[7:10] == "Rv1" else "1"
            reg_dest = reg_source_a = reg_source_b = "000"
            j = 12
            while expression[j] != "/":
                j += 1
            immediate = bin(int(expression[12:j]))[2:]
            immediate = ((16 - len(immediate)) * "0") + immediate
        elif command == "norm":  # normRn4,Rn4
            reg_vd = reg_vs = "0"
            reg_dest = registers[expression[4:7]]
            reg_source_a = registers[expression[8:11]]
            reg_source_b = "000"
            immediate = 16 * "0"
        else:  # get_8x8Rv1,Rv2
            reg_vd = "0" if expression[7:10] == "Rv1" else "1"
            reg_vs = "0" if expression[11:13] == "Rv1" else "1"
            reg_dest = reg_source_a = reg_source_b = "000"
            immediate = 16 * "0"
        final_result = opcode + condition + reg_vd + reg_vs + reg_dest + reg_source_a + reg_source_b + immediate

    return final_result

filename = "ROM.mif"
result_file_path = os.path.join("..", "CPU", "memory", filename)

# Verificar si el directorio existe, si no, crearlo
directory = os.path.dirname(result_file_path)
if not os.path.exists(directory):
    os.makedirs(directory)

# Crear el archivo si no existe
if not os.path.exists(result_file_path):
    with open(result_file_path, "w") as temp_file:
        pass

# Abrir el archivo en modo 'append'
with open(result_file_path, "a") as result_file:
    current_directory = os.getcwd()
    asm_file_path = os.path.join(current_directory, "algorithm.s")

    with open(asm_file_path, "r") as asm_file:
        compiled_instructions = []
        for line in asm_file:
            line = line.strip()
            if line and not line.startswith(("_", "#")):
                instruction = compiler(line)
                result_file.write(instruction + "\n")
