FROM alpine:latest as builder
RUN apk update && apk upgrade
RUN apk add git autoconf automake build-base yaml-dev pcre-dev liblognorm-dev libfastjson-dev zlib-dev
RUN git clone https://github.com/quadrantsec/sagan.git
RUN cd sagan/ && ./autogen.sh
RUN cd sagan/ && ./configure
RUN cd sagan/ && make
RUN cd sagan/ && make install

FROM alpine:latest
RUN apk update && apk upgrade
RUN apk add git
RUN apk update && apk upgrade
RUN apk add yaml-dev pcre-dev liblognorm-dev libfastjson-dev zlib-dev
RUN mkdir -p /usr/local/etc/ && wget "https://raw.githubusercontent.com/quadrantsec/sagan/main/etc/sagan.yaml" -O /usr/local/etc/sagan.yaml
RUN git clone https://github.com/quadrantsec/sagan-rules.git /usr/local/etc/sagan-rules/
RUN wget https://raw.githubusercontent.com/quadrantsec/sagan-rules/451d442549552b9128d5f57cf544111500e19a0b/protocol.map -O /usr/local/etc/sagan-rules/protocol.map
RUN mkdir -p /var/log/sagan/ && touch /var/log/sagan/sagan.log
RUN mkdir -p /var/sagan/fifo && mkfifo /var/sagan/fifo/sagan.fifo
COPY --from=builder /usr/local/bin/sagan /usr/local/bin/sagan

