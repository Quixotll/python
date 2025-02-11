#!/bin/bash

# Buscar todos los archivos httpd.pid en la carpeta /nyl/opt/apache/servers
find /nyl/opt/apache/servers -type f -name "httpd.pid" | while read -r pid_file; do
    # Obtener la ruta base del archivo httpd.pid
    base_dir=$(dirname "$pid_file")
    
    # Buscar el archivo httpd.conf en la misma carpeta o subcarpetas
    conf_file=$(find "$base_dir" -type f -name "httpd.conf" | head -n 1)
    
    if [[ -f "$conf_file" ]]; then
        echo "-----------------------------------"
        echo "Archivo PID: $pid_file"
        echo "Archivo de configuración: $conf_file"
        
        # Extraer ServerName
        server_name=$(grep -iE "^\s*ServerName" "$conf_file" | awk '{print $2}')
        echo "ServerName: ${server_name:-No definido}" 
        
        # Extraer valores de Listen
        listen_ports=$(grep -iE "^\s*Listen" "$conf_file" | awk '{print $2}')
        echo "Listen: ${listen_ports:-No definido}"
    else
        echo "No se encontró httpd.conf en $base_dir"
    fi

done
