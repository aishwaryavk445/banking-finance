resource "aws_instance" "test-server" {
  ami = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name = "Awskeypair"
  vpc_security_group_ids = ["sg-0c1bd65465cdf390f"]
  connection {
     type         = "ssh"
     user         = "ubuntu"
     host         = self.public_ip
}
provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance' "]
}
tags = {
  Name = "test-server"
  }
provisioner "local-exec" {
    command  = " echo ${aws_instance.test-server.public_ip} > inventory "
}
provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/banking-finance-project/my-server/finance-playbook.yml"
}
}
