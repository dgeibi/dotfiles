#!/bin/bash

fontin () {
    if [ "$1" != "" ] ; then
        case $1 in
            inziu*)
                f_dir=inziu
                ;;
            *iosevka-term-slab*)
                f_dir=iosevka-term-slab
                ;;
            *)
                echo "useage: $0 <Inziu/Iosevka Fonts Archive>"
                return 1
                ;;
        esac
            Fonts_Dir=/usr/share/fonts/$f_dir
            sudo -E mkdir -p $Fonts_Dir
            sudo -E rm -f $Fonts_Dir/*
            7z x "$1" -o$f_dir
            sudo -E install -m644 -t$Fonts_Dir $f_dir/* && rm -rf $f_dir
            echo "Updating fonts cache ..."
            sudo fc-cache -f -v
            return 0
    else
        echo "useage: $0 <Inziu/Iosevka Fonts Archive>"
        return 1
    fi
}
fontdown () {
    forinziu() {
        fontname="Inziu Iosevka ${2}"
        churl="http://7xpdnl.dl1.z0.glb.clouddn.com/inziu-iosevka-${2}.7z"
        furl=${churl}
    }
    forterm() {
        fontname="Iosevka Slab Term ${2}"
        churl="https://github.com/be5invis/Iosevka/releases/tag/v${2}"
        furl="https://github.com/be5invis/Iosevka/releases/download/v${2}/05.iosevka-term-slab-${2}.7z"
    }

    downfont () {
        stat=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' "${churl}")
        if [  "${stat}" == '200' ] ; then
            echo "find ${fontname}"
            cd ~/Downloads || exit
            [[ $(wget "${furl}") == '0' ]] && echo "${fontname} downloaded" || echo "failed to download ${fontname}"
        elif [ "${stat}" == '404' ] ; then
                echo "${fontname} not found"
            else
                echo "Network Error."
        fi
    }
    if [ "$1" != "" ] && [ "$2" != "" ] ; then
        case $1 in
            inziu)
                forinziu "$@"
                downfont
                ;;
            term)
                forterm "$@"
                downfont
                ;;
            both)
                forinziu "$@"
                downfont
                forterm "$@"
                downfont
                ;;
            *)
                echo "Usage: $0 {inziu|term|both} <version>"
                ;;
        esac
    else
        echo "Usage: $0 {inziu|term|both} <version>"
    fi
}
