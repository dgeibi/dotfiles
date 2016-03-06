#!/bin/bash

power() {
case "$1" in
    lock)
        i3lock -c 000000
        xset dpms force off
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        i3lock -c 000000 && systemctl suspend
        ;;
    hibernate)
        i3lock -c 000000 && systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: power {lock|logout|suspend|hibernate|reboot|shutdown}"
esac
}
