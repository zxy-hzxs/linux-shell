#!/bin/bash

read -p "please input y/n:" yn
if [ "${yn}" = "Y" ] || [ "${yn}" = "y" ];then
	echo "input yes"
elif [ "${yn}" = "N" ] || [ "${yn}" = "n" ];then
	echo "input no"
else 
	echo "illegal input"
fi

