image() {
	if [ "$BOS_DISTRO" = "guix" ] || [ "$BOS_HOME_TYPE" = "guix" ]; then
		i_guix 'guix' 'system' 'image' "$@"
	elif [ "$BOS_DISTRO" = "nix" ]; then
		echo "Not implemented"
	else
		echo "Error: your environment does not support image generation"
	fi
}

rimage() {
	if [ "$BOS_DISTRO" = "guix" ]; then
		i_guix 'guix' 'repl' '' "$@"
	elif [ "$BOS_DISTRO" = "nix" ]; then
		echo "Not implemented"
	else
		echo "Error: your environment does not support image generation"
	fi
}

valid_image_types=("wsl")

is_valid_image_type() {
    is_valid=false
    for typ in "${valid_image_types[@]}"; do
        if [[ "$1" == "$typ" ]]; then
            is_valid=true
            break
        fi
    done

    echo "$is_valid"
    return "$is_valid"
}

i_guix() {
    using_empty=false
    using_free=false
    inputs=()
    
    for arg in "$@"; do
        if [[ "$arg" == "-e" ]]; then
            using_empty=true
        elif [[ "$arg" == "-f" ]]; then
            using_free=true
        else
            inputs+=("$arg")
        fi
    done

    #!!! FOR WHATEVER REASON MY BASH ARRAYS ARE EXPECTING TO BE 1-based INDEXED??? Hopefully, at the very least, this is a bug intrinsic to this file and not this system :)

    IMAGE_TYPE="${inputs[4]:-}"
    echo "image type: $IMAGE_TYPE"
    if [ -z "${IMAGE_TYPE:-}" ] || [ ! $(is_valid_image_type "$IMAGE_TYPE") ]; then
        printf "Error: please supply an image type ( "
        printf "'%s' " "${valid_image_types[@]}"
        echo ")"
        return
    fi
    if [ ! -f "$BOS_DIR/guix/bos/system/$IMAGE_TYPE/image.scm" ]; then
        echo "Error: no implementation found for image type '$IMAGE_TYPE'"
    fi

    if [ "$using_empty" = true ]; then
        SYSTEM=""
        CONFIG_DIR=""
        echo "image: using 'empty (minimal)' system as image type '$IMAGE_TYPE'"
    else
        SYSTEM="${inputs[5]:-$BOS_SYSTEM}"
        CONFIG_DIR="$BOS_CONFIG_DIR"
        echo "image: using system '$SYSTEM' as image type '$IMAGE_TYPE'"
    fi

	USER="${inputs[6]:-root}"

      USER=$USER DOTFILES_DIR="$BOS_DOTFILES_DIR" FREE=$using_free SYSTEM_DIR="$BOS_SYSTEM_DIR" TARGET="$SYSTEM" "$1" "$2"\
        -L "$BOS_DIR/guix"\
        -L "$BOS_CONFIG_DIR"\
        $3\
        "$BOS_DIR/guix/bos/system/$IMAGE_TYPE/image.scm"
}

