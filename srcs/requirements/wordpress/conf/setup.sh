# https://linux.goffinet.org/administration/scripts-shell/
# https://www.cyberciti.biz/faq/bash-check-if-file-does-not-exist-linux-unix/
# installing WP-CLI that allows one to access WordPress from the command line.
# https://www.hostinger.fr/tutoriels/wp-cli
# https://supporthost.com/wp-cli-the-definitive-guide/
# https://developer.wordpress.org/cli/commands/
# wp core download: to download the latest version of wordpress
# wp core config: to generate the file wp-config.php, mandatory for the database
# wp core install: to start the wordpress installation process
# wp user create: to create a new user

#!/bin/bash

if [ ! -f /var/www/wordpress/wp-config.php ]
then
    wp core download --allow-root 
    wp core config --allow-root --dbname=${DB_NAME} --dbuser=${MYSQL_USERNAME} --dbpass=${MYSQL_USER_PWD} --dbhost=${DB_HOST}
fi

# https://developer.wordpress.org/cli/commands/core/install/
wp core install --allow-root --url='opacaud.42.fr' --title='wordpress' --admin_user=${MYSQL_USERNAME} --admin_password=${MYSQL_USER_PWD} --admin_email="opacaud@user.com" --skip-email --skip-plugins --skip-themes --skip-packages

wp user create --allow-root ${WP_USER} anotheruser@user.com --role=author --user_pass=${WP_UPWD} --skip-plugins --skip-themes --skip-packages

# https://linux.die.net/man/8/php-fpm
# -F: Force to stay in foreground and ignore daemonize option from configuration file.
php-fpm7.3 -F