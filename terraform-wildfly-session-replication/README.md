```
1. Make sure Ansible is installed on the Terraform-Server from where you are running this terraform script.
2. Before running the terraform script provide 600 permission to testkey.pem file using the command chmod 600 testkey.pem. The testkey.pem file contain the private key.
3. Provide public key into the file user_data.sh and necessary details into the file terraform.tfvars.
4. After successfully running the terraform script an Ansible inventory file named as hosts will be generated inside the directory named as main where playbook.yaml file is present.
```
