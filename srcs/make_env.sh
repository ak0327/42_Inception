#!/bin/bash


add_login() {
  local env_path=$1

  content='# login
  LOGIN=takira
  WP_DOMAIN=${LOGIN}.42.fr
  HUGO_DOMAIN=${LOGIN}.hugo.com
  '

  echo "$content" >> "$env_path"
}


add_volume() {
  local env_path=$1

  content='# bind volume
  VOLUME_DIR=/home/${LOGIN}/data
  DB_VOLUME_DIR=${VOLUME_DIR}/mariadb
  WP_VOLUME_DIR=${VOLUME_DIR}/wordpress
  HUGO_VOLUME_DIR=${VOLUME_DIR}/hugo
  '

  echo "$content" >> "$env_path"
}


add_db() {
  local env_path=$1

  content='# DB
  MYSQL_ROOT_PASSWORD=root
  MYSQL_DB_NAME=wp_db
  MYSQL_USER=db_user
  MYSQL_PASSWORD=db_pass
  '

  echo "$content" >> "$env_path"
}


add_wp() {
  local env_path=$1

  content='# Wordpress
  WP_PATH=/var/www/html
  WP_DB_HOST=mariadb:3306
  WP_DB_NAME=wp_db
  WP_DB_USER=db_user
  WP_DB_PASSWORD=db_pass

  WP_URL=${WP_DOMAIN}
  WP_TITLE=${LOGIN}_inception_page
  WP_ADMIN_USER=${LOGIN}
  WP_ADMIN_PASSWORD=${LOGIN}_pass
  WP_ADMIN_EMAIL=${LOGIN}@email.com
  WP_EDITOR_USER=editor
  WP_EDITOR_PASSWORD=editor_pass
  WP_EDITOR_EMAIL=editor@email.com
  '

  echo "$content" >> "$env_path"
}


add_ip() {
  local host_ip=$1
  local env_path=$2

  content="# IP address
  NGINX_NETWORK_SUBNET=192.168.1.0/24  # 192.168.1.1~192.168.1.254
  DNSMASQ_IP=192.168.1.53
  WEB_PAGE_IP=192.168.1.10
  HOST_IP=$host_ip
  "

  echo "$content" >> "$env_path"
}


add_cert() {
  local env_path=$1

  content='# Cert
  RSA_KEY_BITS=2048
  COUNTY=JP
  STATE=Tokyo
  ORGANIZATION=42Tokyo
  CRT_DIR=/etc/nginx/ssh
  '

  echo "$content" >> "$env_path"
}


main() {
  local env_path=$1

  host_ip=$(ip route get 1.1.1.1 | grep -oP 'src \K[\d.]+')

  echo "make: $env_path"
  echo "host_ip: ${host_ip}"

  rm -f $env_path

  add_login $env_path
  add_volume $env_path
  add_db $env_path
  add_wp $env_path
  add_ip $host_ip $env_path
  add_cert $env_path
}


main $1
