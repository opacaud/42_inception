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

sleep 8;

if [ ! -f /var/www/wordpress/wp-config.php ]
then

    wp core download --allow-root 
    sleep 5;

    while [ ! -f /var/www/wordpress/wp-config.php ]
    do
        wp core config --allow-root --dbname=wordpress --dbuser=opacaud --dbpass=password --dbhost=mariadb:3306
    done

    wp core install --allow-root --url='opacaud.42.fr' --title='wordpress' --admin_user=otheruser --admin_password=otherpassword  --admin_email="admin@admin.fr" --path='/var/www/wordpress';
    wp user create --allow-root anotheruser user2@user.com --user_pass=anotherpassword --role=author
    wp theme install --allow-root dark-mode --activate

fi

# https://linux.die.net/man/8/php-fpm
# -F: Force to stay in foreground and ignore daemonize option from configuration file.
# php-fpm7.3 -F
php-fpm7.3 --nodaemonize