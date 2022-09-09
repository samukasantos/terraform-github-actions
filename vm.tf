

resource "aws_key_pair" "terraform_key_name" {
  key_name   = "aws_terraform_key"
  public_key = var.aws_pub_key
}

resource "aws_instance" "terraform_vm" {
  ami                         = "ami-07620139298af599e"
  key_name                    = aws_key_pair.terraform_key_name.key_name
  instance_type               = "t2.micro"
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id]
  associate_public_ip_address = true
  
  tags = {
    "Name" = "terraform-vm"
  }
}