#!/bin/bash

# fonts-liberation2 = Free alternative for Microsoft Fonts
apt install --no-install-recommends fonts-recommended fonts-liberation2

fonts_dir="$HOME/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

cd
mkdir fonts
cd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.zip
unzip -x Iosevka.zip
mv *ttf ~/.local/share/fonts
unzip -x Mononoki.zip
mv *ttf ~/.local/share/fonts
cd ..
rm -rf fonts

fc-cache -fv
