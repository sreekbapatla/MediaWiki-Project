# Launch the instance
resource "aws_instance" "webserver1" {
  ami           = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  key_name = aws_key_pair.mykey.id
  vpc_security_group_ids = [aws_security_group.app-prod.id]
  subnet_id     = aws_subnet.mediawiki-public-1.id
  associate_public_ip_address = true
  tags = {
    Name = "webserver1"
    group = "web"
  }
}
resource "aws_instance" "webserver2" {
  ami           = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  key_name = aws_key_pair.mykey.id
  vpc_security_group_ids = [aws_security_group.app-prod.id]
  subnet_id     = aws_subnet.mediawiki-public-2.id
  associate_public_ip_address = true
  tags = {
    Name = "webserver2"
    group = "web"
  }
}
resource "aws_instance" "dbinstance" {
  ami           = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  key_name = aws_key_pair.mykey.id
  vpc_security_group_ids = [aws_security_group.allow-mariadb.id]
  subnet_id     = aws_subnet.mediawiki-private-1.id
  tags = {
    Name = "db-instance"
    group = "DB"
  }
}
resource "aws_elb" "mw_elb" {
  name = "MediaWikiELB"
  subnets         = [aws_subnet.mediawiki-public-1.id, aws_subnet.mediawiki-public-2.id]
  security_groups = [aws_security_group.elb-securitygroup.id]
  instances = [aws_instance.webserver1.id,aws_instance.webserver2.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}