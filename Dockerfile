FROM debian:latest
# WORKDIR /home/wharding/sagan-docker
RUN apt update && apt upgrade -y
RUN apt install curl gnupg git -y
RUN curl -X GET -L "https://github.com/maxmind/geoipupdate/releases/download/v4.9.0/geoipupdate_4.9.0_linux_amd64.deb" -o geoipupdate_4.9.0_linux_amd64.deb 
RUN dpkg -i geoipupdate_4.9.0_linux_amd64.deb 
RUN curl -SsL https://quadrantsec.github.io/ppa/debian/quadrantsec_key.gpg | apt-key add -
RUN curl -SsL -o /etc/apt/sources.list.d/quadrantsec.list https://quadrantsec.github.io/ppa/debian/quadrantsec_file.list
RUN apt update && apt upgrade -y
RUN apt install meer sagan -y
RUN rm -rf /usr/local/etc/sagan-rules/ && git clone https://github.com/quadrantsec/sagan-rules.git /usr/local/etc/sagan-rules/
