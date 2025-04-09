#!/bin/sh

#TODO BETTER SETUP FOR CHECKING WALLPAPER DIRS
WALLPAPER_DIR="$HOME/wallpapers"

LAST_CMD_FILE="$HOME/.cache/bos/last_wallpaper_cmd"

mkdir -p "$(dirname "$LAST_CMD_FILE")"
if [ ! -f "$LAST_CMD_FILE" ]; then
	touch "$LAST_CMD_FILE"
fi
if [ ! -f "$LAST_CMD_FILE.previous" ]; then
	touch "$LAST_CMD_FILE.previous"
fi

TOGGLE=false

echo "before: $1"
while [[ $# -gt 0 ]]; do
	case $1 in
		--toggle)
			TOGGLE=true; shift;;
		*)
			if [ -z "$CHOICE" ]; then CHOICE="$1"; shift
			else break; fi;;
	esac
done
		
[[ "${CHOICE:0:1}" == "#" ]] && IS_SOLID=true || IS_SOLID=false
#if $IS_SOLID; then CHOICE=${CHOICE:1:7}; fi # must be format rrggbb
REST=$@

get_command() {
	case "$1" in
		"swaymsg")
			if $IS_SOLID; then echo "swaymsg 'output * background $CHOICE solid_color'"
			else echo "swaymsg 'output * background $CHOICE fill'"; fi
		;;
		"swaybg")
			#TODO store PID and pkill after starting new process to avoid flashing
			if $IS_SOLID; then
				choice=${CHOICE:1:7}
				echo "pkill swaybg &>/dev/null; swaybg -c $choice"
			else echo "pkill swaybg &>/dev/null; swaybg -i $CHOICE"; fi
		;;
		"swww")
			if $IS_SOLID; then
				choice=${CHOICE:1:7}
				echo "swww init &>/dev/null; swww clear $choice"
			else echo "swww init &>/dev/null; swww img $CHOICE $REST"; fi
		;;
	esac
}

if command -v "sway" &>/dev/null; then
	declare -a bg_progs=("swww" "swaymsg") # ensure order
fi

if [ -z $bg_progs ]; then
	echo "Error: your compositor is not supported"
	return
fi

## want terminals transparent when using solid color
adjust_terminals() {
	local cmd=""

	if command -v "foot" &>/dev/null; then
		#if $IS_SOLID; then cmd+="foot --server -o colors.alpha=0"
		#else cmd+="foot --server -o colors.alpha="; fi
		#cmd+=";"
		echo "Who knows" >/dev/null
	fi

	if command -v "alacritty" &>/dev/null; then
		local sockets=$($HOME/.config/sway/scripts/find-alacritty-sockets.sh)

		while IFS= read -r socket; do
		  if [ -S "$socket" ]; then
				if $IS_SOLID; then
					cmd+="alacritty msg --socket \"$socket\" config window.opacity=0"
				else
					cmd+="alacritty msg --socket \"$socket\" config -r"
				fi
				cmd+=";"
		  fi
		done <<< "$sockets"
	fi

	echo $cmd
}

adjust_bars() {
	local cmd=""

	if command -v "swaybar" &>/dev/null; then
		if $IS_SOLID; then
			# for item in $(swaymsg -t get_bar_config)
			#TODO get these damn colors dynamically
			cmd+="swaymsg 'bar bar-0 colors background #00000000';"
			cmd+="swaymsg 'bar bar-0 colors focused_workspace #00000000 #00000000 #e78a4e';"
			cmd+="swaymsg 'bar bar-0 colors active_workspace #7daea3 #00000000 #7daea3';"
			cmd+="swaymsg 'bar bar-0 colors inactive_workspace #00000000 #00000000 #928374';"
			cmd+="swaymsg 'bar bar-0 colors urgent_workspace #ea6962 #00000000 #ea6962'"

			#TODO figure out how to dynamically set back to the original value (it shouldn't be so hard smh)
		else
			cmd+="swaymsg 'bar bar-0 colors background #000000cd';" #$(swaymsg -t get_config | grep -m 1 "$trans_background")"
			cmd+="swaymsg 'bar bar-0 colors focused_workspace #000000cd #000000cd #e78a4e';"
			cmd+="swaymsg 'bar bar-0 colors active_workspace #7daea3 #000000cd #7daea3';"
			cmd+="swaymsg 'bar bar-0 colors inactive_workspace #000000cd #000000cd #928374';"
			cmd+="swaymsg 'bar bar-0 colors urgent_workspace #ea6962 #000000cd #ea6962'"
		fi
	fi

	echo $cmd
}

for key in "${bg_progs[@]}"; do
	if command -v "$key" &>/dev/null; then
		LAST_CMD=$(cat "$LAST_CMD_FILE")
		PREV_CMD=$(cat "$LAST_CMD_FILE.previous")
		CHANGE_CMD=$(get_command "$key")
		TERM_CMD=$(adjust_terminals)
		BAR_CMD=$(adjust_bars)

		CMD="$BAR_CMD;$TERM_CMD $CHANGE_CMD"

		if [ $TOGGLE = false ]; then
			eval "$CMD"

			if [ "$LAST_CMD" != "$CMD" ]; then
				echo "$CMD" > "$LAST_CMD_FILE"
				echo "$LAST_CMD" > "$LAST_CMD_FILE.previous"
			fi
		elif [ -z "$PREV_CMD" ]; then break
		else
			eval "$PREV_CMD"
			echo "$PREV_CMD" > "$LAST_CMD_FILE"
			echo "$CMD" > "$LAST_CMD_FILE.previous"
		fi

		break
	fi
done

