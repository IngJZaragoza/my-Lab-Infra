**Especificaciones del Hipervisor (VMware)**
----------------------------------------------

**¿Por qué usamos Ubuntu Server 24.04 LTS?**

Ubuntu Server se ha consolidado como uno de los sistemas operativos más usados en el mundo de la ingeniería por su alta estabilidad a largo plazo, actualizaciones constantes y manejo práctico para personas afines. A estas fechas del 2026 se mantiene la versión 24.04, puede ser que meses después de que se haya escrito este documento (11/02/2026), Ubuntu muestre una nueva versión.

**Recursos asignados**:
--------------------------------------------
- CPU: `2 vCPUs`. *Permite el manejo de procesos en paralelo, incluyendo tareas en segundo plano y actualizaciones del sistema.*
- Memoria RAM: `2 GB`. *Valor mínimo recomendado para Ubuntu Server 24.04 sin entorno gráfico, optimizando el consumo de recursos del host.*
- Almacenamiento: `Disco virtual de 40 GB`.
- Adaptador de red: `Modo NAT`. *Aísla el laboratorio de la red física local, permitiendo al mismo tiempo una salida controlada a Internet.*

![](images/resourses.png)

**Estrategia de Almacenamiento (LVM)**:
--------------------------------------------
Se implementa LVM (Logical Volume Management) en lugar de particiones primarias tradicionales. LVM proporciona flexibilidad para redimensionar volúmenes de forma dinámica (hot-resize) y permite la creación de snapshots previos a cambios críticos, como actualizaciones del kernel o modificaciones en aplicaciones.

Distribución propuesta:
- /(root): `15 GB`
- /var/log: `5 GB`. Separado para evitar que el crecimiento de los registros afecte la estabilidad del sistema operativo.
- Swap: `2 GB`. "Respaldo de emergencia" que usa cuando se quede sin memoria RAM.

![](images/lvm.png)

**Configuración de Red:**
-------------------------------------------
- Direccionamiento: IP estática (IPv4).
- Servidores DNS: 1.1.1.1 y 8.8.8.8, con el fin de garantizar la resolución de nombres de manera independiente del router local.

**Endurecimiento de Seguridad SSH**
-------------------------------------------
La seguridad constituye un pilar fundamental de esta infraestructura. Se aplican las siguientes políticas:
- Algoritmo criptográfico: `Ed25519`. Preferido sobre RSA por su menor tamaño de clave y mayor resistencia frente a ataques conocidos.
- Configuración del servicio (sshd_config):
  - *PasswordAuthentication no*: Elimina los ataques de fuerza bruta basados en diccionario.
  - *PermitRootLogin no*: Obliga al uso de cuentas con privilegios sudo, mejorando la trazabilidad y auditoría.
  - *MaxAuthTries 3*: Limita estrictamente la cantidad de intentos de autenticación.

**Control de cambios y trazabilidad**
--------------------------------------------
- Estándar de mensajes: Conventional Commits.
- Versionamiento: Todo cambio realizado en archivos de configuración bajo /etc/ debe reflejarse de forma equivalente en la carpeta /configs de este repositorio.

*Todas las direcciones IP, nombres de usuario y llaves públicas mostradas en esta documentación son valores de ejemplo (placeholders) siguiendo las mejores prácticas de sanitización de infraestructura para evitar la exposición de la topología real del laboratorio.*
