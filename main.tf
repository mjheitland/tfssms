#--- root/main.tf ---
provider "aws" {
}

# deploy networking resources
module "networking" {
  source        = "./networking"
  project_name  = var.project_name
  vpc_cidr      = var.vpc_cidr
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
  access_ip     = var.access_ip
  service_ports = var.service_ports
}
/*
# Deploy Compute Resources
module "compute" {
  source          = "./compute"
  instance_count    = var.instance_count
  key_name          = var.key_name
  public_key_path   = var.public_key_path
  instance_type     = var.instance_type
  subpup_ids        = module.networking.subpup_id
  subpub_cidr_block = module.networking.subpub_cidr_block
  public_sg         = module.networking.public_sg
}
*/