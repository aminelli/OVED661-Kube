#!/bin/bash

# Generazione di un nuovo token per il service account "admin-user"

# microk8s kubectl -n kubernetes-dashboard create token admin-user
microk8s kubectl -n default create token admin-user

