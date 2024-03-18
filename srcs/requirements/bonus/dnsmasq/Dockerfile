# DNS server for takira.42.fr
FROM alpine:3.18

RUN apk add --no-cache \
    curl=8.5.0-r0 \
    dnsmasq=2.90-r0

RUN mkdir -p /var/log/dnsmasq
COPY conf/dnsmasq.conf /etc/dnsmasq.conf

EXPOSE 53 53/udp 53/tcp

CMD ["dnsmasq", "--keep-in-foreground"]
#CMD ["dnsmasq", "--no-daemon"]
