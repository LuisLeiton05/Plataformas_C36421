# Me aseguro de recibir el nombre del proceso.
if [ $# -eq 0 ] ; then
 echo "Error, debes proporcionar el ID de algun proceso."
 exit 1
fi 

nombre_proceso=$1
comando=$2

# Revisar si se esta ejecutando y sino levantarlo.
 while true ; do 
    if ! pgrep -x "$nombre_proceso" > /dev/null; then
        echo "El proceso $nombre_proceso no se esta ejecutando. Levantando."
        # Utiilizamos el comando para levantarlo de nuevo.
        "$comando"
    else 
        echo "El proceso $nombre_proceso se esta ejecutando correctamente."
    fi

    # Como nos mencionan que debe ser periodico, le ponemos tiempo (50 segundos).
    sleep 50

done