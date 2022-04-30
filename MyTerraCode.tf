resource  "aws_launch_template" "A"  {
  name_prefix   = "pg1"
  image_id      = "ami-02b92c281a4d3dc79"
  instance_type = "t2.micro"
  provider = aws.us
  user_data = "IyEvYmluL2Jhc2gKeXVtIHVwZGF0ZSAteQphbWF6b24tbGludXgtZXh0cmFzIGluc3RhbGwgbmdpbngxLjEyCm5naW54IC12CnN5c3RlbWN0bCBzdGFydCBuZ2lueApzeXN0ZW1jdGwgZW5hYmxlIG5naW54CmNobW9kIDI3NzUgL3Vzci9zaGFyZS9uZ2lueC9odG1sCmZpbmQgL3Vzci9zaGFyZS9uZ2lueC9odG1sIC10eXBlIGQgLWV4ZWMgY2htb2QgMjc3NSB7fSBcOwpmaW5kIC91c3Ivc2hhcmUvbmdpbngvaHRtbCAtdHlwZSBmIC1leGVjIGNobW9kIDA2NjQge30gXDsKZWNobyAiPGgzPlRoaXMgcmVzcG9uc2UgaXMgZnJvbSAkKGhvc3RuYW1lIC1mKS4gSGF2ZSBhIGdyZWF0IERheTwvaDM+IiA+IC91c3Ivc2hhcmUvbmdpbngvaHRtbC9pbmRleC5odG1s"
}
resource  "aws_launch_template" "B" {
  name_prefix   = "pg2"
  image_id      = "ami-0d2986f2e8c0f7d01"
  instance_type = "t2.micro"
  provider = aws.ap
  user_data = "IyEvYmluL2Jhc2gKeXVtIHVwZGF0ZSAteQphbWF6b24tbGludXgtZXh0cmFzIGluc3RhbGwgbmdpbngxLjEyCm5naW54IC12CnN5c3RlbWN0bCBzdGFydCBuZ2lueApzeXN0ZW1jdGwgZW5hYmxlIG5naW54CmNobW9kIDI3NzUgL3Vzci9zaGFyZS9uZ2lueC9odG1sCmZpbmQgL3Vzci9zaGFyZS9uZ2lueC9odG1sIC10eXBlIGQgLWV4ZWMgY2htb2QgMjc3NSB7fSBcOwpmaW5kIC91c3Ivc2hhcmUvbmdpbngvaHRtbCAtdHlwZSBmIC1leGVjIGNobW9kIDA2NjQge30gXDsKZWNobyAiPGgzPlRoaXMgcmVzcG9uc2UgaXMgZnJvbSAkKGhvc3RuYW1lIC1mKS4gSGF2ZSBhIGdyZWF0IERheTwvaDM+IiA+IC91c3Ivc2hhcmUvbmdpbngvaHRtbC9pbmRleC5odG1s"

}
 
resource "aws_autoscaling_group" "aws_bar_1" {
  availability_zones = ["us-west-2a"]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
  provider = aws.us
 
  launch_template {
    id      = aws_launch_template.A.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "aws_bar_2" {
  availability_zones = ["ap-south-1a"]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
  provider = aws.ap
 
  launch_template {
    id      = aws_launch_template.B.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_schedule" "sc_dw" {
  scheduled_action_name = "sc_dw"
  min_size = 1
  max_size = 2
  recurrence = "10 10 * * *"
  desired_capacity = 1
  autoscaling_group_name = "${aws_autoscaling_group.aws_bar_1.name}"
  provider = aws.us
}
resource "aws_autoscaling_schedule" "scale_up" {
  scheduled_action_name = "scale_up"
  min_size = 1
  max_size = 2
  recurrence = "10 10 * * *"
  desired_capacity = 1
  autoscaling_group_name = "${aws_autoscaling_group.aws_bar_2.name}"
  provider = aws.ap
}
