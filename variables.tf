variable "application_name" {
  description = "application name"
  type        = string
  default     = "automuteus"
}

variable "instance_type" {
  description = "bot instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_ami" {
  description = "ec2 instance ami"
  type        = string
  default     = "ami-01748a72bed07727c"
}

# Latest release tag of automuteus
# https://github.com/denverquane/automuteus/releases
variable "automuteus_tag" {
  description = "AUTOMUTEUS_TAG"
  type        = string
  default     = "6.11.0"
}

# Latest release tag of galactus
# https://github.com/automuteus/galactus/releases
variable "galactus_tag" {
  description = "GALACTUS_TAG"
  type        = string
  default     = "2.4.1"
}

variable "galactus_external_port" {
  description = "GALACTUS_EXTERNAL_PORT"
  type        = number
  default     = 8123
}

variable "ssh_public_key" {
  description = "Adding a SSH key to EC2 for debug if you want"
  type        = string
  default     = ""
}

variable "allowed_cidr" {
  description = "The allowed cidr for ssh and galactus. You can modify the IP address to your home ip for security."
  type        = string
  default     = "0.0.0.0/0"
}

variable "application_region" {
  description = "Choose an AWS Region"
  type        = string
  default     = "ap-northeast-1"
}

variable "discord_bot_token" {
  description = "The discord bot token for automuteus"
  type        = string
}
