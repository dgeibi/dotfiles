#!/bin/bash

#vscode
code() {
    # visual-studio-code $1 &> /dev/null
    visual-studio-code "$@" &> /dev/null &
    disown
}

checknet() {
    ping -c 4 114.114.114.114
    echo -e "\n"
    tcping www.google.com 443
}

update() {
    sudo -v
    pacaur -u --noconfirm
    sudo pacman -Syu
    nvim +PlugUpgrade +PlugUpdate +qa
    cd "$NVM_DIR" || exit && git fetch origin && git checkout "$(git describe --abbrev=0 --tags)" && cd - > /dev/null || exit
}

nodeupdate() {
    lastline="$(nvm ls-remote | tail -1)"
    if ! echo "$lastline" | grep -e '->' > /dev/null; then
        nvm install "$(echo "$lastline" | tr -d ' ')"
    else
        echo "${lastline/->       /}" is latest version.
    fi
}

alias uctpkg='cd ~/code/ctpkg/ || exit && ./install.sh && cd - >/dev/null || exit'

syscheck() {
    systemd-analyze
    echo -e "\nJournal Errors"
    journalctl -p 3 -xb -l
    echo -e "\nsytemd failed"
    systemctl --failed -l
}

format() {
    for i in "$@"
    do
        case "$i" in
            *.c)
                astyle --style=allman --add-brackets --break-blocks=all -n "$i"
            ;;
            *.sh)
                bashbeautify "$i"
                echo "$i" formatted
            ;;
        esac
        sed -i -e 's/[ \t]*$//' -e 's/\t/    /g' "$i"
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
    echo "$(head -n1 /var/log/pacman.log | cut -d " " -f 1,2)" 以来一共滚了 "$(grep -c "full system upgrade" /var/log/pacman.log)" 次
}
