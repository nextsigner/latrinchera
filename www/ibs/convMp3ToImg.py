import math
from PIL import Image

mp3_path = "/home/ns/p.mp3"
img_path = "/home/ns/nsp/latrinchera/www/ibs/imgs/imagen_salida.bmp"
ancho_px = 3200

# 1. Leer el archivo MP3 como bytes crudos
with open(mp3_path, "rb") as f:
    contenido = f.read()

original_size = len(contenido)

# 2. Guardar el tamaño original en 4 bytes (32 bits) al inicio
size_bytes = original_size.to_bytes(4, byteorder='big')
bits = []
for b in size_bytes:
    for i in range(7, -1, -1):
        bits.append(1 if (b >> i) & 1 else 0)

# 3. Convertir cada byte del MP3 en bits (MSB primero)
for byte in contenido:
    for i in range(7, -1, -1):
        bits.append(1 if (byte >> i) & 1 else 0)

# 4. Ajustar el alto exactamente a los bits necesarios
total_bits = len(bits)
alto_px = math.ceil(total_bits / ancho_px)
padding_falsos = (ancho_px * alto_px) - total_bits
bits.extend([0] * padding_falsos)

# 5. Crear la imagen en modo RGB de 24 bits (evita paletas indexadas)
img = Image.new("RGB", (ancho_px, alto_px))
pixels = img.load()

# 6. Dibujar píxeles: 1 = Blanco (255, 255, 255), 0 = Negro (0, 0, 0)
for idx, bit in enumerate(bits):
    x = idx % ancho_px
    y = idx // ancho_px
    val = (255, 255, 255) if bit == 1 else (0, 0, 0)
    pixels[x, y] = val

# 7. Guardar como BMP estándar de 24 bits
img.save(img_path, "BMP")
print(f"¡BMP RGB de 24 bits generado con éxito! Ancho: {ancho_px}, Alto: {alto_px}")
