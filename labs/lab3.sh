#!/bin/bash

if minikube status  | grep "not found" >/dev/null
then 
	echo -e "\033[31m[FAIL]\033[0m\t\t Minikube is not running. Did you use \033[1mminikube start\033[0m to start it?" && exit 3
else 
	echo -e "\033[32m[OK]\033[0m\t\t Minikube is running"
fi

if kubectl get pods | grep "lab3" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m\t\t Pod lab3 is running"
else 
	echo -e "\033[31m[FAIL]\033[0m\t\t I cannot find a Pod with the name lab3. Did you use \033[1mkubectl run lab3 --image=nginx\033[0m to start it?" && exit 4
fi

echo
echo -e "\033[32m[CONGRATS]\033[0m\t you have succesfully completed this lab, please move on to the next lesson"
echo
