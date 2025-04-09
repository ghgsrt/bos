set -euo pipefail
shopt -s expand_aliases

USER=${USER:-$(whoami)}

BOS_DIR="$(dirname "$(readlink -f "$0")")"
echo "Using bos directory: $BOS_DIR"

source "$BOS_DIR/scripts/utils.sh"
source "$BOS_DIR/scripts/link.sh"

config=${BOS_CONFIG:-}
distro=${BOS_DISTRO:-}
system=${BOS_SYSTEM:-}
home=${BOS_HOME_NAME:-}
home_type=${BOS_HOME_TYPE:-}
dotfiles=${BOS_DOTFILES:-}

mode="all"
force_link=false
force_unlink=false
no_relink=false
ignore_unlink=false
no_reconfigure_system=false
no_reconfigure_home=false
verbose=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	case $1 in
	-C | --config)
		echo "Config: $2"
		config="$2"
		shift 2 # Move past flag and its value
		;;
	-O | --distro)
		distro="$2"
		shift 2
		;;
	-S | --system)
		system="$2"
		shift 2
		;;
	-H | --home)
		home="$2"
		shift 2
		;;
	-T | --home-type)
		home_type="$2"
		shift 2
		;;
	-D | --dotfiles)
		dotfiles="$2"
		shift 2
		;;
	-M | --mode)
		mode="$2"
		shift 2
		;;
	-f | --force-link)
		force_link=true
		shift
		;;
	-un | --force-unlink-no-relink)
		force_unlink=true
		no_relink=true
		shift
		;;
	-u | --force-unlink)
		force_unlink=true
		shift
		;;
	-i | --ignore-unlink)
		ignore_unlink=false
		shift
		;;
	-nr | --no-reconfigure)
		no_reconfigure_system=true
		no_reconfigure_home=true
		shift
		;;
	-nrs | --no-reconfigure-system)
		no_reconfigure_system=true
		shift
		;;
	-nrh | --no-reconfigure-home)
		no_reconfigure_home=true
		shift
		;;
	-v | --verbose)
		verbose=true
		shift # Move past flag only (no value needed)
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
		recursive_symlink "$BOS_DOTFILES_DIR/root" "/" "$verbose"
	fi
}
unlink_root() {
	if [[ ! -v BOS_DOTFILES_DIR ]]; then return; fi

	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/root" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/root" "/" "$verbose"
	fi
}
link_distro() {
	if [ -d "$BOS_DOTFILES_DIR/distros/$BOS_DISTRO" ]; then
		recursive_symlink "$BOS_DOTFILES_DIR/distros/$BOS_DISTRO" "/" "$verbose"
	fi
}
unlink_distro() {
	if [[ ! -v BOS_DOTFILES_DIR ]]; then return; fi

	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/distros/$BOS_DISTRO" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/distros/$BOS_DISTRO" "/" "$verbose"
	fi
}
link_system() {
	if [ -d "$BOS_DOTFILES_DIR/systems/$BOS_SYSTEM" ]; then
		recursive_symlink "$BOS_DOTFILES_DIR/systems/$BOS_SYSTEM" "/" "$verbose"
	fi
}
unlink_system() {
	if [[ ! -v BOS_DOTFILES_DIR ]]; then return; fi

	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/systems/$BOS_SYSTEM" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/systems/$BOS_SYSTEM" "/" "$verbose"
	fi
}

link_home() {
	# If user-specific configs exist, give precedence and link them
	if [ -d "$BOS_DOTFILES_DIR/users/$USER" ]; then
		recursive_symlink "$BOS_DOTFILES_DIR/users/$USER" "$HOME" "$verbose"
	fi

	if [ -d "$BOS_DOTFILES_DIR/home" ]; then
		recursive_symlink "$BOS_DOTFILES_DIR/home" "$HOME" "$verbose"
	fi
}
unlink_home() {
	if [[ ! -v BOS_DOTFILES_DIR ]]; then return; fi

	# If user-specific configs exist, unlink them
	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/users/$USER" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/users/$USER" "$HOME" "$verbose"
	fi

	if [ $ignore_unlink = false ] && [ -d "$BOS_DOTFILES_DIR/home" ]; then
		recursive_unlink "$BOS_DOTFILES_DIR/home" "$HOME" "$verbose"
	fi
}

if [ $no_relink = false ]; then
	relink_def=true
else
	relink_def=false
fi
relink_root=$relink_def
relink_distro=$relink_def
relink_system=$relink_def
relink_home=$relink_def

if [ "$mode" = "all" ] || [ "$mode" = "system" ]; then
	if [ "$force_unlink" = false ] && [[ -v BOS_DOTFILES ]] && [ "$BOS_DOTFILES" = "$dotfiles" ]; then
		#		relink_root=false
		if [[ -v BOS_DISTRO ]] && [ "$BOS_DISTRO" = "$distro" ]; then
			#			relink_distro=false
			if [[ -v BOS_SYSTEM ]] && [ ! "$BOS_SYSTEM" = "$system" ]; then
				#				relink_system=false
				#else
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

