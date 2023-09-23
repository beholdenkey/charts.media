#!/bin/bash

# Source other scripts
DIR="$(dirname "$0")"
source "${DIR}/logging.sh"
source "${DIR}/helper.sh"
source "${DIR}/start-docker.sh"

log_set_priority debug

# Use environment variable for cluster name
CLUSTER_NAME=${CLUSTER_NAME}

# Validate the cluster name
if [[ -z ${CLUSTER_NAME} || ! ${CLUSTER_NAME} =~ ^[a-zA-Z0-9-]+$ ]]; then
    log_err "Invalid or empty cluster name: ${CLUSTER_NAME}. It must contain only alphanumeric characters and hyphens."
    exit 1
fi

# Ensure Brew, Git, Helm, kubectl, and k3d are installed.
brew_check || exit 1
git_check || exit 1
helm_check || exit 1
kubectl_check || exit 1
k3d_check || exit 1

# Ensure Docker is running.
start_docker || exit 1

# Create Cluster
# Check if cluster already exists
if k3d cluster list | grep -q "${CLUSTER_NAME}"; then
    log_info "Cluster ${CLUSTER_NAME} already exists. Skipping cluster creation."
else
    # Try to create the cluster and log the result
    if k3d cluster create "${CLUSTER_NAME}" -p "8900:30080@agent:0" -p "8901:30081@agent:0" -p "8902:30082@agent:0" --agents 2; then
        log_info "Cluster ${CLUSTER_NAME} created successfully."
    else
        log_err "Failed to create Cluster ${CLUSTER_NAME}."
        exit 1
    fi
fi
