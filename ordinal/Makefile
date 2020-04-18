.PHONY: bootstrap ansible-remote-provision

bootstrap:
	./createLinks.sh

# ansible-remote
ansible-remote-provision:
	cd ansible-remote && ansible-playbook -i inventory.ini \
		--private-key "foundation.key" \
		./playbook.yml
