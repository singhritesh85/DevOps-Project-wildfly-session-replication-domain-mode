# DevOps-Project-wildfly-session-replication
![image](https://github.com/user-attachments/assets/265519a4-3efe-41d1-8768-9320eb624f44)

Using terraform script present in this repository I have created the infrastructure of EC2 Instances, S3 bucket, NLB and RDS. Ansible has been used as a configuration management tool. Before running the terraform script make sure Ansible is installed on your Terraform-Server. In this project I have used Wildfly-11 JBoss Application Server and MySQL 5.7 RDS. For Wildfly domain discovery S3 bucket has been used and MySQL database as a central point for cluster configuration.

After successfully creation of the infrastructure we will test MySQL database connection with slave-1 and slave-2 as shown in the screenshot below.

![image](https://github.com/user-attachments/assets/a74c655d-05d3-4338-90ff-11e763a8bbe4)
![image](https://github.com/user-attachments/assets/0c15ca06-008b-4ad3-bc6a-23559f855665)

After we will ensure everything is fine go fo the deployment of war file as shown in the screenshot below.

![image](https://github.com/user-attachments/assets/72024a81-d65a-45ed-951b-64183bb17efa)
![image](https://github.com/user-attachments/assets/c3c63cf8-39a8-44c6-9057-ca3feb9e1292)
![image](https://github.com/user-attachments/assets/47398af3-cd6b-4eab-85c4-8ca7459bfe99)
![image](https://github.com/user-attachments/assets/74c27264-1d84-4f09-9aa8-825e1daba5eb)
![image](https://github.com/user-attachments/assets/dc4de062-cac3-4c35-9907-781a27e93cfd)
![image](https://github.com/user-attachments/assets/78168822-fd36-41a6-8c34-e40d42292cfc)

