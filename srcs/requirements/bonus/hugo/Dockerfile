# Hugo
FROM alpine:3.18

RUN apk add --no-cache \
    curl=8.5.0-r0 \
    hugo=0.111.3-r6

WORKDIR /var/www/blog
EXPOSE 1313

CMD ["hugo", "server", "--bind", "0.0.0.0"]
