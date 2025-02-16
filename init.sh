set -euo pipefail

USER=${USER:-$(whoami)}

source ./scripts/utils.sh
source ./scripts/link.sh

config=$BOS_CONFIG_DIR
distro=$BOS_DISTRO
system=$BOS_SYSTEM
home=$BOS_HOME_NAME
home_type=$BOS_HOME_TYPE
dotfiles=$BOS_DOTFILES_DIR
mode="all"
force_link=false
force_unlink=false
ignore_unlink=true
verbose=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	case $1 in
		-C|--config)
		echo "Config: $2"
			config="$2"
			shift 2  # Move past flag and its value
			;;
		-O|--distro)
			distro="$2"
			shift 2
			;;
		-S|--system)
			system="$2"
			shift 2
			;;
		-H|--home)
			home="$2"
			shift 2
			;;
		-T|--home-type)
			home_type="$2"
			shift 2
			;;
		-D|--dotfiles)
			dotfiles="$2"
			shift 2
			;;
		-M|--mode)
			mode="$2"
			shift 2
			;;
		-f|--force-link)
			force_link=true
			shift
			;;
		-u|--force-unlink)
			force_unlink=true
			shift
			;;
		-i|--ignore-unlink)
			ignore_unlink=false
			shift
			;;
		-v|--verbose)
			verbose=true
			shift    # Move past flag only (no value needed)
			;;
		*)
			echo "Unknown option: $1"
			return 1
			;;
	esac
done

# Use the parsed arguments
if [ "$verbose" = true ]; then
	echo "Config: $config"
	echo "Distro: $distro"
	echo "System: $system"
	echo "Dotfiles: $dotfiles"
	echo "Home: $home"
	echo "Home type: $home_type"
fi

link_root() {
	if [ -d "$BOS_DOTFILES_DIR/root" ]; then
		recursive_symlink "$BOS_DOTFILES_DIR/root" "/"
	fi
}
unlink_root() {
	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/root" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/root" "/"
	fi
}
link_distro() {
	if [ -d "$BOS_DOTFILES_DIR/distros/$BOS_DISTRO" ]; then
		recursive_symlink "$BOS_DOTFILES_DIR/distros/$BOS_DISTRO" "/"
	fi
}
unlink_distro() {
	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/distros/$BOS_DISTRO" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/distros/$BOS_DISTRO" "/"
	fi
}
link_system() {
	if [ -d "$BOS_DOTFILES_DIR/systems/$BOS_SYSTEM" ]; then
		recursive_symlink "$BOS_DOTFILES_DIR/systems/$BOS_SYSTEM" "/"
	fi
}
unlink_system() {
	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/systems/$BOS_SYSTEM" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/systems/$BOS_SYSTEM" "/"
	fi
}

link_home() {
	if [ -d "$BOS_DOTFILES_DIR/~" ]; then
		recursive_symlink "$BOS_DOTFILES_DIR/~" "$HOME"
	fi
	if [ -d "$BOS_DOTFILES_DIR/.config" ]; then
		recursive_symlink "$BOS_DOTFILES_DIR/.config" "$XDG_CONFIG_HOME"
	fi

    # If user-specific configs exist, link them
    if [ -d "$BOS_DOTFILES_DIR/users/$USER" ]; then
        recursive_symlink "$BOS_DOTFILES_DIR/users/$USER" "$HOME/.config"
    fi
}
unlink_home() {
	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/~" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/~" "$HOME"
	fi
	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/.config" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/.config" "$XDG_CONFIG_HOME"
	fi

	# If user-specific configs exist, unlink them
	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/users/$USER" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/users/$USER" "$HOME/.config"
	fi
}

relink_root=true
relink_distro=true
relink_system=true
relink_home=true

if [ $mode = "all" ] || [ $mode = "system" ]; then
	if [ $force_unlink = false ] && [ $BOS_DOTFILES_DIR = $dotfiles ]; then
		relink_root=false
		if [ $BOS_DISTRO = $distro ]; then
			relink_distro=false
			if [ $BOS_SYSTEM = $system ]; then
				relink_system=false
			else
				unlink_system
			fi
		else
			unlink_distro
			unlink_system
		fi
	else
		unlink_root
		unlink_distro
		unlink_system
	fi
