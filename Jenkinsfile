pipeline {
    agent {
        docker {
            image 'python:3.11'
        }
    }
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
                    # Instalar awscli en el contenedor de Docker
                    pip install --upgrade awscli

                    # Verificar la instalación
                    aws --version
                '''
            }
        }
        stage('Deploy to S3') {
            steps {
                withAWS(credentials: 'aws-digitalnao', region: 'us-east-1') {
                    sh '''
                        # Sincronizar con S3
                        aws s3 sync . s3://$BUCKET --exclude "./git/*"
                        aws s3 ls s3://$BUCKET
                    '''
                }
            }
        }
    }
}
