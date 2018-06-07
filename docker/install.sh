#!/bin/bash
set -e
curl -fsSL https://get.daocloud.io/docker | sh

systemctl enable docker.service
systemctl start  docker

curl -fsSL https://raw.githubusercontent.com/bityuan/install-script/master/docker/install-docker.sh | sh

