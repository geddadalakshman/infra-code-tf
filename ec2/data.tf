data "aws_caller_identity" "current" {}

data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "devops-ansible"
  owners           = [ data.aws_caller_identity.current.account_id]
}