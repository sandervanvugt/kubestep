#!/bin/bash

if docker images | grep "lab2" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m\t\t Image creation succesfull"
else 
	echo -e "\033[31m[FAIL]\033[0m\t\t I cannot find the image lab2, stopping now. Did you use \033[1mcd lab2; docker build -t lab2 .\033[0m to create the image?" && exit 3
fi

if docker ps | grep "lab2" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m\t\t Container lab2 is running"
else 
	echo -e "\033[31m[FAIL]\033[0m\t\t I cannot find a container with the name lab2. Did you use \033[1mdocker run -d lab2\033[0m with the appropriate options to run it?" && exit 4
fi

if ss -tunap | grep 8081 >/dev/null
then
	echo -e "\033[32m[OK]\033[0m\t\t Port 8081 on localhost is listening"
	echo
else
	echo -e "\033[31m[FAIL]\033[0m\t\t Nothing listening on localhost port 8081. You should probably delete the container and run it again, using \033[1mdocker stop lab2; docker rm lab2; docker run -d -p 8081:80 --name lab2 lab2" && exit 2
fi

echo
echo -e "\033[32m[CONGRATS]\033[0m\t you have succesfully completed this lab, please move on to the next lesson"
echo
