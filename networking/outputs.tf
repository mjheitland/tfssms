#--- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.tfmh_vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.tfmh_igw.id
}

output "subpub_ids" {
  value = aws_subnet.tfmh_subpub.*.id
}

output "subpub_ips" {
  value = aws_subnet.tfmh_subpub.*.cidr_block
}

output "subprv_ids" {
  value = aws_subnet.tfmh_subprv.*.id
}

output "subprv_ips" {
  value = aws_subnet.tfmh_subprv.*.cidr_block
}

output "sgpub_ids" {
  value = aws_security_group.tfmh_sgpub.*.id
}

output "sgpub_ingress" {
  value = {
    for ingress in aws_security_group.tfmh_sgpub.ingress:
    format("From %d", ingress.from_port) => format("To %d", ingress.to_port)
  }
}
