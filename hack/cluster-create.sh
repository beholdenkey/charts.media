#!/bin/bash

source "$(dirname "$0")/hack/logging.sh"
source "$(dirname "$0")/hack/checks.sh"

log_set_priority debug

# create k3d cluster
create_cluster() {
    # Check if k3d is installed
    k3d_check
    # Check if CLUSTER_NAME is set and not empty
    if [[ -z ${CLUSTER_NAME} ]]; then
        log_err "CLUSTER_NAME is not set or empty. Current value: '${CLUSTER_NAME}'. Please set CLUSTER_NAME first."
        return 2
    fi

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
        return 3
    fi
}
