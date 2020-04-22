.PHONY: create-links ansible-provision

default: lint

# root (core)
lint:
	@echo

generate-keys:
	./generateKeys.sh
	./createLinks.sh


# distrobuilder
distrobuilder-generate:
	cd distrobuilder && test -d rootfs && sudo rm -rf rootfs && mkdir rootfs || true
	cd distrobuilder && sudo distrobuilder build-dir distrobuilder.yaml rootfs

distrobuilder-package:
# packaged image will be imported to lxc via ansible
	cd distrobuilder && sudo distrobuilder pack-lxd distrobuilder.yaml rootfs/ artifacts/

distrobuilder-generate-and-package:
	cd distrobuilder && sudo distrobuilder build-lxd distrobuilder.yaml artifacts/


# ansible
playbook ?= non
ansible-provision:
	cd ansible && ansible-playbook -i inventory.ini \
		--private-key ../primary.key \
		$(playbook).yml
