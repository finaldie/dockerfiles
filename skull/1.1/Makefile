
version ?= 1.1
repo ?= finaldie/skull
prefix = $(repo):$(version)

sha1 ?=
tag ?= test

all: debian ubuntu alpine

update_sha1:
	find . -name "Dockerfile" | xargs sed -i 's/SKULL_GITSHA1 .*/SKULL_GITSHA1 $(sha1)/g'

debian-build:
	docker build -t $(prefix)-$@ -f ./Dockerfile.build

debian: debian-build
	docker build -t $(prefix)-$@ .

ubuntu-build:
	cd $@ && docker build -t $(prefix)-$@ -f ./Dockerfile.build

ubuntu: ubuntu-build
	cd $@ && docker build -t $(prefix)-$@ .

alpine-build:
	cd $@ && docker build -t $(prefix)-$@ -f ./Dockerfile.build

alpine: alpine-build
	cd $@ && docker build -t $(prefix)-$@ .

push:
	docker push $(prefix)-debian-build
	docker push $(prefix)-debian
	docker push $(prefix)-ubuntu-build
	docker push $(prefix)-ubuntu
	docker push $(prefix)-alpine-build
	docker push $(prefix)-alpine

help:
	@echo "Usage:"
	@echo " - make"
	@echo " - make update_sha1 sha1=abcd..."
	@echo " - make push tag_name"

.PHONY: all update_sha1 debian-build debian ubuntu-build ubuntu alpine-build alpine

