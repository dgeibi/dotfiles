#!/bin/bash
# upgrade electronic-wechat

uwechat(){
    buildroot="$(mktemp -d)"
    Verfile="$HOME/.wechatver"
    AURlink="https://aur.archlinux.org/electronic-wechat-git.git"
    remotever=$(git ls-remote -h -q $AURlink | awk '{print $1}')
    if [ ! -e "$Verfile" ]; then
        echo "4d82cf19340846a8140a9a19d5ee8063ab811517" > "$Verfile"
    fi
    localver=$(cat "$Verfile")
    if [ "$remotever" != "$localver" ]; then
        cd "$buildroot" || exit 1
        git clone $AURlink
        cd electronic-wechat-git || exit 1
        sed -i 's#cd "${_pkgname}"#\0 \&\& sed -i \"/html, body/a\\      zoom: 110%;\" \./src/inject/css\.js#' PKGBUILD
        makepkg --syncdeps --install --noconfirm && echo "$remotever" > "$Verfile"
        cd "$HOME" || exit 1
        rm -rf "$buildroot"
    else
        echo "electronic-wechat 已经是最新版"
    fi
}

