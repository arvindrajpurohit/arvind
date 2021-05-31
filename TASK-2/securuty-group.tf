
resource "aws_security_group" "task2" {
  name_prefix = "task-2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group_rule" "allow-all" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  self = true
  security_group_id = aws_security_group.task2.id
  depends_on = [aws_security_group.task2]
     
}