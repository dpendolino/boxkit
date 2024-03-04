FROM quay.io/toolbx/arch-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="dpendolino@gmail.com"

COPY extra-packages /
RUN pacman -Syu --noconfirm && \
    pacman -S git base base-devel pipewire-jack --noconfirm && \
    pacman -Rs mlocate --noconfirm && \
    cd /tmp && \
    git clone https://aur.archlinux.org/yay-bin.git && \
    cd yay-bin && \
    chmod -R 777 ../yay-bin && \
    runuser -unobody makepkg && \
    pacman -U --noconfirm *.zst
RUN cd / && \
    grep -v '^#' /extra-packages | xargs -t yay -S --noconfirm
RUN rm /extra-packages

RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \  
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
