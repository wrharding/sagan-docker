FROM alpine:latest as builder
RUN apk update && apk upgrade
RUN apk add autoconf automake build-base yaml-dev pcre-dev liblognorm-dev libfastjson-dev zlib-dev
RUN wget https://github.com/quadrantsec/sagan/archive/refs/tags/v,2,0.2.tar.gz -O sagan-v2.0.2.tar.gz && tar -xzvf sagan-v2.0.2.tar.gz
RUN cd sagan-v-2-0.2/ && ./autogen.sh
RUN cd sagan-v-2-0.2/ && ./configure
RUN cd sagan-v-2-0.2/ && make
RUN cd sagan-v-2-0.2/ && make install

FROM alpine:latest
RUN apk update && apk upgrade
RUN apk add git
RUN apk update && apk upgrade
RUN apk add yaml-dev pcre-dev liblognorm-dev libfastjson-dev zlib-dev
RUN mkdir -p /usr/local/etc/ && wget "https://raw.githubusercontent.com/quadrantsec/sagan/main/etc/sagan.yaml" -O /usr/local/etc/sagan.yaml
RUN git clone https://github.com/quadrantsec/sagan-rules.git /usr/local/etc/sagan-rules/
RUN wget https://github.com/quadrantsec/sagan-rules/blob/451d442549552b9128d5f57cf544111500e19a0b/protocol.map -O /usr/local/etc/sagan-rules/protocol.map
RUN mkdir -p /var/log/sagan/ && touch /var/log/sagan/sagan.log
RUN mkdir -p /var/sagan/fifo && mkfifo /var/sagan/fifo/sagan.fifo
COPY --from=builder /usr/local/bin/sagan /usr/local/bin/sagan

