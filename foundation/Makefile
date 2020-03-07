.PHONY: bootstrap, generateKey, foundation-build, foundation-provision

bootstrap:
	make generateKey
	ansible-galaxy install -r ansible-remote/requirements.yml

keyFileName = foundation.key
generateKey:
ifeq ("$(wildcard $(keyFileName))","")
	ssh-keygen -t ed25519 -f ${keyFileName}
endif
	cp ${keyFileName}.pub packer/ansible-local/roles/common/files/${keyFileName}.pub
	cp ${keyFileName} ansible-remote/${keyFileName}

foundation-build:
	cd packer && rm -rf artifacts/
	cd packer && packer build ubuntu.json
	cd packer && touch artifacts/.gitkeep

foundation-provision:
	cd ansible-remote && ansible-playbook -i inventory.ini \
		--extra-vars "rootPassword='$$rootPassword' opsPassword='$$opsPassword'" \
		./playbook.yml
