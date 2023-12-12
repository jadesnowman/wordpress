## CUSTOM ETC HOSTS

## INSTALLATION
1. clone
2. `cp env.example .env`
3. run composer
4. setup mysql
5. setup php-fpm
6. setup nginx
7. setup local hostname

## DEMO
- http://https://blog.sekolah-pilihan.test
- http://https://blog.sekolah-pilihan.test/wordpress/graphql
- http://https://blog.sekolah-pilihan.test/wp-json/wp/v2/posts


docker run -d \
--name db-mysql \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD='root' \
-e MYSQL_PASSWORD='root' \
-e MYSQL_DATABASE=wordpress \
bitnami/mysql:5.7.43

./vendor/bin/phpcs --version
./vendor/bin/phpcs --standard=PSR1 .
