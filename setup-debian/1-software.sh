#!/bin/bash

# X Window System
apt install --no-install-recommends -y xorg xbacklight xinput xdotool xrandr

# CPU Microcode
apt install --no-install-recommends -y intel-microcode

# Network Manager
apt install --no-install-recommends -y network-manager-gnome ufw

# System Utilities
apt install --no-install-recommends -y mtools dosfstools dialog avahi-daemon acpi acpid gvfs-backends
systemctl enable avahi-daemon
systemctl enable acpid

# File Manager
apt install --no-install-recommends -y pcmanfm

# Audio Control
apt install --no-install-recommends -y pulseaudio alsa-utils pavucontrol

# System Monitoring
apt install --no-install-recommends -y htop conky-all

# Softwares for window manager (i3wm)
apt install --no-install-recommends -y rofi dunst libnotify-bin picom dmenu dbus-x11

# Archive management
apt install --no-install-recommends -y 7zip unzip

# Text Editors
apt purge -y vim-tiny
apt install --no-install-recommends -y vim emacs

# Image Viewer
# ffmpegthumbnailer
apt install --no-install-recommends -y feh ueberzug eom ffmpegthumbnailer python3-pillow

# Media Player
apt install --no-install-recommends -y mpv

# Document Viewer
apt install --no-install-recommends -y okular

# Browser
apt install --no-install-recommends -y firefox-esr

# Video Graphics Drivers (Intel)
apt install --no-install-recommends -y mesa-utils

# Appearence and Customization
apt install --no-install-recommends -y lxappearance qt5ct arandr


# Simple Terminal build prerequisites
apt install libxft-dev

# Depedencies icons
apt install --no-install-recommends -y librsvg2-common hicolor-icon-theme gtk-update-icon-cache

# Development Essential
apt install --no-install-recommends -y git wget curl build-essential tmux openjdk-21-jre openjdk-21-jdk
