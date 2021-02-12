
/*
  Create the VPC
*/
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Application" = "StackName"
    "Network" = "MGMT"
    "Name" = "VPCName"
  }
}

resource "aws_network_acl" "wideOpenAcl" {
  vpc_id = "${aws_vpc.main.id}"

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = "${var.egress_port}"
    to_port    = "${var.egress_port}"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = "${var.ingress_port}"
    to_port    = "${var.ingress_port}"
  }
}

# Modified [aws_two_tier.tf] on [2021-02-11 17:55:47.343937]