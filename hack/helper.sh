#!/bin/bash

source "$(dirname "$0")/logging.sh"

# Check if a command is available
# $1: command to check
is_command() {
    command -v "$1" >/dev/null 2>&1
}

# Exit with a specific message and code if a command is not available
# $1: command to check
# $2: error message
# $3: exit code (optional, default: 1)
check_command_or_exit() {
    if ! is_command "$1"; then
        log_err "$2"
        exit "${3:-1}"
    fi
}

# Check if Brew is installed
brew_check() {
    check_command_or_exit brew "Brew is not installed. Please install Brew first."
}

# Check if Git is installed
git_check() {
    check_command_or_exit git "Git is not installed. Please install Git first."
}

# Check if Helm is installed
helm_check() {
    check_command_or_exit helm "Helm is not installed. Please install Helm first."
}

# Check if kubectl is installed
kubectl_check() {
    check_command_or_exit kubectl "kubectl is not installed. Please install kubectl first."
}

# Check if k3d is installed
k3d_check() {
    check_command_or_exit k3d "k3d is not installed. Please install k3d first."
}

# Validate the cluster name
# $1: cluster name to validate
validate_cluster_name() {
    if [[ -z $1 || ! $1 =~ ^[a-zA-Z0-9-]+$ ]]; then
        log_err "Invalid or empty cluster name: $1. It must contain only alphanumeric characters and hyphens."
        exit 1
    fi
}

# Print a message and exit with a specific code
# $1: message
# $2: exit code (optional, default: 1)
exit_with_message() {
    log_err "$1"
    exit "${2:-1}"
}
