provider "aws" {
    #count = 2
 region =  "ap-south-1"
 

}   

  
 module "Vms_app1" {
  #source = "./module/ec2-instance"
  source = "git::https://github.com/harimerits/hariuser20day3//ec2-instance?ref=main"
  region-1 = "ap-south-1"
  instance_type = "t3.micro"
  subnets = ["subnet-0a413d769fe98ba0b", "subnet-043f1f8151b681cca", "subnet-04f47a3252bdf06e6"]
  #Security_group = module.Security_group.op_sg_id
  web_sg = [module.Web_SG01.web_sg_id]
  num_of_vm = 1
  env = "dev"
  user_data = file("scripts/nginx.sh")
}
module "Web_SG01" {
  source = "git::https://github.com/harimerits/hariuser20day3//security-group?ref=main"
  project = "vishwa"
  vpc_id = data.aws_vpc.default.id
}
 
data "aws_vpc" "default" {
  default = true
}