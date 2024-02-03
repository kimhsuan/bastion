#!/usr/bin/env bash
set -e

action=${1-}
service=${2-}
args=("$@")

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ENV="${DIR}/.env"
DOCKER_CMD="docker"
COMPOSE_CMD="docker compose"
USAGE="Usage: $0 {start|stop|restart|status} {service}"
DATA_DIR="${DIR}/data"

. ${ENV}

source ${DIR}/scripts/install_docker.sh
source ${DIR}/scripts/functions.sh

function start() {
  ${EXE} up -d ${SERVICE}
}

function stop() {
  ${EXE} down ${SERVICE}
}

function main() {
  check_docker
  SERVICE=${service}
  EXE=$(get_compose_file_cmd ${SERVICE})
  echo ${EXE}
  case "${action}" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    echo -e "\n"
    start
    ;;
  *)
    echo ${USAGE}
    ;;
  esac
}

main "$@"
