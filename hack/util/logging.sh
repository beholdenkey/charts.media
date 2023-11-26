#!/bin/bash

# Define colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Toggle for color logging (1 for colored logging, 0 for no color)
COLOR_LOGGING=${COLOR_LOGGING:-1}

# Optional log file path
LOG_FILE=${LOG_FILE-}

# Global log prefix
GLOBAL_LOG_PREFIX=${GLOBAL_LOG_PREFIX-}

# Default log priority level (6: info)
_logp=6

# Set the logging priority level
# $1: priority level (emerg, alert, crit, err, warning, notice, info, debug) or numeric value
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

# Output log messages
# $1: message to log
log_output() {
    if [[ -n ${LOG_FILE} ]]; then
        echo -e "$(date '+%Y-%m-%d %H:%M:%S') $(log_prefix): $1" >>"${LOG_FILE}"
    else
        echo -e "$(date '+%Y-%m-%d %H:%M:%S') $(log_prefix): $1" >&2
    fi
}

# Get or check the log priority
# $1: priority to check (optional)
log_priority() {
    if test -z "$1"; then
        echo "${_logp}"
        return
    fi
    [[ $1 -le ${_logp} ]]
}

# Get the log tag based on priority
# $1: priority
log_tag() {
    [[ ${COLOR_LOGGING} -eq 0 ]] && {
        echo "$1"
        return
    }
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

# Get the log prefix
log_prefix() {
    echo -e "${GLOBAL_LOG_PREFIX}${LOG_PREFIX:-$0}"
}

# Log a debug message
# $*: message to log
log_debug() {
    log_priority 7 || return 0
    log_output "$(log_tag 7): $*" || true
}

# Log an info message
# $*: message to log
log_info() {
    log_priority 6 || return 0
    log_output "$(log_tag 6): $*" || true
}

# Log an error message
# $*: message to log
log_err() {
    log_priority 3 || return 0
    log_output "$(log_tag 3): $*" || true
}

# Log a critical error message
# $*: message to log
log_crit() {
    log_priority 2 || return 0
    log_output "$(log_tag 2): $*" || true
}
