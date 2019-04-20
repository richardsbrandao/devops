terraform init

DynamoDb Model
    - Match Day
    - Home
    - Away
    - Score First Half
    - Final Score


Terraform:
    Create Dynamodb table (Representing Model)
    Create Cloudsearch (Representing Model)
    Create Dynamodb Triggers
    Create Lambda to Insert/Remove/Update Cloudsearch documents
    Create S3 Buckets to host it-italy-master
    Create Batch Job to Insert data on Amazon

Code:
    Create lambda code to Insert/Remove/Update Cloudsearch documents
    Dockerize quick project and push to my account to get data from S3 and put in DynamoDb

Application
    React application to search in Cloudsearch documents


Criteria of searches to aim:
    Year (enable range)
    Date (enable range)
    By Team (Home, Away, All)
    By Matches (Home, Away, All)
    ...


