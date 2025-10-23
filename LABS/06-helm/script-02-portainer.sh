#!/bin/bash


helm repo add portainer https://portainer.github.io/k8s/
helm repo update

helm upgrade --install \
    --create-namespace -n portainer portainer portainer/portainer \
    --set tls.force=true \
    --set image.tag=lts

export NODE_PORT=$(kubectl get --namespace portainer -o jsonpath="{.spec.ports[0].nodePort}" services portainer)
export NODE_IP=$(kubectl get nodes --namespace portainer -o jsonpath="{.items[0].status.addresses[0].address}")
echo https://$NODE_IP:$NODE_PORT