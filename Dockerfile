FROM alpine:latest
MAINTAINER Peter Boyd

LABEL Description="Simple and lightweight Samba docker container, based on Alpine Linux." Version="0.02"

ENV SERVERNAME docker-samba
ENV WORKGROUP WORKGROUP
ENV USERNAME samba
ENV GROUP samba
ENV PASSWORD password
ENV SHARES /shares
ENV PUID 1100
ENV PGID 1100

# install samba and supervisord
# create a dir for the config and the share
RUN apk --no-cache add samba samba-common-tools bash wsdd \
  && mkdir /init-config /config /shares

# copy config files from project folder to get a default config going for samba and supervisord
COPY run.sh /

# volume mappings
VOLUME /config

# exposes samba's default ports (137, 138 for nmbd and 139, 445 for smbd)
EXPOSE 137/udp 138/udp 139 445

CMD ["/run.sh"]
