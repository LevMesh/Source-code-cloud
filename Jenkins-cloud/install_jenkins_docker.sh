#!/bin/bash


#################################################################
###################### Download Jenkins #########################
#################################################################

sudo amazon-linux-extras install java-openjdk11
sudo yum -y install wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins.service
##wget http://localhost:8080/jnlpJars/jenkins-cli.jar -- later on must work on installing plugins with jenkins-cli.jar file.

#################################################################
######################## Download Git ###########################
#################################################################

sudo yum install git -y

ssh-keygen

ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

sudo rpm -ivh https://github.com/aquasecurity/trivy/releases/download/v0.36.1/trivy_0.36.1_Linux-64bit.rpm

curl https://get.datree.io | /bin/bash

############# HELM


curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

helm plugin install https://github.com/datreeio/helm-datree

helm plugin update datree

#################################################################
####################### Download Docker #########################
#################################################################

sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo systemctl enable docker.service
sudo usermod -a -G docker ec2-user
sudo usermod -a -G docker jenkins

sudo reboot


###### Manual commands #######

###ssh-keygen -t rsa -N "" -C "" -f MYKEY
#ssh-keygen

#ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

#IMPORTANT NOTE!!~!!~!~~! 
#You must add the ssh key which is located in .ssh/id_rsa.pub inside into your github account by adding a new ssh key. 
#copy all files in ~.ssh/ to /var/lib/jenkins/.ssh/ AND give them permissions 
