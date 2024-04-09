#!/bin/bash

# Función para crear un usuario en una dirección IP con un nombre de usuario específico
crear_usuario() {
    ip=$1
    usuario=$2

    echo "Creando usuario 'ejemplo' en $ip:"
    ssh $usuario@$ip "echo 'password123' | sudo -S useradd -m -s /bin/bash ejemplo && echo 'password123' | sudo -S passwd --stdin ejemplo"
    if [ $? -eq 0 ]; then
        echo "Usuario 'ejemplo' creado correctamente en $ip"
    else
        echo "Error al crear usuario en $ip"
    fi
}

# Crear usuario en cada máquina
crear_usuario 192.168.0.120 ldap
crear_usuario 192.168.0.49 sambasrv
crear_usuario 192.168.0.80 correo
crear_usuario 192.168.0.106 zabbixsrv
