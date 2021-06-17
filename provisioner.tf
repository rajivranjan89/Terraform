# local-exec provisioner helps run a script on instance where we are running our terraform code, not on the resource we are creating.

resource "aws_instance" "testInstance" {
  ami           = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${aws_subnet.subnet_public.id}"
  vpc_security_group_ids = ["${aws_security_group.sg_22.id}"]
  key_name = "${aws_key_pair.ec2key.key_name}"
tags {
        "Environment" = "${var.environment_tag}"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.testInstance.public_ip} >> public_ip.txt"
  }
    provisioner "local-exec" {
    command    = "echo The server's IP address is ${self.private_ip}"
    on_failure = continue
    }
}


# remote-exec provisioner helps invoke a script on the remote resource once it is created. 

provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
    ]
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    private_key = "${file("~/.ssh/id_rsa")}"
  }
}


# File-provisioner used to perform operation related to file

provisioner "file"
{
  source = ""
  destination = ""
}
