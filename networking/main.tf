#-- networking/main.tf ---
data "aws_availability_zones" "available" {}

resource "aws_vpc" "tf_mha_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "tf_mha_vpc" }
}

resource "aws_internet_gateway" "tf_mha_igw" {
  vpc_id = aws_vpc.tf_mha_vpc.id
  tags = { Name = "tf_mha_igw" }
}

resource "aws_subnet" "tf_mha_subpub" {
  count                   = length(var.public_cidrs)
  vpc_id                  = aws_vpc.tf_mha_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = { Name = "tf_mha_subpub_${count.index + 1}" }
}

resource "aws_subnet" "tf_mha_subprv" {
  count                   = length(var.private_cidrs)
  vpc_id                  = aws_vpc.tf_mha_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = { Name = "tf_mha_subprv_${count.index + 1}" }
}

resource "aws_security_group" "tf_mha_sgpub" {
  name        = "tf_mha_sgpub"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.tf_mha_vpc.id
  dynamic "ingress" {
    for_each = [ for s in var.service_ports: {
      from_port = s.from_port
      to_port = s.to_port
    }]
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = [var.accessip]
    }

  }
}
