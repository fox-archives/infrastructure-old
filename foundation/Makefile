.PHONY: bootstrap, lint, generateKey, packer-build, ansible-remote-provision

default: lint

# root (core)
bootstrap:
	make generateKey

lint:
	@echo

# root (misc)
keyFileName = foundation.key
generateKey:
ifeq ("$(wildcard $(keyFileName))","")
	ssh-keygen -t ed25519 -f ${keyFileName}
endif
	cp ${keyFileName}.pub packer/ansible-local/roles/common/files/${keyFileName}.pub
	cp ${keyFileName} ansible-remote/${keyFileName}


# packer
packer-build:
	cd packer && rm -rf artifacts/
	cd packer && packer build ubuntu.json
	cd packer && touch artifacts/.gitkeep


# ansible-remote
ansible-remote-provision:
	cd ansible-remote && ansible-playbook -i inventory.ini \
		--extra-vars "rootPassword='$$rootPassword' opsPassword='$$opsPassword'" \
		./playbook.yml
