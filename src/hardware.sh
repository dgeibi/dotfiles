#!/bin/bash

alon() {
    echo "screen always on"
    [[ -n $(pidof xautolock) ]] && kill $(pidof xautolock)
    xset s off -dpms
}

aloff() {
    echo "turn off alon"
    [[ -z $(pidof xautolock) ]] && xautolock -time 10 -locker "i3lock -c 000000" &
    xset s on
    xset dpms
}


cqt7() {
    sudo systemctl start bluetooth
    bluetoothctl << EOF
power on
connect 1C:52:16:09:FF:C9
EOF
    sleep 1
}
