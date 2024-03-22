# DNS server for takira.42.fr
FROM alpine:3.18

RUN apk add --no-cache \
    curl=8.5.0-r0 \
    dnsmasq=2.90-r0

RUN mkdir -p /etc/dnsmasq /var/log/dnsmasq \
    && chmod -R 755 /etc/dnsmasq
COPY conf/dnsmasq.conf /etc/dnsmasq.conf
COPY conf/hosts-dnsmasq /etc/hosts-dnsmasq

EXPOSE 53 53/udp 53/tcp

CMD ["dnsmasq", "--keep-in-foreground"]
#CMD ["dnsmasq", "--no-daemon"]
