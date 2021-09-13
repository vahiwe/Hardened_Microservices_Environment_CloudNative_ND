#!/bin/bash

echo "[TASK 1] Install Docker" 
# install Docker
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt-get update
sudo apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
sudo usermod -G docker -a $USER
sudo usermod -G docker -a vagrant
sudo systemctl restart docker
# sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

echo "[TASK 2] Disable firewalld"
sudo systemctl stop firewalld
sudo systemctl disable firewalld

echo "[TASK 3] Disable apparmor"
sudo systemctl stop apparmor
sudo systemctl disable apparmor

echo "[TASK 4] Set up rke user"
sudo useradd rke
sudo usermod -a -G docker rke
sudo systemctl restart docker

echo "[TASK 5] Copy auth_keys for rke user"
sudo mkdir -p /home/rke/.ssh
sudo usermod -d /home/rke/ rke
sudo cp /home/vagrant/.ssh/authorized_keys /home/rke/.ssh
sudo chown rke /home/rke -R
