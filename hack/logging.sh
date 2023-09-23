#!/bin/bash

log_prefix() {
    echo "${LOG_PREFIX:-$0}"
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
    echo "$(log_prefix): $1" >&2
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
    0) echo "emerg" ;;
    1) echo "alert" ;;
    2) echo "crit" ;;
    3) echo "err" ;;
    4) echo "warning" ;;
    5) echo "notice" ;;
    6) echo "info" ;;
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
