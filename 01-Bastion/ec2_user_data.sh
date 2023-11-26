#!/bin/bash


echo "Update Packages"
sudo apt-get update -y && sudo apt upgrade -y

echo "Installing AWS CLI"
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "Installing kubectl"

curl -LO "https://dl.k8s.io/release/v1.23.0/bin/darwin/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

echo "Installing ekctl"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
export PATH=$PATH:/usr/local/bin
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
eksctl version

# Para que docker ? 
# echo "Installing docker"
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo chmod +x get-docker.sh
# sudo bash get-docker.sh
# sudo groupadd docker
# sudo usermod -aG docker $USER
# docker --version

echo "Installing Helm"
wget https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz
tar xvf helm-v3.8.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin
helm version

echo "Installing terraform "
sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform

terraform -version



