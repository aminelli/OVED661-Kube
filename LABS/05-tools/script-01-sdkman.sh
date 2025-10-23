#!/bin/bash

sudo apt-get install -y zip unzip
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

# sdk install java 17.0.12-oracle
# sdk install java 21.0.8-oracle

# sdk install maven 3.9.11