data "aws_key_pair" "ssh-key" {
  key_name = "jenkinsec2keypair"
  filter {
    name   = "tag:KeyPair"
    values = ["JenkinsKey"]
  }
}
