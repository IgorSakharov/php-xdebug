FROM php:5.6.30-apache
RUN yes | pecl install xdebug zip mcrypt
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini

#RUN echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' >  /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y git-core php5-mysql php5-curl php5-gd php5-mcrypt

#dpkg-divert --local --rename --add /sbin/initctl
# ln -s /bin/true /sbin/initctl
RUN git clone https://github.com/IgorSakharov/opencart.v2.1.0.1.git /var/www/html ; cd  /var/www/html ;

#RUN ln -s  opencart/upload /var/www/html/opencart

RUN cd upload ; cp config-dist.php config.php ; cp admin/config-dist.php admin/config.php ; cd .. ;

RUN  chmod 0777 -R upload ; cd upload ; chmod 0777 -R image ; cd image ; chmod 0777 -R cache ; \
  cd .. ;cd system/storage ; chmod 0777 -R download ; cd .. ; cd library ; chmod 0777 -R config.php ; cd .. ; cd .. ; chmod 0777 -R config.php ; \
  cd system/storage ; chmod 0777 -R logs/ ; chmod 0777 -R cache
#cd image ; chmod 0777 -R data