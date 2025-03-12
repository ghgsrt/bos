source $BOS_DIR/scripts/utils.sh

srec() {
	if [ "$BOS_DISTRO" = "guix" ]; then
		s_guix 'guix' 'system' 'reconfigure' "$@"
	elif [ "$BOS_DISTRO" = "nix" ]; then
		s_nix "$@"
	else
		echo "Error: '$BOS_DISTRO' does not support reconfiguration"
	fi
}

srep() {
	if [ "$BOS_DISTRO" = "guix" ]; then
		s_guix 'guix' 'repl' '' "$@"
	elif [ "$BOS_DISTRO" = "nix" ]; then
		s_nix "$@"
	else
		echo "Error: '$BOS_DISTRO' does not support reconfiguration"
	fi
}

s_guix() {
	if [ -z "${4:-}" ]; then
        echo "srec: using current system '$BOS_SYSTEM' with dotfiles '$BOS_DOTFILES'"
    fi
	local SYSTEM="${4-$BOS_SYSTEM}"

     DOTFILES_DIR="$BOS_DOTFILES_DIR" SYSTEM_DIR="$BOS_SYSTEM_DIR" TARGET="$SYSTEM" "$1" "$2" -L "$BOS_DIR/guix" -L "$BOS_CONFIG_DIR" $3 "$BOS_DIR/guix/bos/system.scm"
}

if [ "$BOS_DISTRO" = "guix" ]; then
	alias pull='should_sudo guix pull'
	alias herd='should_sudo herd'
	alias sdesc='system describe'

	alias sswitch='system switch-generation'
	alias slist='system list-generations'

	alias package='guix package'
	alias pupdate='pull && should_sudo package -u'
	alias pinstall='package -i'
	alias premove='package -r'
	alias psearch='package -s'
	alias pinfo='package -I'
	alias plist='package -p'
fi

s_nix() {
	if [ -z "$1" ]; then
		echo "srec: using current system '$BOS_SYSTEM'"
	fi
	local SYSTEM="${1-$BOS_SYSTEM}"

	cd $BOS_CONFIG_DIR
	TARGET="$SYSTEM" should_sudo nixos-rebuild switch --flake .#${SYSTEM} --impure
	cd -
}

if [ "$BOS_DISTRO" = "nix" ]; then
	alias upflake='nix flake update'
fi
