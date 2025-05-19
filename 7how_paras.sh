#! /bin/bash
echo "paras1   ==> ${0}"
echo "paras2   ==> $#"
[ "$#" -lt 2 ] && echo "less than 2" && exit 0
echo "paras3   ==> $@"
echo "paras4   ==> ${1}"
echo "paras5   ==> ${2}"

