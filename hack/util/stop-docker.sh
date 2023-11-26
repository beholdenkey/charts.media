#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/../util/logging.sh"
source "${SCRIPT_DIR}/../util/helper.sh"

# Function to stop Docker
stop_docker() {
    # Check if Docker is installed
    check_command_or_exit docker "Docker is not installed. Please install Docker and try again."

    # Check if Docker is running
    if docker info >/dev/null 2>&1; then
        log_info "Stopping Docker. Please wait..."

        # Stop all running containers
        local running_containers=$(docker ps -q)
        if [[ -n ${running_containers} ]]; then
            docker stop "${running_containers}"
            log_info "Docker has stopped successfully."
        else
            log_info "No running Docker containers to stop."
        fi
    else
        log_err "Docker is not running."
        return 1
    fi
}
