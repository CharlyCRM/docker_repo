# README

## Descripción
Este proyecto proporciona un entorno Docker configurado para análisis de datos, con acceso a las credenciales SSH de GitHub para una integración perfecta.

## Requisitos Previos
- Docker instalado en tu sistema
- Claves SSH configuradas para GitHub

## Configuración y Uso

### 1. Construir la imagen Docker
`docker build -t nombre_imagen .`

### 2. Ejecutar el Contenedor
`docker run -it \
-v $(pwd):/core \
nombre_imagen zsh`

### 3. Configurar Git y SSH dentro del Contenedor
Una vez dentro del contenedro, ejecuta:
`make prepare_venv`

El script te guiará a través del proceso de configuración:
1. Te pedirá tu nombre de usuario de Git
2. Te pedirá tu email de Git
3. Te mostrará instrucciones para localizar tus claves SSH:
   - En Windows: `C:\Users\TuUsuario\.ssh\`
   - En Linux/Mac: `~/.ssh/`
4. Deberás crear un archivo temporal 'config' con:
   - Tu clave SSH privada
   - La línea `---PUBKEY---`
   - Tu clave SSH pública

#### Ejemplo del archivo 'config':

-----BEGIN OPENSSH PRIVATE KEY-----
... (contenido de tu clave privada) ...
-----END OPENSSH PRIVATE KEY-----
---PUBKEY---
ssh-rsa AAAA... tu_email@ejemplo.com


### 4. Verificar la Configuración
Después de completar la configuración, puedes verificar la conexión con GitHub:

`ssh -T git@github.com`


## Notas Importantes
- El archivo temporal 'config' se eliminará automáticamente después de la configuración.
- La configuración de Git y SSH solo afecta al contenedor, no a tu máquina host.
- Cada vez que crees un nuevo contenedor, necesitarás ejecutar `make prepare_venv` para configurar las credenciales.
- Tus claves SSH originales en tu máquina host no se modifican.

## Solución de Problemas
Si encuentras problemas para localizar tus claves SSH, puedes:
1. Verificar su existencia:
   - Windows: `type C:\Users\TuUsuario\.ssh\id_rsa.pub`
   - Linux/Mac: `cat ~/.ssh/id_rsa.pub`
2. Si no tienes claves SSH, créalas con:
   ```bash
   ssh-keygen -t rsa -b 4096
   ```
3. Añade la clave pública a GitHub en: https://github.com/settings/keys