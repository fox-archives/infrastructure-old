.PHONY: bootstrap, generateKey, foundation-build, foundation-provision

bootstrap:
	make generateKey
	ansible-galaxy install -r ansible-remote/requirements.yml

keyFileName = foundation.key
generateKey:
ifeq ("$(wildcard $(keyFileName))","")
	ssh-keygen -t ed25519 -f ${keyFileName}
endif
	cp ${keyFileName}.pub ansible-local/roles/common/files/${keyFileName}.pub
	cp ${keyFileName} ansible-remote/${keyFileName}

foundation-build:
	rm -rf artifacts/
	packer build ubuntu.json
	touch artifacts/.gitkeep

foundation-provision:
	ansible-playbook -i ansible-remote/inventory.ini \
		--extra-vars "rootPassword='$$rootPassword' opsPassword='$$opsPassword'" \
		./ansible-remote/playbook.yml
