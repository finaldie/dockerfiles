
version ?= 1.1
repo ?= finaldie/skull
prefix = $(repo):$(version)

sha1 ?=
tag ?= test

all: debian ubuntu alpine

update_sha1:
	find . -name "Dockerfile" -o -name "Dockerfile.build" | xargs sed -i 's/SKULL_GITSHA1 .*/SKULL_GITSHA1 $(sha1)/g'

debian-build:
	docker build -t $(prefix)-build . -f ./Dockerfile.build

debian: debian-build
	docker build -t $(prefix) .

ubuntu-build:
	cd ubuntu && docker build -t $(prefix)-$@ . -f ./Dockerfile.build

ubuntu: ubuntu-build
	cd ubuntu && docker build -t $(prefix)-$@ .

alpine-build:
	cd alpine && docker build -t $(prefix)-$@ . -f ./Dockerfile.build

alpine: alpine-build
	cd alpine && docker build -t $(prefix)-$@ .

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
.PHONY: debian-build debian ubuntu-build ubuntu alpine-build alpine
.PHONY: push clean help

