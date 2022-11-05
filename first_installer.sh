#!/bin/bash

curl -sLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

curl -sLO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

if [ `echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check` == 'OK' ]; then
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi

curl -sLO "https://d1kpmuwb7gvu1i.cloudfront.net/ftkimager.3.1.1_ubuntu64.tar.gz" && \
    tar -zxvf ftkimager.3.1.1_ubuntu64.tar.gz && \
    install ftkimager /usr/local/bin/