resource "aws_key_pair" "automuteus" {
  count      = var.ssh_public_key == "" ? 0 : 1
  key_name   = "automuteus"
  public_key = var.ssh_public_key
}
