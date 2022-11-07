#!/bin/bash

LOG_FILE_PATH="`pwd`/backup.log" # please change in case of need

check_adddel(){
    backup_files=()
    for i in $(ls -a $1)
    do
        backup_files+=($i)
    done

    sync_files=()
    for i in $(ls -a $2)
    do
        sync_files+=($i)
    done

    res=()
    for i in $(diff -u <( printf "%s\n" "${backup_files[@]}" ) <( printf "%s\n" "${sync_files[@]}" ))
    do
        if [[ ${i:0:1} = '+' ]] && [[ ${i:1:1} != '+' ]]; then
            res+=($i)
        elif [[ ${i:0:1} = '-' ]]; then
            res+=($i)
        fi
    done

    last_index=$((${#res[@]}-1))
    for((i=5; i <= last_index; i++))
    do
        str=${res[$i]}
        if [[ ${str:0:1} = '+' ]]; then
            echo "${str:1}    add"
        else
            echo "${str:1}    delete"
        fi
    done
}

make_backup(){
    from=$2
    to=$1
    if [[ ${to:((${#str}-1))} = '/' ]]; then
        rm -rf $to*
    else
        rm -rf $to/*
    fi

    if [[ ${from:((${#str}-1))} = '/' ]]; then
        `cp -R $from* $to`
        `cp -R $from.[^.]* $to`
    else
        `cp -R $from/* $to`
        `cp -R $from/.[^.]* $to`
    fi
}

make_log(){
    for_log=($1)
    size_of_log=${#for_log[@]}
    for((i=0; i < size_of_log; i+=2))
    do
        echo "`date -R` ${for_log[$i]} ${for_log[$(($i+1))]}" >> $2
    done
}

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <backup path> <sync dir>"
    exit 1
fi

backup_path=$1
sync_dir=$2

if [[ ! -d $sync_dir ]]; then
    echo 'Directory does not exist'
    exit 1
fi

[[ -d $backup_path ]] || mkdir $backup_path

make_log "$(check_adddel $backup_path $sync_dir)" $LOG_FILE_PATH
make_backup $backup_path $sync_dir
