#! /bin/bash

file1=$(date +%Y%m%d)
file2=$(date -d "now + 1 day" +%Y%m%d)
file3=$(date -d "now - 1 day" +%Y%m%d)


echo $file1 $file2 $file3
touch "$file1"
touch "$file2"
touch "$file3"

