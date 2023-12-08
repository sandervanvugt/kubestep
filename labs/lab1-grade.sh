#!/bin/bash

if ps aux | grep docker >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m\t\t Good! docker is running"
else 
	echo -e "\033[31m[FAIL]\033[0m\t\t I don't see docker running. Please use \033[1mgit clone https://github.com/sandervanvugt/kubestep\033[0m and run \033[1m./minikube-docker-setup.sh \033[0m from the course Git repository to start it." && exit 3
fi

if docker ps | grep "nginx" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m\t\t You successfully started a container that uses the nginx image"
else 
	echo -e "\033[31m[FAIL]\033[0m\t\t I cannot find a running container that uses the nginx image. Did you use \033[1mdocker run -d nginx\033[0m to run it?" && exit 4
fi


echo
echo -e "\033[32m[CONGRATS]\033[0m\t you have succesfully completed this lab, please move on to the next lesson"
echo
