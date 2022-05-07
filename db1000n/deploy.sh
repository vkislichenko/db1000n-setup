#!/bin/sh

SCRIPT_DIR=$(dirname $0)

. "$SCRIPT_DIR/../.env"

$DOCKER_COMPOSE_COMMAND -f "$DB1000N_DOCKER_COMPOSE_FILE" down
$DOCKER_COMPOSE_COMMAND -f "$DB1000N_DOCKER_COMPOSE_FILE" pull
$DOCKER_COMPOSE_COMMAND -f "$DB1000N_DOCKER_COMPOSE_FILE" up -d
