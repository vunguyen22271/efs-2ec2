# VPC
resource "aws_vpc" "dev_test_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "dev_test_vpc"
  }
}

# Create a subnet
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.dev_test_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "dev_test_subnet_1"
  }
  depends_on = [aws_vpc.dev_test_vpc, aws_internet_gateway.gw]
}

# Create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id     = aws_vpc.dev_test_vpc.id
  depends_on = [aws_vpc.dev_test_vpc]
  tags = {
    Name = "igw"
  }
}

# Create a security group
resource "aws_security_group" "sg_1" {
  name        = "dev_test_sg_1"
  description = "dev_test_sg_1"
  vpc_id      = aws_vpc.dev_test_vpc.id

  ingress {
    description = "80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "443 from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "8000 from anywhere"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "RDP from anywhere"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "WinRM from anywhere"
    from_port   = 5985
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "WinRM from anywhere"
    from_port   = 5986
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "135 from anywhere"
    from_port   = 135
    to_port     = 135
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "RDP from anywhere"
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Ping from anywhere"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # egress {
  #   description = "HTTPS to ssm.us-east-1.amazonaws.com"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["ssm.us-east-1.amazonaws.com/32"]
  # }

  # egress {
  #   description = "HTTPS to ec2messages.us-east-1.amazonaws.com"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["ec2messages.us-east-1.amazonaws.com/32"]
  # }

  # egress {
  #   description = "HTTPS to ssmmessages.us-east-1.amazonaws.com"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["ssmmessages.us-east-1.amazonaws.com/32"]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
  depends_on = [aws_vpc.dev_test_vpc]
}

// Create a route table 
resource "aws_route_table" "trs52-public-rt" {
  vpc_id = aws_vpc.dev_test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

// Associate subnet with routetable 
resource "aws_route_table_association" "trs52-rta-public-subent-1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.trs52-public-rt.id
}
