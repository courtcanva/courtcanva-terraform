data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "jenkins-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "${var.instance_type}"

   tags = {
    Name = "jenkinsmaster"
  }

  # the VPC subnet
  subnet_id = aws_subnet.demo.*.id[0]

  # the security group
  vpc_security_group_ids = [aws_security_group.sg-jenkins.id]

# vailability zone
  availability_zone       = data.aws_availability_zones.available.names[0]

  # the public SSH key
  key_name = aws_key_pair.ssh-key.key_name
 
  associate_public_ip_address = true 


  # user data
  user_data = file("jenkins_init.sh")
  
  root_block_device {
    volume_type = "gp2"
    volume_size = "40"
  }
}
resource "aws_eip_association" "jenkins_eip_assos" {
  instance_id   = aws_instance.jenkins_host.id
  allocation_id = data.aws_eip.jenkins_eip.id
}


resource "aws_ebs_volume" "jenkins_volume_ebs" {
  availability_zone = "ap-southeast-2c"
  size              = "50"
  type              = "gp2"
  tags = {
    Name = "Jenknis"
  }
  lifecycle {
    prevent_destroy = false
  }

}
resource "aws_volume_attachment" "jenkins_volume_ebs_att" {
  device_name = "/dev/sdh"  #name seen in ebs volume, in ec2 it is "/dev/nvme1n1" 
  volume_id   = aws_ebs_volume.jenkins_volume_ebs.id
  instance_id = aws_instance.jenkins_host.id
}
