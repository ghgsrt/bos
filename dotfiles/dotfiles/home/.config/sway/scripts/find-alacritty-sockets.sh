#!/usr/bin/env bash

# Exit on error
set -e

if [ -z "$XDG_RUNTIME_DIR" ]; then
    echo "Error: XDG_RUNTIME_DIR environment variable is not set" >&2
    exit 1
fi

if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    echo "Error: $XDG_RUNTIME_DIR is not a directory or does not exist" >&2
    exit 1
fi

found_sockets=$(find "$XDG_RUNTIME_DIR" -name "*Alacritty*" 2>/dev/null)

if [ -z "$found_sockets" ]; then
    echo "No alacritty instances found in $XDG_RUNTIME_DIR" >&2
    exit 0
fi

echo "$found_sockets"

