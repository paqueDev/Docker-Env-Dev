FROM php:7.1-fpm

# install the PHP extensions we need
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libjpeg-dev \
		libpng12-dev \
                libmcrypt-dev \
                ssmtp \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd mysqli opcache pdo_mysql json mcrypt; \
        pecl install -o -f xdebug redis \
        && rm -rf /tmp/pear \
        && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
        && echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini;

# Nous définissons les settings du PHP.ini. Nous nous référons à la recommandation :
# https://secure.php.net/manual/en/opcache.installation.php

RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { \
                echo '[xdebug]'; \
                echo 'xdebug.default_enable = 0'; \
        } >> /usr/local/etc/php/conf.d/xdebug.ini


RUN { \
        echo 'error_reporting  =  E_ALL'; \
        echo 'log_errors = On'; \
        echo 'display_errors = Off'; \
        echo 'include_path = ".:/usr/share/php:/usr/local/apache2/htdocs/ws_engine"'; \
    } > /usr/local/etc/php/php.ini

CMD ["php-fpm"]
EXPOSE 9000