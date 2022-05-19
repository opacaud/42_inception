# FROM debian:buster

# # COPY conf/wp-config.php /var/www/html/.

# # installing wordpress, php-fpm and all its dependencies and wget
# RUN apt-get update \
# && apt-get upgrade -y \
# && apt-get install -y mariadb-client php7.3 php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath curl \
# && mkdir -p /run/php

# WORKDIR /var/www/wordpress_nginx/

# # installing WP-CLI that allows one to access WordPress from the command line.
# # https://www.hostinger.fr/tutoriels/wp-cli
# # https://supporthost.com/wp-cli-the-definitive-guide/
# # wp core download: to download the latest version of wordpress
# # wp core config: to generate the file wp-config.php, mandatory for the database
# # wp db create: to create a database
# # wp core install: to start the wordpress installation process
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
# && chmod +x wp-cli.phar \
# && mv wp-cli.phar /usr/local/bin/wp \
# && wp core download --allow-root \
# && wp core config --allow-root --dbname=wordpress --dbuser=opacaud --dbpass=Pizza4fromages --dbhost=mariadb:3306 --path=/var/www/wordpress_nginx/ \
# && wp config set WP_SITE_URL 'https://opacaud.42.fr' \
# && wp config set WP_HOME 'https://opacaud.42.fr' \
# && chmod 644 /var/www/html/wp-config.php \
# && wp core install --allow-root --url=https://opacaud.42.fr --title=opacaud --admin_user=opacaud --admin_password=password --admin_email=opacaud@student.42.fr \
# && wp user create --allow-root otheruser otheruser@other.com --role+author --user_pass=otherpassword

# EXPOSE 9000

# RUN chown -R www-data:www-data /var/www/html/ \
# && sed 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/' -i /etc/php/7.3/fpm/pool.d/www.conf

# # https://linux.die.net/man/8/php-fpm
# # -F: Force to stay in foreground and ignore daemonize option from configuration file.
# CMD ["/usr/sbin/php-fpm7.3", "-F"]






FROM debian:buster 

ARG DB_NAME
ARG WP_USER   
ARG WP_PASS
ARG WP_HOST  
ARG WP_PATH

RUN apt-get update \
&& apt-get install -y php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl \php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap php7.3-fpm wget curl openssl sendmail \mariadb-client vim procps;

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp  \
&& echo "listen = 9000" >> /etc/php/7.3/fpm/pool.d/www.conf \
&& echo "access.log = /var/log/$pool.access.log" >> /etc/php/7.3/fpm/pool.d/www.conf \
# && cat /etc/php/7.3/fpm/pool.d/www.conf \
# && sleep 20 \
&& mkdir -p /var/www/wordpress  \
&& chown -R  www-data:www-data /var/www/wordpress/ \
&& chmod 777 /var/www/wordpress/ \
&& mkdir -p /run/php/

COPY conf/setup.sh /

RUN chmod 777 /setup.sh

WORKDIR /var/www/wordpress

EXPOSE 9000

ENTRYPOINT ["sh", "/setup.sh"]







# FROM debian:buster

# # installing wordpress, php-fpm and all its dependencies and wget
# RUN apt-get update \
# && apt-get upgrade -y \
# && apt-get install -y php7.3 php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath unzip wget git \
# && mkdir -p /var/www/html
# # && sed -i "s/post_max_size = 8M/post_max_size = 64M/g" /etc/php/7.3/fpm/php.ini \
# # && sed -i "s/memory_limit = 128/memory_limit = 256M/g" /etc/php/7.3/fpm/php.ini \
# # && sed -i "s/max_execution_time = 30/max_execution_time = 300/g" /etc/php/7.3/fpm/php.ini \
# # && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 32M/g" /etc/php/7.3/fpm/php.ini

# # https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10
# # copying my configuration file with the right database name, username and password in the container
# COPY conf/wp-config.php /var/www/html/.

# # https://www.rosehosting.com/blog/how-to-install-wordpress-with-nginx-on-debian-10/#Step-4-Install-WordPress
# # https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10
# # installing wordpress
# # copying my configuration file in the right folder
# # setting the correct permissions to the wordpress installation (to www-data group and user) to be accessible from the Internet.
# # This is the user and group that Nginx runs as, and Nginx will need to be able to read and write WordPress files in order to serve the website and perform automatic updates.
# # had to add a few lines in the nginx.conf file
# RUN cd /var/www/html/ \
# && wget https://wordpress.org/latest.tar.gz \
# && tar -xvzf latest.tar.gz \
# && rm /var/www/html/wordpress/wp-config-sample.php \
# && cp wp-config.php wordpress/. \
# && mkdir -p /run/php/ \
# && chown -R www-data:www-data /var/www/html/ \
# && chmod -R 755 /var/www/html/wordpress \
# && sed 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/' -i /etc/php/7.3/fpm/pool.d/www.conf
# # && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
# # && mv wp-cli.phar /usr/bin/wp-cli \
# # && chmod 755 /usr/bin/wp-cli

# EXPOSE 9000

# # https://linux.die.net/man/8/php-fpm
# # -F: Force to stay in foreground and ignore daemonize option from configuration file.
# CMD ["/usr/sbin/php-fpm7.3", "-F"]