.PHONY: bootstrap

keyFilePath := ansible-local/roles/common/files/foundation.key

bootstrap:
ifeq ("$(wildcard $(keyFilePath))","")
	ssh-keygen -t ed25519 -f ${keyFilePath}
endif

build-ubuntu:
	rm -rf artifacts/
	packer build ubuntu.json

build-ubuntu-vagrant:
	vagrant up
	vagrant console
	make build-ubuntu
	vagrant destroy
