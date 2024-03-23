# Hugo
FROM alpine:3.18

RUN apk add --no-cache \
    curl=8.5.0-r0 \
    git=2.40.1-r0 \
    hugo=0.111.3-r6

COPY conf/config.toml /tmp
COPY conf/about.md /tmp

COPY tools/entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/blog

EXPOSE 1313

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["hugo", "server", "--bind", "0.0.0.0", "--baseURL" , "takira.hugo.com", "--appendPort=false"]
