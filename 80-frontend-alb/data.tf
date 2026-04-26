data "aws_ssm_parameter" "ingress_alb_certificate_arn" {
  name = "/${var.project_name}/${var.environment}/ingress_alb_certificate_arn"
}


data "aws_ssm_parameter" "private_subnet_ids"{
    name    =  "/${var.project_name}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "eks_node_sg_id" {
  name = "/${var.project_name}/${var.environment}/eks_node_sg_id" 
}

data "aws_ssm_parameter" "eks_control_plane_sg_id" {
  name = "/${var.project_name}/${var.environment}/eks_control_plane_sg_id" 
}

data "aws_ssm_parameter" "ingress_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/ingress_alb_sg_id" 
}

