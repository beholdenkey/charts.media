#!/bin/bash

source "$(dirname "$0")/logging.sh"
source "$(dirname "$0")/helper.sh"

start_docker() {
    if ! is_command docker; then
        log_err "Docker is not installed. Please install Docker and try again."
        return 1
    fi

    open -a Docker

    log_info "Starting Docker. Please wait..."

    # Wait for Docker to start
    local timeout=60 # wait a maximum of 60 seconds for Docker to start
    while ! docker info >/dev/null 2>&1; do
        if ((timeout == 0)); then
            log_err "Docker failed to start within the allocated time."
            return 2
        fi

        sleep 1
        ((timeout--))
    done

    log_info "Docker has started successfully."
}
