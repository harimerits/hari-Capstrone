provider "aws" {
    #count = 2
 region =  "ap-south-1"
 
default_tags {
    tags = {
      owner = "user20"
    }
      }
}   

  
 locals {
  tag_Name = "Hari-${var.env}"
}
  
 

resource "aws_instance" "main" {
    ami = "ami-0ced6a024bb18ff2e"
    instance_type = "t2.micro"
    count = 1
    #subnet_id =
tags = {
    Name = "Hari"
    Name =  local.tag_Name
    owner = "User20"
        #Name = "hari${count.index + 1}"
    
  }
  
}


data "aws_subnet" "subnet1"{

  filter {
    name = "tag:Name"
    values = ["Sub02"]
  }
}

output "vm_pip" {
  value = aws_instance.main[0].public_ip
}
 
output "vm_pips" {
  value = [for vm in aws_instance.main : vm.public_ip ]
}