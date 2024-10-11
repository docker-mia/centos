#!/bin/bash

# Ejecuta la plantilla de datos de red
source /home/soporte/datos

# Establece el método de obtención de la IP a manual (estático)
nmcli connection modify ens33 ipv4.method manual

# Asigna la dirección IP y la máscara de subred
nmcli connection modify ens33 ipv4.addresses $IP1

# Asigna la puerta de enlace
nmcli connection modify ens33 ipv4.gateway $GW

# Establece los servidores DNS
nmcli connection modify ens33 ipv4.dns $DNS

# Desactiva IPv6
nmcli connection modify ens33 ipv6.method "disabled"

# Restablece la tarjeta de red
nmcli networking off
nmcli networking on

sleep 5 # Esto añade un retardo de 5 segundos


RETRIES=1

# Ejecuta dentro de este script el script cliookla.sh
source /home/soporte/cliookla.sh $ISP1_ID


