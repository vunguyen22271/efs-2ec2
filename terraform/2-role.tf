# Purpose: Create an IAM role and attach the AmazonSSMManagedInstanceCore policy to it.
resource "aws_iam_role" "role" {
  name = "my_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# https://skundunotes.com/2023/08/27/provision-an-amazon-ec2-instance-with-session-manager-access-using-terraform/
resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "profile" {
  name = "my_profile"
  role = aws_iam_role.role.name
}


