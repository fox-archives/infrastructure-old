.PHONY: bootstrap

keyFileName = foundation.key

bootstrap: generateKey

generateKey:
ifeq ("$(wildcard $(keyFileName))","")
	ssh-keygen -t ed25519 -f ${keyFileName}
endif
	cp ${keyFileName}.pub ansible-local/roles/common/files/${keyFileName}.pub
	cp ${keyFileName} ansible-remote/${keyFileName}

build-foundation:
	rm -rf artifacts/
	packer build ubuntu.json

provision-foundation:
	ansible-playbook -i ansible-remote/inventory.ini \
		./ansible-remote/playbook.yml
