FROM centos

MAINTAINER Ldos

ADD php-7.4.2.tar.gz /usr/local/src

RUN yum install -y gcc gcc-c++ glibc make autoconf openssl openssl-devel --nogpgcheck 
RUN yum install -y libxml2 libxml2-devel libxslt-devel -y gd gd-devel pcre pcre-devel libcurl-devel libcurl curl libjpeg-devel libpng-devel freetype-devel --allowerasing --nogpgcheck

RUN yum -y install https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/o/oniguruma-5.9.5-3.el7.x86_64.rpm --allowerasing --nogpgcheck

RUN yum -y install https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/o/oniguruma-devel-5.9.5-3.el7.x86_64.rpm --allowerasing --nogpgcheck

RUN yum -y install epel-release sqlite sqlite-devel --nogpgcheck

WORKDIR /usr/local/src/php-7.4.2

RUN ./configure   --prefix=/usr/local/php7   --exec-prefix=/usr/local/php7   --bindir=/usr/local/php7/bin   --sbindir=/usr/local/php7/sbin   --includedir=/usr/local/php7/include   --libdir=/usr/local/php7/lib/php   --mandir=/usr/local/php7/php/man   --with-config-file-path=/usr/local/php7/etc   --with-mcrypt=/usr/include   --with-mhash   --with-openssl   --with-mysqli=shared,mysqlnd   --with-pdo-mysql=shared,mysqlnd   --enable-gd   --with-iconv   --with-zlib   --enable-zip   --enable-inline-optimization   --disable-debug   --disable-rpath   --enable-shared   --enable-xml   --enable-bcmath   --enable-shmop   --enable-sysvsem   --enable-mbregex   --enable-mbstring   --enable-ftp   --enable-gd-native-ttf   --enable-pcntl   --enable-sockets   --with-xmlrpc   --enable-soap   --without-pear   --with-gettext   --enable-session   --with-curl   --with-jpeg-dir   --with-freetype-dir   --enable-opcache   --enable-fpm   --without-gdbm   --disable-fileinfo && make && make install



RUN cp php.ini-production /usr/local/php7/etc/php.ini
RUN cp /usr/local/php7/etc/php-fpm.conf.default /usr/local/php7/etc/php-fpm.conf

WORKDIR /usr/local/php7/etc/php-fpm.d
RUN cp www.conf.default www.conf

ADD www.conf /usr/local/php7/etc/php-fpm.d/www.conf

# Open up fcgi port
EXPOSE 9000
#CMD ["/usr/local/php7/sbin/php-fpm"]
#ENTRYPOINT ["/usr/local/php7/sbin/php-fpm","-c","/usr/local/php7/etc/php.ini -D -y /usr/local/php7/etc/php-fpm.conf"]
CMD ["/usr/local/php7/sbin/php-fpm","-F"]
