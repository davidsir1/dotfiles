#!/bin/bash

option=$(echo -e "Desligar\nReiniciar\nSair" | rofi -dmenu -i -p "Selecionar Opcão:")

case "$option" in
    'Desligar') systemctl poweroff ;;
    'Reiniciar') systemctl reboot ;;
    'Sair') i3-msg exit ;;
esac
