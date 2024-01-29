FROM alpine:3.19@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

LABEL org.opencontainers.image.description="Simple and lightweight Samba docker container, based on Alpine Linux."
LABEL org.opencontainers.image.authors="ed@edcourtenay.co.uk"
LABEL org.opencontainers.image.source="https://github.com/edcourtenay/docker-samba"
LABEL org.opencontainers.image.documentation="https://github.com/edcourtenay/docker-samba/blob/main/README.md"

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
  && mkdir /config /shares

# copy config files from project folder to get a default config going for samba and supervisord
COPY run.sh /

# volume mappings
VOLUME /config

# exposes samba's default ports (137, 138 for nmbd and 139, 445 for smbd)
EXPOSE 137/udp 138/udp 139 445

CMD ["/run.sh"]
