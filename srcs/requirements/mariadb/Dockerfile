FROM debian:buster

# updating and upgrading everything that needs to be
RUN apt-get update \
&& apt-get upgrade -y

# defining a working directory in the container
WORKDIR /tmp/mariadb/

# creating an env variable
# ARG MYSQL_ROOT_PWD=Pizza6fromages

# copying everything in the setup folder on the host machine in the working directory
COPY setup/ /tmp/mariadb/

# replacing in the script because it is not expanded on its own...
RUN sed -i "s/MYSQL_ROOT_PWD/$MYSQL_ROOT_PWD/g" /tmp/mariadb/setup.sql \
&& mkdir -p /run/mysql \
&& apt-get install -y mariadb-server mariadb-client \
&& service mysql start \
&& chown -R mysql:mysql /run/mysqld \
# && mariadb -v -u root --password=$MYSQL_ROOT_PWD < /tmp/mariadb/setup.sql \
&& mariadb -v -u root -p < /tmp/mariadb/setup.sql \
&& sed 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/' -i /etc/mysql/mariadb.conf.d/50-server.cnf \
# && mkdir tmpsql \
&& chown -R mysql:mysql /var/lib/mysql
# && cp -r /var/lib/mysql/* tmpsql

# open port 3306
EXPOSE 3306

# command to launch in the mariadb container

# CMD cp -r tmpsql/* /var/lib/mysql/ \
# && mysqld

CMD mysqld