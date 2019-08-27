#--- root/outputs.tf ---

output "tf_mha_vpc_id" {
  value = module.networking.tf_mha_vpc_id
}

output "tf_mha_subpub_ids" {
  value = module.networking.tf_mha_subpub_ids
}

output "tf_mha_subpub_ips" {
  value = module.networking.tf_mha_subpub_ips
}

output "tf_mha_subprv_ids" {
  value = module.networking.tf_mha_subprv_ids
}

output "tf_mha_subprv_ips" {
  value = module.networking.tf_mha_subprv_ips
}

output "tf_mha_sgpub_id" {
  value = module.networking.tf_mha_sgpub_id
}

output "tf_mha_sgpub_ingress" {
  value = module.networking.tf_mha_sgpub_ingress
}