if [ "$mode" = "all" ] || [ "$mode" = "home" ]; then
	if [ "$force_unlink" = true ] && [[ ! -v BOS_DOTFILES ]] && [ ! "$BOS_DOTFILES" = "$dotfiles" ]; then
		#		relink_home=false
		#else
		unlink_home
	fi
fi

BOS_CONFIG=$config
BOS_DOTFILES=$dotfiles
BOS_DISTRO=$distro
BOS_SYSTEM=$system
BOS_HOME_NAME=$home
BOS_HOME_TYPE=$home_type

BOS_DOTFILES_DIR="$BOS_DIR/dotfiles/$dotfiles"
BOS_CONFIG_DIR="$BOS_DIR/configs/$config"
BOS_SYSTEM_DIR="$BOS_CONFIG_DIR/system"
BOS_HOME_DIR="$BOS_CONFIG_DIR/home"

setup_system() {
	echo "Setting up system configuration..."

	if [ $no_reconfigure_system = false ] && [ ! -z "$BOS_SYSTEM" ]; then
		source "$BOS_DIR/scripts/reconfigure/system.sh"
		if command -v srec &>/dev/null; then
			srec
		fi
	fi

	if [ $force_link = true ] || [ $relink_root = true ]; then
		link_root
	fi
	if [ $force_link = true ] || [ $relink_distro = true ]; then
		link_distro
	fi
	if [ $force_link = true ] || [ $relink_system = true ]; then
		link_system
	fi

	if [ ! -d "/etc/bos" ]; then
		should_sudo mkdir /etc/bos
	fi
	
	if [ -f "/etc/bos/profile" ]; then
		echo "/etc/bos/profile already exists. Remove it if you want to regenerate its contents."
		return
	fi

	cat <<EOF | should_sudo tee "/etc/bos/profile" >/dev/null
# Generated by init script - DO NOT EDIT

export BOS_DIR="${BOS_DIR}"

export BOS_CONFIG="${BOS_CONFIG}"
export BOS_DOTFILES="${BOS_DOTFILES}"

export BOS_CONFIG_DIR="${BOS_CONFIG_DIR}"
export BOS_DOTFILES_DIR="${BOS_DOTFILES_DIR}"
export BOS_SYSTEM_DIR="${BOS_SYSTEM_DIR}"
export BOS_HOME_DIR="${BOS_HOME_DIR}"

export BOS_DISTRO="${BOS_DISTRO}"
export BOS_SYSTEM="${BOS_SYSTEM}"

gpg-connect-agent updatestartuptty /bye >/dev/null
unset SSH_AGENT_PID
if [ "\${gnupg_SSH_AUTH_SOCK_by:-0}" -ne \$\$ ]; then
	export SSH_AUTH_SOCK="\$(gpgconf --list-dirs agent-ssh-socket)"
fi

EOF

	# Ensure the generated file is readable
	should_sudo chmod 644 "/etc/bos/profile"

	if [ -f "/etc/bos/bashrc" ]; then
		echo "/etc/bos/bashrc already exists. Remove it if you want to regenerate its contents."
		return
	fi

	cat <<EOF | should_sudo tee "/etc/bos/bashrc" >/dev/null
# Generated by init script - DO NOT EDIT

# needs to be set whenever a shell changes (otherwise pinentry curses in tmux can cause weird behavior and crash; at least I hope this is the culprit lol)
export GPG_TTY=\$(tty)
if [ "\$BOS_DISTRO" = "guix" ] || [ "\$BOS_DISTRO" = "nix" ]; then
	source "\${BOS_DIR}/scripts/reconfigure/system.sh"
	source "\${BOS_DIR}/scripts/reconfigure/home.sh"
	source "\${BOS_DIR}/scripts/image.sh"
elif [ "\$BOS_HOME_TYPE" = "guix" ] || [ "\$BOS_HOME_TYPE" = "nix" ]; then
	source "\${BOS_DIR}/scripts/reconfigure/home.sh"
	source "\${BOS_DIR}/scripts/image.sh"
fi

EOF

	# Ensure the generated file is readable
	should_sudo chmod 644 "/etc/bos/bashrc"
}

setup_home() {
	echo "Setting up home configuration for $USER..."

	if [ $no_reconfigure_home = false ] && [ ! -z "$BOS_HOME_NAME" ]; then
		source "$BOS_DIR/scripts/reconfigure/home.sh"
		if command -v hrec &>/dev/null; then
			hrec
		fi
	fi

	if [ -f "$BOS_DOTFILES_DIR/home/.gnupg/sshcontrol" ] && [ -f "$HOME/.gnupg/sshcontrol" ]; then
		should_sudo rm "$HOME/.gnupg/sshcontrol"
	fi

	if [ $force_link = true ] || [ $relink_home = true ]; then
		echo "HUH"
		link_home
	fi

	if [ -f "$HOME/.bash_profile" ]; then
		if [ ! "$BOS_HOME_TYPE" = "guix" ] && [ ! "$BOS_HOME_TYPE" = "nix" ]; then
			echo "Warning: ~/.bash_profile already exists. Please ensure it sources /etc/bos/profile."
		fi
		return
	fi

	echo "Generating ~/.bash_profile ..."

	cat <<EOF | should_sudo tee "$HOME/.bash_profile" >/dev/null
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
