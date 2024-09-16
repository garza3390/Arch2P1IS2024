import tkinter as tk
from tkinter import ttk, Text
import subprocess

def load_file_content(filepath):
    try:
        with open(filepath, 'r') as file:
            return file.read()
    except FileNotFoundError:
        return f"Error: No se encontró el archivo {filepath}"
    except Exception as e:
        return f"Error al abrir {filepath}: {e}"
    
root = tk.Tk()
root.title("AES Encryption Debugger")
root.geometry("80x60+100+100")  # Para garantizar que los tamaños se adapten
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

# Variables de ejemplo JTAG
indicator_line_number = 1
variables = {
    "Variable 1": "Valor 1",
    "Variable 2": "Valor 2",
    "Variable 3": "Valor 3",
    "Variable 4": "Valor 4",
    "Variable 5": "Valor 5",
    "Ciclos por instruccion: ": "Valor 6"
}
for i, (title, value) in enumerate(variables.items()):
    row = i // 3
    col = i % 3
    tk.Label(var_grid, text=title).grid(row=row, column=col*2, padx=5, pady=5, sticky="e")
    tk.Label(var_grid, text=value).grid(row=row, column=col*2+1, padx=5, pady=5, sticky="w")
top_text = Text(top_frame, wrap="none", state=tk.DISABLED)
bottom_text = Text(bottom_frame, wrap="none", state=tk.DISABLED)
#  Extracción de los datos almacenados en memoria para su verificación.
top_file_content = load_file_content("programa_entrada.fff")
bottom_file_content = load_file_content("resultado.fff")
top_text.configure(state=tk.NORMAL)
top_text.insert(tk.END, top_file_content)
top_text.configure(state=tk.DISABLED)
bottom_text.configure(state=tk.NORMAL)
bottom_text.insert(tk.END, bottom_file_content)
bottom_text.configure(state=tk.DISABLED)
# Función para agregar el indicador circular en una línea específica
def add_circular_indicator(text_widget, line_number):
    canvas = tk.Canvas(top_frame, width=20, height=20, bg='white', highlightthickness=0)
    canvas.create_oval(5, 5, 15, 15, fill='red')
    text_widget.configure(state=tk.NORMAL)
    index = f"{line_number}.0"
    text_widget.mark_set("insert", index)
    text_widget.window_create(index, window=canvas)
    text_widget.configure(state=tk.DISABLED)
# Agregar el indicador circular en la línea especificada (stepping) esto con el fin de verificar la ejecución del código.
add_circular_indicator(top_text, indicator_line_number)
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
# El valor de llave se almacena en memoria
def save_key():
    key = entry_key.get()
    with open("key.fff", "w") as key_file:
        key_file.write(key)
    print("Llave guardada.")
# Función para cifrar el texto makefile
def encrypt_text():
    subprocess.run(["make", "-f", "Makefile_encrypt"])
    print("Texto cifrado.")
# Función para descifrar el texto makefile
def decrypt_text():
    subprocess.run(["make", "-f", "Makefile_decrypt"])
    print("Texto descifrado.")
# Los datos de entrada se almacenan en memoria
def save_text():
    text = entry_text.get()
    with open("salida.fff", "w") as text_file:
        text_file.write(text)
    print("Texto a cifrar guardado.")
save_key_button = tk.Button(control_aes_frame, text="Guardar Llave", command=save_key)
save_key_button.pack(pady=5)
save_encrypt_text_button = tk.Button(control_aes_frame, text="Guardar Texto a Encriptar o Descifrar", command=save_text)
save_encrypt_text_button.pack(pady=5)
encrypt_button = tk.Button(control_aes_frame, text="Cifrar Texto", command=encrypt_text)
encrypt_button.pack(pady=5)
decrypt_button = tk.Button(control_aes_frame, text="Descifrar Texto", command=decrypt_text)
decrypt_button.pack(pady=5)
root.mainloop()
