FROM ubuntu:18.04

RUN apt update \
    && apt install -y software-properties-common
RUN add-apt-repository ppa:sipe-collab/ppa \
    && add-apt-repository ppa:remmina-ppa-team/remmina-next \
    && apt-cache search freerdp2 \
    && apt remove pidgin* --purge \
    && apt install -y pidgin pidgin-sipe remmina remmina-plugin-rdp remmina-plugin-secret farstream-0.2 xauth \
    && apt full-upgrade -y
EXPOSE 8887
CMD pidgin