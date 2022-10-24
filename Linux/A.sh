#!/bin/bash

show_help(){
	echo '
	--all <network> <mask> - displays the IP addresses and symbolic names of all hosts in the current subnet.
	--target - displays a list of open system tcp ports.'
}

show_all(){
	nmap -sP $1/$2
}

show_target(){
	nmap $1
}

if [[ $# -eq 0 ]]; then
	show_help
	exit 1
fi

case $1 in
	'--all')
		show_all $2 $3
		;;

	'--target')
		show_target $2
		;;
	*)
		show_help
		;;
esac


