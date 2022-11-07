resource "aws_launch_configuration" Greenalytics{
  name_prefix = "${var.name_prefix}"
  image_id = "ami-062df10d14676e201" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
  instance_type = "t2.micro"
  key_name = "mumbai"

  security_groups = [ aws_security_group.allow_http.id ]
  associate_public_ip_address = true

  user_data = <<USER_DATA
#!/bin/bash
sudo apt-get update
sudo apt-get -y install nginx
echo "$(curl http://169.254.169.254/latest/meta-data/local-ipv4)" > /usr/share/nginx/html/index.html
chkconfig nginx on
service nginx start
  USER_DATA

  lifecycle {
    create_before_destroy = true
  }
}

