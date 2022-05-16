FROM debian:buster

RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y wordpress php-fpm php-mysql php-cgi php-common php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-bcmath unzip wget

COPY conf/wp-config.php /var/www/html

RUN cd /var/www/html \
&& wget https://wordpress.org/latest.tar.gz \
&& tar -xvzf latest.tar.gz \
&& cp /var/www/html/wp-config.php wordpress/. \
&& mkdir -p /run/php/ \
&& chown -R www-data:www-data /var/www/html/ \
&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& mv wp-cli.phar /usr/bin/wp-cli \
&& chmod 755 /usr/bin/wp-cli

EXPOSE 9000

# https://linux.die.net/man/8/php-fpm
# -F: Force to stay in foreground and ignore daemonize option from configuration file.
CMD ["/usr/sbin/php-fpm7.3", "-F"]