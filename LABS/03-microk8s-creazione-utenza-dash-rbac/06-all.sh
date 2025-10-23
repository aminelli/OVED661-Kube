#!/bin/bash

# If RBAC is not enabled access the dashboard using the token 
# retrieved with:
# 
# microk8s kubectl describe secret -n kube-system 
# microk8s-dashboard-token
# 
# Use this token in the https login UI of the kubernetes-dashboard 
# service.
# 
# In an RBAC enabled setup (microk8s enable RBAC) you need to create 
# a user with restricted
# permissions as shown in:
# https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

microk8s kubectl apply -f 01-service-account.yaml
microk8s kubectl apply -f 02-cluster-role-binding.yaml
source ./03-generate-token.sh
microk8s kubectl apply -f 04-secret.yaml
source ./05-get-generate-token.sh

echo ""


