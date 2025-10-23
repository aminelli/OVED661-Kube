#!/bin/bash

#####  KUBECTL #####  
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
sudo snap install kubectl --classic
# Copia "config" microk8s per kubectl
microk8s config > ~/.kube/config
kubectl version --client
kubectl cluster-info

