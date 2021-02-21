resource "aws_instance" "bot" {
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  ami                         = var.instance_ami
  associate_public_ip_address = true
  key_name                    = var.ssh_public_key == "" ? null : aws_key_pair.automuteus[0].key_name

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  vpc_security_group_ids = [
    aws_security_group.bot.id,
  ]

  user_data = <<-EOS
    #!/bin/bash

    docker_compose_version=1.28.2

    # Install docker and git
    sudo yum update -y
    sudo yum install -y git docker
    sudo systemctl start docker
    sudo usermod -a -G docker ec2-user

    # Install docker-compose
    sudo curl -L https://github.com/docker/compose/releases/download/$docker_compose_version/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo systemctl enable docker

    cd /home/ec2-user

    # Setup automuteus
    git clone https://github.com/denverquane/automuteus
    cd automuteus

    # EC2 instance IP
    public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

    # Replace initial env with customized variables
    sed \
      -e "s/^AUTOMUTEUS_TAG=/AUTOMUTEUS_TAG=${var.automuteus_tag}/" \
      -e "s/^GALACTUS_TAG=/GALACTUS_TAG=${var.galactus_tag}/" \
      -e "s/^GALACTUS_HOST=/GALACTUS_HOST=http:\/\/$public_ip:${var.galactus_external_port}/" \
      -e "s/^GALACTUS_EXTERNAL_PORT=/GALACTUS_EXTERNAL_PORT=${var.galactus_external_port}/" \
      -e "s/^DISCORD_BOT_TOKEN=/DISCORD_BOT_TOKEN=${var.discord_bot_token}/" \
      sample.env > .env

    sudo /usr/local/bin/docker-compose up -d
  EOS

  tags = {
    Name    = "${var.application_name}-bot"
    AppName = var.application_name
  }
}
