terraform {
  backend "local" {
    path = ".terraform/dev/stack-aaa.tfstate"
  }
}