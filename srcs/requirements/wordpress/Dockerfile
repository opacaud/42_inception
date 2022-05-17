FROM debian:buster

# installing wordpress, php-fpm and all its dependenciesm and wget
RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y wordpress php7.3 php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath unzip wget git
# && sed -i "s/post_max_size = 8M/post_max_size = 64M/g" /etc/php/7.3/fpm/php.ini \
# && sed -i "s/memory_limit = 128/memory_limit = 256M/g" /etc/php/7.3/fpm/php.ini \
# && sed -i "s/max_execution_time = 30/max_execution_time = 300/g" /etc/php/7.3/fpm/php.ini \
# && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 32M/g" /etc/php/7.3/fpm/php.ini

# https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10
# copying my configuration file with the right database name, username and password in the container
COPY conf/wp-config.php /var/www/html/.

# https://www.rosehosting.com/blog/how-to-install-wordpress-with-nginx-on-debian-10/#Step-4-Install-WordPress
# https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10
# installing wordpress
# copying my configuration file in the right folder
# setting the correct permissions to the wordpress installation (to www-data group and user) to be accessible from the Internet.
# This is the user and group that Nginx runs as, and Nginx will need to be able to read and write WordPress files in order to serve the website and perform automatic updates.
# had to add a few lines in the nginx.conf file
RUN cd /var/www/html/ \
&& wget https://wordpress.org/latest.tar.gz \
&& tar -xvzf latest.tar.gz \
&& rm /var/www/html/wordpress/wp-config-sample.php \
&& cp wp-config.php wordpress/. \
&& mkdir -p /run/php/ \
&& chown -R www-data:www-data /var/www/html/ \
&& chmod -R 755 /var/www/html/wordpress \
&& sed 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/' -i /etc/php/7.3/fpm/pool.d/www.conf \
&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& mv wp-cli.phar /usr/bin/wp-cli \
&& chmod 755 /usr/bin/wp-cli

EXPOSE 9000

# https://linux.die.net/man/8/php-fpm
# -F: Force to stay in foreground and ignore daemonize option from configuration file.
CMD ["/usr/sbin/php-fpm7.3", "-F"]