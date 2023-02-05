resource "aws_key_pair" "ketan-key" {
  key_name   = "ketan-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}
0

resource "aws_instance" "MyFirstInstnace" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.ketan-key.key_name
  

  tags = {
    Name = var.INSTANCE_USERNAME
  
}

#EBS VOLUME
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-west-2a"
  size              = 10
  name = "gp-2"

  tags = {
    Name = "secondary volume Disk"
  }
}

#EBS volume attachment
resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.MyFirstInstnace.id
}