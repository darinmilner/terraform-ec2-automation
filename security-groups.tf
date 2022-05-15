resource "aws_security_group" "mtc-sg" {
  name        = "dev-sg"
  description = "Dev security group."

  vpc_id = aws_vpc.mtc-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # all protocols 
    cidr_blocks = ["0.0.0.0/0"] # add your own ip  list of ips
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

resource "aws_key_pair" "mtc-auth" {
  key_name   = "mtckey"
  public_key = file("mtckey.pub")
}
