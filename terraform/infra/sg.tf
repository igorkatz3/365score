#SG
# add the below resources in the sg.tf file to create a new security group

resource "aws_security_group" "sg" {
  name        = "dev-sg"
  description = "dev-sg"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "dev-sg"
  }
}

resource "aws_security_group_rule" "ingress" {
  for_each = toset(var.allowed_ports)

  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = "tcp"
  cidr_blocks       = [var.dev_cidr]
  security_group_id = aws_security_group.sg.id
  description       = "Allow traffic on port ${each.key}"
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}