include {
    path = find_in_parent_folders()
}

terraform {
  source = "../../modules/ec2"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
    vpc_id = dependency.vpc.outputs.vpc_id
    subnet_id = dependency.vpc.outputs.subnet_id
    security_group_id = dependency.vpc.outputs.security_group_id
}


