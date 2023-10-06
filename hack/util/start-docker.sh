#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_DIR}/../util/logging.sh"
source "${SCRIPT_DIR}/../util/helper.sh"

# Function to start Docker
start_docker() {
    # Check if Docker is installed
    check_command_or_exit docker "Docker is not installed. Please install Docker and try again."

    # Platform-specific command to open Docker
    case "$(uname -s)" in
    Darwin)
        open -a Docker
        ;;
    Linux)
        systemctl start docker || {
            log_err "Failed to start Docker using systemctl."
            return 1
        }
        ;;
    *)
        log_err "Unsupported platform for this script."
        return 1
        ;;
    esac

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

start_docker
