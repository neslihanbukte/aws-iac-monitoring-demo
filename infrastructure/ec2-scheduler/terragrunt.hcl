terraform {
  source = "../../modules/ec2-scheduler"
}

dependency "ec2" {
  config_path = "../ec2"
}

inputs = {
  instance_id  = dependency.ec2.outputs.web_instance_id
  instance_arn = dependency.ec2.outputs.web_instance_arn
}
