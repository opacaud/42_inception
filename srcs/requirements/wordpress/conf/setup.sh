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
    wp core config --allow-root --dbname=${DB_NAME} --dbuser=${WP_USER} --dbpass=${WP_PASS} --dbhost=${WP_HOST} --path=${WP_PATH}
    echo "\n 0 \n"
fi

echo "\n 1 \n"

wp core install --allow-root --url='opacaud.42.fr' --title='wordpress' --admin_user=otheruser --admin_password=otherpassword  --admin_email="admin@admin.fr" --path='/var/www/wordpress';

echo "\n 2 \n"

wp user create --allow-root opacaud opacaud@user.com --user_pass=Pizza4fromages --role=administrator

echo "\n 3 \n"

wp user create --allow-root anotheruser anotheruser2@user.com --user_pass=anotherpassword --role=author

echo "\n 4 \n"

# https://linux.die.net/man/8/php-fpm
# -F: Force to stay in foreground and ignore daemonize option from configuration file.
php-fpm7.3 -F
# php-fpm7.3 --nodaemonize

echo "\n 5 \n"
