.PHONY: default, bootstrap

PATH := ../bin:$(PATH)

default:
	terraform plan

bootstrap:
	lxc init
	terraform init

# terraform lxd provider creates resources too fast after they are destroyed,
# failing to create because they 'already exist
apply:
	if ! ../bin/terraform apply; then sleep 1 && terraform apply -auto-approve; fi

lint:
	./lint.sh
