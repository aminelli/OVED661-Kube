#!/bin/bash

sudo usermod -a -G microk8s $USER
mkdir -p $HOME/.kube
chmod 0700 $HOME/.kube
sudo chown -R $USER ~/.kube

sudo microk8s status --wait-ready
sudo microk8s kubectl get nodes
sudo microk8s kubectl get services
sudo microk8s kubectl get pods

# mkdir -p ~/.kube
# chmod 0700 ~/.kube
