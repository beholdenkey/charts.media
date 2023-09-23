#!/bin/bash

# Source other scripts
DIR="$(dirname "$0")"
source "${DIR}/logging.sh"
source "${DIR}/helper.sh"
source "${DIR}/start-docker.sh"
source "${DIR}/cluster-create.sh"

# Set default log priority to debug
log_set_priority debug

# Default cluster name
readonly DEFAULT_CLUSTER_NAME="media-cluster"

# Override cluster name with the first script argument, if provided
CLUSTER_NAME=${1:-${DEFAULT_CLUSTER_NAME}}

# Validate the cluster name
if [[ ! ${CLUSTER_NAME} =~ ^[a-zA-Z0-9-]+$ ]]; then
    log_err "Invalid cluster name: ${CLUSTER_NAME}. It must contain only alphanumeric characters and hyphens."
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
create_cluster || exit 1
