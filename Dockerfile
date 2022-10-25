FROM composer AS composer

FROM php:5.6-apache

# COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN a2enmod rewrite

RUN apt-get update

RUN apt-get install -y git zip unzip libzip-dev zlib1g-dev libmcrypt-dev libpng-dev nano \
 && apt-get install --yes --force-yes cron g++ gettext libicu-dev openssl libmcrypt-dev libc-client-dev libkrb5-dev  libxml2-dev libfreetype6-dev libgd-dev libmcrypt-dev bzip2 libbz2-dev libtidy-dev libcurl4-openssl-dev libz-dev libmemcached-dev libxslt-dev \
 && docker-php-ext-install mysql gd mysqli zip mcrypt pdo pdo_mysql\
 && docker-php-ext-enable mysql \
 && docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr

 
WORKDIR /var/www/html

COPY . .

CMD apache2-foreground
