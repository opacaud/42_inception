FROM debian:buster 

ARG DB_NAME
ARG DB_HOST
ARG WP_PATH
ARG WP_USER
ARG WP_UPWD

RUN apt-get update \
&& apt-get install -y php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap wget mariadb-client sendmail \
&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp \
&& echo 'listen = 9000' >> /etc/php/7.3/fpm/pool.d/www.conf \
&& mkdir -p /var/www/wordpress \
&& chown -R  www-data:www-data /var/www/wordpress/ \
&& chmod 777 /var/www/wordpress/ \
&& mkdir -p /run/php/

EXPOSE 9000

WORKDIR /var/www/wordpress

COPY conf/setup.sh /

RUN chmod 777 /setup.sh

CMD /setup.sh