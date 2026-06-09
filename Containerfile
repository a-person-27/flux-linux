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

RUN rpm-ostree install \
    gnome-tweaks \
    gtk-murrine-engine \
    sassc \
    && ostree container commit

RUN git clone https://github.com/vinceliuice/Graphite-gtk-theme.git /tmp/graphite && \
    cd /tmp/graphite && \
    ./install.sh --dest /usr/share/themes --name Ledora --color dark --tweaks rimless && \
    rm -rf /tmp/graphite \
    && ostree container commit

RUN mkdir -p /usr/share/glib-2.0/schemas && \
    cat > /usr/share/glib-2.0/schemas/zz-ledora.gschema.override << 'EOF'
[org.gnome.desktop.interface]
gtk-theme='Ledora-Dark'
color-scheme='prefer-dark'
accent-color='#348576'
icon-theme='Adwaita'
cursor-theme='Adwaita'

[org.gnome.desktop.wm.preferences]
theme='Ledora-Dark'
EOF
    && glib-compile-schemas /usr/share/glib-2.0/schemas \
    && ostree container commit
