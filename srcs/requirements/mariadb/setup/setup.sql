-- https://mariadb.com/kb/en/sql-statements/

-- https://bertvv.github.io/notes-to-self/2015/11/16/automating-mysql_secure_installation/
-- cleaning default data
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';

FLUSH PRIVILEGES;

-- https://mariadb.com/kb/en/create-database/
-- "CREATE DATABASE creates a database with the given name."
-- "When the IF NOT EXISTS clause is used, MariaDB will return a warning instead of an error if the specified database already exists."
CREATE DATABASE IF NOT EXISTS wordpress;

-- https://mariadb.com/kb/en/create-user/
-- "Account names have both a user name component and a host name component, and are specified as 'user_name'@'host_name'"
CREATE USER 'opacaud'@'localhost';

-- https://mariadb.com/kb/en/set-password/
-- "The SET PASSWORD statement assigns a password to an existing MariaDB user account."
SET PASSWORD FOR 'opacaud'@'localhost' = PASSWORD('Pizza4fromages');

-- https://mariadb.com/kb/en/grant/
-- usage: "GRANT priv_type [...] ON [...] priv_level TO user_specification [user_options]"
-- priv_type: "The ALL PRIVILEGES privilege grants all available privileges. [...] You can use ALL instead of ALL PRIVILEGES."
-- priv_level: " * | *.* | db_name.* | db_name.tbl_name | tbl_name | db_name.routine_name [...] Database privileges priv_type are granted using db_name.* for priv_level, or using just * to use default database."
-- user_specification: "username [authentication_option]"
-- authentication_option: IDENTIFIED BY 'password'
GRANT ALL PRIVILEGES ON wordpress.* TO 'opacaud'@'localhost' IDENTIFIED BY 'Pizza4fromages';
GRANT ALL ON wordpress.* TO 'opacaud'@'%' IDENTIFIED BY 'Pizza4fromages';

-- https://mariadb.com/kb/en/flush/#:~:text=The%20FLUSH%20statement%20clears%20or,statement%20is%20similar%20to%20FLUSH%20.
-- "The FLUSH statement clears or reloads various internal caches used by MariaDB."
-- "Reload all privileges from the privilege tables in the mysql database."
FLUSH PRIVILEGES;

-- creating the admin user whose username can't be admin
CREATE USER 'boss'@'localhost' IDENTIFIED BY 'Pizza5fromages';

-- https://mariadb.com/kb/en/grant/
-- "Global privileges priv_type are granted using *.* for priv_level."
-- "Use the WITH GRANT OPTION clause to give users the ability to grant privileges to other users at the given privilege level."
GRANT ALL ON *.* TO 'boss'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;

CREATE USER 'boss'@'%' IDENTIFIED BY 'Pizza5fromages';
GRANT ALL ON *.* TO 'boss'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

-- https://mariadb.com/kb/en/alter-user/
-- "The ALTER USER statement modifies existing MariaDB accounts."
-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'MYSQL_ROOT_PWD';

SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PWD');

FLUSH PRIVILEGES;