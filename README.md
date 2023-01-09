Установка:
1) По желанию, заменить порты в .env напротив комментария #EDIT PORT
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

9) Выполнить базовую установку laravel проекта
10) Скопировать папку docker и docker-compose.yml в проект laravel (предварительно удалить папку docker/MySQL если она есть)
11) Добавить в .env настройки docker
12) Настроить подключение к БД, например:

    DB_CONNECTION=mysql
    DB_HOST=db-your-project #название контейнера из docker-compose.yml
    DB_PORT=3306
    DB_DATABASE=my_database
    DB_USERNAME=my_database
    DB_PASSWORD=12345

13) Изменить APP_URL в .env
14) Запустить docker-compose up --build -d, построитcя проект с laravel

Пересобрать контейнер
docker-compose up -d --force-recreate --no-deps --build service_name
