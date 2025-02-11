#!/bin/bash

# Ruta al archivo de texto con las rutas de los archivos httpd.conf
archivo_txt="rutas_archivos.txt"

# Comprobamos si el archivo de texto existe
if [[ ! -f "$archivo_txt" ]]; then
    echo "El archivo $archivo_txt no existe."
    exit 1
fi

# Leemos las rutas de los archivos desde el archivo de texto
while IFS= read -r archivo; do
    # Verificamos que el archivo httpd.conf existe
    if [[ -f "$archivo" ]]; then
        echo "Procesando archivo: $archivo"
        
        # Buscamos los valores de Listen y ServerName
        listen=$(grep -i '^Listen' "$archivo" | head -n 1)
        servername=$(grep -i '^ServerName' "$archivo" | head -n 1)
        
        # Imprimimos los resultados
        echo "  Listen: $listen"
        echo "  ServerName: $servername"
        echo "---------------------------------------"
    else
        echo "El archivo $archivo no se encontró."
    fi
done < "$archivo_txt"

