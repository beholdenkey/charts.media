#!/bin/bash

is_command() {
    command -v "$1" >/dev/null 2>&1
}
