pipeline {
    agent {
        docker {
            image 'python:3.11' // Usar la imagen Docker de Python 3.11 para ejecutar las etapas
        }
    }
    environment {
        BUCKET = "aws-web-digitalnao-1" // Nombre del bucket S3 de AWS
    }
    stages {
        stage('Checkout SCM') {
            steps {
                // Checkout del código fuente del repositorio
                checkout scm
            }
        }
        stage('Setup AWS CLI') {
            steps {
                sh '''
                    # Instalar la última versión de AWS CLI en el contenedor de Docker
                    pip install --upgrade awscli

                    # Verificar la instalación de AWS CLI
                    aws --version
                '''
            }
        }
        stage('Deploy to S3') {
            steps {
                // Usar las credenciales de AWS configuradas en Jenkins y la región especificada
                withAWS(credentials: 'aws-digitalnao', region: 'us-east-1') {
                    sh '''
                        # Sincronizar el contenido actual con el bucket S3, excluyendo el directorio .git
                        aws s3 sync . s3://$BUCKET --exclude "./git/*"
                        
                        # Listar los contenidos del bucket S3 para verificar la sincronización
                        aws s3 ls s3://$BUCKET
                    '''
                }
            }
        }
    }
}
