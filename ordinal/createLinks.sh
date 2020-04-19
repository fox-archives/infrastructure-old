#!/bin/bash -eu

fileWithOrdinalContainerNames="../foundation/ansible/roles/lxd/vars/main.yml"
json="$(python -c "import json,yaml; print(json.dumps(yaml.safe_load(open(\"$fileWithOrdinalContainerNames\", \"r\").read())))")"

readarray -t containerNames < <(echo "$json" | jq -c '.containers[].name' | sed s/\\\"//g)
for containerName in "${containerNames[@]}"
do
    keyFileName="$containerName.key"
    echo "creating link to original $keyFileName file"

    ln -sf "../../foundation/$keyFileName" .
done
