#--- networking/outputs.tf ---

output "tf_mha_vpc_id" {
  value = aws_vpc.tf_mha_vpc.id
}

output "tf_mha_subpub_ids" {
  value = aws_subnet.tf_mha_subpub.*.id
}

output "tf_mha_subpub_ips" {
  value = aws_subnet.tf_mha_subpub.*.cidr_block
}

output "tf_mha_subprv_ids" {
  value = aws_subnet.tf_mha_subprv.*.id
}

output "tf_mha_subprv_ips" {
  value = aws_subnet.tf_mha_subprv.*.cidr_block
}

/*
output "public_sg" {
  value = "aws_security_group.tf_mha_public_sg.*.id"
}
*/