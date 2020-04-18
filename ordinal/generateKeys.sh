#!/bin/bash -eu

configSpecifyingContainerNames="../foundation/ansible-remote/roles/lxd/vars/main.yml"
json="$(python -c "import json,yaml; print(json.dumps(yaml.safe_load(open(\"$configSpecifyingContainerNames\", \"r\").read())))")"

readarray -t containerNames < <(echo "$json" | jq -c '.containers[].name' | sed s/\\\"//g)
for containerName in "${containerNames[@]}"
do
    keyFileName="$containerName.key"

    if [ ! -r "$keyFileName" ] || [ ! -r "$keyFileName.pub" ]
    then
      echo "creating ssh key for $containerName"
      ssh-keygen -t ed25519 -f "$keyFileName"
    else
      echo "skipping generating $keyFileName as it already exists"
    fi
done
