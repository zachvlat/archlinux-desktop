#!/bin/sh

set -e

# Upgrade
sudo pacman -Syyu --noconfirm

# Uncomment multilib
sudo sed -i '/^#\[multilib\]$/s/^#//' /etc/pacman.conf
sudo sed -i '/^#Include/s/^#//' /etc/pacman.conf

# Install yay
sudo pacman -S --noconfirm yay

# Install archrepo packages
while read package; do
  sudo pacman -S --noconfirm "$package"
done < archrepo-packages.txt

# Install flatpak packages
flatpak-packages.txt
while read package; do
  flatpak install flathub "$package" --noninteractive
done < flatpak-packages.txt

# Install RustDesk
RUSTDESK_VERSION=1.1.9
wget "https://github.com/rustdesk/rustdesk/releases/download/$RUSTDESK_VERSION/rustdesk-$RUSTDESK_VERSION-manjaro-arch.pkg.tar.zst"
