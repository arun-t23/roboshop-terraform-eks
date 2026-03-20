## MOngodb SG RULES: ####

resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id ## traffic to Database mongodb from bastion
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

## REDIS SG_RULES ##

resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  security_group_id = local.redis_sg_id ## traffic to Database redis from bastion
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}



#### MYSQL SG RULES ###

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  security_group_id = local.mysql_sg_id ## traffic to Database mysql from bastion
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}


#### RABBITMQ SG RULES #####

resource "aws_security_group_rule" "rabbitmq_bastion" {
  type              = "ingress"
  security_group_id = local.rabbitmq_sg_id ## traffic to Database rabbitmq from bastion
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}




### THIS IS A MISTAKE THE CART, IF IT WANTS TO CONNECT TO CATALOGUE IT HAS TO CONNECT THROUGH BACKEND ALB , they cannot have direct connection because there might be multiple catalogue servers not one

# resource "aws_security_group_rule" "catalogue_cart" {
#   type              = "ingress"
#   security_group_id = local.catalogue_sg_id
#   source_security_group_id  = local.cart_alb_sg_id
#   from_port         = 8080
#   protocol          = "tcp"
#   to_port           = 8080
# }


#### USER SG RULES ######$$$



#### CART SG RULES #######


##### SHIPPING SG RULES ####



####### PAYMENT SG RULES ###########


######## BACKEND ALB SG RULES #######



### FRONTEND ALB SG RULES ######
resource "aws_security_group_rule" "ingress_alb_public" {
  type              = "ingress"
  security_group_id = local.ingress_alb_sg_id ## traffic to alb from public
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

##### BASTION SG RULES ####

resource "aws_security_group_rule" "bastion_laptop" {
    type              = "ingress"
  security_group_id = local.bastion_sg_id ## traffic to BAstion 
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

### OPENVPN SG RULES ###
resource "aws_security_group_rule" "open_vpn_public" {
  type              = "ingress"
  security_group_id = local.open_vpn_sg_id ## traffic to vpn from public
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "open_vpn_443" {
  type              = "ingress"
  security_group_id = local.open_vpn_sg_id ## traffic to vpn from public
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

resource "aws_security_group_rule" "open_vpn_943" {
  type              = "ingress"
  security_group_id = local.open_vpn_sg_id ## traffic to vpn from public
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 943
  protocol          = "tcp"
  to_port           = 943
}

resource "aws_security_group_rule" "open_vpn_1194" {
  type              = "ingress"
  security_group_id = local.open_vpn_sg_id ## traffic to vpn from public
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 1194
  protocol          = "tcp"
  to_port           = 1194
}

# resource "aws_security_group_rule" "catalogue_vpn" {
#   type              = "ingress"
#   security_group_id = local.catalogue_sg_id ## traffic to vpn from public
#   source_security_group_id  = local.open_vpn_sg_id
#   from_port         = 22
#   protocol          = "tcp"
#   to_port           = 22
# }

# resource "aws_security_group_rule" "catalogue_vpn_8080" {
#   type              = "ingress"
#   security_group_id = local.catalogue_sg_id ## traffic to vpn from 8080
#   source_security_group_id  = local.open_vpn_sg_id
#   from_port         = 8080
#   protocol          = "tcp"
#   to_port           = 8080
# }

resource "aws_security_group_rule" "components_vpn" {
  for_each  = local.vpn_ingress_rules
  type              = "ingress"
  security_group_id = each.value.sg_id
  source_security_group_id  = local.open_vpn_sg_id
  from_port         = each.value.port
  protocol          = "tcp"
  to_port           = each.value.port
}

#### THESE ARE WRONG WE CANNOT ACCESS COMPONENTS DIRECTLY, THEY SHOULD ACCESS FROM BACKEND ALB

# resource "aws_security_group_rule" "cart_shipping" {
#   type              = "ingress"
#   security_group_id = local.cart_sg_id
#   source_security_group_id  = local.shipping_alb_sg_id
#   from_port         = 8080
#   protocol          = "tcp"
#   to_port           = 8080
# }

# resource "aws_security_group_rule" "user_payment" {
#   type              = "ingress"
#   security_group_id = local.user_sg_id
#   source_security_group_id  = local.payment_alb_sg_id
#   from_port         = 8080
#   protocol          = "tcp"
#   to_port           = 8080
# }
# resource "aws_security_group_rule" "cart_payment" {
#   type              = "ingress"
#   security_group_id = local.cart_sg_id
#   source_security_group_id  = local.payment_alb_sg_id
#   from_port         = 8080
#   protocol          = "tcp"
#   to_port           = 8080
# }



#### ALL connections from bastion to EKS

resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type              = "ingress"
  security_group_id = local.eks_control_plane_sg_id
  source_security_group_id  = local.bastion_sg_id
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

resource "aws_security_group_rule" "eks_node_bastion" {
  type              = "ingress"
  security_group_id = local.eks_node_sg_id
  source_security_group_id  = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

## EKS node can accept all traffic coming from Control plane
resource "aws_security_group_rule" "eks_node_eks_control_plane" {
  type              = "ingress"
  security_group_id = local.eks_node_sg_id
  source_security_group_id  = local.eks_control_plane_sg_id
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
}


## EKS Control plane can accept all traffic coming from EKS node
resource "aws_security_group_rule" "eks_control_plane_eks_node" {
  type              = "ingress"
  security_group_id = local.eks_control_plane_sg_id
  source_security_group_id  = local.eks_node_sg_id
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
}

### nodes allow traffic between each other for pod to pod communication, because pods can be in any node in VPC CIDR
resource "aws_security_group_rule" "eks_node_vpc" {
  type              = "ingress"
  security_group_id = local.eks_node_sg_id
  cidr_blocks       = ["10.0.0.0/16"]
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
}



