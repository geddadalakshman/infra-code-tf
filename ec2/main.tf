resource "aws_instance" "instance" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  iam_instance_profile = "${var.env}-${var.component}-profile"
  tags = {
    Name = "${ var.component }-${var.env}"
    Monitor = var.monitor ? "yes" : "no"
  }
}

resource "null_resource" "provisioner" {
  depends_on = [aws_route53_record.record]

  connection {
    host     = aws_instance.instance.public_ip
    user     = "centos"
    password = "DevOps321"
  }

  provisioner "remote-exec" {

    inline = [
      "ansible-pull -i localhost, -U https://github.com/geddadalakshman/infra-conf-ansible.git roboshop.yml -e role_name=${var.component}"
    ]
  }
}

#AWS Security-group
resource "aws_security_group" "sg" {
  name        = "${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-all_traffic"
  }
}

resource "aws_route53_record" "record" {
  zone_id = "Z10202231Q9C3TKFTZOQE"
  name    = "${var.component}-${var.env}.devops71.tech"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}

###IAM Policy creation
resource "aws_iam_policy" "ssm-policy" {
  name        = "${var.env}-${var.component}-ssm"
  path        = "/"
  description = "${var.env}-${var.component}-ssm"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": "arn:aws:ssm:us-east-1:820762291138:parameter/${var.env}.${var.component}*"
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": [
          "ssm:DescribeParameters",
          "ssm:ListAssociations"
        ],
        "Resource": "*"
      }
    ]
  })
}

#IAM role
resource "aws_iam_role" "role" {
  name = "${var.env}-${var.component}-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

#IAM instance profile
resource "aws_iam_instance_profile" "profile" {
  name = "${var.env}-${var.component}-profile"
  role = aws_iam_role.role.name
}

#IAM role_policy attachment
resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.ssm-policy.arn
}
