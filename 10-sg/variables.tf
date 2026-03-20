variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable    "sg_names"{
    default =   [
        #databases
        "mongodb","mysql","redis","rabbitmq",
        # backend
        # "catalogue","user","cart","shipping","payment",
        # #frontend
        # "frontend",
        # #Bastion
        "bastion",
        # #load balancer
        "ingress_alb",
        # #backend-alb
        # "backend_alb",
        "open_vpn",
        "eks_control_plane",
        "eks_node"

    ]
}