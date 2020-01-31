#!/bin/sh -ue

prefix="[CORSAC]"

# prep
echo "$prefix updating package sources"
sudo apt-get update -y

# install make
if [ "$(which unzip)" = "" ]
then
  echo "$prefix installing make"
  sudo apt-get install -y make
else
  echo "$prefix make already installed"
fi

# install ansible
if [ "$(which ansible)" = "" ]
then
  echo "$prefix installing ansible"
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository -yu ppa:ansible/ansible
  sudo apt-get install -y ansible
else
  echo "$prefix ansible already installed"
fi

# install terraform
if [ "$(which terraform)" = "" ]
then
  echo "$prefix installing terraform"

  # need unzip
  if [ "$(which unzip)" = "" ]
  then
    echo "$prefix installing unzip"
    sudo apt-get install -y unzip
  else
    echo "$prefix unzip already installed"
  fi

  terraformVersion="0.12.20"
  wget -nv https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip
  unzip terraform_${terraformVersion}_linux_amd64.zip -d .tmp.terraform
  chmod +x .tmp.terraform/*
  sudo mv -f .tmp.terraform/* /usr/local/bin
  rmdir .tmp.terraform/
  rm -f terraform_${terraformVersion}_linux_amd64.zip
else
  echo "$prefix terraform already installed"
fi

# install terraform-provider-lxd
if [ ! -e "$HOME/.terraform.d/plugins/linux_amd64/terraform-provider-lxd" ]
then
  echo "$prefix installing terraform-provider-lxd"

  terraformProviderLxdVersion="v1.3.0"
  wget -nv https://github.com/sl1pm4t/terraform-provider-lxd/releases/download/${terraformProviderLxdVersion}/terraform-provider-lxd_${terraformProviderLxdVersion}_linux_amd64.zip
  unzip terraform-provider-lxd_${terraformProviderLxdVersion}_linux_amd64.zip -d .tmp.tlxd
  chmod +x .tmp.tlxd/*
  mkdir -p "$HOME/.terraform.d/plugins/linux_amd64"
  mv -f .tmp.tlxd/* "$HOME/.terraform.d/plugins/linux_amd64/terraform-provider-lxd"
  rmdir .tmp.tlxd/
  rm -f terraform-provider-lxd_${terraformProviderLxdVersion}_linux_amd64.zip
else
  echo "$prefix terraform-provider-lxd already installed"
fi

# install docker
if [ "$(which docker)" = "" ]
then
  echo "$prefix installing docker"

  sudo apt-get install \
    -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    -yu "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get install docker-ce docker-ce-cli containerd.io
else
  echo "$prefix docker already installed"
fi

if [ "$(which docker-compose)" = "" ]
then
  echo "$prefix installing docker-compose"

  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
else
  echo "$prefix docker-compose already installed"
fi

# install lxd
if [ "$(which lxd)" = "" ]
then
  echo "$prefix installing lxd"
  sudo snap install lxd
else
  echo "$prefix lxd already installed"
fi

sudo apt-get autoremove -y
