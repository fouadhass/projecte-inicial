#!/bin/bash

# Función para realizar un escaneo de puertos en una dirección IP con un nombre de host
escanear_puertos() {
    ip=$1
    nombre=$2

    echo "Escaneando puertos en $nombre ($ip):"
    nmap -p- $ip | grep ^[0-9] | awk '{print "Puerto "$1": "$2}'
}

# Escanear puertos en cada máquina
escanear_puertos 192.168.0.120 "LDAP"
escanear_puertos 192.168.0.49 "SMB"
escanear_puertos 192.168.0.80 "Mail"
escanear_puertos 192.168.0.106 "Zabbix"
