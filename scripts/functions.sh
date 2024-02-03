#!/usr/bin/env bash

function echo_green() {
  echo -e "\033[1;32m$1\033[0m"
}

function echo_yellow() {
  echo -e "\033[1;33m$1\033[0m"
}

function get_compose_file_cmd() {
  SERVICE=$1
  if [ "${SERVICE}" ]; then
    COMPOSE_CMD+=" -f docker-compose-network.yml"
    case "${SERVICE}" in
    cloudflared)
      COMPOSE_CMD+=" -f docker-compose-${SERVICE}.yml"
      ;;
    next-terminal)
      COMPOSE_CMD+=" -f docker-compose-${SERVICE}.yml"
      ;;
    gitea)
      COMPOSE_CMD+=" -f docker-compose-${SERVICE}.yml"
      ;;
    esac
    echo "${COMPOSE_CMD}"
  else
    echo ${USAGE}
    exit 1
  fi
}
