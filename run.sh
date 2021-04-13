#!/bin/bash

#xhost local:docker

#Pulseaudio
 docker run -d \
	-v /etc/localtime:/etc/localtime:ro \
	--device /dev/snd \
	--name pulseaudio \
	-p 4713:4713 \
	-v /var/run/dbus:/var/run/dbus \
	-v /etc/machine-id:/etc/machine-id \
	pulseaudio

docker run \
   -v /etc/localtime:/etc/localtime \
   -v /tmp/.X11-unix:/tmp/.X11-unix \  #mount the X11 socket
   -e DISPLAY=unix$DISPLAY \  #pass the display
	--link pulseaudio:pulseaudio \
	-e PULSE_SERVER=pulseaudio \
   -v ${HOME}/.pidgin:/home/pidgin/config \
   --device /dev/snd \  #sound
   --device /dev/dri \
   --device /dev/video0 \  #video
   s4b