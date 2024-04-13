# Me aseguro de recibir el nombre del proceso.
if [ $# -ne 2 ] ; then
 echo "Error, debes proporcionar el nombre de algun proceso y el comando para ejecutarlo"
 exit 1
fi 

nombre_proceso=$1
comando=$2

# Funcion que revise y levante.
verificar_levantar () {
    nombre_proceso="$1"
    coamndo="$2"

    # Revisar si se esta ejecutando y sino levantarlo.
    while true ; do 
        # Revisar si el proceso existe.
        if ! pgrep "$nombre_proceso"  ; then
            echo "El proceso no existe. Proporcione uno nuevo."
            exit 1
        fi
        # Si existe seguimos con el programa.
        if ! pgrep -x "$nombre_proceso"  ; then
            echo "El proceso $nombre_proceso no se esta ejecutando. Levantando."
            # Utiilizamos el comando para levantarlo de nuevo.
            eval "$comando" &
        else 
            echo "El proceso $nombre_proceso se esta ejecutando correctamente."
        fi 

        # Como nos mencionan que debe ser periodico, le ponemos tiempo (50 segundos), pero pongo el break para cancelar la ejecucion.
        break 
        sleep 50

    done
}
verificar_levantar "$nombre_proceso" "$comando"