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
                    sh 'aws s3 sync . s3://$BUCKET --exclude "./git/*"'
                    sh 'aws s3 ls s3://$BUCKET'
                        }
                        }
                        }
                        }
                        }
