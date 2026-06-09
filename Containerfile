FROM ghcr.io/ublue-os/base-main:latest

# Ledora - Lightweight PC gaming distro based on Fedora Atomic
# Focused on PC gaming, emulation, and a clean custom experience

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

RUN rpm-ostree override remove \
    gnome-tour \
    gnome-maps \
    gnome-weather \
    && ostree container commit

RUN systemctl enable gamemoded \
    && ostree container commit
