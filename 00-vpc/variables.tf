variable "project_name" {
  type    = string
  default = "roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "tags" {
  default = {
    Purpose    = "Roboshop VPC"
    DontDelete = "true"
  }
}

variable "public_subnet_cidrs" {
    
    default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}