#!/bin/bash

# Actualiza todos los paquetes instalados
sudo yum update -y

# Instala Docker y Git
sudo yum install docker git -y

# Habilita Docker para que se inicie automáticamente al arrancar el sistema
sudo systemctl enable docker

# Inicia el servicio Docker
sudo systemctl start docker

# Añade el usuario ec2-user al grupo docker para permitir ejecutar comandos Docker sin sudo
sudo usermod -a -G docker ec2-user

# Obtiene la última versión de Docker Compose desde GitHub
DC_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/docker/compose/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')

# Descarga Docker Compose y lo coloca en /usr/local/bin
sudo curl -L "https://github.com/docker/compose/releases/download/$DC_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Otorga permisos de ejecución a Docker Compose
sudo chmod +x /usr/local/bin/docker-compose

# Reinicia el servicio Docker para aplicar cambios
sudo systemctl restart docker
