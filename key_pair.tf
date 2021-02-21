resource "aws_key_pair" "automuteus" {
  # Add ssh public key for debug if ssh_public_key is defined.
  count      = var.ssh_public_key == "" ? 0 : 1
  key_name   = "automuteus"
  public_key = var.ssh_public_key
}
