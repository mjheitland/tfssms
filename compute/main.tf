#--- compute/main.tf
resource "aws_key_pair" "tfmh_keypair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

data "aws_ami" "tfmh_server_ami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}
data "template_file" "tfmh_userdata" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    firewall_subnets = "element(var.subpub_cidrs, count.index)"
  }
}
resource "aws_instance" "tfmh_server" {
  count = length(var.subpub_ids)

  instance_type           = var.instance_type
  ami                     = data.aws_ami.tfmh_server_ami.id
  key_name                = aws_key_pair.tfmh_keypair.id
  subnet_id               = element(var.subpub_ids, count.index)
  vpc_security_group_ids  = [var.sg_id]
  user_data               = data.template_file.tfmh_userdata.*.rendered[0]
  tags = { 
    Name = format("%s_server_%d", var.project_name, count.index)
    project_name = var.project_name
  }
}
