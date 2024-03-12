
# resource "aws_instance" "vm_1" {
#   ami           = "ami-0f409bae3775dc8e5"
#   instance_type = "t2.micro"
#   key_name      = "vockey"
#   user_data     = file("ec2-user-data.sh")
  
#   vpc_security_group_ids = ["${aws_security_group.sg_1.id}"]
#   subnet_id              = aws_subnet.subnet_1.id

#   iam_instance_profile = aws_iam_instance_profile.profile.name

#   tags = {
#     Name = "dev_test_ec2"
#   }
# }

resource "aws_instance" "vm_1" {
  ami           = "ami-04d7825822fe66af3"
  instance_type = "t3.micro"
  key_name      = "vockey"
  get_password_data = true
  vpc_security_group_ids = ["${aws_security_group.sg_1.id}"]
  subnet_id              = aws_subnet.subnet_1.id

  iam_instance_profile = aws_iam_instance_profile.profile.name

  tags = {
    Name = "win_1"
  }
}

resource "aws_instance" "vm_2" {
  ami           = "ami-04d7825822fe66af3"
  instance_type = "t3.micro"
  key_name      = "vockey"
  get_password_data = true
  vpc_security_group_ids = ["${aws_security_group.sg_1.id}"]
  subnet_id              = aws_subnet.subnet_1.id

  iam_instance_profile = aws_iam_instance_profile.profile.name

  tags = {
    Name = "win_2"
  }
}

# resource "aws_ebs_volume" "ebs_volume" {
#   availability_zone    = aws_instance.vm_1.availability_zone
#   size                 = 10
#   type                 = "io1"
#   iops                 = 100
#   multi_attach_enabled = true
# }

# resource "aws_volume_attachment" "ebs_attachment_vm_1" {
#   device_name = "/dev/sdf"
#   volume_id   = aws_ebs_volume.ebs_volume.id
#   instance_id = aws_instance.vm_1.id
# }

# resource "aws_volume_attachment" "ebs_attachment_vm_2" {
#   device_name = "/dev/sdf"
#   volume_id   = aws_ebs_volume.ebs_volume.id
#   instance_id = aws_instance.vm_2.id
# }

