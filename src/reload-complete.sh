#!/bin/bash

_reload()
{
    cur=${COMP_WORDS[COMP_CWORD]}
    case "${cur}" in
        a*) use="all" ;;
        w*) use="wifi" ;;
        d*) use="dns" ;;
        s*) use="ss status";;
        sa*) use="status";;
        *) use="all wifi dns ss status";;
    esac
    COMPREPLY=( $( compgen -W "$use" -- $cur ) )
}
complete -o default -o nospace -F _reload reload
