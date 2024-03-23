#!/bin/sh

set -eu -o pipefail

mkdir -p ${HUGO_CONTAINER_PATH}

if [ -z "$(ls -A ${HUGO_CONTAINER_PATH})" ]; then
  hugo new site ${HUGO_CONTAINER_PATH}

  THEME_PATH=${HUGO_CONTAINER_PATH}/themes/hello-friend-ng
  git clone https://github.com/rhazdon/hugo-theme-hello-friend-ng.git ${THEME_PATH}
  cp -r ${THEME_PATH}/exampleSite/content/ ${HUGO_CONTAINER_PATH}/
#  cp -r ${THEME_PATH}/exampleSite/config.toml ${HUGO_CONTAINER_PATH}/

  cp /tmp/config.toml ${HUGO_CONTAINER_PATH}
  cp /tmp/about.md ${HUGO_CONTAINER_PATH}/content

fi

chown -R nobody:nobody "${HUGO_CONTAINER_PATH}"
chmod -R 755 "${HUGO_CONTAINER_PATH}"

exec "$@"
