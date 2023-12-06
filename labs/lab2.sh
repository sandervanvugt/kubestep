#!/bin/bash

if docker images | grep "lab2" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m Image creation succesfull"
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot find the image lab2, stopping now" && exit 3
fi

if docker ps | grep "lab2" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m Container lab2 is running"
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot find a container with the name lab2" && exit 4
fi

if ss -tunap | grep 8081 >/dev/null
then
	echo -e "\033[32m[OK]\033[0m Port 8081 on localhost is listening"
	echo
else
	echo -e "\033[31m[FAIL]\033[omNothing listening on localhost port 8081" && exit 2
fi


echo -e "\033[32m[CONGRATS]\033[0m you have succesfully completed this lab, please move on to the next lesson"
echo
