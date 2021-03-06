This Terraform project shows how to specify and deploy the following components:
+ VPC
+ 1 internet gateway
+ 1 public subnet (number can be easily modified changing variables in terraform.tfvars)
+ 1 public security group
+ 1 public route table (opening the ingress ports listed in terraform.tfvars)
+ 1 keypair (first you have to run ssh-keygen in your home folder)
+ 1 ec2 micro instance per public subnet with Chocolatery and MS SQL Server Management Studio installed

## in .zshrc

    export AWS_ACCESS_KEY_ID="xxx"
    export AWS_SECRET_ACCESS_KEY="xxx"
    export AWS_DEFAULT_REGION="eu-central-1"

## generate a keypair to access EC2 instances

    ssh-keygen

## Terraform commands
    
    terraform init
    
    terraform validate
    
    terraform plan -out=tfplan.binary

    terraform show -json tfplan.binary > tfplan.json

    terraform apply -auto-approve tfplan.binary
    
    terraform apply -auto-approve
    
    terraform destroy -auto-approve

## To delete Terraform state files
    rm -rfv **/.terraform # remove all recursive subdirectories
    