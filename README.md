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

After successfull deployment of war file to wildfly domain mode cluster do the entry of NLB DNS name into the Route53 hosted zone and create the record set as shown in the screenshot below. 

![image](https://github.com/user-attachments/assets/b6448ae7-70a7-4e7c-bf4a-143d89991508)

Access the Application's URL and open the web developer's tool and check the session Id. In web developer's tool if JSESSIONID ends with slave name as slave-1 then next time for the testing purpose stop slave-1 and refresh the page you will find JESSIONID value with same session id but different slave name as slave-2 and page count will be increased.

![image](https://github.com/user-attachments/assets/7f910d28-3b4f-4e22-9d0b-af3325439cb9)
![image](https://github.com/user-attachments/assets/a9b0dcd9-5763-4f5b-8bb5-54bb42733ff9)

Finally check the entry of the database jgroups and table as shown in the screenshot below.

![image](https://github.com/user-attachments/assets/96ffd096-4eaa-478b-9692-90c8e52c035c)

<br><br/>
<br><br/>
<br><br/>
<br><br/>
<br><br/>
<br><br/>
```
References:-       https://octopus.com/blog/wildfly-s3-domain-discovery
                   https://octopus.com/blog/wildfly-jdbc-ping
```
