.PHONY: default, bootstrap, start, lint

default: lint

bootstrap:
	cd foundation && make bootstrap
	cd distrobuilder make bootstrap
	cd terraform && make bootstrap

start:
	cd terraform && make start

lint:
	cd terraform && make lint
