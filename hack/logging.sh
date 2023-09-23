#!/bin/bash

# Define colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

log_prefix() {
    echo -e "${LOG_PREFIX:-$0}"
}

_logp=6

log_set_priority() {
    case "$1" in
    emerg | 0) _logp=0 ;;
    alert | 1) _logp=1 ;;
    crit | 2) _logp=2 ;;
    err | 3) _logp=3 ;;
    warning | 4) _logp=4 ;;
    notice | 5) _logp=5 ;;
    info | 6) _logp=6 ;;
    debug | 7) _logp=7 ;;
    *) _logp="$1" ;;
    esac
}

log_output() {
    echo -e "$(log_prefix): $1" >&2
}

log_priority() {
    if test -z "$1"; then
        echo "${_logp}"
        return
    fi
    [[ $1 -le ${_logp} ]]
}

log_tag() {
    case $1 in
    0) echo "${RED}emerg${NC}" ;;
    1) echo "${RED}alert${NC}" ;;
    2) echo "${RED}crit${NC}" ;;
    3) echo "${RED}err${NC}" ;;
    4) echo "${YELLOW}warning${NC}" ;;
    5) echo "${YELLOW}notice${NC}" ;;
    6) echo "${GREEN}info${NC}" ;;
    7) echo "debug" ;;
    *) echo "$1" ;;
    esac
}

log_debug() {
    log_priority 7 || return 0
    log_output "$(log_tag 7): $*" || true
}

log_info() {
    log_priority 6 || return 0
    log_output "$(log_tag 6): $*" || true
}

log_err() {
    log_priority 3 || return 0
    log_output "$(log_tag 3): $*" || true
}

log_crit() {
    log_priority 2 || return 0
    log_output "$(log_tag 2): $*" || true
}
