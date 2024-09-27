import tkinter as tk
from tkinter import ttk, Text
import subprocess
from Compiler import compiler
import os
# Permite cargar el contenido de un archivo
def load_file_content(filepath):
    try:
        with open(filepath, 'r') as file:
            return file.read()
    except FileNotFoundError:
        return f"Error: No se encontró el archivo {filepath}"
    except Exception as e:
        return f"Error al abrir {filepath}: {e}"
# Ventana principal    
root = tk.Tk()
root.title("AES Encryption Debugger")
root.geometry("80x60+100+100")
root.update_idletasks()
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()
window_width = int(screen_width * 0.9)
window_height = int(screen_height * 0.8)
root.geometry(f"{window_width}x{window_height}")

control_frame = ttk.LabelFrame(root, width=window_width * 0.7, height=window_height, relief="sunken")
control_aes_frame = ttk.LabelFrame(root, text="Control AES", width=window_width * 0.3, height=window_height, relief="sunken")
control_frame.grid(row=0, column=0, sticky="nswe")
control_aes_frame.grid(row=0, column=1, sticky="nswe")

top_frame = ttk.LabelFrame(control_frame, text="File Debug", relief="sunken")
bottom_frame = ttk.LabelFrame(control_frame, text="AES Result", relief="sunken")
top_frame.pack(side="top", fill="both", expand=True)
bottom_frame.pack(side="bottom", fill="both", expand=True)

var_frame = ttk.LabelFrame(top_frame, text="Variables", relief="flat", height=100)
var_frame.pack(side="bottom", fill="x")

var_grid = tk.Frame(var_frame)
var_grid.pack(fill="both", expand=True)

# Variables de JTAG
pc_from_jtag = 1
stepping = []
variables = {
    "Metrica 1 1": "Valor 1",
    "Metrica 2": "Valor 2",
    "Metrica 3": "Valor 3",
    "Metrica 4": "Valor 4",
    "Metrica 5": "Valor 5",
    "Ciclos por instruccion: ": "Valor 6"
}
for i, (title, value) in enumerate(variables.items()):
    row = i // 3
    col = i % 3
    tk.Label(var_grid, text=title).grid(row=row, column=col*2, padx=5, pady=5, sticky="e")
    tk.Label(var_grid, text=value).grid(row=row, column=col*2+1, padx=5, pady=5, sticky="w")
    
top_text = Text(top_frame, wrap="none", state=tk.DISABLED)
bottom_text = Text(bottom_frame, wrap="none", state=tk.DISABLED)
top_file_content = load_file_content("textoInicial.s")
bottom_file_content = load_file_content("../CPU/memory/RAM_resultado.mif")
top_text.configure(state=tk.NORMAL)
top_text.insert(tk.END, top_file_content)
top_text.configure(state=tk.DISABLED)
bottom_text.configure(state=tk.NORMAL)
bottom_text.insert(tk.END, bottom_file_content)
bottom_text.configure(state=tk.DISABLED)
# Función para agregar el indicador circular en una línea específica
def add_circular_indicator_pc(text_widget, line_number):
    canvas = tk.Canvas(top_frame, width=20, height=20, bg='white', highlightthickness=0)
    canvas.create_oval(5, 5, 15, 15, fill='green')
    text_widget.configure(state=tk.NORMAL)
    index = f"{line_number}.0"
    text_widget.mark_set("insert", index)
    text_widget.window_create(index, window=canvas)
    text_widget.configure(state=tk.DISABLED)
def add_circular_indicator_debug(text_widget, line_number):
    canvas = tk.Canvas(top_frame, width=20, height=20, bg='white', highlightthickness=0)
    canvas.create_oval(5, 5, 15, 15, fill='red')
    text_widget.configure(state=tk.NORMAL)
    index = f"{line_number}.0"
    text_widget.mark_set("insert", index)
    text_widget.window_create(index, window=canvas)
    text_widget.configure(state=tk.DISABLED)
def clear_text_and_stepping():
    global stepping
    top_text.configure(state=tk.NORMAL)
    top_text.delete(1.0, tk.END)  # Limpiar el contenido anterior
    stepping = []
    top_text.configure(state=tk.DISABLED)
    add_circular_indicator_pc(top_text, pc_from_jtag)
def on_text_widget_click(event):
    line_number = int(top_text.index(f"@{event.x},{event.y}").split('.')[0])
    add_circular_indicator_debug(top_text, line_number)
    global stepping
    stepping.append(line_number)
