# DevOps-Project-wildfly-session-replication
![image](https://github.com/user-attachments/assets/e5e99fdb-34f5-487e-b6fd-13d8a27f10d7)

Using terraform script present in this repository I have created the infrastructure of EC2 Instances, NLB and RDS. Ansible has been used as a configuration management tool. Before running the terraform script make sure Ansible is installed on your Terraform-Server. In this project I have used Wildfly-11 JBoss Application Server and MySQL 5.7 RDS. For Wildfly domain discovery S3 bucket has been used and MySQL database as a central point for cluster configuration.
