#!/usr/bin/env bash

# Log4Bash is a simple utility to help standardize logging in bash
# Copyright (C) 2022 Daddie0
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Configs
# ------------------------------------------------------------------------------
SCRIPT_NAME="$0"
# Replace all "/" with "" to avoid weird additional slashes to the script name
SCRIPT_NAME="${SCRIPT_NAME//\//}"

export LOGFILE="/var/log/cim/${SCRIPT_NAME}.log"
export LOG_FORMAT="%DATE | %PID | %LEVEL | %MESSAGE" # This was very shamelessly inspired by the way the MYSQL 8.0 Docker image handles logging

# Date format in RFC 3339
export LOG_DATE_FORMAT="--rfc-3339=seconds"

# Colors for log levels (RFC 5424)
# ------------------------------------------------------------------------------
# Numerical         Severity
#     Code

#     0       Emergency: system is unusable
#     1       Alert: action must be taken immediately
#     2       Critical: critical conditions
#     3       Error: error conditions
#     4       Warning: warning conditions
#     5       Notice: normal but significant condition
#     6       Informational: informational messages
#     7       Debug: debug-level messages
declare -A levels=([EMERGENCY]=0 [ALERT]=1 [CRITICAL]=2 [ERROR]=3 [WARNING]=4 [NOTICE]=5 [INFO]=6 [DEBUG]=7)

# Severity colors are as follows
# ------------------------------------------------------------------------------
# Emergency:    Red background
# Alert:        Yellow background
# Critical:     Blue background
# Error:        Red
# Warning:      Yellow
# Notice:       Green
# INFO:         White
# Debug:        Gray

export LOG_COLOR_EMERGENCY="\e[41m"
export LOG_COLOR_ALERT="\e[43m"
export LOG_COLOR_CRITICAL="\e[44m"
export LOG_COLOR_ERROR="\e[31m"
export LOG_COLOR_WARNING="\e[33m"
export LOG_COLOR_NOTICE="\e[32m"
export LOG_COLOR_INFO="\e[0m"
export LOG_COLOR_DEBUG="\e[37m"
export LOG_COLOR_RESET="\e[0m"
export LOG_LEVEL_DEFAULT="INFO"

[[ -z $LOG_LEVEL ]] && LOG_LEVEL=$LOG_LEVEL_DEFAULT

# Log levels
# ------------------------------------------------------------------------------

EMERGENCY() {
    LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"
    exit 1
}
ALERT() {
    LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"
    exit 1
}

CRITICAL() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }
ERROR() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }
WARNING() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }
NOTICE() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }
INFO() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }
DEBUG() { LOG_HANDLER_DEFAULT "$FUNCNAME" "$@"; }

FORMAT_LOG() {
    local level="$1"
    local message="$2"
    local pid=$$
    local date
    date="$(date "$LOG_DATE_FORMAT")"
    local formatted_log="${LOG_FORMAT}"

    formatted_log="${formatted_log/'%MESSAGE'/$message}"
    formatted_log="${formatted_log/'%LEVEL'/$level}"
    formatted_log="${formatted_log/'%PID'/$pid}"
    formatted_log="${formatted_log/'%DATE'/$date}"
    printf "%s\n" "$formatted_log" # According to SC2059 you should do "echo "$formatted_log"" like this dunno about the reason why
}

LOG() {
    local level="$1"
    local message="$2"
    local log_function_name="${!level}"
    $log_function_name "${message}"
}

#------------------------------------------------------------------------------
# Log handlers

LOG_HANDLER_DEFAULT() {
    [[ ${levels[$1]} ]] || return 1 # Default to info if no level is given
    [[ ${levels[$LOG_LEVEL]} ]] || LOG_LEVEL=$LOG_LEVEL_DEFAULT

    local formatted_log
    formatted_log="$(FORMAT_LOG "$@")"

    LOG_HANDLER_FILE "$1" "${formatted_log}"
    ((${levels[$1]} > ${levels[$LOG_LEVEL]})) && return 0 # Do not print to terminal if level is too low but still log to logfile (should probably make this more configurable later)
    LOG_HANDLER_COLOR "$1" "${formatted_log}"
}

LOG_HANDLER_COLOR() {
    local level="$1"
    local message="$2"
    local color="LOG_COLOR_${level}"
    message="${!color}${message}${LOG_COLOR_RESET}"
    echo -en "${message}\n"
}

LOG_HANDLER_FILE() {
    local level="$1"
    local message="$2"
    local log_path
    log_path="$(dirname "$LOGFILE")"
    [ -d "$log_path" ] || mkdir -p "$log_path"
    echo "${message}" >>"${LOGFILE}"
}
