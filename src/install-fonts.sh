#!/bin/bash

fontin () {
    if [ "$1" != "" ] ; then
      case $1 in
        inziu*)
            sudo mkdir -p /usr/share/fonts/inziu/
            sudo rm -f /usr/share/fonts/inziu/*
            7z x "$1" -oinziu
            sudo install -m644 -t/usr/share/fonts/inziu/ inziu/* && rm -rf inziu
            echo "Updating fonts cache ..."
            sudo fc-cache -f -v
          ;;
          *)
            echo "useage: $0 <Inziu Fonts Archive>"
          ;;
      esac
    else
        echo "useage: $0 <Inziu Fonts Archive>"
    fi
}
