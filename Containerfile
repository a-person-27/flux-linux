FROM ghcr.io/ublue-os/base-main:latest

# Ledora - a gaming focused Fedora atomic distro 

# Install gaming packages
RUN rpm-ostree install \
    steam \
    lutris \
    gamemode \
    mangohud \
    gamescope \
    && ostree container commit
