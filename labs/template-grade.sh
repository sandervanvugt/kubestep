#!/bin/bash

if ps aux  | grep "minikube" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m Minikube is running"
else 
	echo -e "\033[31m[FAIL]\033[0m Minikube is not running. Did you use \033[1mminikube start\033[0m to start it?" && exit 3
fi

if kubectl get pods | grep "lab3" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m Pod lab3 is running"
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot find a Pod with the name lab3. Did you use \033[1mkubectl run lab3 --image=nginx\033[0m to start it?" && exit 4
fi


echo -e "\033[32m[CONGRATS]\033[0m you have succesfully completed this lab, please move on to the next lesson"
echo
