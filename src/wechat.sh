#!/bin/bash
# upgrade electronic-wechat

uwechat(){
    git clone https://aur.archlinux.org/electronic-wechat-git.git
    cd electronic-wechat-git || exit
    sed -i 's#cd "${_pkgname}"#\0 \&\& sed -i \"/html, body/a\\      zoom: 110%;\" \./src/inject/css\.js#' PKGBUILD
    makepkg -sri && cd .. && rm -rf electronic-wechat-git
}

