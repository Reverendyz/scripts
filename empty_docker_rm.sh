#!/bin/bash

main(){
    read -a -r images <<< "$(docker image ls | awk '{if (NR>1 && $1 == "<none>") {print $3} }')"

    for img in "${images[@]}"; do
        echo "removing $img"
        docker image rm -f "$img"
    done

}