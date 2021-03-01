init: docker-down-clear \
	  app-clear \
	  docker-pull docker-build docker-up \
	  app-init

up: docker-up
down: docker-down
restart: down up

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

app-clear:
	docker run --rm -v ${PWD}:/app -w /app alpine sh -c 'rm -rf .ready build'

app-init: app-npm-install app-ready

app-npm-install:
	docker-compose run --rm node-cli npm install

app-ready:
	docker run --rm -v ${PWD}:/app -w /app alpine touch .ready
