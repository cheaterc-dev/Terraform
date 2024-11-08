provider "aws" {
  access_key = ""
  secret_key = ""

  region = "eu-central-1"

}




#####################################  VPC  #####################################
resource "aws_vpc" "VPC" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "LAMP"
  }
}


#####################################  SUBNETS  #####################################

resource "aws_subnet" "PUBLIC-A" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "PUBLIC-A"
  }
}


resource "aws_subnet" "PUBLIC-B" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "172.16.11.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "PUBLIC-B"
  }

}


resource "aws_subnet" "PRIVATE-A" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "172.16.20.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "PRIVATE-A"
  }
}


resource "aws_subnet" "PRIVATE-B" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "172.16.21.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "PRIVATE-B"
  }
}



##################################### NAT GATEWAY ####################################
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.PUBLIC-A.id
}

#####################################  INTERNET GATEWAY ####################################
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "GATEWAY"
  }
}


#####################################  ELASTICK IP  ####################################
resource "aws_eip" "nat_eip" {
  vpc = true
}




#####################################S  ROUTE TABLE #####################################
resource "aws_route_table" "Route_Table_Public-A" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public route table-A"
  }
}



resource "aws_route_table" "Route_Table_Public-B" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public route table-B"
  }
}


resource "aws_route_table" "Route_Table_Private-A" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Private route table-A"
  }
}



resource "aws_route_table" "Route_Table_Private-B" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Private route table-B"
  }
}



resource "aws_route_table_association" "Public-A" {
  subnet_id      = aws_subnet.PUBLIC-A.id
  route_table_id = aws_route_table.Route_Table_Public-A.id
}


resource "aws_route_table_association" "Public-B" {
  subnet_id      = aws_subnet.PUBLIC-B.id
  route_table_id = aws_route_table.Route_Table_Public-B.id
}


resource "aws_route_table_association" "Private-A" {
  subnet_id      = aws_subnet.PRIVATE-A.id
  route_table_id = aws_route_table.Route_Table_Private-A.id
}

resource "aws_route_table_association" "Private-B" {
  subnet_id      = aws_subnet.PRIVATE-B.id
  route_table_id = aws_route_table.Route_Table_Private-B.id
}




