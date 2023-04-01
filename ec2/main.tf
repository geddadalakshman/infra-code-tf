data "aws_caller_identity" "current" {}

data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-ansible"
  owners           = [ data.aws_caller_identity.current.account_id]
}

data "aws_route53_zone" "zone_id" {
  name         = "devops71.tech"
  private_zone = false
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.zone_id.zone_id
  name = "www.${data.aws_route53_zone.zone_id.name}"
  type    = "A"
  ttl     = 30
  records = [aws_instance.component.private_ip]
}

resource "aws_instance" "component" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.sg.id ]

  tags = {
    Name = var.component
  }
}

resource "aws_security_group" "sg" {
  name        = "${var.component}-sg"
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
    Name = "${var.component}-all_traffic"
  }
}



variable "instance_type" {}
variable "component" {}
