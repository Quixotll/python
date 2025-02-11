#!/bin/bash

# Archivo de salida
output_file="resultado_httpd.txt"

# Limpiar archivo de salida
echo "" > "$output_file"

# Buscar todos los archivos httpd.pid en todas las subcarpetas de /nyl/opt/apache/servers
find /nyl/opt/apache/servers -type f -name "httpd.pid" | while read -r pid_file; do
    # Obtener la ruta base del archivo httpd.pid
    base_dir=$(dirname "$pid_file")
    
    # Buscar el archivo httpd.conf en la misma carpeta o cualquier subcarpeta
    conf_file=$(find "$base_dir" -type f -name "httpd.conf" | head -n 1)
    
    if [[ -f "$conf_file" ]]; then
        echo "-----------------------------------" >> "$output_file"
        echo "Archivo PID: $pid_file" >> "$output_file"
        echo "Archivo de configuración: $conf_file" >> "$output_file"
        
        # Extraer ServerName
        server_name=$(grep -iE "^\s*ServerName" "$conf_file" | awk '{print $2}')
        echo "ServerName: ${server_name:-No definido}" >> "$output_file"
        
        # Extraer valores de Listen
        listen_ports=$(grep -iE "^\s*Listen" "$conf_file" | awk '{print $2}')
        echo "Listen: ${listen_ports:-No definido}" >> "$output_file"
    else
        echo "No se encontró httpd.conf en $base_dir o sus subcarpetas" >> "$output_file"
    fi

done
