# FTP
FROM alpine:3.18

RUN apk add --no-cache \
    curl=8.5.0-r0 \
    pure-ftpd=1.0.51-r1

RUN mkdir -p /var/www/html /etc/pure-ftpd/conf /var/log/pure-ftpd \
    && chmod 755 /var/www/html

COPY tools/entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# -j: --createhomedir
# -Y: --tls O: no TLS
# -p: --passiveportrange
# -P: --forcepassiveip
CMD ["pure-ftpd", "-j", "-Y", "O", "-p", "30000:30000", "-P", "localhost"]
