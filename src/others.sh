#!/bin/bash

#vscode
code() {
 # visual-studio-code $1 &> /dev/null
  visual-studio-code "$@" &> /dev/null &
  disown
}

### mount ntfs
ntfs() {
    case $1 in
        c) [ ! -e /media/c/ ] && sudo mkdir -p /media/c; sudo ntfs-3g /dev/sda3 /media/c ;;
        #d) [ ! -e /media/d/ ] && sudo mkdir -p /media/d; sudo ntfs-3g /dev/sdb1 /media/d ;;
        uc) sudo umount /media/c ;;
        #ud) sudo umount /media/d ;;
        *) echo "Usage: ntfs {c,uc}"
    esac
}

checknet() {
    ping -c 4 114.114.114.114
    echo -e "\n"
    tcping www.google.com 443
}

update() {
    sudo -v
    pacaur -u
    cd ~/code/ctpkg/ && ./install.sh && cd -
    sudo pacman -Syu
    nvim +PlugUpgrade +PlugUpdate +qa
    cd "$NVM_DIR" && git fetch origin && git checkout `git describe --abbrev=0 --tags` && cd -
}

syscheck() {
    systemd-analyze
    echo -e "\nJournal Errors"
    journalctl -p 3 -xb
    echo -e "\nsytemd failed"
    systemctl --failed
}

format() {
    sed -i -e 's/[ \t]*$//' -e 's/\t/    /g' "$@"
    for each in "$@"
    do
        if [[ "$each" = *.c ]]; then
            astyle --style=kr -n "$each"
        fi
    done
}

take() {
    if [ -n "$1" ]; then
        mkdir -p "$1"
        cd "$1" || exit
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
    echo $(head -n1 /var/log/pacman.log | cut -d " " -f 1,2) 以来一共滚了 $(grep -c "full system upgrade" /var/log/pacman.log) 次
}
