
verion ?= 1.1
repo ?= finaldie/skull
prefix = $(repo):$(version)

sha1 ?=
tag ?= test

all: debian ubuntu alpine

update_sha1:
	find . -name "Dockerfile" | xargs sed -i 's/SKULL_GITSHA1 .*/SKULL_GITSHA1 $(sha1)/g'

debian:
	docker build -t $(prefix)-$@ .

ubuntu:
	cd $@ && docker build -t $(prefix)-$@ .

alpine:
	cd $@ && docker build -t $(prefix)-$@ .

push:
	docker push $(repo):$(tag)

.PHONY: all update_sha1 debian ubuntu alpine

