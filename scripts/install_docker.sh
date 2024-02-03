#!/usr/bin/env bash

function start_docker() {
  if command -v systemctl &> /dev/null; then
    echo_yellow "Enabling and starting docker service..."
    sudo systemctl enable docker
    sudo systemctl start docker
  fi
  if ! docker ps &> /dev/null; then
    exit 1
  fi
}

function install_docker() {
  if ! command -v docker &> /dev/null; then
    echo_yellow "Docker not found, installing..."
    curl -fsSL https://get.docker.com | sudo bash -s -- --version ${DOCKER_VERSION:-"23.0"}
    sleep 1
    echo_yellow "Adding ${USER} to docker group..."
    sudo usermod -aG docker ${USER}
    newgrp docker
    start_docker
  fi
}

function check_docker() {
  command -v ${DOCKER_CMD} &> /dev/null || {
    install_docker
  }
  command -v ${COMPOSE_CMD} &> /dev/null || {
    install_docker
  }
}