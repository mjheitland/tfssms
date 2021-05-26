#--- compute/outputs.tf
output "keypair_id" {
  value = join(", ", aws_key_pair.tfssms_keypair.*.id)
}
output "server_ids" {
  value = join(", ", aws_instance.tfssms_server.*.id)
}
output "server_public_ips" {
  value = join(", ", aws_instance.tfssms_server.*.public_ip)
}
