FROM php:5.6.30-apache
RUN yes | pecl install xdebug zip mcrypt  \
      && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
      && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
      && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
      && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini
