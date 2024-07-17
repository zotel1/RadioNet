pipeline {
    agent any
    environment {
        BUCKET = "aws-web-digitalnao-1"
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Setup AWS CLI') {
            steps {
                sh '''
                    # Crear entorno virtual
                    python3 -m venv venv

                    # Activar el entorno virtual
                    . venv/bin/activate

                    # Instalar awscli en el entorno virtual
                    pip install --upgrade awscli

                    # Verificar la instalación
                    venv/bin/aws --version
                '''
            }
        }
        stage('Deploy to S3') {
            steps {
                withAWS(credentials: 'aws-digitalnao', region: 'us-east-1') {
                    sh '''
                        # Activar el entorno virtual
                        . venv/bin/activate

                        # Sincronizar con S3
                        venv/bin/aws s3 sync . s3://$BUCKET --exclude "./git/*"
                        venv/bin/aws s3 ls s3://$BUCKET
                    '''
                }
            }
        }
    }
}
