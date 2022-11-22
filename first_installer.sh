#!/bin/bash

curl -sLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

curl -sLO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"



mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
chmod a+r /etc/apt/keyrings/docker.gpg
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin


curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube

if `echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check` == 'OK'; then
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi

curl -sLO "https://d1kpmuwb7gvu1i.cloudfront.net/ftkimager.3.1.1_ubuntu64.tar.gz" && \
    tar -zxvf ftkimager.3.1.1_ubuntu64.tar.gz && \
    install ftkimager /usr/local/bin/
    