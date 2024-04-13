# Revisar que se proporcione el ID.
if [ $# -eq 0 ] ; then
 echo "Error, debes proporcionar el ID de algun proceso."
 exit 1
fi 

id_proceso=$1

# Funcion que me imprima la informacion requerida.
mostrar_informacion () {
    id_proceso=$1
    linea=$(ps aux | awk 'print{1:11}' | grep "$id_proceso")


    # Hacemos variables para poder almacenar nuestros datos.
    nombre=$(echo "$linea" | awk '{print $11}')
    usuario=$(echo "$linea" | awk '{print $1}')
    cpu=$(echo "$linea" | awk '{print $3}')
    estatus=$(echo "$linea" | awk '{print $8}')
    memoria=$(echo "$linea" | awk '{print $4}') 
    parent=$(echo "ps -f"| grep "$id_proceso" | awk '{print $3}')
    path=$(readlink /proc/$id_proceso/exe)

    # Las imprimimos en el formato deseado.
    echo "Nombre del proceso: $nombre"
    echo "ID del proceso: $id_proceso"
    echo "Parent process ID: $parent "
    echo "Usuario propietario: $usuario"
    echo "Porcentaje de uso del CPU: $cpu"
    echo "Consumo de memoria: $memoria"
    echo "Estado (status): $estatus"
    echo "Path del ejecutable: $path"

}

mostrar_informacion "$id_proceso"