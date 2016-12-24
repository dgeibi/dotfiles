#!/bin/bash

_op()
{
    cur=${COMP_WORDS[COMP_CWORD]}
    case "${cur}" in
        c*) use="conf cleanbin";;
        co*) use="conf";;
        f*) use="format files";;
        fo*) use="format";;
        fi*) use="files";;
        b*) use="bfiles bl";;
        bf*) use="bfiles";;
        s*) use="sysup ss softup";;
        sy*) use="sysup";;
        so*) use="softup";;
        d*) use="dns";;
        r*) use="reboot";;
        u*) use="upup upscript";;
        o*) use="ongfw offgfw";;
        on*) use="ongfw";;
        of*) use="offgfw";;
        *) use="conf cleanbin format files bfiles bl ongfw offgfw sysup ss softup dns reboot upup upscript";;
    esac
    COMPREPLY=( $( compgen -W "$use" -- $cur ) )
}
complete -o default -o nospace -F _op op
