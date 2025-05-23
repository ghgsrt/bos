source $BOS_DIR/scripts/utils.sh

hrec() {
	if [ -x "$(command -v guix)" ]; then
		h_guix 'guix' 'home' 'reconfigure' "$@"
	elif [ -x "$(command -v ___)" ]; then
		hrec_nix "$@"
	else
		echo "Error: no home manager available"
	fi
}

hrep() {
	if [ -x "$(command -v guix)" ]; then
		h_guix 'guix' 'repl' '' "$@"
	elif [ -x "$(command -v ___)" ]; then
		hrec_nix "$@"
	else
		echo "Error: no home manager available"
	fi
}

h_guix() {
	if [ -z "${4:-}" ]; then
		echo "hrec: using current home '$BOS_HOME_NAME'"
	fi
	local HOME_NAME="${4-$BOS_HOME_NAME}"

	if [ ! -d /var/guix/profiles/per-user/$USER ]; then
		should_sudo mkdir -p /var/guix/profiles/per-user/$USER
		should_sudo chown $USER /var/guix/profiles/per-user/$USER
	fi

	DOTFILES_DIR="$BOS_DOTFILES_DIR" HOME_DIR="$BOS_HOME_DIR" TARGET="$HOME_NAME" "$1" "$2" -L "$BOS_DIR/guix" -L "$BOS_CONFIG_DIR" $3 "$BOS_DIR/guix/bos/home/object.scm"
}

if [ "$BOS_HOME_TYPE" = "guix" ]; then
	alias hdesc='home describe'
	alias home='guix home'

	alias hswitch='home switch-generation'
	alias hlist='home list-generations'
fi

hrec_nix() {
	if [ -z "${1:-}" ]; then
		echo "hrec: using current home '$BOS_HOME_NAME'"
	fi
	local HOME_NAME="${1-$BOS_HOME_NAME}"

	cd $BOS_CONFIG_DIR
	#! DO NOT SUDO ON HOME RECONFIGURES
	TARGET="$HOME_NAME" USER="$USER" home-manager switch --flake .#${HOME_NAME}-${USER} --impure
	cd -
}

if [ "$BOS_HOME_TYPE" = "nix" ]; then
	alias home='home-manager'
fi
