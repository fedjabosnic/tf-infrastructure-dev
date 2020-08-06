terraform {
  backend "local" {
    path = ".terraform/dev/stack-bbb.tfstate"
  }
}