#!/usr/bin/env bash

# optionally, we can start `spotifyd` here
if ! pidof -q spotifyd
then
  spotifyd --use-mpris
fi

dest=rs.spotifyd.instance$(pidof spotifyd)

wait_for_name() {
  dst=$1
  counter=0

  # check if controls are available
  until [ $counter -gt 10 ] || (dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames | grep -q "$dest")
  do
    sleep 0.3
    ((counter++))
  done

  if [ $counter -gt 10 ]
  then
    echo "waiting for spotifyd timed out" >&1
    exit 1
  fi
}

controls_name=rs.spotifyd.instance$(pidof spotifyd)
wait_for_name $controls_name
echo "Transferring Playback"
dbus-send --print-reply --dest=$controls_name /rs/spotifyd/Controls rs.spotifyd.Controls.TransferPlayback

# if URI is specified, start the playback there
if [ -n "$1" ]
then
  uri="$1"
  mpris_name=org.mpris.MediaPlayer2.spotifyd.instance$(pidof spotifyd)
  wait_for_name $mpris_name
  echo "Starting Playback of $uri"
  dbus-send --print-reply --dest=$mpris_name /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri "string:$uri"
else
  echo "Hint: specify an argument to start playback of a specific Spotify URI"
fi
