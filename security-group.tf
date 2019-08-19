provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "jenkins-pipeline" {
  name        = "jenkins-pipeline"
  description = "built-by-jenkins-pipeline"
}
