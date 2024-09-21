# Using PHP with FPM and Alpine
FROM php:8.3-fpm-alpine AS base

# Installing the necessary PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache

# Adding the OpCache configuration file
COPY opcache.ini $PHP_INI_DIR/conf.d/

# Installing dependencies for Composer and Git
RUN apk add --no-cache git unzip curl bash

# Downloading Composer
COPY --from=composer:2.7.9 /usr/bin/composer /usr/local/bin/composer

# Setting up the working directory
WORKDIR /var/www/html

# Using a separate stage for Symfony CLI (optional)
# FROM base AS symfony-cli
# RUN wget https://get.symfony.com/cli/installer -O - | bash \
#     && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# End of the final image
