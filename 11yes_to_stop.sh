#!/bin/bash
while [ "${yn}" != "yes" ] && [ "${yn}" != "YES" ]
do
	read -p "input yes/YES:" yn
done
echo "correct"
