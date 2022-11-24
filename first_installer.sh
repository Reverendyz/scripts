#!/bin/bash

main(){
    get_packages
    add_sources
    apt update
    docker_install
    ftkimager_install
    kubectl_install
    minikube_install
    powershell_install
    cleanup
}

get_packages(){
    wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    curl -sLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -sLO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
}

add_sources(){
    echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    apt install terraform -y
}

docker_install(){
    mkdir -p /etc/apt/keyrings
    chmod a+r /etc/apt/keyrings/docker.gpg
    apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
}

ftkimager_install(){
    curl -sLO "https://d1kpmuwb7gvu1i.cloudfront.net/ftkimager.3.1.1_ubuntu64.tar.gz" && \
    tar -zxvf ftkimager.3.1.1_ubuntu64.tar.gz && \
    install ftkimager /usr/local/bin/
}

kubectl_install(){
    if `echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check` == 'OK'; then
      install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    fi
}

minikube_install(){
    install minikube-linux-amd64 /usr/local/bin/minikube
}

powershell_install(){
    dpkg -i packages-microsoft-prod.deb
    apt install -y powershell
}

cleanup(){
    for file in `ls | grep -Ev ".sh$"`; do
        rm -f $file
    done
}

main