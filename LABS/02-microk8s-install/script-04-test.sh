#!/bin/bash


# Test
microk8s kubectl get all --all-namespaces
microk8s kubectl create deployment nginx --image nginx 
microk8s kubectl expose deployment nginx --port 80 --target-port 80 --selector app=nginx --type ClusterIP --name nginx
microk8s kubectl get all --all-namespaces
microk8s kubectl get all

# DASHBOARD: (model # https://[IP OR DNS OR HOSTNAME]:10443)
# https://132.164.250.156:10443

# microk8s kubectl -n kube-system get secret $(microk8s kubectl -n kube-system get sa default -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"


 