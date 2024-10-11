terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.45, != 5.71.0"  # Укажите нужную версию
    }
  }
}

provider "aws" {
  region     = "eu-central-1"
  access_key =      # Замените на ваш ключ доступа
  secret_key =      # Замените на ваш секретный ключ
}

resource "aws_security_group" "my_webserver" {
  name        = "my_webserver_sg"
  description = "Security group for my web server"
  tags = {
    Name = "allow_ALLL"
  }

  dynamic "ingress" {
    for_each = ["80", "443", "8000", "9092"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Разрешить все исходящие соединения
    cidr_blocks = ["0.0.0.0/0"]
  }
}