fi

if [ $mode = "all" ] || [ $mode = "home" ]; then
	if [ $force_unlink = false ] && [ $BOS_DOTFILES_DIR = $dotfiles ] && [ $BOS_HOME_NAME = $home ]; then
			relink_home=false
	else
		unlink_home
	fi
fi

BOS_DIR="$(dirname "$(readlink -f "$0")")"
echo "Using bos directory: $BOS_DIR"
BOS_DOTFILES_DIR="$BOS_DIR/dotfiles/$dotfiles"
BOS_CONFIG_DIR="$BOS_DIR/configs/$config"
BOS_SYSTEM_DIR="$BOS_CONFIG_DIR/system"
BOS_HOME_DIR="$BOS_CONFIG_DIR/home"
BOS_DISTRO=$distro
BOS_SYSTEM=$system
BOS_HOME_NAME=$home
BOS_HOME_TYPE=$home_type

setup_system() {
    echo "Setting up system configuration..."

	if [ $force_link = true ] || [ $relink_root = true ]; then
		link_root
	fi
	if [ $force_link = true ] || [ $relink_distro = true ]; then
		link_distro
	fi
	if [ $force_link = true ] || [ $relink_system = true ]; then
		link_system
	fi

	if [ -f "/etc/bos/profile" ]; then
		echo "/etc/bos/profile already exists. Remove it if you want to regenerate its contents."
		return
	fi

	if [ ! -d "/etc/bos" ]; then
		should_sudo mkdir /etc/bos
	fi

	cat << EOF | should_sudo tee "/etc/bos/profile" > /dev/null
# Generated by init script - DO NOT EDIT

export BOS_DIR="${BOS_DIR}"

export BOS_CONFIG_DIR="${BOS_CONFIG_DIR}"
export BOS_DOTFILES_DIR="${BOS_DOTFILES_DIR}"
export BOS_SYSTEM_DIR="${BOS_SYSTEM_DIR}"
export BOS_HOME_DIR="${BOS_HOME_DIR}"

export BOS_DISTRO="${BOS_DISTRO}"
export BOS_SYSTEM="${BOS_SYSTEM}"

if [ $BOS_DISTRO = "guix" ] || [ $BOS_DISTRO = "nix" ]; then
	source "${BOS_DIR}/scripts/reconfigure/system.sh"
	source "${BOS_DIR}/scripts/reconfigure/home.sh"
elif [ $BOS_HOME_TYPE = "guix" ] || [ $BOS_HOME_TYPE = "nix" ]; then
	source "${BOS_DIR}/scripts/reconfigure/home.sh"
fi

EOF

	# Ensure the generated file is readable
	should_sudo chmod 644 "/etc/bos/profile"
}

setup_home() {
    echo "Setting up home configuration for $USER..."

	if [ $force_link = true ] || [ $relink_home = true ]; then
		link_home
	fi

	if [ -f "$HOME/.bash_profile" ]; then
		if [ ! "$BOS_HOME_TYPE" = "guix" ] && [ ! "$BOS_HOME_TYPE" = "nix" ]; then
			echo "Warning: ~/.bash_profile already exists. Please ensure it sources /etc/bos/profile."
		fi
		return
	fi

	echo "Generating ~/.bash_profile ..."

	cat << EOF | should_sudo tee "$HOME/.bash_profile" > /dev/null
# Generated by init script - DO NOT EDIT

# Source system-wide profile
source /etc/bos/profile
EOF

	# Ensure the generated file is readable
    should_sudo chmod 644 "$HOME/.bash_profile"

	# ATM, only for indicating that dotfiles have already been linked to guix home
	mkdir "$HOME/.bos"
}

# Main
echo "Setting up configuration for $USER on $BOS_SYSTEM with ${BOS_DISTRO}..."
case "$mode" in
    "all")
        setup_system
        setup_home
        ;;
    "system")
        setup_system
        ;;
    "home")
        setup_home
        ;;
    *)
        echo "Invalid mode: $mode"
        exit 1
        ;;
esac

#TODO detect if guix or nix homes are available and hrec automatically
#TODO		if HOME_NAME is provided
#TODO detect if guix or nix systems are available and srec automatically

