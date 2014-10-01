FROM ubuntu:14.04
MAINTAINER Jason Wilder jwilder@litl.com

# Install Nginx.
RUN apt-get update
RUN apt-get install --only-upgrade bash
RUN apt-get install -y  wget nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#fix for long server names
RUN sed -i 's/# server_names_hash_bucket/server_names_hash_bucket/g' /etc/nginx/nginx.conf

RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego
RUN chmod u+x /usr/local/bin/forego

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.3.3/docker-gen-linux-amd64-0.3.3.tar.gz
RUN tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-0.3.3.tar.gz

RUN mkdir /app
WORKDIR /app
ADD . /app

RUN mkdir -p /etc/nginx/ssl
RUN cp init.bash /usr/local/bin/init.bash

EXPOSE 80
EXPOSE 443
ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME ["/etc/nginx/ssl"]

CMD ["/bin/bash", "/usr/local/bin/init.bash"]
