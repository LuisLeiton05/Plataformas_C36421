# El directorio que queremos monitorear.
directorio="/home/luis05/laboratorio_1"

# Necesitamos un archivo log donde guardar los eventos.
archivo_log="eventos.txt"

# Monitoreamos usando la sugerencia.
inotifywait -m -r -e create,modify,delete "$directorio" |
    while read $path $evento $archivo ; do
        # Obtener la fecha y hora actual.
        fecha=$(date)
        # Escribir y pasar el evento al archivo.
        echo "[$fecha] Evento: $evento Archivo: $archivo Directorio: $path" >> "$archivo_log"

    done
