source $BOS_DIR/scripts/utils.sh

alias srec='echo Error: your current distro '$BOS_DISTRO' does not support reconfiguration'

srec_guix() {
	if [ -z "$1" ]; then
        echo "srec: using current system '$BOS_SYSTEM'"
    fi
	local SYSTEM="${1-$BOS_SYSTEM}"

     SYSTEM_DIR="$BOS_SYSTEM_DIR" TARGET="$SYSTEM" guix system -L $BOS_DIR/guix -L $BOS_CONFIG_DIR reconfigure $BOS_DIR/guix/bos/system/base.scm
}

if [ "$BOS_DISTRO" = "guix" ]; then
	alias srec='srec_guix'
	alias system='guix system'

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

srec_nix() {
	if [ -z "$1" ]; then
		echo "srec: using current system '$BOS_SYSTEM'"
	fi
	local SYSTEM="${1-$BOS_SYSTEM}"

	cd $BOS_CONFIG_DIR
	TARGET="$SYSTEM" should_sudo nixos-rebuild switch --flake .#${SYSTEM} --impure
	cd -
}

if [ "$BOS_DISTRO" = "nix" ]; then
	alias srec='srec_nix'

	alias upflake='nix flake update'
fi
