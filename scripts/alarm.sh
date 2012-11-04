#! /bin/bash

MUSIC_PLAYER=/usr/bin/mocp
PLAYLIST=/home/pavel/Music/alarm/

function play_music {

    $MUSIC_PLAYER -S
    $MUSIC_PLAYER --on shuffle 
    $MUSIC_PLAYER --on repeat
    $MUSIC_PLAYER --on autonext 
    $MUSIC_PLAYER -c -v 30 -a $PLAYLIST -p

    for ((a = 1; a <= 7; a++)); do
        $MUSIC_PLAYER -v +5
        sleep 300
    done
}

play_music
