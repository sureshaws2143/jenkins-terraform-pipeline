#!/bin/sh
yum -y update

# install docker
sudo yum -y install yum-utils device-mapper-persistent-data lvm2 epel-release
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker
#systemctl start docker
#systemctl enable docker
sudo service docker start
sudo chkconfig docker on

# install git
sudo yum -y install git

# install jenkins
sudo yum -y install java-1.8.0-openjdk.x86_64 wget
sudo cp /etc/profile /etc/profile_backup
sudo echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
sudo echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profilesource /etc/profile
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum -y install jenkins
sudo service jenkins start
sudo chkconfig jenkins on
sudo usermod -a -G docker jenkins
sudo usermod -a -G docker jenkins
sudo service firewalld start
sudo chconfig firewalld on
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --reload

# install aws cli
sudo yum -y install python-pip
sudo pip install --upgrade pip
sudo pip install awscli --upgrade --user
sudo echo "PATH=~/.local/bin:$PATH" >> ~/.bash_profile

# reboot
sudo reboot
