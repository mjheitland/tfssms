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
output "subprv_ids" {
  value = module.networking.subprv_ids
}
output "sg_id" {
  value = module.networking.sg_id
}

#--- compute
output "server_ids" {
  value = module.compute.server_ids
}
output "server_public_ips" {
  value = module.compute.server_public_ips
}
