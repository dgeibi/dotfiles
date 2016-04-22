#!/bin/bash
# upgrade electronic-wechat

uwechat(){
    Verfile="./wechatver"
    AURlink="https://aur.archlinux.org/electronic-wechat-git.git"
    remotever=$(git ls-remote -h -q $AURlink | awk '{print $1}')
    if [ ! -e $Verfile ]; then
        echo "4d82cf19340846a8140a9a19d5ee8063ab811517" > $Verfile
    fi
    localver=$(cat ~/.wechatver)
    if [ "$remotever" != "$localver" ]; then
        git clone $AURlink
        cd electronic-wechat-git || exit
        sed -i 's#cd "${_pkgname}"#\0 \&\& sed -i \"/html, body/a\\      zoom: 110%;\" \./src/inject/css\.js#' PKGBUILD
        makepkg -sri && cd .. && rm -rf electronic-wechat-git && echo "$remotever" > "$Verfile"
    else
        echo "electronic-wechat 已经是最新版"
    fi
}

