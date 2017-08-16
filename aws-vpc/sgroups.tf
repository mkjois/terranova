resource "aws_default_security_group" "allow_self" {
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    self = true
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
  tags {
    Name = "default-allow-self"
  }
}

resource "aws_security_group" "allow_all" {
  name = "default-allow-all"
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
    Name = "default-allow-all"
  }
}

resource "aws_security_group" "allow_http" {
  name = "default-allow-http"
  description = "Allow HTTP traffic"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
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
    Name = "default-allow-http"
  }
}

resource "aws_security_group" "allow_https" {
  name = "default-allow-https"
  description = "Allow HTTPS traffic"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
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
    Name = "default-allow-https"
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "default-allow-ssh"
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
    Name = "default-allow-ssh"
  }
}

resource "aws_security_group" "allow_icmp" {
  name = "default-allow-icmp"
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
    Name = "default-allow-icmp"
  }
}
