resource "aws_instance" "Ubuntu-AWS" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.privatesubnetaz1.id
  key_name               = var.keyname
  availability_zone      = var.az1
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  tags = {
    Name = "Ubuntu-AWS"
  }
}
