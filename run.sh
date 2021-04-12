xhost local:docker
docker run \
   -v /etc/localtime:/etc/localtime \
   -v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
   -e DISPLAY=unix$DISPLAY \ # pass the display
   -v ${HOME}/.pidgin:/home/pidgin/config \
   --device /dev/snd \ # sound
   --device /dev/dri \
   --device /dev/video0 \ # video
   s4b