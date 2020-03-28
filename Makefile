.PHONY: default, bootstrap lint

default: lint

bootstrap:
	cd foundation && make bootstrap
	cd base && make bootstrap

lint:
	cd base && make lint
