#!/bin/bash

# Función para verificar el almacenamiento disponible en una dirección IP con un nombre de host y usuario SSH específicos
verificar_almacenamiento() {
    ip=$1
    usuario=$2

    echo "Almacenamiento disponible en $ip:"
    ssh $usuario@$ip "df -h" | grep -vE '^Filesystem|tmpfs|cdrom|udev'
}

# Verificar almacenamiento disponible en cada máquina para el servicio correspondiente
verificar_almacenamiento 192.168.0.120 ldap
verificar_almacenamiento 192.168.0.49 sambasrv
verificar_almacenamiento 192.168.0.80 correo
verificar_almacenamiento 192.168.0.106 zabbixsrv
