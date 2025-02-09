FROM php:8.4-fpm-alpine

RUN apk add --no-cache git

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN docker-php-ext-install mysqli

WORKDIR /var/www

COPY composer.json /var/www/
COPY composer.lock /var/www/

RUN composer update

COPY . /var/www/

EXPOSE 9000

CMD ["php-fpm"]