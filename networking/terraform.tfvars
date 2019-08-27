#--- networking
vpc_cidr     = "10.50.0.0/16"
public_cidrs = [
  "10.50.101.0/24"
]
private_cidrs = [
  "10.50.201.0/24",
  "10.50.202.0/24"
]
accessip    = "0.0.0.0/0"

#--- compute
#public_key_path = "~/.ssh/id_rsa.pub"
#server_instance_type = "t2.micro"
