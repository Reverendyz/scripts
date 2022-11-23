build_object(){
    local asm=$1
    local preffix=$(echo $asm | cut -d. -f1-1)
    nasm -f elf64 $asm -o $preffix.o || exit 1
    echo "${preffix}"
}

build_executable(){
    local preffix=$(build_object $1)
    ld "${preffix}.o" -o $preffix
}

main(){
    build_executable $1
}

main $1