#!/bin/bash
sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
sudo chmod 666 /var/run/docker.sock
touch dockerfile
echo 
FROM amazonlinux:2 /n/
RUN yum update -y /n/
ARG maria_package=mariadb-server /n/
ADD https://wordpress.org/latest.zip . /n/
RUN yum -y install unzip /n/
RUN unzip latest.zip /n/
WORKDIR wordpress /n/
RUN cp -r wp-config-sample.php wp-config.php /n/
RUN amazon-linux-extras enable php7.4 -y && yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap} -y && yum install ${maria_package} -y /n/
RUN yum -y install httpd /n/
CMD /usr/sbin/httpd -D FOREGROUND /n/
RUN cp -r * /var/www/html /n/
EXPOSE 80 /n/   >> dockerfile
