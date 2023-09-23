FROM amazonlinux:2
RUN yum update -y
ARG maria_package=mariadb-server
ADD https://wordpress.org/latest.zip .
RUN yum -y install unzip
RUN unzip latest.zip
WORKDIR wordpress
RUN cp -r wp-config-sample.php wp-config.php
RUN amazon-linux-extras enable php7.4 -y && yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap} -y && yum install ${maria_package} -y
RUN yum -y install httpd
CMD /usr/sbin/httpd -D FOREGROUND
RUN cp -r * /var/www/html
EXPOSE 80
