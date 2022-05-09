FROM debian:buster

RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y wordpress

EXPOSE 9000

CMD php-fpm