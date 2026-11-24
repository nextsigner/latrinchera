mp3_path = "/home/ns/p_real.mp3"
bin_path = "/home/ns/nsp/latrinchera/www/ibs/audios/audio_salida.bin"

# Leer el MP3 como bytes crudos y guardarlos directamente en el archivo binario
with open(mp3_path, "rb") as f:
    contenido = f.read()

with open(bin_path, "wb") as f:
    f.write(contenido)

print(f"¡Archivo binario puro generado con éxito (Tamaño: {len(contenido)} bytes)!")
