#-- networking/main.tf ---
data "aws_availability_zones" "available" {}

resource "aws_vpc" "tfssms_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { 
    Name = format("%s_vpc", var.project_name)
    project_name = var.project_name
  }
}

resource "aws_internet_gateway" "tfssms_igw" {
  vpc_id = aws_vpc.tfssms_vpc.id

  tags = { 
    Name = format("%s_igw", var.project_name)
    project_name = var.project_name
  }
}

resource "aws_subnet" "tfssms_subpub" {
  count                   = length(var.subpub_cidrs)

  vpc_id                  = aws_vpc.tfssms_vpc.id
  cidr_block              = var.subpub_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  
  tags = { 
    Name = format("%s_subpub_%d", var.project_name, count.index + 1)
    project_name = var.project_name
  }
}

resource "aws_security_group" "tfssms_sg" {
  name        = "tfssms_sgpub"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.tfssms_vpc.id
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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { 
    Name = format("%s_sgpub", var.project_name)
    project_name = var.project_name
  }
}
# Public route table, allows all outgoing traffic to go the the internet gateway.
# https://www.terraform.io/docs/providers/aws/r/route_table.html?source=post_page-----1a7fb9a336e9----------------------
resource "aws_route_table" "tfssms_rtpub" {
  vpc_id = aws_vpc.tfssms_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tfssms_igw.id
  }
  tags = {
    Name = format("%s_tfssms_rtpub", var.project_name)
    project_name = var.project_name
  }
}
# connect every public subnet with our public route table
resource "aws_route_table_association" "tfssms_rtpubassoc" {
  count = length(var.subpub_cidrs)

  subnet_id      = aws_subnet.tfssms_subpub.*.id[count.index]
  route_table_id = aws_route_table.tfssms_rtpub.id
}
