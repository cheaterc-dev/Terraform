provider "aws" {
    access_key = 
    secret_key = 
    region = "eu-central-1"

}

resource "aws_instance" "my_ubuntu" {
    ami = "ami-0084a47cc718c111a"
    instance_type = "t2.micro"
    tags = {
        Name= "my ubuntu server1"
        Owner = "Denis"
        Project = "Terraform"
    }
}

resource "aws_instance" "my_ubuntu1" {
    ami = "ami-0084a47cc718c111a"
    instance_type = "t2.micro"
    tags = {
        Name= "my ubuntu server2"
        Owner = "Denis"
        Project = "Terraform"
    }
}
