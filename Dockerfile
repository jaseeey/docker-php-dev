FROM php:7.4-cli

RUN \
  mkdir -p /usr/share/man/man1 \
  && apt-get update \
  && apt-get install -y \
    default-jdk-headless \
    libreoffice \
    libreoffice-core \
    libreoffice-common \
    libreoffice-java-common \
    libmagickwand-dev \
    libbz2-dev \
    libicu-dev \
    libpng-dev \
    libpq-dev \
    libsqlite3-dev \
    libyaml-dev \
    libzip-dev \
    zlib1g-dev \
  && pecl install \
    imagick \
    xdebug \
    yaml \
  && docker-php-ext-install \
    gd \
    intl \
    mysqli \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    zip \
  && docker-php-ext-enable \
    imagick \
    xdebug \
    yaml \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer \
  && rm -rf /usr/share/doc/* \
  && rm -rf /usr/share/locale/* \
  && rm -rf /usr/share/man/* \
  && rm -rf /var/lib/apt/lists/*

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY imagick-policy.xml /etc/ImageMagick-6/policy.xml

WORKDIR /opt/project

EXPOSE 8080
EXPOSE 9000


