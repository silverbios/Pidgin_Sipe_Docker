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
    alsa-base \
    alsa-oss \
    alsa-utils \
    dbus-x11 \
    farstream-0.2 \
    gconf-service \
    gstreamer1.0-libav \
    gstreamer1.0-nice \
    gstreamer1.0-plugins-ugly \
    hicolor-icon-theme \
    libappindicator1 \
    libasound2 \
    libcanberra-gtk-module \
    libcurl3 \
    libexif-dev \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libgstreamer-plugins-bad1.0-0 \
    libgstreamer-plugins-base1.0-0 \
    libgstreamer-plugins-good1.0-0 \
    libpango1.0 \
    libpulse0 \
    libv4l-0 \
    libxss1 \
    libxtst6 \
    pidgin \
    pidgin-encryption \
    pidgin-extprefs \
    pidgin-plugin-pack \
    pidgin-sipe \
    pulseaudio \
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
	&& usermod -a -G audio,video sipe \
    && chmod +x /usr/local/bin/run-pidgin-and-wait-for-exit


WORKDIR $HOME
USER sipe

# Start Pidgin
ENTRYPOINT ["/usr/local/bin/run-pidgin-and-wait-for-exit"]
