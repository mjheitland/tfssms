#--- root/variables.tf
variable "vpc_cidr" {
    type = string
}
variable "public_cidrs" { 
    type = list
}
variable "private_cidrs" { 
    type = list
}
variable "accessip" {
    type = string
}
variable "service_ports" {
    type = list
}

/*
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
*/
