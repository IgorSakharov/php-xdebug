FROM php:5.6.30-apache
MAINTAINER Igor Sakharov
RUN apt-get update && yes | apt-get install -y \
            libpng12-dev \
            libjpeg-dev \
            libxml2-dev \
            libmcrypt-dev \
            libmhash2 \
            libc6 \
            php5-mcrypt \
            php-pear \
            php-http-request \
            zlib1g \
            bzip2
RUN yes | apt-get install php5-dev
RUN yes | pecl install xdebug zip gb
RUN apt-get install -y php5-mcrypt git-core php5-mysql php5-curl
RUN apt-get update
#RUN apt-cache search png | grep -i header
#RUN apt-get install --assume-yes apt-utils
RUN mkdir /tmp/opencart
RUN git clone https://github.com/opencart/opencart.git /tmp/opencart && \
 cd /tmp/opencart && \
 git checkout 2.1.0.1
RUN cp -r /tmp/opencart/upload/* /var/www/html
RUN rm -rf /tmp/opencart
RUN cd /var/www/html
RUN cp config-dist.php config.php
RUN cd admin
RUN cp config-dist.php config.php
RUN cd .. && cd ..
#RUN chmod -R 0777 /html
RUN docker-php-ext-install gd mcrypt zip
RUN docker-php-ext-enable gd mcrypt zip


RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini
