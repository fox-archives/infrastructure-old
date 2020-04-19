#!/bin/sh

hostname=foundation
keyFileName="$hostname.key"

if [ ! -r "$keyFileName" ] || [ ! -r "$keyFileName.pub" ]
then
  echo "creating ssh key for $hostname"
  ssh-keygen -t ed25519 -f "$keyFileName"
else
  echo "skipping generating $keyFileName as it already exists"
fi

ln -sf "../../../../../$keyFileName.pub" packer/ansible/roles/common/files/
ln -sf "../../$keyFileName" ansible/
