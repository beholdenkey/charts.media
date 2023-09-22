#!/bin/bash

source "$(dirname "$0")/hack/logging.sh"

# Default cluster name
readonly DEFAULT_CLUSTER_NAME="media-cluster"

# Override cluster name with first script argument, if provided
CLUSTER_NAME=${1:-${DEFAULT_CLUSTER_NAME}}

# Validate the cluster name
if [[ ! "${CLUSTER_NAME}" =~ ^[a-zA-Z0-9-]+$ ]]; then
    log_err "Invalid cluster name: ${CLUSTER_NAME}. It must contain only alphanumeric characters and hyphens."
    exit 1
fi

create_cluster
