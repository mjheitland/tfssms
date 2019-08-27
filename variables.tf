#--- root/variables.tf ---
variable "aws_region" {
    type = string
}

#--- networking variables
variable "vpc_cidr" {
    type = string
}
variable "public_cidrs" { 
    type = "list" 
}
variable "private_cidrs" { 
    type = "list" 
}
variable "accessip" {
    type = string
}

#-------compute variables
variable "key_name" {
    type = string
}
variable "public_key_path" {
    type = string
}
variable "server_instance_type" {
    type = string
}
variable "instance_count" {
    type = number
    default = 1
}