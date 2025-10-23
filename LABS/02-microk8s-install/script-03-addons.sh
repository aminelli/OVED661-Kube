#!/bin/bash

# Addons List:
# https://microk8s.io/docs/addons#heading--list

# Enable Addons
microk8s enable community
microk8s enable dashboard
microk8s enable dns 
microk8s enable rbac
microk8s enable ingress
microk8s enable hostpath-storage
microk8s enable registry
microk8s enable metallb
microk8s enable cert-manager
microk8s enable istio

microk8s config > ~/.kube/config
# microk8s.kubectl config view > $HOME/.kube/config