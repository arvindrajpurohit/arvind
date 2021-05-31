### Launching EC2 Instance with nginx


resource "aws_instance" "nginx-server" {
  ami           = var.image_id
  instance_type = "t3.micro"
  subnet_id     = "${element(module.vpc.public_subnets, 0)}"
  security_groups= [aws_security_group.task2.id]
  key_name = "test"
  user_data     = <<EOT
 package_update: true  
 packages:
 - nginx


EOT

  tags = {
    Name = "nginx-server"
  }
}
  ### Launching  Instance with ES and Kibana

resource "aws_instance" "logs" {
  ami           = var.image_id
  instance_type = "t3.medium"
  subnet_id     = "${element(module.vpc.public_subnets, 0)}"
  security_groups= [aws_security_group.task2.id]
  key_name = "test"
  user_data     = <<EOT
  
#cloud-config
# update apt on boot
package_update: true
# install elasticsearch, Kibana
packages:
 - docker.io
runcmd: 
  - sudo docker network create es
  - sudo docker run -d --name elasticsearch -v elasticsearch:/usr/share/elasticsearch/data  --net es -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch:6.8.15
  - sudo docker run -d --name kibana   -v  kibana:/usr/share/kibana/data   --net es -p 5601:5601 kibana:6.8.15


  EOT

tags = {
    Name = "log-server"
  }
}
