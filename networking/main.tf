#-- networking/main.tf ---
data "aws_availability_zones" "available" {}

resource "aws_vpc" "tfmh_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { 
    name          = format("%s_vpc", var.project_name)
    project_name  = var.project_name
  }
}

resource "aws_internet_gateway" "tfmh_igw" {
  vpc_id = aws_vpc.tfmh_vpc.id
  tags = { 
    name          = format("%s_igw", var.project_name)
    project_name  = var.project_name
  }
}

resource "aws_subnet" "tfmh_subpub" {
  count                   = length(var.subpub_cidrs)

  vpc_id                  = aws_vpc.tfmh_vpc.id
  cidr_block              = var.subpub_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = { 
    name          = format("%s_subpub_%d", var.project_name, count.index + 1)
    project_name  = var.project_name
  }
}

resource "aws_subnet" "tfmh_subprv" {
  count                   = length(var.subprv_cidrs)
  vpc_id                  = aws_vpc.tfmh_vpc.id
  cidr_block              = var.subprv_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = { 
    name          = format("%s_subprv_%d", var.project_name, count.index + 1)
    project_name  = var.project_name
  }
}

resource "aws_security_group" "tfmh_sg" {
  name        = "tfmh_sgpub"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.tfmh_vpc.id
  tags = { 
    name          = format("%s_sgpub", var.project_name)
    project_name  = var.project_name
  }
  dynamic "ingress" {
    for_each = [ for s in var.service_ports: {
      from_port = s.from_port
      to_port = s.to_port
    }]
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = [ingress.value.to_port == 27017 ? "0.1.2.3/32" : var.access_ip]
    }
  }
}
