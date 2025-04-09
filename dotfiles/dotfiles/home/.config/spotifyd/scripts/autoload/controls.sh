#!/usr/bin/env bash

dest="rs.spotifyd.instance$(pidof spotifyd)"
# become the active playback device
spotifyd_take_control() {
	dbus-send --print-reply --dest=$dest /rs/spotifyd/Controls rs.spotifyd.Controls.TransferPlayback
}

