resource "aws_security_group" "bot" {
  name        = "${var.application_name}-bot"
  description = "automuteus ec2 instance"
  vpc_id      = aws_vpc.automuteus.id

  ingress {
    # for galactus
    description = "galactus external port"
    protocol    = "tcp"
    from_port   = var.galactus_external_port
    to_port     = var.galactus_external_port
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    # for yum
    description = "http"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    # for yum and automuteus bot
    description = "https"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.application_name}-sg-bot"
    AppName = var.application_name
  }
}

resource "aws_security_group_rule" "ssh" {
  # Open ssh port if ssh_public_key is added.
  count             = var.ssh_public_key == "" ? 0 : 1
  security_group_id = aws_security_group.bot.id
  description       = "SSH"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = [var.allowed_cidr]
  protocol          = "tcp"
}
