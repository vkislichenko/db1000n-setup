#!/bin/sh

sudo apt-get install -y tmux vim jq git

wget -O - https://get.docker.com/ | bash

systemctl enable docker.service
systemctl start docker.service

mkdir -p /root/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o /root/.docker/cli-plugins/docker-compose
chmod +x /root/.docker/cli-plugins/docker-compose
