#!/bin/bash

fontin () {
    if [ "$1" != "" ] ; then
      case $1 in
        inziu*)
          sudo rm -rf /usr/share/fonts/inziu/
          7z x $1 -oinziu
          sudo mv inziu /usr/share/fonts/
          cd /usr/share/fonts/
          sudo chown -R root inziu
          sudo chgrp -R root inziu
          sudo chmod -R 755 inziu
          echo "Updating fonts cache ..."
          sudo fc-cache -f -v
          ;;
          *)
            echo "useage: $0 <Fonts Archive File>; for inziu"
          ;;
      esac
    else
        echo "useage: $0 <Fonts Archive File>; for inziu"
    fi
}
