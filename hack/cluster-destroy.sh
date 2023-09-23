#!/bin/bash

DIR="$(dirname "$0")"
source "${DIR}/logging.sh"
source "${DIR}/helper.sh"

# Use environment variable for cluster name
CLUSTER_NAME=${CLUSTER_NAME}

# Validate the cluster name
if [[ -z ${CLUSTER_NAME} || ! ${CLUSTER_NAME} =~ ^[a-zA-Z0-9-]+$ ]]; then
    log_err "Invalid or empty cluster name: ${CLUSTER_NAME}. It must contain only alphanumeric characters and hyphens."
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
