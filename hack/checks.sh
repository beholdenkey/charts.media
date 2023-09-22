#!/bin/bash

source "$(dirname "$0")/hack/logging.sh"
source "$(dirname "$0")/hack/helper.sh"

log_set_priority debug

# Check if Brew is installed
brew_check() {
    if ! is_command brew; then
        log_err "Brew is not installed. Please install Brew first."
        exit 1
    else
        log_info "Brew is installed."
    fi
}

# Check if Git is installed
git_check() {
    if ! is_command git; then
        log_err "Git is not installed. Please install Git first."
        exit 1
    else
        log_info "Git is installed."
    fi
}

# check if helm is installed
helm_check() {
    if ! is_command helm; then
        log_err "Helm is not installed. Please install Helm first."
        exit 1
    else
        log_info "Helm is installed."
    fi
}

# check if kubectl is installed
kubectl_check() {
    if ! is_command kubectl; then
        log_err "kubectl is not installed. Please install kubectl first."
        exit 1
    else
        log_info "kubectl is installed."
    fi
}

k3d_check() {
    if ! is_command k3d; then
        log_err "k3d is not installed. Please install k3d first."
        exit 1
    else
        log_info "k3d is installed."
    fi
}
