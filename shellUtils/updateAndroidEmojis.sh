echo "Escribe la ruta del archivo .ttf que contiene los emojis(recuerda renombrar el archivo a el nombre que corresponde con los emojis de tu Sistema (AndroidEmoji.ttf, NotoColorEmoji.ttf, SamsungColorEmoji.ttf, LGEmoji.ttf, HTC_ColorEmoji.ttf, SegoeUIEmoji.ttf, AppleColorEmoji.ttf, Etc.)):"
read emojiPath
emojiFile=$(echo "$emojiPath" | sed 's:.*/::')
echo "Estableciendo partituración a escritura"
su -c "mount -o remount,rw /system"
echo "Copiando emojis a /system/fonts"
su -c "cp $emojiPath /system/fonts"
echo "Estableciendo permisos..."
su -c "chmod 644 /system/fonts/$emojiFile"
su -c "restorecon /system/fonts/$emojiFile"
echo "Restableciendo partituración a solo lectura"
su -c "mount -o remount,ro /system"
echo "Emojis actualizados correctamente"
echo -e "Este cambio require reiniciar el Dispositivo!\nQuieres reiniciar el dispositivo? (s/n)"
read reiniciarbol
if [ "$reiniciarbol" = "s" ]; then
    su -c "reboot"
else
    echo "No se reiniciara el dispositivo"
fi