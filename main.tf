# 1. Configure the Cloud Provider Location
provider "aws" {
  region = "us-east-2"
}

# 2. Automatically build a Custom Isolated Network VPC Container
resource "aws_vpc" "gabby_custom_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "gabby-nton-vpc"
  }
}

# 3. Provision an Isolated Network Routing Subnet Channel inside the VPC
resource "aws_subnet" "gabby_custom_subnet" {
  vpc_id                  = aws_vpc.gabby_custom_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "gabby-nton-subnet"
  }
}

# 4. Declare the Server Instance Box and Link it Directly to the New Subnet
resource "aws_instance" "gabby_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Standard Ohio Ubuntu image
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.gabby_custom_subnet.id # Bypasses default VPC checks!

  tags = {
    Name = "gabby-nton-infrastructure-node"
  }
}

