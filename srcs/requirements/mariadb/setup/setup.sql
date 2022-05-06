CREATE DATABASE IF NOT EXIST wordpress;
CREATE USER 'opacaud'@'localhost';
SET PASSWORD FOR 'opacaud'@'localhost' = PASSWORD('Pizza4fromages');
GRANT ALL PRIVILEGES ON wordpress.* TO 'opacaud'@'localhost' IDENTIFIED BY 'Pizza4fromages';
GRANT ALL ON wordpress.* TO 'opacaud'@'%' IDENTIFIED BY 'Pizza4fromages';

FLUSH PRIVILEGES;

CREATE USER 'superuser'@'localhost' IDENTIFIED BY 'Pizza4fromages';
GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;

CREATE USER 'superuser'@'%' IDENTIFIED BY 'Pizza4fromages'
GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'Pizza5froamges';

FLUSH PRIVILEGES;