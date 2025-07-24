#!/usr/bin/env bash

main () {
    echo ">> Installing i3"

    sudo pacman -Syu && sudo pacman -S --noconfirm i3 feh j4-dmenu-desktop morc_menu wmctrl

    echo ">> Creating plasma-i3"
    touch /usr/share/xsessions/plasma-i3.desktop

    echo "
    [Desktop Entry]
    Type=XSession
    Exec=env KDEWM=/usr/bin/i3 /usr/bin/startplasma-x11
    DesktopNames=KDE
    Name=Plasma with i3
    Comment=Plasma with i3
    " > /usr/share/xsessions/plasma-i3.desktop


}

main
