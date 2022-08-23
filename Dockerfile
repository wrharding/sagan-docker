FROM alpine:latest
# WORKDIR /home/wharding/sagan-docker
RUN apk update && apk upgrade
RUN apk add git
RUN apk update && apk upgrade
RUN apk add yaml-dev pcre-dev liblognorm-dev libfastjson-dev zlib-dev
ADD sagan/bin/ /usr/local/bin/
ADD sagan/etc/ /usr/local/etc/
