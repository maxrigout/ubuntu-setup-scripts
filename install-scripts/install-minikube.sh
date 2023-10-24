#!/bin/bash

echo "installing minikube"
# https://minikube.sigs.k8s.io/docs/start/
sudo apt install -y curl wget apt-transport-https
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube