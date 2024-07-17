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
        stage('Install AWS CLI') {
            steps {
                sh '''
                    # Install python3-pip if not already installed
                    apt-get update
                    apt-get install -y python3-pip

                    # Install awscli using pip
                    pip3 install --upgrade awscli --user

                    # Add the AWS CLI to the PATH
                    export PATH=$PATH:$HOME/.local/bin

                    # Verify installation
                    aws --version
                '''
            }
        }
        stage('Deploy to S3') {
            steps {
                withAWS(credentials: 'aws-digitalnao', region: 'us-east-1') {
                    sh '''
                        export PATH=$PATH:$HOME/.local/bin
                        aws s3 sync . s3://$BUCKET --exclude "./git/*"
                        aws s3 ls s3://$BUCKET
                    '''
                }
            }
        }
    }
}
