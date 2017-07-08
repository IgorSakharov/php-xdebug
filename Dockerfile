FROM php:5.6.30-apache
RUN yes | pecl install xdebug zip mcrypt  \
     && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
     && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
     && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
     && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini
 RUN yes | pecl install xdebug zip mcrypt
 RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini
 RUN echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini
 RUN echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini
 RUN echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini

 RUN echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' >  /etc/apt/sources.list
 RUN apt-get update \
  && apt-get install -y --force-yes apache2 git-core php5 php5-mysql php5-curl php5-gd php5-mcrypt
 #RUN echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' >  /etc/apt/sources.list
 RUN apt-get update
 RUN apt-get install -y git-core php5-mysql php5-curl php5-gd php5-mcrypt


  #dpkg-divert --local --rename --add /sbin/initctl
  #ln -s /bin/true /sbin/initctl

 RUN git clone https://github.com/opencart/opencart.git  /var/www/html
  && cd  /var/www/html \
  && git checkout v2.1.0.1
 RUN git clone https://github.com/opencart/opencart.git /var/www/html ; cd  /var/www/html ; git checkout 2.1.0.1


  RUN ln -s  /var/www/html/upload/var/www/opencart

 RUN cd /var/www/opencart \
  && cp config-dist.php config.php \
  && cp admin/config-dist.php admin/config.php

 RUN chmod 0777 image/ \
  && chmod 0777 image/cache/ \
  && chmod 0777 cache/ \
  && chmod 0777 download/ \
  && chmod 0777 config.php/ \
  && chmod 0777 admin/config.php/ \
  && chmod 0777 image/data/ \
  && chmod 0777 system/logs/ \
  && chmod 0777 system/cache/
 RUN cd /var/www/opencart ; cp config-dist.php config.php ; cp admin/config-dist.php admin/config.php

 RUN chmod 0777 image/ ;chmod 0777 image/cache/ ;chmod 0777 cache/ ;chmod 0777 download/ ;chmod 0777 config.php/ ;chmod 0777 admin/config.php/ ;chmod 0777 image/data/ ;chmod 0777 system/logs/ ;chmod 0777 system/cache/
