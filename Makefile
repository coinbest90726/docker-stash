SHELL=/bin/bash

export HOST_UID := $(shell id -u)
export HOST_GID := $(shell id -g)
export UNAME_S := $(shell uname -s)
export IP := 127.0.0.1

default: run;

run: build up

#Build images
build:
	@docker-compose build

# Run the environment
up:
	@docker-compose up -d --remove-orphans

# Restart the environment
restart:
	@docker-compose restart

# Recreate environment (cleaning files)
recreate:
	@docker-compose up -d --force-recreate

# Destroy environment but without removing persistent data
destroy:
	@docker-compose stop
	@docker-compose rm -f

# Upgrade and run the environment
upgrade:
	@docker-compose pull
	@docker-compose up -d --remove-orphans

ssh:
	@docker exec -it -u=root psycho-logstash bash