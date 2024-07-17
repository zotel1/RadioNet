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
        stage('deploy to s3') {
            steps {
                withAWS(credentials: 'aws-digitalnao', region: 'us-east-1') {
                    // Sincronizar archivos con S3
                    s3Upload(bucket: "${env.BUCKET}", path: '', workingDir: '.', includePathPattern: '**', excludePathPattern: '.git/**')
                    
                    // Listar contenido del bucket S3
                    s3FindFiles(bucket: "${env.BUCKET}", path: '', maxResults: 100).each { file ->
                        echo "Found file: ${file.key}"}
                        }
                        }
                        }
                        }
                        }
                        }
