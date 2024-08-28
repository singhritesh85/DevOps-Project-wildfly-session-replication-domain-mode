
##############################Parameters to launch EC2#############################

region = "us-east-2"
instance_count = 3
provide_ami = {
  "us-east-1" = "ami-0a1179631ec8933d7"
  "us-east-2" = "ami-080e449218d4434fa"
  "us-west-1" = "ami-0e0ece251c1638797"
  "us-west-2" = "ami-086f060214da77a16"
}
#subnet_id = "subnet-03XXXXXXXXXXXXXXc"
#vpc_security_group_ids = ["sg-0XXXXXXXXXXXXX9"]
#cidr_blocks = ["0.0.0.0/0"]
instance_type = [ "t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge" ]
name = "Application-Server"

#vpc_id = "vpc-XXXXXXXXX"
kms_key_id = "arn:aws:kms:us-east-2:02XXXXXXXXX6:key/XXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"   ### Provide the ARN of KMS Key.

env = ["dev", "stage", "prod"]

################################Parameters to create NLB############################

network_loadbalancer_name = "wildfly-nlb"
internal = false
load_balancer_type = "network"
#subnets = ["subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXXX"]
#security_groups = ["sg-05XXXXXXXXXXXXXXc"]  ## Security groups are not supported for network load balancer
enable_deletion_protection = false
s3_bucket_exists = false   ### Select between true and false. It true is selected then it will not create the s3 bucket. 
s3_domain_bucket = "wildfly-domain" ### S3 Bucket into which the Access Log will be captured
#prefix = "network_loadbalancer_log_folder"
idle_timeout = 60
enabled = true
target_group_name = "appserver"
instance_port = 8085
instance_protocol = "TCP"          #####Don't use protocol when target type is lambda
target_type_nlb = ["instance", "ip", "lambda"]
vpc_id = "vpc-XXXXXXXXXXXX"
#ec2_instance_id = ""
###load_balancing_algorithm_type = ["round_robin", "least_outstanding_requests"]
healthy_threshold = 2
unhealthy_threshold = 2
timeout = 3
interval = 30
###healthcheck_path = "/"
ssl_policy = ["ELBSecurityPolicy-2016-08", "ELBSecurityPolicy-TLS-1-2-2017-01", "ELBSecurityPolicy-TLS-1-1-2017-01", "ELBSecurityPolicy-TLS-1-2-Ext-2018-06", "ELBSecurityPolicy-FS-2018-06", "ELBSecurityPolicy-2015-05"]
certificate_arn = "arn:aws:acm:us-east-2:02XXXXXXXXXXX6:certificate/XXXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
type = ["forward", "redirect", "fixed-response"]

############################### Parameters to create RDS #############################

  db_instance_count = 1
###  identifier = "dbinstance-1"
  db_subnet_group_name = "rds-subnetgroup"        ###  postgresql-subnetgroup
#  rds_subnet_group = ["subnet-XXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXX", "subnet-XXXXXXXXXXXXXX"]
#  read_replica_identifier = "dbinstance-readreplica-1"
  allocated_storage = 20
  max_allocated_storage = 100
#  read_replica_max_allocated_storage = 100
  storage_type = ["gp2", "gp3", "io1", "io2"]
#  read_replica_storage_type = ["gp2", "gp3", "io1", "io2"]
###  engine = ["mysql", "mariadb", "mssql", "postgres"]
###  engine_version = ["5.7.44", "8.0.33", "8.0.35", "8.0.36", "10.4.30", "10.5.20", "10.11.6", "10.11.7", "13.00.6435.1.v1", "14.00.3421.10.v1", "15.00.4365.2.v1", "14.9", "14.10", "14.11", "15.5", "16.1"] ### For postgresql select version = 14.9 and for MySQL select version = 5.7.44
  instance_class = ["db.t3.micro", "db.t3.small", "db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.t3.2xlarge"]
#  read_replica_instance_class = ["db.t3.micro", "db.t3.small", "db.t3.medium", "db.t3.large", "db.t3.xlarge", "db.t3.2xlarge"]
  rds_db_name = "jgroups"
###  username = "postgres"   ### For MySQL select username as admin and For PostgreSQL select username as postgres
  password = "Admin123"          ### "Sonar123" use this password for PostgreSQL
  parameter_group_name = ["default.mysql5.7", "default.postgres14"]
  multi_az = ["false", "true"]   ### select between true or false
#  read_replica_multi_az = false   ### select between true or false
#  final_snapshot_identifier = "database-1-final-snapshot-before-deletion"   ### Here I am using it for demo and not taking final snapshot while db instance is deleted
  skip_final_snapshot = ["true", "false"]
#  copy_tags_to_snapshot = true   ### Select between true or false
  availability_zone = ["us-east-2a", "us-east-2b", "us-east-2c"]
  publicly_accessible = ["true", "false"]  #### Select between true or false
#  read_replica_vpc_security_group_ids = ["sg-038XXXXXXXXXXXXc291", "sg-a2XXXXXXca"]
#  backup_retention_period = 7   ### For Demo purpose I am not creating any db backup.
  kms_key_id_rds = "arn:aws:kms:us-east-2:02XXXXXXXXXX6:key/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
#  read_replica_kms_key_id = "arn:aws:kms:us-east-2:027330342406:key/XXXXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXXXX"  ### I am not using any read replica here.
  monitoring_role_arn = "arn:aws:iam::02XXXXXXXXXX6:role/rds-monitoring-role"
###  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]   ### ["audit", "error", "general", "slowquery"]  for MySQL


