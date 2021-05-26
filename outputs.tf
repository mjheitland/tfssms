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
output "sg_id" {
  value = module.networking.sg_id
}
output "rtpub_ids" {
  value = module.networking.rtpub_ids
}

#--- compute
output "keypair_id" {
  value = module.compute.keypair_id
}
output "server_ids" {
  value = module.compute.server_ids
}
output "server_public_ips" {
  value = module.compute.server_public_ips
}