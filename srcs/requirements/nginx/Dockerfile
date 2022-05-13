# https://hub.docker.com/_/nginx

FROM debian:buster

RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y nginx openssl \
&& mkdir -p /etc/nginx/ssl/ \
&& openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/opacaud.42.fr.crt -keyout /etc/nginx/ssl/opacaud.42.fr.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=opacaud/CN=opacaud.42.fr" \
&& mkdir -p /tmp/nginx/

WORKDIR /tmp/nginx/

COPY conf/nginx.conf /tmp/nginx/

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log \
&& rm -f /etc/nginx/sites-enabled/default \
&& rm -f /etc/nginx/sites-available/default \
&& mv /tmp/nginx/nginx.conf /etc/nginx/sites-available \
&& ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# RUN nginx -t

EXPOSE 443

# -g daemon off in order for nginx to stay in the foreground so that Docker can track the process properly
# (otherwise the container will stop immediately after starting)
CMD ["nginx", "-g", "daemon off;"]