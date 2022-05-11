# https://hub.docker.com/_/nginx

FROM debian:buster

RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y nginx openssl \
&& mkdir /tmp/nginx

WORKDIR /tmp/nginx

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY conf/nginx.conf /tmp/nginx/

EXPOSE 443

# -g daemon off in order for nginx to stay in the foreground so that Docker can track the process properly
# (otherwise the container will stop immediately after starting)
CMD [nginx, '-g', 'daemon off;']