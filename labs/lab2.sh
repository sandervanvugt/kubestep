#!/bin/bash

if docker images | grep "lab2" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m\t\t Image creation succesfull"
else 
	echo -e "\033[31m[FAIL]\033[0m\t\t I cannot find the image lab2, stopping now" && exit 3
fi

if docker ps | grep "lab2" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m\t\t Container lab2 is running"
else 
	echo -e "\033[31m[FAIL]\033[0m\t\t I cannot find a container with the name lab2" && exit 4
fi

if ss -tunap | grep 8081 >/dev/null
then
	echo -e "\033[32m[OK]\033[0m\t\t Port 8081 on localhost is listening"
	echo
else
	echo -e "\033[31m[FAIL]\033[om\t\t Nothing listening on localhost port 8081" && exit 2
fi

echo
echo -e "\033[32m[CONGRATS]\033[0m\t you have succesfully completed this lab, please move on to the next lesson"
echo
