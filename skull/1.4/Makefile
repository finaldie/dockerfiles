
version ?= 1.4
repo ?= finaldie/skull
prefix = $(repo):$(version)

sha1 ?=
tag ?= test

all: debian-build ubuntu-build alpine-build

update_sha1:
	find . -name "Dockerfile" -o -name "Dockerfile.build" | xargs sed -i 's/SKULL_GITSHA1 .*/SKULL_GITSHA1 $(sha1)/g'

debian:
	docker build -t $(prefix) .

debian-build: debian
	docker build -t $(prefix)-build . -f ./Dockerfile.build

ubuntu:
	cd ubuntu && docker build -t $(prefix)-$@ .

ubuntu-build: ubuntu
	cd ubuntu && docker build -t $(prefix)-$@ . -f ./Dockerfile.build

alpine:
	cd alpine && docker build -t $(prefix)-$@ .

alpine-build: alpine
	cd alpine && docker build -t $(prefix)-$@ . -f ./Dockerfile.build

push:
	docker push $(prefix)-build
	docker push $(prefix)
	docker push $(prefix)-ubuntu-build
	docker push $(prefix)-ubuntu
	docker push $(prefix)-alpine-build
	docker push $(prefix)-alpine

clean:
	docker image rm $(prefix)-build
	docker image rm $(prefix)
	docker image rm $(prefix)-ubuntu-build
	docker image rm $(prefix)-ubuntu
	docker image rm $(prefix)-alpine-build
	docker image rm $(prefix)-alpine

help:
	@echo "Usage:"
	@echo " - make"
	@echo " - make update_sha1 sha1=abcd..."
	@echo " - make push tag_name"

.PHONY: all update_sha1
.PHONY: debian-build debian
.PHONY: ubuntu-build ubuntu
.PHONY: alpine-build alpine
.PHONY: push clean help

