.PHONY: bootstrap

keyFilePath := ansible-local/roles/common/files/foundation.key

bootstrap:
ifeq ("$(wildcard $(keyFilePath))","")
	ssh-keygen -t ed25519 -f ${keyFilePath}
endif

local:
	packer build ubuntu.json
