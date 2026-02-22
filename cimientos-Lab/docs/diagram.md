# Diagrama de Flujo: Proceso de Autenticación SSH (Ed25519)

Este diagrama detalla el flujo lógico desde que un cliente inicia la solicitud hasta que se le otorga acceso a la Shell, pasando por las capas de red, aplicación y criptografía.

```mermaid
graph TD
    %% Nodos principales
    Start((Inicio: Solicitud SSH)) --> UFW{¿Puerto abierto en UFW?}
    
    %% Capa de Red
    UFW -- No --> Drop[Conexión Rechazada: Silent Drop]
    UFW -- Sí --> SSHD[Servicio OpenSSH]

    %% Capa de Aplicación
    SSHD --> AllowUsers{¿Usuario en AllowUsers?}
    AllowUsers -- No --> Denied1[Acceso Denegado]
    AllowUsers -- Sí --> AuthMethod[Solicitud de Autenticación]

    %% Capa Criptográfica y Archivos
    AuthMethod --> Perms{¿Permisos 600 en authorized_keys?}
    Perms -- No --> Denied2[Error de Seguridad / Denegado]
    Perms -- Sí --> Challenge[Servidor envía reto cifrado con Llave Pública]

    %% Verificación Local y Firma
    Challenge --> Sign[Cliente firma reto con Llave Privada local]
    Sign --> Verify{¿Firma Válida?}

    %% Resultado Final
    Verify -- No --> Denied3[Acceso Denegado]
    Verify -- Sí --> Shell[**Acceso Concedido: Shell de Bash**]
