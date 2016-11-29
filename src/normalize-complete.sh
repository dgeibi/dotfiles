#!/bin/bash

_normalize() {
    cur=${COMP_WORDS[COMP_CWORD]}
    case "${cur}" in
        l*) use="lower";;
        c*) use="chmod";;
        *) use="lower chmod";;
    esac
    COMPREPLY=( $( compgen -W "$use" -- $cur ) )
}
complete -o default -o nospace -F _normalize normalize

