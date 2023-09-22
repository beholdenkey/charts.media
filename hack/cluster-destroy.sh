#!/bin/bash

source "$(dirname "$0")/hack/logging.sh"
source "$(dirname "$0")/hack/checks.sh"

destroy_cluster() {
    # Check if k3d is installed
    k3d_check
    # Check if CLUSTER_NAME is set and not empty
    if [[ -z ${CLUSTER_NAME} ]]; then
        log_err "CLUSTER_NAME is not set or empty. Current value: '${CLUSTER_NAME}'. Please set CLUSTER_NAME first."
        return 2
    fi

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
