FROM debian:buster

# updating and upgrading everything that needs to be
RUN apt-get update \
&& apt-get upgrade -y

# defining a working directory in the container
WORKDIR /tmp/mariadb/

# creating an env variable
ARG DB_NAME
ARG MYSQL_ROOT_PWD
ARG MYSQL_BOSS_PWD
ARG MYSQL_USERNAME
ARG MYSQL_USER_PWD

# copying everything in the conf folder on the host machine in the working directory
COPY conf/ /tmp/mariadb/

# replacing in the script because it is not expanded on its own...
# installing mariadb
# starting sql
# configuring sql
# allowing remote connections to mysql server
RUN sed -i "s/\$DB_NAME/$DB_NAME/g" /tmp/mariadb/conf.sql \
&& sed -i "s/\$MYSQL_ROOT_PWD/$MYSQL_ROOT_PWD/g" /tmp/mariadb/conf.sql \
&& sed -i "s/\$MYSQL_BOSS_PWD/$MYSQL_BOSS_PWD/g" /tmp/mariadb/conf.sql \
&& sed -i "s/\$MYSQL_USERNAME/$MYSQL_USERNAME/g" /tmp/mariadb/conf.sql \
&& sed -i "s/\$MYSQL_USER_PWD/$MYSQL_USER_PWD/g" /tmp/mariadb/conf.sql \
&& mkdir -p /run/mysql \
&& apt-get install -y mariadb-server mariadb-client \
&& service mysql start \
&& chown -R mysql:mysql /run/mysqld \
&& mariadb -u root --password=$MYSQL_ROOT_PWD < /tmp/mariadb/conf.sql \
&& sed 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/' -i /etc/mysql/mariadb.conf.d/50-server.cnf \
&& chown -R mysql:mysql /var/lib/mysql

# expose port 3306
EXPOSE 3306

# command to launch IN the mariadb container: sql daemon to react to commands
CMD mysqld