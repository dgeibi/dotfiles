#!/bin/bash

infonts () {
    if [ "$1" != "" ] ; then
      case $1 in
        inziu*)
          Font_Dir=inziu-iosevka
          mkdir -p $Font_Dir
          mv $1 $Font_Dir
          cd $Font_Dir || exit
          jieya $1
          cd ..
          sudo rm -rf /usr/share/fonts/$Font_Dir
          sudo mv $Font_Dir /usr/share/fonts/
          sudo fc-cache -f -v
          ;;
        iosevka*.zip)
          jieya $1
          Font_Dir=`ls | grep -v zip | grep iosevka`
          sudo rm -rf /usr/share/fonts/$Font_Dir
          sudo mv $Font_Dir /usr/share/fonts/
          sudo fc-cache -f -v
          ;;
          *) 
            echo "useage: $0 <Fonts Archive File>; for inziu or iosevka"
          ;;
      esac
    else
        echo "useage: $0 <Fonts Archive File>; for inziu or iosevka"
    fi
}
