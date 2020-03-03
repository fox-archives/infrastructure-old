.PHONY: default, bootstrap, start, lint

default:
	terraform plan

bootstrap:
	lxc init
	terraform init
	ssh-keygen -t ed25519 -f corsac-host.key -C 'ssh key for all corsac hosts'

start:
	terraform apply -auto-approve

lint:
	./lint.sh
