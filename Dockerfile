FROM php:7.3-apache
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer 
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils curl git gnupg unzip libzip4 zlib1g-dev libzip-dev && apt-get clean
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs
RUN npm install
RUN docker-php-ext-install zip 
WORKDIR /var/www
COPY . /var/www
RUN echo '<VirtualHost *:80> \n\
	DocumentRoot /var/www/public \n\
	ErrorLog ${APACHE_LOG_DIR}/error.log \n\
	CustomLog ${APACHE_LOG_DIR}/access.log combined \n\
</VirtualHost>' >> /etc/apache2/sites-available/symfony.conf
RUN npm install npm i @symfony/webpack-encore
RUN a2enmod rewrite
RUN a2dissite 000-default.conf
RUN a2ensite symfony.conf
EXPOSE 80