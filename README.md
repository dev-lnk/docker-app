Быстрая установка (необхоимо чтобы в вашей ОС был установлен Makefile):
1) Переименовать .env.example -> .env
2) make build (поднимет все контейнеры)
Открыть в браузере http://localhost и проверить что все работает
4) sudo make laravel-install
Открыть в браузере http://localhost и проверить что работает Laravel
5) Скопировать настройки из файла .env-docker в файл .env для работы докера

Установка (если необходимо изменить название приложения и пути):
1) .env.example -> .env 
2) .env - указать путь до проекта APP_PATH
3) docker/PHP8/Dockerfile - указать WORKDIR такой же как APP_PATH
4) docker-compose.yml - Заменить custom_network если нужно
5) docker-compose.yml - Заменить laravel-app в названиях контейнерах если нужно
6) docker/Nginx/core/conf.d/default.conf - изменит директиву root на основе APP_PATH (laravel-app по умолчанию)
7) docker/Nginx/core/conf.d/default.conf - fastcgi_pass должен называться так же как контейнер php
Например: fastcgi_pass php-laravel-app:9000; 
8) docker/dump/mysql-init.sql - заменить my_database на свою базу
На данном этапе можно выполнить docker-compose up --build -d или make build
Если всё пройдет успешно и проект откроется по адресу localhost.
Установка laravel:
9) Выполнить команду sudo make laravel-install или выполнить установку Laravel в контейнере php-laravel-app вручную
10) Скопировать настройки докера из файла .env-docker в файл .env если была установка через команду make


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


