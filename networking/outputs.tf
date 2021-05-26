#--- networking/outputs.tf ---
output "vpc_id" {
  value = aws_vpc.tfssms_vpc.id
}
output "igw_id" {
  value = aws_internet_gateway.tfssms_igw.id
}
output "subpub_ids" {
  value = aws_subnet.tfssms_subpub.*.id
}
output "sg_id" {
  value = aws_security_group.tfssms_sg.id
}
output "rtpub_ids" {
  value = aws_route_table.tfssms_rtpub.*.id
}
