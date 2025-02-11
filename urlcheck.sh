import re

# Ruta del archivo de texto que contiene las rutas de los archivos httpd.conf
archivo_txt = 'rutas_archivos.txt'

# Lista para almacenar los resultados
resultados = []

# Expresiones regulares para buscar los valores Listen y ServerName
listen_pattern = re.compile(r'^\s*Listen\s+(\d+|\d+\.\d+\.\d+\.\d+:\d+|\[.*\]):(\d+)', re.IGNORECASE)
servername_pattern = re.compile(r'^\s*ServerName\s+(\S+)', re.IGNORECASE)

# Función para buscar los valores en el archivo httpd.conf
def buscar_valores_en_archivo(archivo):
    listen_value = None
    servername_value = None
    try:
        with open(archivo, 'r') as f:
            for linea in f:
                if not listen_value:
                    match_listen = listen_pattern.match(linea)
                    if match_listen:
                        listen_value = match_listen.group(0)
                if not servername_value:
                    match_servername = servername_pattern.match(linea)
                    if match_servername:
                        servername_value = match_servername.group(0)
                if listen_value and servername_value:
                    break
    except FileNotFoundError:
        print(f"El archivo {archivo} no fue encontrado.")
    return listen_value, servername_value

# Leer las rutas de los archivos desde el archivo de texto
with open(archivo_txt, 'r') as f:
    rutas_archivos = f.readlines()

# Recorremos cada ruta de archivo y buscamos los valores Listen y ServerName
for archivo in rutas_archivos:
    archivo = archivo.strip()  # Eliminamos posibles saltos de línea
    listen, servername = buscar_valores_en_archivo(archivo)
    if listen or servername:
        resultados.append({
            'archivo': archivo,
            'Listen': listen,
            'ServerName': servername
        })

# Mostramos los resultados
for resultado in resultados:
    print(f"Archivo: {resultado['archivo']}")
    print(f"  Listen: {resultado['Listen']}")
    print(f"  ServerName: {resultado['ServerName']}")
    print("-" * 40)

