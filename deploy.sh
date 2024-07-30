#!/bin/bash

# Definimos el nombre del bucket y la región de AWS
BUCKET="aws-web-digitalnao-1"
REGION="us-east-1"

# Función para verificar si el bucket existe
bucket_exists() {
    aws s3api head-bucket --bucket $BUCKET 2>/dev/null  # Comprueba si el bucket existe, suprime la salida de error
}

# Función para crear el bucket si no existe
create_bucket() {
    if ! bucket_exists $BUCKET; then  # Si el bucket no existe
        echo "Creating bucket $BUCKET"
        aws s3api create-bucket --bucket $BUCKET --region $REGION  # Crea el bucket en la región especificada
    else
        echo "Bucket $BUCKET already exists"  # Si el bucket ya existe, imprime un mensaje
    fi
}

# Llama a la función para crear el bucket
create_bucket
