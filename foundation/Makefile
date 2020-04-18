.PHONY: lint generate-key packer-build \
	ansible-remote-provision distrobuilder-bootstrap \
	distrobuilder-package distrobuilder-generate-and-package

default: lint

# root (core)
lint:
	@echo

generate-key:
	./generateKeys.sh


# packer
packer-build:
	cd packer && rm -rf artifacts/
	cd packer && packer build ubuntu.json
	cd packer && touch artifacts/.gitkeep


# ansible-remote
ansible-remote-provision:
	./checkPrerequisites.sh
	cd ansible-remote && ansible-playbook -i inventory.ini \
		--extra-vars "rootPassword='$$rootPassword' opsPassword='$$opsPassword'" \
		--private-key "../foundation.key" \
		./playbook.yml
