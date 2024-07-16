pipeline {
    agent any
    environment{
        BUCKET = "aws-digitalnao"

    }

    stages {
        stage('deploy to s3') {
            steps {
                withAWS(credentials: 'aws-digitalnao', region: 'us-east-2') {
                    sh 'aws s3 sync . s3://$BUCKET --exclude ".git/*"'
                    sh 'aws s3 ls s3://$BUCKET'
                }
            }
        }
    }
}
