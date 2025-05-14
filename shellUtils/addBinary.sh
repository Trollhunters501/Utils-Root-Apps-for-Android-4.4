echo "Ruta del binario:"
read rutaBinario
binarioName=${rutaBinario##*/}
echo "Quieres Instalar el binario en el sistema? (s/n)"
read binSysB
if [ "$binSysB" = "s" ]; then
    echo "Instalando binario en el sistema..."
    su -c "cp $rutaBinario /system/bin/"
    su -c "chmod 755 /system/bin/$binarioName"
    su -c "restorecon /system/bin/$binarioName"
else
    echo "Instalando binario en la terminal actual..."
    su -c "cp $rutaBinario /data/local/tmp/"
    su -c "chmod 755 /data/local/tmp/$binarioName"
    su -c "restorecon /data/local/tmp/$binarioName"
    alias "$binarioName=/data/local/tmp/$binarioName"
fi
echo "Binario instalado correctamente. Puedes usarlo con el comando $binarioName"