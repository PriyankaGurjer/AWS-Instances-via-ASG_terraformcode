provider "aws" {

  alias = "ap"

  access_key = "**********"

  secret_key = "*********"

  region = "ap-south-1"

}

provider "aws" {

  alias = "us"

  access_key = "*********"

  secret_key = "***************"

  region = "us-west-2"

}
