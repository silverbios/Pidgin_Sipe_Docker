FROM debian:stable-slim

RUN apt update && apt install -y \
	alsa-utils \
	libasound2 \
	libasound2-plugins \
	pulseaudio \
	pulseaudio-utils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/pulseaudio
RUN useradd --create-home --home-dir $HOME pulseaudio \
	&& usermod -aG audio,pulse,pulse-access pulseaudio \
	&& chown -R pulseaudio:pulseaudio $HOME

WORKDIR $HOME
USER pulseaudio

COPY default.pa /etc/pulse/default.pa
COPY client.conf /etc/pulse/client.conf
COPY daemon.conf /etc/pulse/daemon.conf

ENTRYPOINT [ "pulseaudio" ]
CMD [ "--log-level=4", "--log-target=stderr", "-v" ]
