#--- compute/main.tf
resource "aws_key_pair" "tfssms_keypair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

data "aws_ami" "amazon_windows" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base*"]
  }
  filter {
      name   = "root-device-type"
      values = ["ebs"]
    }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }  
}  

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "template_file" "tfssms_userdata" {
  count = length(var.subpub_ids)

  template = file("${path.module}/userdata.tpl")
  vars = {
    subnet = element(var.subpub_ids, count.index)
    region = data.aws_region.current.name
  }
}

#-- ec2
resource "aws_instance" "tfssms_server" {
  count = length(var.subpub_ids)

  instance_type           = var.instance_type
  ami                     = data.aws_ami.amazon_windows.id
  key_name                = aws_key_pair.tfssms_keypair.id
  subnet_id               = element(var.subpub_ids, count.index)
  vpc_security_group_ids  = [var.sg_id]
  user_data               = data.template_file.tfssms_userdata.*.rendered[count.index]
  tags = { 
    Name = format("%s_server_%d", var.project_name, count.index)
    Environment = "CheckedBySecurity"
  }
}
