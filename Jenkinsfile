pipeline {
    agent any
    environment{
        BUCKET = "aws-web-digitalnao-1"
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Install AWS CLI') {
            steps {
                sh '''
                    if ! [ -x "$(command -v aws)" ]; then
                        echo "AWS CLI no está instalada. Instalando ahora..."
                        sudo apt-get update
                        sudo apt-get install python3-pip -y
                        pip3 install awscli --upgrade --user
                        export PATH=$PATH:$HOME/.local/bin
                    else
                        echo "AWS CLI ya está instalada."
                    fi
                '''
            }
        }
        stage('deploy to s3') {
            steps {
                withAWS(credentials: 'aws-digitalnao', region: 'us-east-1'){
                    sh 'aws s3 sync . s3://$BUCKET --exclude "./git/*"'
                    sh ' s3 ls s3://$BUCKET'
                }
                        }
                        }
                        }
                        }
