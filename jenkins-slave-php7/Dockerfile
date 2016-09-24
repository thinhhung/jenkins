FROM sontn1988/jenkins-slaves

MAINTAINER SonTN (sontn1988@gmail.com)


# Install "software-properties-common" (for the "add-apt-repository")
RUN apt-get update && apt-get install -y \
    software-properties-common

# Install Mysql
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections \
    && echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections \
    && apt-get install -y mysql-server-5.6

# Install Redis, Mongo
RUN apt-get -y --force-yes install redis-server mongodb  \
    && mkdir -p /data/db

# Add the "PHP 7" ppa
RUN add-apt-repository -y \
    ppa:ondrej/php

# Install PHP-CLI 7, some PHP extentions and some useful Tools with APT
RUN apt-get update && apt-get install -y --force-yes \
        php7.0-cli \
        php7.0-common \
        php7.0-curl \
        php7.0-json \
        php7.0-xml \
        php7.0-mbstring \
        php7.0-mcrypt \
        php7.0-mysql \
        php7.0-pgsql \
        php7.0-sqlite \
        php7.0-sqlite3 \
        php7.0-zip \
        php7.0-memcached \
        php7.0-gd \
        php7.0-fpm \
        php7.0-xdebug \
        php-dev \
        libcurl4-openssl-dev \
        libedit-dev \
        libssl-dev \
        libxml2-dev \
        xz-utils \
        sqlite3 \
        libsqlite3-dev \
        git \
        curl \
        vim \
        nano \
        net-tools \
        pkg-config \
        iputils-ping

# remove load xdebug extension (only load on phpunit command)
RUN sed -i 's/^/;/g' /etc/php/7.0/cli/conf.d/20-xdebug.ini

# Add bin folder of composer to PATH.
RUN echo "export PATH=${PATH}:/var/www/html/vendor/bin:/root/.composer/vendor/bin" >> ~/.bashrc

# Install Composer
RUN curl -s http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require "squizlabs/php_codesniffer=*"

RUN chmod +x /usr/local/bin/composer

# Load xdebug Zend extension with phpunit command
RUN echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/laravel/vendor/bin/phpunit'" >> ~/.bashrc

# Install mongodb extension
RUN pecl install mongodb
RUN echo "extension=mongodb.so" >> /etc/php/7.0/cli/php.ini
RUN echo "extension=mongodb.so" >> /etc/php/7.0/fpm/php.ini

# Install Nodejs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g n \
    && n stable \
    && npm install -g gulp bower eslint babel-eslint eslint-plugin-react


# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/html

COPY entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["/tmp/entrypoint.sh"]

EXPOSE 22
