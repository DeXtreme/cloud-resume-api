variable "region" {
  type        = string
  description = "Region to deploy to"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private-subnets" {
  type        = map(string)
  description = "Map of az to cidr for private subnets"
  default = {
    us-east-1a = "10.0.0.0/24"
    us-east-1b = "10.0.1.0/24"
    us-east-1c = "10.0.2.0/24"
  }
}