top_text.bind('<Button-1>', on_text_widget_click)
# Agregar el indicador circular en la línea especificada
add_circular_indicator_pc(top_text, pc_from_jtag)
top_text.pack(fill="both", expand=True)
bottom_text.pack(fill="both", expand=True)
# Crear los campos de entrada y botones en el frame "Control AES"
label_key = tk.Label(control_aes_frame, text="Llave:")
label_key.pack(pady=5, anchor="w")
entry_key = tk.Entry(control_aes_frame, width=100)
entry_key.pack(pady=5, padx=5, fill="x")
label_text = tk.Label(control_aes_frame, text="Texto a cifrar/descifrar:")
label_text.pack(pady=5, anchor="w")
entry_text = tk.Entry(control_aes_frame, width=100)
entry_text.pack(pady=5, padx=5, fill="x")
# Funcion para guardar la llave de 128 bits
def save_key():
    key = entry_key.get()
    result_file_path = os.path.join("..", "CPU", "memory", "key.fff")
    directory = os.path.dirname(result_file_path)
    if not os.path.exists(directory):
        os.makedirs(directory)
    with open(result_file_path, "w") as key_file:
        key_file.write(key)
    print("Llave guardada en:", result_file_path)
# Funciones para elegir el algoritmo
def encrypt_text_no_SIMD():
    clear_text_and_stepping()
    top_file_content = load_file_content("../CPU/memory/algorithm_cifrado_no_SIMD.s")
    top_text.configure(state=tk.NORMAL)
    top_text.insert(tk.END, top_file_content)
    top_text.configure(state=tk.DISABLED)
    compiler('../CPU/memory/algorithm_cifrado_no_SIMD.s')
    print("Texto no SIMD cifrado.")
def encrypt_text_SIMD():
    clear_text_and_stepping()
    top_file_content = load_file_content("../CPU/memory/algorithm_cifrado_SIMD.s")
    top_text.configure(state=tk.NORMAL)
    top_text.insert(tk.END, top_file_content)
    top_text.configure(state=tk.DISABLED)
    compiler('../CPU/memory/algorithm_cifrado_SIMD.s')
    print("Texto SIMD cifrado.")
def decrypt_text_no_SIMD():
    clear_text_and_stepping()
    top_file_content = load_file_content("../CPU/memory/algorithm_descifrado_no_SIMD.s")
    top_text.configure(state=tk.NORMAL)
    top_text.insert(tk.END, top_file_content)
    top_text.configure(state=tk.DISABLED)
    compiler('../CPU/memory/algorithm_descifrado_no_SIMD.s')
    print("Texto no SIMD descifrado.")
def decrypt_text_SIMD():
    clear_text_and_stepping()
    top_file_content = load_file_content("../CPU/memory/algorithm_descifrado_SIMD.s")
    top_text.configure(state=tk.NORMAL)
    top_text.insert(tk.END, top_file_content)
    top_text.configure(state=tk.DISABLED)
    compiler('../CPU/memory/algorithm_descifrado_SIMD.s')
    print("Texto SIMD descifrado.")
# Guardar Texto de cifrado/descrifrado
def save_text():
    text = entry_text.get()
    result_file_path = os.path.join("..", "CPU", "memory", "RAM_input.mif")
    directory = os.path.dirname(result_file_path)
    if not os.path.exists(directory):
        os.makedirs(directory)
    with open(result_file_path, "w") as text_file:
        text_file.write(text)
    print("Texto a cifrar guardado en:", result_file_path)
# Poner botones
save_key_button = tk.Button(control_aes_frame, text="Guardar Llave", command=save_key)
save_key_button.pack(pady=5)
save_encrypt_text_button = tk.Button(control_aes_frame, text="Guardar Texto a Encriptar o Descifrar", command=save_text)
save_encrypt_text_button.pack(pady=5)
encrypt_button = tk.Button(control_aes_frame, text="Cifrar SIMD Texto", command=encrypt_text_SIMD)
encrypt_button.pack(pady=5)
decrypt_button = tk.Button(control_aes_frame, text="Descifrar SIMD Texto", command=decrypt_text_SIMD)
decrypt_button.pack(pady=5)
encrypt_button = tk.Button(control_aes_frame, text="Cifrar no SIMD Texto", command=encrypt_text_no_SIMD)
encrypt_button.pack(pady=5)
decrypt_button = tk.Button(control_aes_frame, text="Descifrar no SIMD Texto", command=decrypt_text_no_SIMD)
decrypt_button.pack(pady=5)
#Terminar Ventana Principal
root.mainloop()
