#! /bin/bash

read -p "input a num: " num
s=0
for ((i=1; i<=$num; i=i+1)) do
	s=$(($s+$i))
done
echo "number is $s"
