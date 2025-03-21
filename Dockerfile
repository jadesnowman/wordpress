# Use BuildKit for secure secrets handling
# syntax=docker/dockerfile:1.4

FROM php:8.4-fpm-alpine

# Install required dependencies
RUN apk add --no-cache git

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP extensions
RUN docker-php-ext-install mysqli

WORKDIR /var/www

# Copy composer files first to utilize caching
COPY composer.json composer.lock /var/www/

# Use Docker BuildKit secrets instead of ARG
RUN --mount=type=secret,id=github_token \
    mkdir -p /root/.composer && \
    echo '{"github-oauth": {"github.com": "'$(cat /run/secrets/github_token)'"}}' > /root/.composer/auth.json && \
    composer install --no-dev --no-cache --prefer-dist && \
    rm -rf /root/.composer/auth.json

# Copy application source code
COPY . /var/www/

# Expose PHP-FPM port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
