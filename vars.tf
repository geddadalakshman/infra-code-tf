variable "instances" {
  default = {
    frontend = {
      name = "frontend"
      type = "t3.micro"
    }
    catalouge = {
      name = "catalouge"
      type = "t3.micro"
    }
  }
}

