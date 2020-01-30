#!/bin/sh -xe

# prep
sudo apt update -y

# install make
sudo apt-get install -y make

# install ansible
sudo apt-get install -y software-properties-common
sudo apt-add-repository -yu ppa:ansible/ansible
sudo apt-get install -y ansible
