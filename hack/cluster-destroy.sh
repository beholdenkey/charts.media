#!/bin/bash

DIR="$(dirname "$0")"
source "${DIR}/logging.sh"
source "${DIR}/helper.sh"

# Default cluster name
readonly DEFAULT_CLUSTER_NAME="media-cluster"

# Override cluster name with first script argument, if provided
CLUSTER_NAME=${1:-${DEFAULT_CLUSTER_NAME}}

# Validate the cluster name
if [[ ! ${CLUSTER_NAME} =~ ^[a-zA-Z0-9-]+$ ]]; then
    log_err "Invalid cluster name: ${CLUSTER_NAME}. It must contain only alphanumeric characters and hyphens."
    exit 1
fi

destroy_cluster() {
    # Check if k3d is installed
    k3d_check

    # Check if the cluster exists
    if ! k3d cluster list | grep -q "${CLUSTER_NAME}"; then
        log_info "Cluster ${CLUSTER_NAME} does not exist. Skipping cluster destruction."
        return 0
    fi

    # Try to destroy the cluster and log the result
    if k3d cluster delete "${CLUSTER_NAME}"; then
        log_info "Cluster ${CLUSTER_NAME} deleted successfully."
    else
        log_err "Failed to delete Cluster ${CLUSTER_NAME}."
        return 3
    fi
}

destroy_cluster
