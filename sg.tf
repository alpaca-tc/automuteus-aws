resource "aws_security_group" "ec2" {
  name        = "${var.application_name}-ec2"
  description = "automuteus ec2 instance"
  vpc_id      = aws_vpc.automuteus.id

  ingress {
    description = "SSH"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.ec2_reqres_cidr]
  }

  ingress {
    description = "automuteus"
    protocol    = "tcp"
    from_port   = var.application_port
    to_port     = var.application_port
    cidr_blocks = [var.ec2_reqres_cidr]
  }

  egress {
    description = "automuteus"
    protocol    = "tcp"
    from_port   = var.application_port
    to_port     = var.application_port
    cidr_blocks = [var.ec2_reqres_cidr]
  }

  egress {
    description = "http"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [var.ec2_reqres_cidr]
  }

  egress {
    description = "https"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.ec2_reqres_cidr]
  }

  tags = {
    Name    = "${var.application_name}-sg-ec2"
    AppName = var.application_name
  }
}
