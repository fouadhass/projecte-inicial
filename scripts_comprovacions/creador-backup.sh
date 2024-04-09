#!/bin/bash

# Ruta de la carpeta de origen
ORIGEN="/Carpeta/con/los/datos/a/copiar"

# Ruta de la carpeta de destino
DESTINO="/Carpeta/donde/estara/el/backup(tar)"

# Nombre base del archivo de backup
BASE="Nombre_Backup"

# Número máximo de backups a mantener
MAX_BACKUPS=5

# Obtener la fecha actual (NombreAñoMesDia.tar)
FECHA=$(date +"%Y%m%d")

# Crear el nombre del archivo de backup con la fecha
NOMBRE_BACKUP="$BASE$FECHA.tar"

# Comprobar si el directorio de destino existe, si no, crearlo
if [ ! -d "$DESTINO" ]; then
    mkdir -p "$DESTINO"
fi

# Con esto podremos hacer que la copia contenga los archivos sin la ruta absoluta
cd "$ORIGEN" || exit

# Crear el backup
tar -czf "$DESTINO/$NOMBRE_BACKUP" .

# Contar la cantidad de backups existentes
NUM_BACKUPS=$(ls -1 "$DESTINO" | grep "$BASE" | wc -l)

# Si hay más de MAX_BACKUPS, se eliminara el bk más antiguo
if [ "$NUM_BACKUPS" -gt "$MAX_BACKUPS" ]; then
    # Obtener el nombre del backup más antiguo
    OLDEST_BACKUP=$(ls -t "$DESTINO" | grep "$BASE" | tail -1)

    # Eliminar el backup más antiguo
    rm "$DESTINO/$OLDEST_BACKUP"
fi
