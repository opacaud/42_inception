FROM debian:buster

# updating and upgrading evrything that needs to be
RUN apt-get update \
&& apt-get upgrade -y

# defining a working directory in the container
WORKDIR /tmp/mariadb/

# copying everything in the setup folder on the host machine in the working directory
COPY setup/ /tmp/mariadb/

# 

RUN mkdir -p /run/mysql \
&& apt-get install -y mariadb-server mariadb-client \
&& service mysql start \
&& mariadb -u root < /tmp/mariadb/setup.sql \
&& sed 's/bind-address = 127.0.0.1/bind-address = 0.0.0.0/' -i /etc/mysql/mariadb.conf.d/50-server.cnf \
&& mkdir tmpsql \
&& cp -r /var/lib/mysql/* tmpsql

# open port 3306
EXPOSE 3306

# 

CMD cp -r tmpsql/* /var/lib/mysql/ \
&& mysqld
