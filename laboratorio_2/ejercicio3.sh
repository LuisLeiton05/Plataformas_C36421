# Verificamos que se reciba al menos un parametro.
if [ $# -ne 1 ] ; then
 echo "Error, debes proporcionar un ejecutable."
 exit 1
fi 

# Voy a buscar el proceso para realizar lo demas con su PID.
ejecutable_id=$1
linea=$(ps aux | awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}' | grep "$ejecutable_id")

# Creamos el archivo log donde vamos a llevar un registro.
archivo_log="registro_del_consumo.txt"

# Funcion que lee y registra el consumo.
leer_registrar () {
    linea="$1"
    ejecutable_id="$2"
    # Monitoreamos y leemos el proceso.
    while true ; do 
        nombre=$(echo "$linea" | awk '{print $11}')
        # Revisar si el proceso existe.
        if ! pgrep "$nombre"  ; then
            echo "El proceso no existe. Proporcione uno nuevo."
            exit 1
        fi

        # Si existe seguimos con el programa.
        cpu=$(echo "$linea" | awk '{print $3}')
        memoria=$(echo "$linea" | awk '{print $4}') 
        date=$(date)

        # Registramos en el archivo.
        echo "Fecha $date   CPU %: $cpu   MEM %: $memoria" >> $archivo_log

        # Si finaliza, se grafica.
        if ! pgrep -x "$nombre"  ; then
            echo "El proceso $nombre_proceso finalizo."
            
            # Graficamos con gnuplot.
            gnuplot << 
            EOF
                set terminal png
                set output "grafico.png"
                set title "Tiempo del consumo del CPU y MEM"
                set xlabel "Tiempo"
                set ylabel "Porcentaje"
                set xdata time
                set timefmt "%Y-%m-%d %H:%M:%S"
                set format x "%H:%M:%S"
                plot "$log_file" using 1:5 title "CPU" with lines, \
                     "$log_file" using 1:7 title "Memoria" with lines
                
            EOF
            echo "Grafico generado: grafico.png"

        fi
            
        # El sleep es para estarlo monitoreando periodicamente pero pongo break para efectos de la prueba.
        break 
        sleep 50

    done

}

leer_registrar "$ejecutable_id" "$linea"