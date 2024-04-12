variable "region" {
  description = "The AWS region to deploy to"
  default     = "eu-west-1"
}

variable "app_name" {
  description = "The name of the application"
  default     = "trust-wallet-proxy" 
}

variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    default     = "10.0.0.0/16"
}

variable "docker_image_url" {
    description = "The URL of the Docker image to use"
    default     = "https://hub.docker.com/r/haroldsphinx/trust-wallet-proxy"  
}

variable "docker_image" {
    description = "The Docker image to use"
    default     = "haroldsphinx/trust-wallet-proxy"  
}

