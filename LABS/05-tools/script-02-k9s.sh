#!/bin/bash

# DOCS
# https://k9scli.io/topics/install/
# https://github.com/derailed/k9s/releases

# SNAP
# sudo snap install k9s --devmode

# export TERM=xterm-256color
# export KUBE_EDITOR=kubectl

echo "export TERM=xterm-256color" >> ~/.bashrc
source ~/.bashrc

# UBUNTU con wget
mkdir $HOME/downloads
cd $HOME/downloads
wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb && sudo rm k9s_linux_amd64.deb

