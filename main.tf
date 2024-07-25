provider "aws" {             
  region = "us-east-1"  #any region as per choice 
}

variable "cidr" {             #variablizing the cidr 
  default = "10.0.0.0/16"
}

resource "aws_key_pair" "example" { 
  key_name   = "pro001"              # enter your key-pair name (any name)
  public_key = file("key.pub")       #enter the path of your public key
}

resource "aws_vpc" "my_vpc" {        #creating vpc 
  cidr_block = var.cidr            
}

resource "aws_subnet" "subnet1" {               #creating subnet
  vpc_id                  = aws_vpc.my_vpc.id       
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1c" 
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {  #creating gateway 
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "RouteTable" {  #creating Route table 

  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id      
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RouteTable.id
}

resource "aws_security_group" "webSg" {  #creating security group
  name   = "web"
  vpc_id = aws_vpc.my_vpc.id

  ingress {                           #  inbound traffic controller help to reach endpoints
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {                #outbound traffic controller for security group
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

resource "aws_instance" "EC2_instance" {     #creating EC2 instance of type ubuntu
  ami                    = "ami-0261755bbcb8c4a84"
  instance_type          = "t3.micro"
  key_name      = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.subnet1.id

  connection {
    type        = "ssh"
    user        = "ubuntu"     # Replace with the appropriate username for your EC2 instance
    private_key = file("key path")  # Replace with the path to your private key
    host        = self.public_ip
  }

  # File provisioner to copy a file from local to the remote EC2 instance

  provisioner "file" {
    source      = "app.py"               # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {              
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",                   # Update package lists for ubuntu
      "sudo apt-get install -y python3-pip",  #  package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }
}