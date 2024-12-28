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

## Autor
Carlos Ramírez Martín - [www.linkedin.com/in/carlosramirezmartin](https://www.linkedin.com/in/carlosramirezmartin)

## Licencia
Este proyecto está bajo la Licencia MIT

MIT License

Copyright (c) 2024 Carlos Ramírez Martín

Se concede permiso, de forma gratuita, a cualquier persona que obtenga una copia de este software y de los archivos de documentación asociados (el "Software"), para utilizar el Software sin restricción, incluyendo sin limitación los derechos a usar, copiar, modificar, fusionar, publicar, distribuir, sublicenciar, y/o vender copias del Software, y a permitir a las personas a las que se les proporcione el Software a hacer lo mismo, sujeto a las siguientes condiciones:

El aviso de copyright anterior y este aviso de permiso se incluirán en todas las copias o partes sustanciales del Software.

EL SOFTWARE SE PROPORCIONA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA, INCLUYENDO PERO NO LIMITADO A GARANTÍAS DE COMERCIALIZACIÓN, IDONEIDAD PARA UN PROPÓSITO PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS AUTORES O TITULARES DEL COPYRIGHT SERÁN RESPONSABLES DE NINGUNA RECLAMACIÓN, DAÑOS U OTRAS RESPONSABILIDADES, YA SEA EN UNA ACCIÓN DE CONTRATO, AGRAVIO O CUALQUIER OTRO MOTIVO, QUE SURJA DE O EN CONEXIÓN CON EL SOFTWARE O EL USO U OTROS TRATOS EN EL SOFTWARE.
