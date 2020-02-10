.PHONY: default, bootstrap, start, lint

default: lint

bootstrap:
	cd terraform && make bootstrap

start:
	cd terraform && make start

lint:
	cd terraform && make lint
