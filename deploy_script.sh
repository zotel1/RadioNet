#!/bin/bash

# Definimos nuestras variables de entorno
SERVER_USER="tu_usuario"           # Usuario del servidor remoto
SERVER_IP="tu_servidor_ip"         # Dirección IP del servidor remoto
LOCAL_BUID_PATH="target/release"   # Ruta del build local

# Imprimimos un mensaje de inicio de despliegue
echo "Iniciando el despliegue a $SERVER_USER@$SERVER_IP:$SERVER_PATH"

# Construimos el proyecto
echo "Construyendo el proyecto..."
cargo build --release              # Construye el proyecto en modo release

# Verificamos si la construcción fue exitosa
if [ $? -ne 0 ]; then              # $? verifica el código de salida del último comando ejecutado
  echo "La construcción falló, abortando despliegue."
  exit 1                           # Sale del script con un código de error
fi

# Sincronizamos archivos con el servidor remoto
echo "Sincronizando archivos con el servidor remoto..."
rsync -avz --delete $LOCAL_BUID_PATH $SERVER_USER@$SERVER_IP:$SERVER_PATH  # Sincroniza archivos con el servidor remoto

# Verificamos si la sincronización fue exitosa
if [ $? -ne 0 ]; then              # Verifica si rsync se ejecutó correctamente
  echo "La sincronización falló, abortando despliegue."
  exit 1                           # Sale del script con un código de error
fi

# Reiniciamos el servicio en el servidor remoto
echo "Reiniciando el servicio en el servidor remoto..."
ssh $SERVER_USER@$SERVER_IP "sudo systemctl restart nombre_del_servicio"  # Reinicia el servicio en el servidor remoto

# Verificamos si el reinicio fue exitoso
if [ $? -ne 0 ]; then              # Verifica si el comando ssh se ejecutó correctamente
  echo "El reinicio del servicio falló, revisa el servidor."
  exit 1                           # Sale del script con un código de error
fi

# Imprimimos mensaje de éxito
echo "Despliegue completado exitosamente."  # Mensaje final indicando que el despliegue fue exitoso
