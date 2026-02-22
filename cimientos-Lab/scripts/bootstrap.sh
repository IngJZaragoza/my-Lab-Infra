#!/bin/bash

# =============================================================================
# Preparación base de instancia Ubuntu Server 24.04 LTS
# =============================================================================

# 1. Configuración de ejecución (Strict Mode)
# -e: Termina si un comando falla.
# -u: Termina si una variable no está definida.
set -eu

# 2. Validación de privilegios
if [[ $EUID -ne 0 ]]; then
   echo "[ERROR] Este script requiere privilegios de superusuario (root)." >&2
   exit 1
fi

# 3. Definición de variables de entorno para evitar interactividad
export DEBIAN_FRONTEND=noninteractive

# 4. Actualización del sistema (Silenciosa y forzada)
# Se utiliza -y y -q para asegurar que no se detenga por prompts de usuario
apt-get update -qq
apt-get upgrade -y -qq

# 5. Instalación de utilidades base para Infraestructura
# Incluimos paquetes para gestión de red, monitoreo y edición
DEPENDENCIES=(
    "openssh-server"
    "ufw"
    "curl"
    "git"
    "vim"
    "htop"
    "net-tools"
    "software-properties-common"
)
apt-get install "${DEPENDENCIES[@]}" -y -qq

# 6. Configuración de Firewall (UFW)
# Implementación de política restrictiva por defecto
ufw default deny incoming > /dev/null
ufw default allow outgoing > /dev/null

# Permitimos el servicio SSH (Puerto 22 por defecto en esta etapa)
ufw allow 22/tcp > /dev/null

# Activación no interactiva del firewall
echo "y" | ufw enable > /dev/null

# 7. Limpieza de paquetes residuales
apt-get autoremove -y -qq
apt-get clean -qq

# 8. Salida exitosa
exit 0
