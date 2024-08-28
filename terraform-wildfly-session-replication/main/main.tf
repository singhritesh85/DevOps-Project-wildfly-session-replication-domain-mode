module "network_server" {
source = "../module"

###########################Launch EC2 Instances###################################

  instance_count = var.instance_count
  provide_ami = var.provide_ami["us-east-2"]
  instance_type = var.instance_type[2]
#  vpc_security_group_ids = var.vpc_security_group_ids 
#  cidr_blocks = var.cidr_blocks
#  subnet_id = var.subnet_id
#  vpc_id = var.vpc_id
  kms_key_id = var.kms_key_id
  name = var.name
  
  env = var.env[0]

###########################To create NLB###################################

  network_loadbalancer_name = var.network_loadbalancer_name
  internal = var.internal
  load_balancer_type = var.load_balancer_type
#  subnets = var.subnets
#  security_groups = var.security_groups  ## Security groups are not supported for network load balancer
  enable_deletion_protection = var.enable_deletion_protection
  s3_bucket_exists = var.s3_bucket_exists
  s3_domain_bucket = var.s3_domain_bucket  ### S3 Bucket into which the Access Log will be captured
#  prefix = var.prefix
  idle_timeout = var.idle_timeout
  enabled = var.enabled
  target_group_name = var.target_group_name
  instance_port = var.instance_port
  instance_protocol = var.instance_protocol          #####Don't use protocol when target type is lambda
  target_type_nlb = var.target_type_nlb[0]
###  healthcheck_path = var.healthcheck_path
  vpc_id = var.vpc_id
#  ec2_instance_id = var.ec2_instance_id
###  load_balancing_algorithm_type = var.load_balancing_algorithm_type[0]
  healthy_threshold = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  timeout = var.timeout
  interval = var.interval
  ssl_policy = var.ssl_policy[0]
  certificate_arn = var.certificate_arn
  type = var.type

############################################### For RDS ##############################################################

#  count = var.db_instance_count
###  identifier = var.identifier
  db_subnet_group_name = var.db_subnet_group_name
#  rds_subnet_group = var.rds_subnet_group
#  read_replica_identifier = var.read_replica_identifier  ###  read_replica_identifier = "${var.read_replica_identifier}-${count.index + 1}"
  allocated_storage = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
#  read_replica_max_allocated_storage = var.read_replica_max_allocated_storage
  storage_type = var.storage_type[0]
#  read_replica_storage_type = var.read_replica_storage_type
###  engine = var.engine[3]             ### var.engine[0]  use for MySQL
###  engine_version = var.engine_version[2]       ### var.engine_version[0]  for MySQL
  instance_class = var.instance_class[0]
#  read_replica_instance_class = var.read_replica_instance_class
  rds_db_name = var.rds_db_name
###  username = var.username
  password = var.password
  parameter_group_name = var.parameter_group_name[1]
  multi_az = var.multi_az[0]
#  read_replica_multi_az = var.read_replica_multi_az
#  final_snapshot_identifier = var.final_snapshot_identifier
  skip_final_snapshot = var.skip_final_snapshot[0]
#  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  availability_zone = var.availability_zone[0]  ### It should not be enabled for Multi-AZ option, If it is not enabled for Single DB Instance then it's value will be taken randomly.
  publicly_accessible = var.publicly_accessible[1]
#  read_replica_vpc_security_group_ids = var.read_replica_vpc_security_group_ids
#  backup_retention_period = var.backup_retention_period
  kms_key_id_rds = var.kms_key_id_rds
#  read_replica_kms_key_id = var.read_replica_kms_key_id
  monitoring_role_arn = var.monitoring_role_arn
###  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

}
