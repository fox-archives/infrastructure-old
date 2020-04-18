#!/bin/bash -eu

# 1.
# ensure that the soft links under ./ansible-remote/roles/lxd/files/*.key.pub
# actually link to the proper files in `/ordinal`. if they are not, you
# must create them with a make command in `/ordinal`
configSpecifyingContainerNames="./ansible-remote/roles/lxd/vars/main.yml"
json="$(python -c "import json,yaml; print(json.dumps(yaml.safe_load(open(\"$configSpecifyingContainerNames\", \"r\").read())))")"

allOrdinalKeysExist="yes"

readarray -t containerNames < <(echo "$json" | jq -c '.containers[].name' | sed s/\\\"//g)
for containerName in "${containerNames[@]}"
do
    keyFileName="./ansible-remote/roles/lxd/files/$containerName.key.pub"

    test ! -e "$keyFileName" && allOrdinalKeysExist="no"
done

if [ $allOrdinalKeysExist == "no" ]
then
  echo "PREREQUISITE 1: NOT SATISFIED. ensure you have created the \
public keys for the \`ordinal\` lxd containers. check this script for details"
  exit 1
else
  echo "PREREQUISITE 1: SATISFIED"
fi


# 2.
# ensure the soft links
# `ansible-remote/roles/distrobuilder/files/{lxd.tar.xz,rootfs.squashfs}`
# are actually valid. if not, you must run a 'distrobuilder' make
# command in `/ordinal`
files=(./ansible-remote/roles/distrobuilder/files/{lxd.tar.xz,rootfs.squashfs})
for file in "${files[@]}"
do
  test ! -e "$file" && (echo "PREREQUISITE 2: NOT SATISFIED. ensure you have created \
the base system (with distrobuilder) for the \`ordinal\` lxd containers. check this \
script for details"; exit 1)
done
echo "PREREQUISITE 2: SATISFIED"
