#!/bin/bash
BUCKET="aws-web-digitalnao-1"
REGION="us-east-1"

bucket_exists() {
    aws s3api head-bucket --bucket $BUCKET 2>/dev/null
}

create_bucket() {
    if ! bucket_exists $BUCKET; then 
        echo "Creating bucket $BUCKET"
    aws s3api create-bucket --bucket $BUCKET --region $REGION
    else
        echo "Bucket $BUCKET already exists"
    fi
}

create_bucket