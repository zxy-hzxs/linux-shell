#! /bin/bash
#输入pi的小数点后几位，求pi值
read -p "please input a float number to caiculate pi:" value
num=${value:-"10"}
time echo "scale=${num};4*a(1)"|bc -lq
