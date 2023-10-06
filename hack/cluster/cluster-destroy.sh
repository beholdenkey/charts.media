#!/bin/bash

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source required scripts
source "${SCRIPT_DIR}/../util/logging.sh"
source "${SCRIPT_DIR}/../util/helper.sh"

# Get cluster name from argument
CLUSTER_NAME=$1

# Validate cluster name
validate_cluster_name "${CLUSTER_NAME}"

# Function to destroy a cluster
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

# Call the function to destroy the cluster
destroy_cluster
