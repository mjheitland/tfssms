#--- root/outputs.tf ---
output "project_name" {
  value = var.project_name
}

#--- networking
output "vpc_id" {
  value = module.networking.vpc_id
}
output "igw_id" {
  value = module.networking.igw_id
}
output "subpub_ids" {
  value = module.networking.subpub_ids
}
output "subpub_ips" {
  value = module.networking.subpub_ips
}
output "subprv_ids" {
  value = module.networking.subprv_ids
}
output "subprv_ips" {
  value = module.networking.subprv_ips
}
output "sgpub_ids" {
  value = module.networking.sgpub_ids
}
output "sgpub_ingress" {
  value = module.networking.sgpub_ingress
}

/*
#--- compute
output "server_id" {
  value = module.compute.server_id
}
output "server_public_ip" {
  value = module.compute.server_public_ip
}
*/