# Docker Compose для приложения на Laravel

Образы:
 - PHP 8.3.4 (php:8.3.4-fpm)
 - Nginx (nginx:1.25.4-alpine)
 - MySQL 8.0 (mysql:8.0.33)
 - Node (node:21.7.1-alpine3.18)

## Установка
Путь до приложения внутри контейнера - `/var/www/app`. В файле `docker/dockerfiles/mysql/config/create_database.sql` настроить базу данных и пользователя.

### Установка проекта
1) Переименовать .env.example -> .env и изменить DOCKER_USER и COMPOSE_PROJECT_NAME.
2) Выполнить `make build` - создание контейнеров. Открыть в браузере http://localhost.

### Установка Laravel с помощью Makefile

1) Переименовать .env.example -> .env и изменить DOCKER_USER и COMPOSE_PROJECT_NAME.
2) Выполнить `make build` - создание контейнеров. Открыть в браузере http://localhost и проверить что все работает.
3) С включенным docker-compose, выполнить `sudo make laravel-install`. Будет удалена папка .git с данным репозиторием и скопирован проект Laravel в корень текущего проекта. Открыть в браузере http://localhost и проверить что работает фреймворк Laravel.
4) Скопировать настройки из файла .env-docker в файл .env для работы докера, удалить .env-docker
5) Настроить .env, пример в `.env.laravel-example`
6) Для работы vite необходимо добавить в vite.config.js:

````
export default defineConfig({
    server: {
        host: '0.0.0.0',
        hmr: {
            host: 'localhost',
        }
    },
    ...
````


