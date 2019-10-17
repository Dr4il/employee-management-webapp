cp /var/www/.docker/symfony.conf /etc/apache2/sites-available/symfony.conf
composer install --prefer-dist --no-interaction
a2enmod rewrite
a2dissite 000-default.conf
a2ensite symfony.conf
apache2 restart