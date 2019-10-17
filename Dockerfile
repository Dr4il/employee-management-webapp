FROM php:7.3-apache AS base
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer 
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils git unzip libzip4 zlib1g-dev libzip-dev && apt-get clean
RUN docker-php-ext-install zip 
WORKDIR /var/www
COPY . /var/www
FROM node:lts-stretch-slim AS node
RUN npm install npm i @symfony/webpack-encore
FROM base
ENTRYPOINT [ "sh", "./entrypoint.sh" ]
EXPOSE 80
CMD ["apache2-foreground"]