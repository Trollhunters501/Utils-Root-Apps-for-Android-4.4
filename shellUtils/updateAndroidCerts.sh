echo "Escribe la Ruta para hacer copia de los certificados originales(Puedes eliminarlos despues, Es posible que debas crear la ruta antes de usar este Script):"
read rutaCopy
echo -e "Escribe la Ruta donde estan los certificados de Android actualizados(LA CARPETA SOLO DEBE CONTENER LOS CERTIFICADOS .0)\nLinks donde Descargar certificados oficiales: https://android.googlesource.com/platform/system/ca-certificates/+/refs/heads/main/wfa_certs/files \n https://android.googlesource.com/platform/system/ca-certificates/+/refs/heads/main/files"
read rutaCerts
rutaCerts=${rutaCerts%/}
echo "Copiando los certificados originales a la ruta $rutaCopy"
mkdir -p $rutaCopy
su -c "cp /system/etc/security/cacerts/* $rutaCopy"
echo "Estableciendo partituración a escritura"
su -c "mount -o remount,rw /system"
echo "Copiando los certificados actualizados $rutaCerts a la ruta /system/etc/security/cacerts"
su -c "rm /system/etc/security/cacerts/*"
su -c "cp $rutaCerts/* /system/etc/security/cacerts/"
echo "Estableciendo permisos..."
su -c "chmod 644 /system/etc/security/cacerts/*"
su -c "restorecon /system/etc/security/cacerts/*"
echo "Restableciendo partituración a solo lectura"
su -c "mount -o remount,ro /system"
echo "Certificados actualizados correctamente"
echo -e "Este cambio require reiniciar el Dispositivo!\nQuieres reiniciar el dispositivo? (s/n)"
read reiniciarbol
if [ "$reiniciarbol" = "s" ]; then
    su -c "reboot"
else
    echo "No se reiniciara el dispositivo"
fi
