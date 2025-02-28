FROM php:8.4-fpm-alpine

RUN apk add --no-cache git

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN docker-php-ext-install mysqli

WORKDIR /var/www

ARG GITHUB_PERSONAL_ACCESS_TOKEN
RUN mkdir -p /root/.composer && echo '{"github-oauth": {"github.com": "'${GITHUB_PERSONAL_ACCESS_TOKEN}'"}}' > /root/.composer/auth.json

COPY composer.json /var/www/
COPY composer.lock /var/www/

RUN composer update

RUN rm -rf /root/.composer/auth.json && unset GITHUB_PERSONAL_ACCESS_TOKEN

COPY . /var/www/

EXPOSE 9000

CMD ["php-fpm"]