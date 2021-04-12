FROM ubuntu:18.04
# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt update \
    && apt install -y software-properties-common ca-certificates gnupg apt-transport-https \
    && add-apt-repository ppa:sipe-collab/ppa \
    && add-apt-repository ppa:remmina-ppa-team/remmina-next \
    && apt remove pidgin* --purge \
    && apt full-upgrade -y \
    && apt install -y \
	alsa-utils \
    dbus-x11 \
    farstream-0.2 \ 
    gconf-service \
    hicolor-icon-theme \
    libcanberra-gtk-module \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpulse0 \
    pidgin \
    pidgin-sipe \
    remmina \
    remmina-plugin-rdp \
    remmina-plugin-secret \
    xauth \
    xdg-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

COPY run-pidgin-and-wait-for-exit /usr/local/bin

# Make a user
ENV HOME /home/sipe

RUN useradd --create-home --home-dir $HOME sipe \
	&& chown -R sipe:sipe $HOME \
	&& usermod -a -G audio,video sipe

WORKDIR $HOME
USER sipe

# Start Pidgin
ENTRYPOINT ["/usr/local/bin/run-pidgin-and-wait-for-exit"]