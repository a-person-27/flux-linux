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
    curl \
    && ostree container commit

RUN git clone https://github.com/vinceliuice/Graphite-gtk-theme.git /tmp/graphite && \
    cd /tmp/graphite && \
    ./install.sh --dest /usr/share/themes --name flux-linux --color dark --tweaks rimless && \
    rm -rf /tmp/graphite \
    && ostree container commit

RUN mkdir -p /usr/share/backgrounds && \
    curl -L -o /usr/share/backgrounds/flux-linux-wallpaper.png \
    "https://raw.githubusercontent.com/a-person-27/main/flux-linux-wallpaper.png" \
    && ostree container commit

RUN mkdir -p /usr/share/pixmaps && \
    curl -L -o /usr/share/pixmaps/flux-linux-logo.png \
    "https://raw.githubusercontent.com/a-person-27/flux-linux/main/flux-linux-logo.png" \
    && ostree container commit

RUN mkdir -p /usr/share/glib-2.0/schemas && \
    echo '[org.gnome.desktop.interface]' > /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo "gtk-theme='flux-linux-Dark'" >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo "color-scheme='prefer-dark'" >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo "icon-theme='Adwaita'" >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo "cursor-theme='Adwaita'" >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo '' >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo '[org.gnome.desktop.wm.preferences]' >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo "theme='flux-linux-Dark'" >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo '' >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo '[org.gnome.desktop.background]' >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo "picture-uri='file:///usr/share/backgrounds/flux-linux-wallpaper.png'" >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo "picture-uri-dark='file:///usr/share/backgrounds/flux-linux-wallpaper.png'" >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    echo "picture-options='zoom'" >> /usr/share/glib-2.0/schemas/zz-flux-linux.gschema.override && \
    glib-compile-schemas /usr/share/glib-2.0/schemas \
    && ostree container commit
