#!/bin/bash

# lanciare: source script-01-install.sh

# GUIDA Installazione 
# https://microk8s.io/

# GUIDA Linux di dettaglio
# https://microk8s.io/


# Installazione microk8s
sudo snap install microk8s --classic
microk8s status --wait-ready



#####  ALIAS MKCTL #####  
# alias mkctl="microk8s kubectl"
echo "alias mkctl='microk8s kubectl'" >> ~/.bashrc
source ~/.bashrc

