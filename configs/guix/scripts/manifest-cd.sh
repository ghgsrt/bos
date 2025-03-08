#!/bin/bash

check_path_for_manifest() {
    local path=$1
    local current_manifest=$2

    # If absolute path or contains '..' start from root
    if [[ "$path" = /* ]] || [[ "$path" = *..* ]]; then
        path=$(realpath "$path")
        current_manifest=""
        local check_dir=""  # Start empty for root
        local parts=(${path#/})  # Split path into parts

        # Check root first
        [[ -f "/.guix-manifest" ]] && current_manifest="/"

        # Walk forward from root
        for part in ${parts[@]}; do
            check_dir="$check_dir/$part"
            [[ -f "$check_dir/.guix-manifest" ]] && current_manifest="$check_dir"
        done
    else
 		# Relative path without '..' - start from current dir
        local check_dir="$PWD"
        local parts=(${path//\// })  # Split path into parts

        for part in ${parts[@]}; do
            check_dir="$check_dir/$part"
            [[ -f "$check_dir/.guix-manifest" ]] && current_manifest="$check_dir"
        done
	fi

    echo "$current_manifest"
}

cd() {
    local target_path="$1"
    builtin cd "$target_path"
    local new_manifest=$(check_path_for_manifest "$target_path")

    if [[ -n "$new_manifest" ]]; then
        if [[ -z "$GUIX_ENVIRONMENT" ]] || [[ "$new_manifest" != "$GUIX_MANIFEST_PATH" ]]; then
            export GUIX_MANIFEST_PATH="$new_manifest"
            # cd "$PWD"
            exec guix shell -D -C "$new_manifest"
        fi
    elif [[ -n "$GUIX_ENVIRONMENT" ]]; then
        unset GUIX_MANIFEST_PATH
        exit
    fi
}