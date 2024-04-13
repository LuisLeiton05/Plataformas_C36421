# Verificamos que se reciba al menos un parametro.
if [ $# -eq 0 ] ; then
 echo "Error, debes proporcionar un ejecutable."
 exit 1
fi 

ejecutable=$1
eval "$ejecutable"

# Creamos el archivo log donde vamos a llevar un registro.
archivo_log="registro_del_consumo.log"

# Funcion que lee y registra el consumo.
leer_registrar () {
    # Ejecutemos el proceso en segundo plano.
    eval "$ejecutable" &
    echo"$(date) $(ps aux)" >> "$archivo_log"




}

