#!/bin/sh -ue

prefix="[CORSAC]"

# prep
echo "$prefix updating package sources"
sudo apt-get update -y

# install make
if command -v make >/dev/null
then
  echo "$prefix make already installed"
else
  echo "$prefix installing make"
  sudo apt-get install -y make

fi

# install ansible
if command -v ansible >/dev/null
then
  echo "$prefix ansible already installed"
else
  echo "$prefix installing ansible"
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository -yu ppa:ansible/ansible
  sudo apt-get install -y ansible

fi

# install terraform
if command -v terraform >/dev/null
then
  echo "$prefix terraform already installed"
else
  echo "$prefix installing terraform"

  # need unzip
  if command -v unzip >/dev/null
  then
    echo "$prefix unzip already installed"
  else
    echo "$prefix installing unzip"
    sudo apt-get install -y unzip
  fi

  terraformVersion="0.12.20"
  wget -nv https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip
  unzip terraform_${terraformVersion}_linux_amd64.zip -d .tmp.terraform
  chmod +x .tmp.terraform/*
  sudo mv -f .tmp.terraform/* /usr/local/bin
  rmdir .tmp.terraform/
  rm -f terraform_${terraformVersion}_linux_amd64.zip
fi

# install terraform-provider-lxd
if [ -e "$HOME/.terraform.d/plugins/linux_amd64/terraform-provider-lxd" ]
then
  echo "$prefix terraform-provider-lxd already installed"
else
  echo "$prefix installing terraform-provider-lxd"

  terraformProviderLxdVersion="v1.3.0"
  wget -nv https://github.com/sl1pm4t/terraform-provider-lxd/releases/download/${terraformProviderLxdVersion}/terraform-provider-lxd_${terraformProviderLxdVersion}_linux_amd64.zip
  unzip terraform-provider-lxd_${terraformProviderLxdVersion}_linux_amd64.zip -d .tmp.tlxd
  chmod +x .tmp.tlxd/*
  mkdir -p "$HOME/.terraform.d/plugins/linux_amd64"
  mv -f .tmp.tlxd/* "$HOME/.terraform.d/plugins/linux_amd64/terraform-provider-lxd"
  rmdir .tmp.tlxd/
  rm -f terraform-provider-lxd_${terraformProviderLxdVersion}_linux_amd64.zip
fi

# install docker
if command -v docker >/dev/null
then
  echo "$prefix docker already installed"
else
  echo "$prefix installing docker"

  sudo apt-get install \
    -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    -yu "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get install docker-ce docker-ce-cli containerd.io
fi

if command -v docker-compose >/dev/null
then
  echo "$prefix docker-compose already installed"
else
  echo "$prefix installing docker-compose"

  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

# install lxd
if command -v lxd >/dev/null
then
  echo "$prefix lxd already installed"
else
  echo "$prefix installing lxd"
  sudo snap install lxd
fi

# install distrobuilder
if command -v distrobuilder >/dev/null
then
  echo "$prefix distrobuilder already installed"
else
  echo "$prefix installing distrobuilder"
  sudo snap install distrobuilder --classic
fi

sudo apt-get autoremove -y
