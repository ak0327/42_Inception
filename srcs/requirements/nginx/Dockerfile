# NGINX
FROM alpine:3.18

RUN apk add --no-cache \
    gettext-envsubst=0.21.1-r7 \
    curl=8.5.0-r0 \
    nginx=1.24.0-r7 \
    openssl=3.1.4-r5

RUN mkdir -p /var/run/nginx /etc/nginx/http.d
COPY conf/http.d/default.conf.template /etc/nginx/http.d/default.conf.template

COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
