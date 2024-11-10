# Cloud Resume API

This repository is a solution to the Cloud Resume Challenge API project. The goal is to create a serverless API to count visits to a resume hosted in the cloud. The API is deployed using AWS services and Infrastructure as Code (IaC) to automate the setup process. The challenge demonstrates proficiency with cloud technologies, serverless architecture, and DevOps practices.

## Solution Architecture

The solution uses the following AWS services:
- **API Gateway**: To expose the REST API endpoint.
- **Lambda**: To handle request processing and visitor count increment logic.
- **DynamoDB**: To store and persist the visitor count.
- **IAM**: To define fine-grained permissions for security.

## Getting Started

These instructions will help you set up and deploy the project to your AWS account.

### Prerequisites

To deploy this solution, you'll need:
- **AWS Account** with access to IAM, API Gateway, Lambda, and DynamoDB.
- **AWS CLI** installed and configured with appropriate permissions.
- **Terraform** (or AWS CDK) to provision infrastructure as code.
- **Python 3.9** for running and testing Lambda functions locally.

### Deployment

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/DeXtreme/cloud-resume-api.git
   cd cloud-resume-api
   ```

2. **Terraform Deployment**:
   Ensure the Terraform backend is properly configured, then initialize and apply Terraform.

   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

3. **API Gateway**:
   Terraform will output the url to the API Gateway

4. **DynamoDB**:
     Add your resume to the `resumes` DynamoDB table and set the `version` partition key to "latest"
### Usage

After deployment, access the API via the output url. Your resume will be returned in JSON format.


## Future Improvements
- Use CloudWatch to monitor Lambda invocation errors and API performance.
- Automate tests and deployments through a CI/CD pipeline (e.g., GitHub Actions).

---

