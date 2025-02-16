source $BOS_DIR/scripts/utils.sh

alias hrec='echo Error: no home manager installed'

hrec_guix() {
	if [ -z "$1" ]; then
		echo "hrec: using current home '$BOS_HOME_NAME'"
	fi
	local HOME_NAME="${1-$BOS_HOME_NAME}"

	#! DO NOT SUDO ON HOME RECONFIGURES
	HOME_DIR="$BOS_HOME_DIR" TARGET="$HOME_NAME" home -L $BOS_DIR/guix -L $BOS_CONFIG_DIR reconfigure $BOS_DIR/guix/bos/home/base.scm
}

if [ "$BOS_HOME_TYPE" = "guix" ]; then
	alias hrec='hrec_guix'
	alias hdesc='home describe'
	alias home='guix home'

	alias hswitch='home switch-generation'
	alias hlist='home list-generations'
fi

hrec_nix() {
	if [ -z "$1" ]; then
		echo "hrec: using current home '$BOS_HOME_NAME'"
	fi
	local HOME_NAME="${1-$BOS_HOME_NAME}"

	cd $BOS_CONFIG_DIR
	#! DO NOT SUDO ON HOME RECONFIGURES
	TARGET="$HOME_NAME" USER="$USER" home-manager switch --flake .#${HOME_NAME}-${USER} --impure
	cd -
}

if [ "$BOS_HOME_TYPE" = "nix" ]; then
	alias hrec='hrec_nix'
	alias home='home-manager'
fi
