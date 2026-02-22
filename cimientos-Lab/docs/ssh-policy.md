**SSH Security & Access Policy**
----------------------------------

- **Objetivo**:

    Definir los estándares de acceso remoto para la infraestructura del laboratorio, garantizando la integridad, confidencialidad y autenticidad de las conexiones mediante el endurecimiento (hardening) del protocolo SSH.

- **Estándares Criptográficos**:

    Se ha estandarizado el uso exclusivo de algoritmos de curva elíptica para la generación de identidades.
    - *Algoritmo*: `Ed25519`
    -	*Justificación*: A diferencia de RSA, Ed25519 ofrece una mayor seguridad con llaves más cortas, es inmune a colisiones de hash conocidas y presenta un rendimiento superior en el intercambio de llaves.
    -	*Comando de Generación*: `ssh-keygen -t ed25519 -a 100 -C "user@email"`

    (Nota: El parámetro -a 100 aumenta las rondas de hashing para dificultar el cracking offline de la passphrase).

- **Configuración de Hardening (sshd_config)**

    Para mitigar vectores de ataque comunes (fuerza bruta, escalación de privilegios), se aplican las siguientes directivas en `/etc/ssh/sshd_config`:
  
    | Directiva | Valor | Justificación Técnica |
    |:----------|:------|:----------------------|
    | `PasswordAuthentication` |	`no` | Elimina ataques de diccionario al forzar autenticación criptográfica. |
    | `PermitRootLogin` |	`no`	| Mitiga el riesgo de compromiso total del sistema; obliga al uso de sudo para trazabilidad. |
    | `PubkeyAuthentication`	| `yes`	| Habilita el único método de acceso permitido. |
    | `MaxAuthTries` | `3`	| Reduce la ventana de exposición ante intentos de conexión automatizados. |
  
- **Gestión de Permisos en el Sistema de Archivos**

    El servicio SSH de OpenSSH rechaza conexiones si los archivos de identidad tienen permisos laxos. Se impone la siguiente jerarquía:

    -	Directorio `~/.ssh/`: `700 (drwx------)` - Solo el propietario puede acceder.
    - Archivo `authorized_keys`: `600 (-rw-------)` - Solo el propietario puede leer/escribir.
 
- **Auditoría y Monitoreo**

   Cualquier intento de acceso fallido debe quedar registrado en los logs del sistema para su posterior análisis forense:
   - 	Ruta de logs: `/var/log/auth.log`
   - 	Comando de inspección: `tail -f /var/log/auth.log | grep sshd`
