<h2>Docker Compose для приложения на Laravel:</h2>
<ul>
    <li>PHP 8.3.4 (php:8.3.4-fpm)</li>
    <li>Nginx (nginx:1.25.4-alpine)</li>
    <li>MySQL 8.0 (mysql:8.0.33)</li>
    <li>Node (node:21.7.1-alpine3.18)</li>
</ul>

<h2>Установка</h2>
По умолчанию контейнер с PHP называется laravel-app, путь до приложения внутри контейнера - /var/www/laravel-app<br><br>

В файле docker/volumes/MySQL/dump/mysql-init.sql настроить базу данных и пользователя, по умолчанию в файле используются:
<ul>
    <li>Database: my_database</li>
    <li>User: my_database</li>
    <li>Password: 12345</li>
</ul>

<h3>Установка с помощью Makefile</h3>

1) Переименовать .env.example -> .env и изменить DOCKER_USER и порты по желанию
2) Выполнить <code>make build</code> - создание контейнеров<br>
   Открыть в браузере http://localhost и проверить что все работает
4) Выполнить <code>sudo make laravel-install</code> - устновка последней версии Laravel с помощью Composer<br>
   Открыть в браузере http://localhost и проверить что работает фреймворк Laravel
5) Скопировать настройки из файла .env-docker в файл .env для работы докера, удалить .env-docker
6) В .env указать настройки подключения к mysql, если были изменены в mysql-init.sql

<h3>Ручная установка</h3>

1) Переименовать .env.example -> .env и изменить DOCKER_USER и порты по желанию
2) Выполнить <code>docker-compose up --build -d</code><br>
   Открыть в браузере http://localhost и проверить что все работает
3) Перейти в контейнер laravel-app
4) В контейнере laravel-app выполнить <code>composer create-project laravel/laravel laravel</code>
5) Удалить папку public из текущего каталога
6) Из корневого .env скопировать настройки докера в файл laravel/.env
6) Переместить все файлы из директории laravel в корневую директорию с заменой файлов
7) В .env указать настройки подключения к mysql, если были изменены в mysql-init.sql


Для работы vite необходимо добавить в vite.config.js:

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


