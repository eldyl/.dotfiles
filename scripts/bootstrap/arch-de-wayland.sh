#!/bin/bash

# Install packages
sudo pacman -S ly wayland hyprland xorg wofi waybar pcmanfm wl-clipboard stow \
    pavucontrol nitrogen lxappearance-gtk3 htop neofetch cmus neomutt ripgrep \
    firefox thunderbird obsidian zathura zathura-pdf-mupdf obs-studio \
    opensnitch syncthing rustup tree-sitter-cli jq

# Install fonts
sudo pacman -S --noconfirm noto-fonts noto-fonts-emoji ttf-croscore ttf-dejavu \
    ttf-droid ttf-liberation ttf-roboto ttf-bitstream-vera gnu-free-fonts \
    ttf-noto-nerd ttf-ubuntu-nerd

# Install paru
sudo pacman -S --needed base-devel
cd /tmp || exit;
git clone https://aur.archlinux.org/paru.git;
cd paru/ || exit;makepkg -si --noconfirm;cd || exit;

# Install aur packages
paru -S opensnitch-ebpf-module easyeffects-git deadd-notification-center-bin \
    freetube-bin librewolf-bin syncthingtray

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
