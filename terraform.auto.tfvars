#--- terraform.tfvars ---
project_name = "tfssms"
vpc_cidr     = "10.50.0.0/16"
subpub_cidrs = [
  "10.50.101.0/24"
]
access_ip     = "0.0.0.0/0"
service_ports = [
  { # ssh
    from_port = 22,
    to_port   = 22
  },
  { # Windows rdp
    from_port = 3389,
    to_port   = 3389
  },
  { # web http
    from_port = 80,
    to_port   = 80
  },
  { # web https
    from_port = 443,
    to_port   = 443
  },
  { # MS SQL Server
    from_port = 1433, 
    to_port   = 1433
  } 
]

#--- compute
key_name        = "tfssms_key"
public_key_path = "./id_rsa.pub"
instance_type   = "t2.micro"
