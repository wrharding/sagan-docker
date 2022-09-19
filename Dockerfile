FROM debian:11-slim as builder
RUN apt update && apt upgrade -y
RUN apt install git autoconf automake build-essential libpcre3-dev libpcre3 libyaml-dev liblognorm-dev libfastjson-dev libestr-dev pkg-config zlib1g-dev -y
RUN git clone https://github.com/quadrantsec/sagan.git
RUN cd sagan/ && ./autogen.sh
RUN cd sagan/ && ./configure
RUN cd sagan/ && make
RUN cd sagan/ && make install

FROM debian:11-slim
RUN apt update && apt upgrade -y
RUN apt install git curl -y
RUN apt install libyaml-dev libpcre3-dev libpcre3 liblognorm-dev libfastjson-dev -y
RUN mkdir -p /usr/local/etc/ && curl "https://raw.githubusercontent.com/quadrantsec/sagan/main/etc/sagan.yaml" -o /usr/local/etc/sagan.yaml
RUN git clone https://github.com/quadrantsec/sagan-rules.git /usr/local/etc/sagan-rules/
RUN mkdir -p /var/log/sagan/ && touch /var/log/sagan/sagan.log
RUN mkdir -p /var/sagan/fifo && mkfifo /var/sagan/fifo/sagan.fifo
COPY --from=builder /usr/local/bin/sagan /usr/local/bin/sagan
