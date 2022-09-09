output "vm_ip" {
  value = aws_instance.terraform_vm.public_ip
}