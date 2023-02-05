resource "aws_key_pair" "ketan-key" {
  key_name   = "ketan-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}


resource "aws_instance" "MyFirstInstnace" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.ketan-key.key_name
  availability_zone = "us-east-2a"
  user_data = data.template_cloudinit_config.install_apache-config.rendered
  

  tags = {
    Name = var.INSTANCE_USERNAME 
 }
}
output "public_ip" {
  value = "aws_instance.MyFirstInstnace.public_ip"
 
}
