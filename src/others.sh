#!/bin/bash

checknet() {
    ping -c 4 114.114.114.114
    echo -e "\n"
    tcping www.google.com 443
}

update() {
    sudo pacman -Syu
    #vim +PlugUpgrade +PlugUpdate +qa
    pacaur -u --noconfirm
    uctpkg
}

syscheck() {
    systemd-analyze
    echo -e "\nJournal Errors"
    journalctl -p 3 -xb -l
    echo -e "\nsystemd failed"
    systemctl --failed -l
}

take() {
    if [ -n "$1" ]; then
        mkdir -p "$1"
        cd "$1" || return
    fi
}

gdiff() {
    if [ -n "$1" ] && [ -n "$2" ]; then
        git diff --no-index --word-diff "$1" "$2"
    else
        echo "Usage: gdiff <old_file> <new_file>"
    fi
}

roll() {
    echo "$(head -n1 /var/log/pacman.log | cut -d " " -f 1,2)" 以来一共滚了 "$(grep -c "full system upgrade" /var/log/pacman.log)" 次
}
