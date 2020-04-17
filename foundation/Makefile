.PHONY: bootstrap, lint generate-key, packer-build \
	ansible-remote-provision distrobuilder-bootstrap \
	distrobuilder-package distrobuilder-generate-and-package

default: lint

# root (core)
bootstrap:
	make generateKey

lint:
	@echo


# root (misc)
keyFileName = foundation.key
generate-host-key:
ifeq ("$(wildcard $(keyFileName))","")
	ssh-keygen -t ed25519 -f ${keyFileName}
endif
	cp ${keyFileName}.pub packer/ansible-local/roles/common/files/${keyFileName}.pub
	cp ${keyFileName} ansible-remote/${keyFileName}
	cp ${keyFileName} ansible-local/${keyFileName}

generate-guest-keys:
	./generateKeys.sh


# packer
packer-build:
	cd packer && rm -rf artifacts/
	cd packer && packer build ubuntu.json
	cd packer && touch artifacts/.gitkeep


# ansible-remote
ansible-remote-provision:
	cd ansible-remote && ansible-playbook -i inventory.ini \
		--extra-vars "rootPassword='$$rootPassword' opsPassword='$$opsPassword'" \
		--private-key "foundation.key" \
		./playbook.yml


# distrobuilder
distrobuilder-generate:
	cd distrobuilder && test -d rootfs && sudo rm -rf rootfs && mkdir rootfs || true
	cd distrobuilder && sudo distrobuilder build-dir distrobuilder.yaml rootfs

distrobuilder-package:
# packaged image will be imported to lxc via ansible
	cd distrobuilder && sudo distrobuilder pack-lxd distrobuilder.yaml rootfs/ artifacts/

distrobuilder-generate-and-package:
	cd distrobuilder && sudo distrobuilder build-lxd distrobuilder.yaml artifacts/
