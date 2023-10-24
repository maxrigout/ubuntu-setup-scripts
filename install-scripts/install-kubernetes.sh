#!/bin/bash

echo "installing kubernetes"
#(requires docker first)
#https://kubernetes.io/docs/tasks/tools/#kubectl
# need to disable swap after reboot
sudo swapoff -a #use swapon -a to reenable it (see man swapoff)
sudo sed -i '/ swap / s/^/#/' /etc/fstab #after reboot
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://dl.k8s.io/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
# sudo apt-mark hold kubelet kubeadm kubectl