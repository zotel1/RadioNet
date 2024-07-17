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
                    sh 'aws s3 sync . s3://$BUCKET --exclude "./git/*"'
                    sh ' s3 ls s3://$BUCKET'
                        }
                        }
                        }
                        }
