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
    if [ $(curl -o /dev/null --silent --head --write-out '%{http_code}\n' "https://github.com/be5invis/Iosevka/releases/tag/v${1}") == '200' ] ; then
        cd ~/Downloads
        wget "https://github.com/be5invis/Iosevka/releases/download/v${1}/05.iosevka-term-slab-${1}.7z"
        return 0
    else
        echo "Failed to download iosevka-term-slab-${1}."
        return 1
    fi

}
