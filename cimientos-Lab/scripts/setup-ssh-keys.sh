#!/bin/bash
# =============================================================================
# Configuración estricta del directorio .ssh y permisos de llaves.
# =============================================================================

set -eu

# 1. Definir el usuario (por defecto el actual, o pasado como argumento)
TARGET_USER="${1:-$USER}"
USER_HOME=$(eval echo "~$TARGET_USER")

echo "Configurando entorno SSH para el usuario: $TARGET_USER"

# 2. Crear directorio .ssh con permisos restrictivos
# 700: rwx para el dueño, nada para el resto (estándar de seguridad)
if [ ! -d "$USER_HOME/.ssh" ]; then
    mkdir -p "$USER_HOME/.ssh"
    chmod 700 "$USER_HOME/.ssh"
fi

# 3. Crear archivo authorized_keys si no existe
if [ ! -f "$USER_HOME/.ssh/authorized_keys" ]; then
    touch "$USER_HOME/.ssh/authorized_keys"
    # 600: rw para el dueño, nada para el resto
    chmod 600 "$USER_HOME/.ssh/authorized_keys"
fi

# 4. Asegurar que el dueño sea el correcto (en caso de ejecución con sudo)
chown -R "$TARGET_USER:$TARGET_USER" "$USER_HOME/.ssh"

echo "Entorno .ssh listo. Por favor, añade tu llave pública Ed25519 en $USER_HOME/.ssh/authorized_keys"
