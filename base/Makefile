.PHONY: default, bootstrap, lint, base-build, generateKey

default: lint

bootstrap:
	make generateKey

lint:
	cd terraform && make lint

base-build:
	cd packer && rm -rf artifacts/
	cd packer && packer build .
	cd packer && touch artifacts/.gitkeep

keyFileName = base.key
generateKey:
ifeq ("$(wildcard $(keyFileName))","")
	ssh-keygen -t ed25519 -f ${keyFileName} -C 'ssh key for a base host'
endif
	cp ${keyFileName}.pub packer/ansible-local/roles/common/files
	@echo ensure you copy \`base.key\{,.pub\}\` to \`~/.ssh/config\` with the proper hostname
