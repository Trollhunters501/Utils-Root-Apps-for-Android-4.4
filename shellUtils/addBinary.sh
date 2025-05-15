echo "Ruta del binario:"
read rutaBinario
binarioName=${rutaBinario##*/}
echo "Quieres Instalar el binario en el sistema? (s/n)"
read binSysB
rutaBinFinal=""
if [ "$binSysB" = "s" ]; then
    echo "Instalando binario en el sistema..."
    su -c "cp $rutaBinario /system/bin/"
    su -c "chmod 755 /system/bin/$binarioName"
    su -c "restorecon /system/bin/$binarioName"
    rutaBinFinal="$binarioName"
else
    echo "Quieres Instalar el binario en el sistema de archivos temporal? (s/n)"
    read binTmpB
    if [ "$binTmpB" = "s" ]; then
        echo "Instalando binario en el sistema de archivos temporal..."
        su -c "cp $rutaBinario /data/local/tmp/"
        su -c "chmod 755 /data/local/tmp/$binarioName"
        su -c "restorecon /data/local/tmp/$binarioName"
        rutaBinFinal="/data/local/tmp/$binarioName"
    else
        echo "Instalando binario en la terminal actual..."
        su -c "cp $rutaBinario $HOME/bin/"
        su -c "chmod 755 $HOME/bin/$binarioName"
        su -c "restorecon $HOME/bin/$binarioName"
        rutaBinFinal="\$HOME/bin/$binarioName"
    fi
fi
echo "Binario instalado correctamente. Puedes usarlo con el comando $rutaBinFinal"