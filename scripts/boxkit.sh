#!/bin/sh

# Set up distrobox shims
/distrobox-shims.sh

# Update and install base packages
pacman -Syu --noconfirm
pacman -S git base base-devel pipewire-jack go curl wget fish starship --noconfirm

# Bootstrap yay from AUR
cd /tmp
curl 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay-bin' -o PKGBUILD
runuser -unobody makepkg
pacman -U --noconfirm *.zst

# Install packages from list
cd /
grep -v '^#' /boxkit.packages | xargs -t yay -S --noconfirm
