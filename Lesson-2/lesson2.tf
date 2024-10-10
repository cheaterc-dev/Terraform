#----------------------------------
# My terrafrom
#Build my server
#
#----------------------------------

provider "aws" {
    access_key = 
    secret_key = 

    region = "eu-central-1"

}
resource "aws_instance" "my_web" {
  ami = "ami-0084a47cc718c111a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
 
}

resource "aws_security_group" "my_webserver" {
  name        = "Security group"
  description = "First cec"
  

  tags = {
    Name = "allow_80"
  }


  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} 
