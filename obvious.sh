#!/bin/bash


while inotifywait -e modify $1.c --quiet; do
    gcc -o $1 $1.c
    if [[ "$2" == "d" ]]; then
        gdb -batch -ex "set disassembly-flavor intel" -ex "disassemble /m main" -ex "quit" ./$1 > $1.asm
        clear
        cat $1.asm
        sleep 1
    elif [[ "$2" == "r" ]]; then
        ./test
    else
        echo "Usage: ./auto_dis.sh [file] [d/r]"
        echo "d: disassemble"
        echo "r: run"
    fi
done

# inotifywait silent

