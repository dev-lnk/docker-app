Установка:
1) .env.example -> .env 
2) .env - указать путь до проекта APP_PATH
3) docker/PHP8/Dockerfile - указать WORKDIR такой же как APP_PATH
4) docker-compose.yml - Заменить custom_network если нужно
5) docker-compose.yml - Заменить your-project в названиях контейнерах если нужно
6) docker/Nginx/core/conf.d/default.conf - изменит директиву root на основе APP_PATH
7) docker/Nginx/core/conf.d/default.conf - fastcgi_pass должен называться так же как контейнер php
Например: fastcgi_pass php-your-project:9000; 
8) docker/dump/mysql-init.sql - заменить my_database на свою базу

На данном этапе можно выполнить docker-compose up --build -d и построить проект.
Если всё пройдет успешно и проект откроется по адресу localhost, то контейнеры можно останавливать и удалить проект из docker desktop.

Установка laravel:

9) Установить laravel в любую папку контейнера php, но не в /var/www/your-project, например /var/www/laravel
10) Скопировать всё из /var/www/laravel в /var/www/your-project c заменой .env (предварительно добавив в .env настройки docker), Readme.md и .gitignore
11) Настроить подключение к БД и redis, например:
````
    DB_CONNECTION=mysql
    DB_HOST=db-your-project #название контейнера из docker-compose.yml
    DB_PORT=3306
    DB_DATABASE=my_database
    DB_USERNAME=my_database
    DB_PASSWORD=12345
````
12) 
````
REDIS_HOST=redis-your-project
REDIS_PASSWORD=null
REDIS_PORT=6379
````
13) Изменить APP_URL в .env
14) Запустить docker-compose up --build -d, построитcя проект с laravel

Пересобрать контейнер<br> 
<code>docker-compose up -d --force-recreate --no-deps --build service_name</code>

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

<p>NPM (работа из консоли)</p>
<code>docker-compose run --rm npm-your-project install</code><br>
<code>docker-compose run --rm npm-your-project run build</code><br>
<code>docker-compose run --rm --service-ports npm-your-project run dev --host</code><br>


