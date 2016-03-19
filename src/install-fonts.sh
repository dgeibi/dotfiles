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
    RemV=$(git ls-remote --tags https://github.com/be5invis/Iosevka.git |  awk '{print $2}' | cut -d '/' -f 3 | cut -d '^' -f 1  | sort -b -t . -k 1,1nr -k 2,2nr -k 3,3r -k 4,4r -k 5,5r | uniq | sed '2,$d' | sed "s/^v//")
    LocalV=1.8.3
    if [ -z "$1" ]; then
        Ver=${RemV}
    else Ver=$1
    fi
    forinziu() {

        fontname="Inziu Iosevka ${Ver}"
        churl="http://7xpdnl.dl1.z0.glb.clouddn.com/inziu-iosevka-${Ver}.7z"
        furl=${churl}
    }
    forterm() {
        fontname="Iosevka Slab Term ${Ver}"
        churl="https://github.com/be5invis/Iosevka/releases/tag/v${Ver}"
        furl="https://github.com/be5invis/Iosevka/releases/download/v${Ver}/05.iosevka-term-slab-${Ver}.7z"
    }

    downfont () {
        stat=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' "${churl}")
        if [  "${stat}" == '200' ] ; then
            echo "find ${fontname}"
            cd ~/Downloads || exit
            if [ "$(wget "${furl}")" -eq 0 ]; then
                echo "${fontname} downloaded"
                sed -i "s/\(    LocalV=\).*/\1$Ver/" ~/code/dotfiles/src/install-fonts.sh
            else
                echo "failed to download ${fontname}"
            fi
        elif [ "${stat}" == '404' ] ; then
                echo "${fontname} not found"
            else
                echo "Network Error."
        fi
    }
    if [ "$LocalV" == "$Ver" ]; then
        echo "$Ver has been installed."
    else
        forinziu
        downfont
        forterm
        downfont
    fi
    # if [ "$1" != "" ] && [ "$LocalV" != "$Ver" ]; then
    #     case $1 in
    #         inziu)
    #             forinziu
    #             downfont
    #             ;;
    #         term)
    #             forterm
    #             downfont
    #             ;;
    #         both)
    #             forinziu
    #             downfont
    #             forterm
    #             downfont
    #             ;;
    #         *)
    #             echo "Usage: $0 {inziu|term|both} [version]"
    #             ;;
    #     esac
    #     else
    #         if [ -z "$1" ] ; then
    #             echo "Usage: $0 {inziu|term|both} [version]"
    #         fi
    #         if [ "$LocalV" == "$Ver" ]; then
    #             echo "$Ver has been installed."
    #         fi
    # fi
}
