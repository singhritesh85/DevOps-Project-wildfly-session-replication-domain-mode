########################################### variables to launch EC2 ############################################################

variable "region" {
  type = string
  description = "Provide the AWS Region into which VPC to be created"
}

variable "instance_count" {
  description = "Provide the Instance Count"
  type = number
}

variable "provide_ami" {
  description = "Provide the AMI ID for the EC2 Instance"
  type = map
}

#variable "vpc_security_group_ids" {
#  description = "Provide the security group Ids to launch the EC2"
#  type = list
#}

#variable "subnet_id" {
#  description = "Provide the Subnet ID into which EC2 to be launched"
#  type = string
#}

#variable "cidr_blocks" {
#  description = "Provide the CIDR Block range"
#  type = list
#}

#variable "vpc_id" {
#  description = "Provide the VPC ID into which EC2 to be launched"
#  type = string
#}

variable "instance_type" {
  description = "Provide the Instance Type"
  type = list
}

variable "kms_key_id" {
  description = "Provide the KMS Key ID to Encrypt EBS"
  type = string
}

variable "name" {
  description = "Provide the name of the EC2 Instance"
  type = string
}

variable "env" {
  type = list
  description = "Provide the Environment for AWS Resources to be created"
}

################################################## Variables to create NLB for Network Server ######################################################

variable "network_loadbalancer_name" {
  description = "Provide the Network Loadbalancer Name"
  type = string
}
variable "internal" {
  description = "Whether the lodbalancer is internet facing or internal"
  type = bool
}
variable "load_balancer_type" {
  description = "Provide the type of the loadbalancer"
  type = string
}
#variable "subnets" {
#  description = "List of subnets for Loadbalancer"
#  type = list
#}
#variable "security_groups" {     ## Security groups are not supported for network load balancers
#  description = "List of security Groups for Loadbalancer"
#  type = list
#}
variable "enable_deletion_protection" {
  description = "To disavle or enable the deletion protection of loadbalancer"
  type = bool
}
variable "s3_bucket_exists" {
  description = "Create S3 bucket only if doesnot exists."
  type = bool
}
variable "s3_domain_bucket" {
  description = "S3 bucket for Wildfly domain discovery"
  type = string
}
#variable "prefix" {
#  description = "Provide the s3 bucket folder name"
#  type = string
#}
variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type = number
}
variable "enabled" {
  description = "To capture access log into s3 bucket or not"
  type = bool
}
variable "target_group_name" {
  description = "Provide Target Group Name for Network Loadbalancer"
  type = string
}
variable "instance_port" {    #### Don't apply when target_type is lambda
  description = "Instance Port on which Network will run"
  type = number
}
variable "instance_protocol" {          #####Don't use protocol when target type is lambda
  description = "The protocol to use for routing traffic to the targets."
  type = string
}
variable "target_type_nlb" {
  description = "Select the target type of the Network LoadBalancer"
  type = list
}
variable "vpc_id" {
  description = "The identifier of the VPC in which to create the target group."
  type = string
}
###variable "load_balancing_algorithm_type" {
###  description = "Determines how the load balancer selects targets when routing requests. Only applicable for Network Load Balancer Target Groups."
###  type = list
###}
variable "healthy_threshold" {
  description = "Provide healthy threshold in seconds, the number of checks before the instance is declared healthy"
  type = number
}
variable "unhealthy_threshold" {
  description = "Provide unhealthy threshold in seconds, the number of checks before the instance is declared unhealthy"
  type = number
}
###variable "healthcheck_path" {
###  description = "Provide the health check path"
###  type = string
###}
#variable "ec2_instance_id" {
#  description = "Provide the EC2 Instance ID which is to be attached to the Target Group"
#  type = list
#}
variable "timeout" {
  description = "Provide the timeout in seconds, the length of time before the check times out."
  type = number
}
variable "interval" {
  description = "The interval between checks."
  type = string
}
variable "ssl_policy" {
  description = "Select the SSl Policy for the Network Loadbalancer"
  type = list
}
variable "certificate_arn" {
  description = "Provide the SSL Certificate ARN from AWS Certificate Manager"
  type = string
}
variable "type" {
  description = "The type of routing action."
  type = list
}

#################################################### Variables for RDS #########################################################

###variable "identifier" {
###  description = "Provide the DB Instance Name"
###  type = string
###}
variable "db_subnet_group_name" {
  description = "Provide the Name for DB Subnet Group"
  type = string
}
#variable "rds_subnet_group" {
#  description = "Provide the Subnet IDs to create DB Subnet Group"
#  type = list
#}
variable "db_instance_count" {
  description = "Provide the number of DB Instances to be launched"
  type = number
}
#variable "read_replica_identifier" {
#  description = "Provide the Read-Replica DB Instance Name"
#  type = string
#}
variable "allocated_storage" {
  description ="Memory Allocated for RDS"
  type = number
}
variable "max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance"
  type = number
}
#variable "read_replica_max_allocated_storage" {
#  description = "The upper limit to which Amazon RDS Read Replica can automatically scale the storage of the DB instance"
#  type = number
#}
variable "storage_type" {
  description = "storage type of RDS"
  type = list
}
#variable "read_replica_storage_type" {
#  description = "storage type of RDS Read Replica"
#  type = string
#}
###variable "engine" {
###  description = "Engine of RDS"
###  type = list
###}
###variable "engine_version" {
###  description = "Engine Version of RDS"
###  type = list
###}
variable "instance_class" {
  description = "DB Instance Type"
  type = list
}
#variable "read_replica_instance_class" {
#  description = "DB Instance Type of Read Replica"
#  type = list
#}
variable "rds_db_name" {
  description = "Provide the DB Name"
  type = string
}
###variable "username" {
###  description = "Provide the DB Instance username"
###  type = string
###}
variable "password" {
  description = "Provide the Password of DB Instance"
  type = string
}
variable "parameter_group_name" {
  description = "Parameter Group Name for RDS"
  type = list
}
variable "multi_az" {
  description = "To enable or disable multi AZ"
  type = list
}
#variable "read_replica_multi_az" {
#  description = "To enable or disable multi AZ"
#  type = list
#}
#variable "final_snapshot_identifier" {
#  description = "Provide the Final Snapshot Name"
#  type = string
#}
variable "skip_final_snapshot" {
  description = "To skip Final Snapshot before deletion"
  type = list
}
#variable "copy_tags_to_snapshot" {
#  description = "Copy Tags to Final Snapshot"
#  type = list
#}
variable "availability_zone" {
  description = "Availabilty Zone of the RDS DB Instance"
  type = list
}
variable "publicly_accessible" {
  description = "To make RDS publicly Accessible or not"
  type = list
}
#variable "read_replica_vpc_security_group_ids" {
#  description = "List of VPC security groups to br associated with RDS Read Replica"
#  type = list
#}
#variable "backup_retention_period" {
#  description = "The days to retain backups for. Must be between 0 and 35"
#  type = list
#}
variable "kms_key_id_rds" {
  description = "ARN of Kms Key Id to encrypt the RDS Volume"
  type = string
}
#variable "read_replica_kms_key_id" {
#  description = "ARN of Kms Key Id to encrypt the RDS Volume of Read Replica"
#  type = string
#}
variable "monitoring_role_arn" {
  description = "ARN of IAM Role to enable enhanced monitoring"
  type = string
}
###variable "enabled_cloudwatch_logs_exports" {
###  description = "Which type of Logs to enable"
###  type = list
###}
