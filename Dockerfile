#################################
# Imagen base y dependencias
###################################
FROM python:3.11-slim

# Instalar dependencias básicas
RUN apt-get update && \
    apt-get install -y \
    git \
    openssh-client \
    zsh \
    curl \
    make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

###################################
# Configuración de ZSH
###################################
# Instalar Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Establecer zsh como shell por defecto
RUN chsh -s $(which zsh)

###################################
# Configuración del directorio
###################################
WORKDIR /core

# Copiar los archivos de requisitos
COPY requirements.txt Makefile ./

# Instalar las dependencias del proyecto
RUN pip install --no-cache-dir -r requirements.txt

# Crear archivo .gitignore
RUN touch .gitignore

# Definir el volumen para la persistencia
VOLUME /core

# Copiar todo el código del proyecto al contenedor
COPY . /core
