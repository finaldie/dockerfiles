
version ?= 0.9
repo ?= finaldie/dnsturbo
prefix = $(repo):$(version)

all: debian-build

debian-build: debian
	docker build -t $(prefix)-build . -f Dockerfile.build

debian:
	docker build -t $(prefix) .

push:
	docker push $(prefix)
	docker push $(prefix)-build

clean:
	docker image rm $(prefix)
	docker image rm $(prefix)-build

help:
	@echo "Usage:"
	@echo " - make"
	@echo " - make debian"
	@echo " - make push"
	@echo " - make clean"

