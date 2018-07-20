
version ?= 0.6
repo ?= finaldie/dnsturbo
prefix = $(repo):$(version)

all: debian

debian:
	docker build -t $(prefix) .

push:
	docker push $(prefix)

clean:
	docker image rm $(prefix)

help:
	@echo "Usage:"
	@echo " - make"
	@echo " - make debian"
	@echo " - make push"
	@echo " - make clean"

