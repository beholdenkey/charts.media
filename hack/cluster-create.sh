#!/bin/bash

# Source required scripts
source "$(dirname "$0")/logging.sh"
source "$(dirname "$0")/helper.sh"
source "$(dirname "$0")/start-docker.sh"

# Set log priority
log_set_priority debug

# Validate the cluster name
validate_cluster_name

# Check required dependencies
check_dependencies() {
    brew_check || exit 1
    git_check || exit 1
    helm_check || exit 1
    kubectl_check || exit 1
    k3d_check || exit 1
}

# Ensure Docker is running
ensure_docker_running() {
    start_docker || exit 1
}

# Function to create a cluster
create_cluster() {
    # Check if cluster already exists
    if k3d cluster list | grep -q "${CLUSTER_NAME}"; then
        log_info "Cluster ${CLUSTER_NAME} already exists. Skipping cluster creation."
        return 0
    fi

    # Try to create the cluster and log the result
    if k3d cluster create "${CLUSTER_NAME}" -p "8900:30080@agent:0" -p "8901:30081@agent:0" -p "8902:30082@agent:0" --agents 2; then
        log_info "Cluster ${CLUSTER_NAME} created successfully."
    else
        log_err "Failed to create Cluster ${CLUSTER_NAME}."
        exit 1
    fi
}
