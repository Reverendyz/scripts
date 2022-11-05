#!/bin/bash

toggle_audio_sink(){
    local list=$(pactl list sinks | grep "Name: " | sed -E "s/Name\:\ //g" | grep -E "G635|0000_00_1f.3.analog-stereo")
    for device in $list; do
        if [ $(pactl info | grep 'Default Sink:' | sed "s/Default Sink: //g") != "$device" ]; then
            echo changing to $device
            pactl set-default-sink $device
            exit 0
        fi
    done
}

main(){
    toggle_audio_sink
}

main
