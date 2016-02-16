#!/bin/bash

power() {
case "$1" in
    lock)
        i3lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        i3lock && systemctl suspend
        ;;
    hibernate)
        i3lock && systemctl hibernate
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
