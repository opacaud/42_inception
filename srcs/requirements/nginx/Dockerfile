# https://hub.docker.com/_/nginx

FROM debian:buster

# installing nginx and openssl
# creating the directory to retrieve keys to make connexion safe (https)
# creating a self-signed certificate by retrieving keys
# https://www.openssl.org/docs/man1.1.1/man1/openssl-req.html
# - req primarily creates and processes certificate requests.
#   It can additionally create self signed certificates.
# - -newkey <arg> creates a new certificate request and a new private key.
#   The argument takes one of several forms.
#   rsa:nbits, where nbits is the number of bits, generates an RSA key nbits in size.
# - -x509 outputs a self signed certificate instead of a certificate request. 
# - -days n. When the -x509 option is being used this specifies the number of days to certify the certificate for.
# - secure hash algorithm 256 considered the safest nowadays.
# - -nodes. If this option is specified then if a private key is created it will not be encrypted.
# - -out <filename> specifies the output filename to write to or standard output by default.
# - -keyout <filename> gives the filename to write the newly created private key to.
# - -subj sets subject name for new request or supersedes the subject name when processing a request. 
# creating directory to retrieve configuration file in container
RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y nginx openssl \
&& mkdir -p /etc/nginx/ssl/ \
&& openssl req -newkey rsa:4096 -x509 -days 365 -sha256 -nodes -out /etc/nginx/ssl/opacaud.42.fr.crt -keyout /etc/nginx/ssl/opacaud.42.fr.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=opacaud/CN=opacaud.42.fr" \
&& mkdir -p /tmp/nginx/

WORKDIR /tmp/nginx/

# copying the configuration file in container
COPY conf/nginx.conf /tmp/nginx/

# forwarding request and error logs to docker log collector
# moving the configuration file to the right spot
# creating the symbolic link as it is for the default configuration file
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log \
&& rm -f /etc/nginx/sites-enabled/default \
&& rm -f /etc/nginx/sites-available/default \
&& mv /tmp/nginx/nginx.conf /etc/nginx/sites-available/ \
&& ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# checking that the syntax of configuration file is okay
# RUN nginx -t

EXPOSE 443

# -g daemon off in order for nginx to stay in the foreground so that Docker can track the process properly
# (otherwise the container will stop immediately after starting)
CMD ["nginx", "-g", "daemon off;"]