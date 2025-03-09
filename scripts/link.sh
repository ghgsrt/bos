source $BOS_DIR/scripts/utils.sh

create_symlink() {
    local src="$1"
    local dst="$2"
    local verbose="$3"

    if [ ! -e "$src" ]; then
        echo "Source file $src does not exist"
        return 1
    fi

    # If destination exists and is a symlink
    if [ -L "$dst" ]; then
        local current_target=$(readlink -f "$dst")
        # If it's already pointing to our source, skip
        if [ "$current_target" = "$(readlink -f "$src")" ]; then
            [ "$verbose" = true ] && echo "Symlink already correctly set for $dst"
            return 0
        else
            # If it's pointing somewhere else, replace it
            [ "$verbose" = true ] && echo "Replacing existing symlink $dst"
            should_sudo rm "$dst"
        fi
    elif [ -e "$dst" ]; then
        # If it's a regular file, warn and skip
        [ "$verbose" = true ] && echo "Warning: $dst exists and is not a symlink"
        return 1
    fi

    should_sudo ln -f "$src" "$dst"
    return $?
}

recursive_symlink() {
    local src_dir="$1"
    local dst_dir="$2"
    local verbose="$3"
    local -a exclusions=("${@:4}") # Get all arguments after the first three as exclusions
    local track_file="${dst_dir}/.symlink_tracking"

    # Ensure source directory exists
    if [ ! -d "$src_dir" ]; then
        echo "Source directory $src_dir does not exist"
        return 1
    fi

    # Create destination directory if it doesn't exist
    if [ ! -d "$dst_dir" ]; then
        should_sudo mkdir -p "$dst_dir"
    fi

    if [ ! -f "$track_file" ]; then
        should_sudo touch "$track_file"
    fi

    local exclude_expr=""
    for excl in "${exclusions[@]}"; do
        if [ -n "$exclude_expr" ]; then
            exclude_expr="$exclude_expr -o "
        fi
        exclude_expr="$exclude_expr -path \"$src_dir/$excl/*\" -o -path \"$src_dir/$excl\""
    done

    # Use find with exclusion if paths exist
    if [ -n "$exclude_expr" ]; then
        eval "find \"$src_dir\" -type f ! \( $exclude_expr \) -print0"
    else
        eval "find \"$src_dir\" -type f ! \( -name "_*" \) -print0"
    fi | while IFS= read -r -d $'\0' src_path; do
        # Calculate relative path from source directory
        local rel_path="${src_path#$src_dir/}"
        local dst_path="$dst_dir/$rel_path"

        # Create parent directories in destination if needed
        local dst_parent_dir=$(dirname "$dst_path")
        if [ ! -d "$dst_parent_dir" ]; then
            sudo mkdir -p "$dst_parent_dir"
        fi

        # If symlink was created successfully, track it
        if create_symlink "$src_path" "$dst_path" $verbose; then
            # Only add to tracking if not already present
            if ! grep -Fxq "$dst_path" "$track_file"; then
                should_sudo echo "$dst_path" >>"$track_file"
            fi
            [ "$verbose" = true ] && echo "Created symlink: $src_path"
        else
            [ "$verbose" = true ] && echo "Failed to create symlink: $src_path"
        fi
    done || true
}

recursive_unlink() {
    local src_dir="$1"
    local dst_dir="$2"
    local verbose="$3"
    local track_file="${dst_dir}/.symlink_tracking"

    if [ ! -f "$track_file" ]; then
        echo "No tracking file found at $track_file"
        return 1
    fi

    # Create a temporary file for the new tracking list
    local temp_track_file=$(mktemp)
    echo "Symlinks that failed to be removed after last unlink:\n" >"$temp_track_file"

    # Read the tracking file in reverse order
    while IFS= read -r link_path; do
        if [ -L "$link_path" ]; then
            # Verify this is a symlink pointing to our source directory
            #local target=$(readlink -f "$link_path")
            #if [[ "$target" == "$(readlink -f "$src_dir")"* ]]; then
            if should_sudo rm "$link_path"; then
                [ "$verbose" = true ] && echo "Removed symlink: $link_path"
            else
                # If removal failed, keep in tracking file
                [ "$verbose" = true ] && echo "Failed to remove symlink: $link_path"
                echo "$link_path" >>"$temp_track_file"
            fi
            #else
            #    [ "$verbose" = true ] && echo "Skipping $link_path - points to different source"
            # echo "$link_path" >> "$temp_track_file"
            #fi
        else
            [ "$verbose" = true ] && echo "Skipping $link_path - not a symlink or doesn't exist"
        fi
    done < <(tac "$track_file")

    # Replace original tracking file with new one if any entries remain
    if [ -s "$temp_track_file" ]; then
        should_sudo mv "$temp_track_file" "$track_file"
        echo "Warning: Some symlinks could not be removed"
    else
        rm "$track_file"
        rm "$temp_track_file"
    fi
}
