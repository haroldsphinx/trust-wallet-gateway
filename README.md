# Trust-Wallet-Gateway Application Deployment on AWS ECS Fargate with GitHub Actions

This repository contains the necessary codebase and deployment artifacts for deploying a trust-wallet-gateway service on AWS ECS FARgate.

## Architecture

The architecture includes the use of GitHub for source code management and GitHub Actions for Continuous Integration and Continuous Deployment (CI/CD). The CI/CD pipeline lints, tests, builds, and deploys the Go service to a Kubernetes cluster in AWS ECS. 

Here is a high-level view of the architecture:
```
[GitHub] --- [GitHub Actions] --- [Docker Hub]
       \                            /
        -- [AWS ECS Fargate (Kubernetes)] --  
```


## Prerequisites

- Go 1.16+
- Docker
- AWS 
- terraform

## Deployment Steps

1. Clone this repository and navigate to the project directory.
2. Run `make install-dependencies` to install required dependencies.
3. Set the required environment variables in your local environment and GitHub secrets for GitHub Actions.
4. Push your changes to the `main` branch.
5. GitHub Actions will automatically lint, test, build the Docker image, push the image to Docker Hub, and deploy the service to the AWS Fargate.


## Builld and Deployment Configuration

The Makefile includes the commands to lint, test, build the Docker image, and push the image to Docker Hub. 

```shell
# Run lint
make lint 
# Run tests
make test 
# Build Docker image
make docker-build 
# Push Docker image
make docker-push 
 # Install dependencies
make install-dependencies
# Deploy to AWS ECS Fargate
make deploy 
```

## Continuous Integration and Deployment

This project uses GitHub Actions for CI/CD. When changes are pushed to the `main` branch, the following steps are executed:

1. Linting and testing of the Go code.
2. Building of the Docker image.
3. Pushing of the Docker image to Docker Hub.
4. Deployment of the Docker image to the Kubernetes cluster in the AWS EKS environment.
5. Setting up the AWS ECS Fargate cluster and deploying the service.
6. The service is accessible via the public IP address of the AWS ECS Fargate cluster.
7. The GitHub Actions workflow is defined in the `.github/workflows/build-deploy.yml` file and its used to autoae the deployment of the service to AWS ECS Fargate.
8. 


- Github Action Steps 
https://github.com/haroldsphinx/trust-wallet-gateway/blob/main/.github/workflows/deploy.yml


- Architectural Diagram



