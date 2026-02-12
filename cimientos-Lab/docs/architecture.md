**Especificaciones del Hipervisor (VMware)**
----------------------------------------------

**¿Por qué usamos Ubuntu Server 24.04 LTS?**

Ubuntu Server se ha consolidado como uno de los sistemas operativos más usados en el mundo de la ingeniería por su alta estabilidad a largo plazo, actualizaciones constantes y manejo práctico para personas afines. A estas fechas del 2026 se mantiene la versión 24.04, puede ser que meses después de que se haya escrito este documento (11/02/2026), Ubuntu muestre una nueva versión.

**Recursos asignados**:

- CPU: `2 vCPUs`. *Permite el manejo de procesos en paralelo, incluyendo tareas en segundo plano y actualizaciones del sistema.*
- Memoria RAM: `2 GB`. *Valor mínimo recomendado para Ubuntu Server 24.04 sin entorno gráfico, optimizando el consumo de recursos del host.*
- Almacenamiento: `Disco virtual de 40 GB`.
- Adaptador de red: `Modo NAT`. *Aísla el laboratorio de la red física local, permitiendo al mismo tiempo una salida controlada a Internet.*

![](images/resourses.png)

**Estrategia de Almacenamiento (LVM)**:

Se implementa LVM (Logical Volume Management) en lugar de particiones primarias tradicionales. LVM proporciona flexibilidad para redimensionar volúmenes de forma dinámica (hot-resize) y permite la creación de snapshots previos a cambios críticos, como actualizaciones del kernel o modificaciones en aplicaciones.

Distribución propuesta:
- /(root): `15 GB`
- /var/log: `5 GB`. Separado para evitar que el crecimiento de los registros afecte la estabilidad del sistema operativo.
- Swap: `2 GB`. "Respaldo de emergencia" que usa cuando se quede sin memoria RAM.

![](images/lvm.png)
