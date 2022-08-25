FROM alpine:latest
RUN apk update && apk upgrade
RUN apk add git
RUN apk update && apk upgrade
RUN apk add yaml-dev pcre-dev liblognorm-dev libfastjson-dev zlib-dev
RUN mkdir -p /usr/local/etc/ && wget "https://raw.githubusercontent.com/quadrantsec/sagan/main/etc/sagan.yaml" -O /usr/local/etc/sagan.yaml
RUN git clone https://github.com/quadrantsec/sagan-rules.git /usr/local/etc/sagan-rules/
RUN mkdir -p /var/log/sagan/ && touch /var/log/sagan/sagan.log
RUN mkdir -p /var/sagan/fifo && mkfifo /var/sagan/fifo/sagan.fifo
ADD ./sagan-bin-alpine /usr/local/bin/sagan

