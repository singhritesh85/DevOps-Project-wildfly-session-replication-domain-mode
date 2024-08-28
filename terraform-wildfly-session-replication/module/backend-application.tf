############################################################# Application Server ###################################################################

data "aws_subnet" "subnet-id" {
  filter {
    name   = "tag:Name"
    values = ["Public-1"]
  }

}

output "subnet_id" {
  value = data.aws_subnet.subnet-id.id
}

resource "aws_security_group" "appserversg" {
  name        = "ApplicationServerSecurityGroup"
  description = "Security Group for Application Server"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 8085
    to_port          = 8085
    protocol         = "tcp"
    cidr_blocks  = ["0.0.0.0/0"] 
  }

  ingress {
    from_port        = 9990
    to_port          = 9990
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 8443
    to_port          = 8443
    protocol         = "tcp"
    cidr_blocks      = ["172.31.0.0/16"]
  }
 
  ingress {
    from_port        = 7600
    to_port          = 7600
    protocol         = "tcp"
    cidr_blocks      = ["172.31.0.0/16"]
  }  

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ApplicationServer-SecurityGroup"
  }
}

resource "aws_instance" "appserver" {
  count         = var.instance_count
  ami           = var.provide_ami
  instance_type = var.instance_type
  monitoring = true
  vpc_security_group_ids = [aws_security_group.appserversg.id]  ### var.vpc_security_group_ids       ###[aws_security_group.all_traffic.id]
  subnet_id = data.aws_subnet.subnet-id.id                ### var.subnet_id
 
  user_data = file("user_data.sh")

  root_block_device{
    volume_type="gp2"
    volume_size="20"
    encrypted=true
    kms_key_id = var.kms_key_id
    delete_on_termination=true
  }

  ebs_block_device{
    device_name="/dev/xvdb"
    volume_type="gp2"
    volume_size="20"
    encrypted=true
    kms_key_id = var.kms_key_id
    delete_on_termination=true 
  }

  lifecycle{
    prevent_destroy=false
    ignore_changes=[ ami ]
  }

  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }

  metadata_options { #Enabling IMDSv2
    http_endpoint = "enabled"
    http_tokens   = "required"
    http_put_response_hop_limit = 2
  }

  tags={
    Name="${var.name}-${count.index + 1}"
    Environment = var.env
  }

}

resource "aws_eip" "eip_associate_appserver" {
  count  = var.instance_count
  domain = "vpc"     ###vpc = true
} 

resource "aws_eip_association" "eip_association_appserver" {  ### I will use this EC2 behind the NLB.
  count         = var.instance_count
  instance_id   = aws_instance.appserver[count.index].id
  allocation_id = aws_eip.eip_associate_appserver[count.index].id
}

resource "null_resource" "ansible_node1" {
  provisioner "local-exec" {
        interpreter = ["/bin/bash", "-c"]
        command = "echo [master] >> hosts"
  }
  depends_on = [aws_eip_association.eip_association_appserver]
}

resource "null_resource" "ansible_inventory1" {
  provisioner "local-exec" {
        interpreter = ["/bin/bash", "-c"]
        command = "echo ${aws_instance.appserver[0].private_ip} >> hosts"
  }
  depends_on = [aws_eip_association.eip_association_appserver, null_resource.ansible_node1]
}

resource "null_resource" "ansible_node2" {
  provisioner "local-exec" {
        interpreter = ["/bin/bash", "-c"]
        command = "echo [slave-1] >> hosts"
  }
  depends_on = [aws_eip_association.eip_association_appserver, null_resource.ansible_node1, null_resource.ansible_inventory1]
}

resource "null_resource" "ansible_inventory2" {
  provisioner "local-exec" {
        interpreter = ["/bin/bash", "-c"]
        command = "echo ${aws_instance.appserver[1].private_ip} >> hosts"
  }
  depends_on = [aws_eip_association.eip_association_appserver, null_resource.ansible_node1, null_resource.ansible_inventory1, null_resource.ansible_node2]
}

resource "null_resource" "ansible_node3" {
  provisioner "local-exec" {
        interpreter = ["/bin/bash", "-c"]
        command = "echo [slave-2] >> hosts"
  }
  depends_on = [aws_eip_association.eip_association_appserver, null_resource.ansible_node1, null_resource.ansible_inventory1, null_resource.ansible_node2, null_resource.ansible_inventory2]
}

resource "null_resource" "ansible_inventory3" {
  provisioner "local-exec" {
        interpreter = ["/bin/bash", "-c"]
        command = "echo ${aws_instance.appserver[2].private_ip} >> hosts"
  }
  depends_on = [aws_eip_association.eip_association_appserver, null_resource.ansible_node1, null_resource.ansible_inventory1, null_resource.ansible_node2, null_resource.ansible_inventory2, null_resource.ansible_node3]
}

resource "null_resource" "ansible" {
  provisioner "local-exec" {
        interpreter = ["/bin/bash", "-c"]
        command = "sleep 60 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./hosts  --user ritesh --private-key testkey.pem playbook.yaml"
  } 
  depends_on = [null_resource.ansible_inventory1, aws_eip_association.eip_association_appserver, null_resource.ansible_node1, null_resource.ansible_inventory2, null_resource.ansible_node2, null_resource.ansible_node3, null_resource.ansible_inventory3, null_resource.rds_endpoint1, null_resource.rds_endpoint2, aws_s3_bucket_policy.s3bucket_policy]
}
