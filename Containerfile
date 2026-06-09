FROM ghcr.io/ublue-os/base-main:latest

RUN rpm-ostree install \
    gnome-shell \
    gnome-control-center \
    gnome-terminal \
    nautilus \
    gdm \
    && ostree container commit

RUN rpm-ostree install \
    steam \
    lutris \
    wine \
    winetricks \
    gamemode \
    mangohud \
    gamescope \
    && ostree container commit

RUN rpm-ostree install \
    RetroArch \
    dolphin-emu \
    && ostree container commit

RUN mkdir -p /usr/lib/systemd/system/gamemoded.service.d && \
    echo -e "[Install]\nWantedBy=multi-user.target" > /usr/lib/systemd/system/gamemoded.service.d/override.conf \
    && ostree container commit
