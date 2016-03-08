#!/bin/bash

fontin () {
    if [ "$1" != "" ] ; then
        case $1 in
            inziu*)
                f_dir=inziu 
                ;;
            a-nl-iosevka-slab*)
                f_dir=nl-iosevka-slab
                ;;
            *)
                echo "useage: $0 <Inziu/Iosevka Fonts Archive>"
                exit 1
                ;;
        esac
            Fonts_Dir=/usr/share/fonts/$f_dir
            sudo -E mkdir -p $Fonts_Dir
            sudo -E rm -f $Fonts_Dir/*
            7z x "$1" -o$f_dir
            sudo -E install -m644 -t$Fonts_Dir $f_dir/* && rm -rf $f_dir
            echo "Updating fonts cache ..."
            sudo fc-cache -f -v
            exit 0
    else
        echo "useage: $0 <Inziu/Iosevka Fonts Archive>"
    fi
}
