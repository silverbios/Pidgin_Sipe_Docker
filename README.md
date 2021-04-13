Running Pidgin with Sipe Plugin over the Docker

[docker-compose to run pidgin application with sipe plugin](docker-compose.yml)

`version: '3.3'`

`services:` 

    pidgin_sipe:
        volumes:
            - '/etc/localtime:/etc/localtime'
            - '/tmp/.X11-unix:/tmp/.X11-unix'
            - '${HOME}/.pidgin:/home/.purple'
        environment:
            - DISPLAY=unix$DISPLAY
            - PULSE_SERVER=pulseaudio
        links:
            - 'pulseaudio:pulseaudio'
        logging:
            options:
                max-size: 1g
        restart: always
        devices:
            - /dev/snd
            - /dev/dri
            - /dev/video0
        image: silverbios/pidgin_sipe

    pulseaudio:
        volumes:
            - '/etc/localtime:/etc/localtime:ro'
            - '/var/run/dbus:/var/run/dbus'
            - '/etc/machine-id:/etc/machine-id'
        devices:
            - /dev/snd
        container_name: pulseaudio
        ports:
            - '4713:4713'
        logging:
            options:
                max-size: 1g
        restart: always
        image: silverbios/pulseaudio`
