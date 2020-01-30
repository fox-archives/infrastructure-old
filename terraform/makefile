.PHONY: default, bootstrap

default:
	terraform plan

bootstrap:
	terraform init

lint:
	../bin/tflint -c .tflint.hcl
