resource "aws_security_group" "allow_all" {
  name = "allow-all"
  description = "Allow all traffic"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  tags {
    Name = "${var.name}-allow-all"
  }
}

resource "aws_security_group" "allow_http" {
  name = "allow-http"
  description = "Allow HTTP traffic"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  ingress {
    protocol = "tcp"
    from_port = 8080
    to_port = 8080
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  tags {
    Name = "${var.name}-allow-http"
  }
}

resource "aws_security_group" "allow_https" {
  name = "allow-https"
  description = "Allow HTTPS traffic"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  ingress {
    protocol = "tcp"
    from_port = 8443
    to_port = 8443
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  tags {
    Name = "${var.name}-allow-https"
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "allow-ssh"
  description = "Allow SSH traffic"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  tags {
    Name = "${var.name}-allow-ssh"
  }
}

resource "aws_security_group" "allow_icmp" {
  name = "allow-icmp"
  description = "Allow ICMP traffic"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    protocol = "icmp"
    from_port = -1
    to_port = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    protocol = "58"
    from_port = -1
    to_port = -1
    ipv6_cidr_blocks = [ "::/0" ]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  tags {
    Name = "${var.name}-allow-icmp"
  }
}
