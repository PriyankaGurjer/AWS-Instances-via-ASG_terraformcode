resource "aws_launch_template" "myfoo" {
  name_prefix   = "myfoo"
  image_id      = "ami-03ededff12e34e59e"
  instance_type = "t2.micro"
}
 
resource "aws_autoscaling_group" "aws_bar" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
 
  launch_template {
    id      = aws_launch_template.myfoo.id
    version = "$Latest"
  }
}
resource "aws_autoscaling_schedule" "sc_dw" {
  scheduled_action_name = "sc_dw"
  min_size = 1
  max_size = 1
  recurrence = "0 10 * * *"
  desired_capacity = 1
  autoscaling_group_name = "${aws_autoscaling_group.aws_bar.name}"
}
resource "aws_autoscaling_schedule" "scale_up" {
  scheduled_action_name = "scale_up"
  min_size = 2
  max_size = 2
  recurrence = "10 10 * * *"
  desired_capacity = 2
  autoscaling_group_name = "${aws_autoscaling_group.aws_bar.name}"
}
