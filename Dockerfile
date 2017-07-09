FROM php:5.6.30-apache
MAINTAINER Igor Sakharov

RUN yes | pecl install xdebug zip mcrypt && \
    apt-get update && \
    apt-get install -y git-core php5-mysql php5-curl php5-gd && \
    git clone https://github.com/opencart/opencart.git /tmp/opencart && \
    cd /tmp/opencart && \
    git checkout 2.1.0.1 && \
    cp -r /tmp/opencart/upload/* /var/www/html && \
    rm -rf /tmp/opencart && \
    cd /var/www/html && \
    cp config-dist.php config.php && \
    cd admin && \
    cp config-dist.php config.php && \
    cd .. && cd .. && \
    chmod -R 0777 html/*


RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini
