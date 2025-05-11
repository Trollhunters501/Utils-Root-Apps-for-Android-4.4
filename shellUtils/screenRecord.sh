echo "Para empezar a grabar la pantalla escriba start"
read accion
if [ "$accion" = "start" ]; then
    echo "Cuanto tiempo desea grabar la pantalla? (en segundos)"
    read timeR
    echo "Grabando..."
    filename="screen-$( date +%Y-%m-%d_%H-%M-%S )".mp4
    echo "Para detener la grabación preciona Enter"
    screenrecord --time-limit $timeR /storage/emulated/0/Movies/$filename & pid=$!
    wait $pid
    if ps -p $pid > /dev/null; then
        echo "La grabación ha sido detenida por el usuario"
    else
        echo "La grabación ha sido detenida por el tiempo límite"
    fi
    echo "El Video se ha guardado en /storage/emulated/0/Movies/$filename"
else
    echo "No se ha iniciado la grabación"
    exit 1
fi