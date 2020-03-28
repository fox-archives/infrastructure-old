.PHONY: default, bootstrap, lint, generateKey, distrobuilder-bootstrap, distrobuilder-package-and-import, packer-base-build

default: lint

# root (core)
bootstrap:
	make generateKey
	cd distrobuilder
	cd packer
	cd terraform && lxc init
	cd terraform && terraform init

lint:
	cd terraform && ./lint.sh


# root (misc)
keyFileName = base.key
generateKey:
ifeq ("$(wildcard $(keyFileName))","")
	ssh-keygen -t ed25519 -f ${keyFileName} -C 'ssh key for a base host'
endif
	cp ${keyFileName}.pub packer/ansible-local/roles/common/files/
	cp ${keyFileName} terraform/
	@echo ensure you copy \`base.key\{,.pub\}\` to \`~/.ssh/config\` with the proper hostname


# distrobuilder
distrobuilder-bootstrap:
	cd distrobuilder && test -d rootfs && sudo rm -rf rootfs && mkdir rootfs || true
	cd distrobuilder && sudo distrobuilder build-dir distrobuilder.yaml rootfs

distrobuilder-package-and-import:
	cd distrobuilder && sudo distrobuilder pack-lxd distrobuilder.yaml rootfs/ artifacts/
	cd distrobuilder && lxc image delete corsac-ubuntu-image
	cd distrobuilder && lxc image import artifacts/lxd.tar.xz corsac-ubuntu-image/rootfs.squashfs --alias corsac-ubuntu-image


# packer
packer-base-build:
	cd packer && rm -rf artifacts/
	cd packer && packer build .
	cd packer && touch artifacts/.gitkeep


# terraform
