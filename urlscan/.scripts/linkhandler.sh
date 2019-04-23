#!/bin/sh

# Feed script a url or file location.
# If an image, it will view in sxiv,
# if a video or gif, it will view in mpv
# if a music file or pdf, it will download,
# otherwise it opens link in browser.

# Set default browser
 if [ -e "/usr/bin/firefox" ]
then
    export BROWSER="firefox"
elif [ -e "/usr/bin/iceweasel" ]
then
    export BROWSER="iceweasel"
fi

# Set default terminal
export TERMINAL="st"

case "$1" in
	*mkv|*webm|*mp4|*youtube.com*|*youtu.be*|*hooktube.com*|*bitchute.com*)
		setsid mpv --input-ipc-server=/tmp/mpvsoc"$(date +%s)" -quiet "$1" >/dev/null 2>&1 & ;;
	*png|*jpg|*jpe|*jpeg|*gif)
		curl -sL "$1" > "/tmp/$(echo "$1" | sed "s/.*\///")" && sxiv -a "/tmp/$(echo "$1" | sed "s/.*\///")"  >/dev/null 2>&1 & ;;
	*mp3|*flac|*opus|*mp3?source*)
		setsid tsp curl -LO "$1" >/dev/null 2>&1 & ;;
	*)
		if [ -f "$1" ]; 
        then 
            "$TERMINAL" -e "$EDITOR $1"
		else 
            setsid "$BROWSER" "$1" >/dev/null 2>&1 & 
        fi ;;
esac