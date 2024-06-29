#!/bin/bash

# Definimos nuestras variables de entorno
SERVER_USER="tu_usuario"
SERVER_IP="tu_servidor_ip"
LOCAL_BUID_PATH="target/release" #La ruta del build local

# Imprimimos un mensaje de inicio de despliegue
echo "Iniciando el despliegue a $SERVER_USER@$SERVER_IP:$SERVER_PATH"

# Construimos el proyecto
echo "Construyendo el proyecto..."
cargo build --release

# Verificamos si la construcción fue exitosa
if [ $? -ne 0 ]; then
  echo "La construcción falló, abortando despliegue."
  exit 1
fi

# Sincronizamos archivos con el servidor remoto
echo "Sincronizando archivos con el servidor remoto..."
rsync - avz --delete $LOCAL_BUID_PATH $SERVER_USER@$SERVER_IP:$SERVER_PATH

# Verificamos si la sincronización fue exitosa
if [ $? -ne 0 ]; then
  echo "La sincronización falló, abortando despliegue."
  exit 1
fi

# Reiniciamos el servicio en el servidor remoto
echo "Reiniciando el servicio en el servidor remoto..."
ssh $SERVER_USER@$SERVER_IP "sudo systemctl restart nombre_del_servicio"

# Verificamos si el reinicio fue exitoso
if [ $? -ne 0 ]; then
  echo "El reinicio del servicio falló, revisa el servidor."
  exit 1
fi

# Iprimimos mensaje de éxito
echo "Despliegue completado exitosamente."