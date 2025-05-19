#!/bin/bash
s=0
i=0
n=100
while [ $i != $n ]
do
	i=$(($i+1))
	s=$(($s+$i))
done
echo $s
