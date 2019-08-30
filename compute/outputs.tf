#--- compute/outputs.tf

output "server_ids" {
  value = "${join(", ", aws_instance.tfmh_server.*.id)}"
}

output "server_public_ips" {
  value = "${join(", ", aws_instance.tfmh_server.*.public_ip)}"
}
