.PHONY: default, bootstrap, start, lint

default:
	terraform plan

bootstrap:
	lxc init
	terraform init

start:
	terraform apply -auto-approve

lint:
	./lint.sh
