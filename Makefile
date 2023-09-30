THIS_FILE := $(lastword $(MAKEFILE_LIST))
.PHONY: build rebuild rebuild-app up migrate migrate-rollback migrate-fresh migration route-list test composer-install composer-update composer-du npm-install npm-update npm-build npm-host
app := php-laravel-app
path := /var/www/laravel-app
app-npm := npm-laravel-app
#docker
build:
	docker-compose -f docker-compose.yml up --build -d $(c)
rebuild:
	docker-compose up -d --force-recreate --no-deps --build $(r)
rebuild-app:
	docker-compose up -d --force-recreate --no-deps --build $(app)
up:
	docker-compose -f docker-compose.yml up -d $(c)
laravel-install:
	docker exec $(app) composer create-project laravel/laravel laravel
	mv .env .env-docker
	mv README.md README-DOCKER.md
	rm -r public
	rm -r .git
	rm -r .env.example
	rm .gitignore
	mv laravel/* .

#laravel
migrate:
	docker exec $(app) php $(path)/artisan migrate
migrate-rollback:
	docker exec $(app) php $(path)/artisan migrate:rollback
migrate-fresh:
	docker exec $(app) php $(path)/artisan migrate:fresh --seed
migration:
	docker exec $(app) php $(path)/artisan make:migration $(m)
route-list:
	docker exec $(app) php $(path)/artisan route:list
test:
	docker exec $(app) php $(path)/artisan test
#composer
composer-install:
	docker exec $(app) composer install
composer-update:
	docker exec $(app) composer update
composer-du:
	docker exec $(app) composer du
#npm
npm-install:
	docker-compose run --rm --service-ports $(app-npm) install $(c)
npm-update:
	docker-compose run --rm --service-ports $(app-npm) update $(c)
npm-build:
	docker-compose run --rm --service-ports $(app-npm) run build $(c)
npm-host:
	docker-compose run --rm --service-ports $(app-npm) run dev --host $(c)