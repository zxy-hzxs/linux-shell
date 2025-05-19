#!/bin/bash
printit( ) {
	printf "your choice is "
}

case ${1} in
	"hello")
		printit; echo "hello"
		;;
	"")
		printit; echo "illeagl"
		;;
	*)
		printit; echo "usage ${0} {hello}"
		;;
esac
