#!/bin/bash

# Función para verificar el estado de un servicio en una dirección IP con un usuario específico
verificar_estado() {
    servicio=$1
    ip=$2
    usuario=$3

    # Verifica el estado del servicio
    if ping -c 1 $ip &> /dev/null; then
        estado=$(ssh $usuario@$ip "systemctl is-active --quiet $servicio" &> /dev/null && echo "activo" || echo "inactivo")
        echo "$servicio está $estado en $ip"
    else
        echo "El host $ip no está disponible."
    fi
}

# Verificar estado del servicio en cada máquina
echo "Ingrese el servicio que desea verificar:"
read servicio
echo "Ingrese la dirección IP de la máquina:"
read ip
echo "Ingrese el nombre de usuario para la máquina:"
read usuario

# Verificar estado del servicio en la máquina especificada
verificar_estado $servicio $ip $usuario
