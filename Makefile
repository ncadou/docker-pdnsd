#! make -f

__name__ := $(realpath $(lastword $(MAKEFILE_LIST)))
BASEDIR := $(patsubst %/,%,$(dir $(__name__)))

VOLUMES = /srv/docker/volumes
IMAGE = ncadou/pdnsd
CONTAINER = pdnsd
HOSTIP = $(shell ifconfig docker0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $$1 }')

export CONTAINER HOSTIP IMAGE VOLUMES

build:
	@cd $(BASEDIR); \
	docker build --rm -t $(IMAGE) .

rmi:
	@docker rmi $(IMAGE)

up::
	@test -d $(VOLUMES)/$(CONTAINER) || sudo mkdir -p $(VOLUMES)/$(CONTAINER)

shell: OPTIONS = --rm bash
up:: OPTIONS = -d

logs ps restart rm shell stop start up::
	@cd $(BASEDIR); \
	docker-compose $@ $(OPTIONS)

enter:
	@docker exec -it $(CONTAINER) bash
