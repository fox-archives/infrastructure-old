#!/bin/bash -eu

json="$(python -c "import json,yaml; print(json.dumps(yaml.safe_load(open(\"./ansible-remote/roles/lxd/vars/main.yml\", \"r\").read())))")"

readarray -t containerNames < <(echo "$json" | jq -c '.containers[].name' | sed s/\\\"//g)
for containerName in "${containerNames[@]}"
do
    keyFileName="$containerName.key"

    if [ ! -r "$keyFileName" ]
    then
      echo "createing ssh key for container \"$containerName\""
      ssh-keygen -t ed25519 -f "${keyFileName}"
    else
      echo "skipping generating $keyFileName as it already exists"
    fi

    echo "copying $keyFileName to directories"
    cp "$keyFileName.pub" "ansible-remote/roles/lxd/files"
done
