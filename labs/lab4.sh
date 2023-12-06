#!/bin/bash

if find ~ -name "newdb.yaml" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m I have found the YAML file \033[1mnewdb.yaml\033[0m. I\'m not smart enough to guarantee that is works though"
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot find \033[1mnewdb.yaml\033[0m anywhere in your home directory. Did you use \033[1mkubectl create deploy newdb --image=newdb --replicas==2 --dry-run=client -o yaml > newdb.yaml\033[0m to generate it?" && exit 3
fi

if kubectl get pods | grep "lab3" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m Pod lab3 is running"
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot find a Pod with the name lab3. Did you use \033[1mkubectl run lab3 --image=nginx\033[0m to start it?" && exit 4
fi


echo -e "\033[32m[CONGRATS]\033[0m you have succesfully completed this lab, please move on to the next lesson"
echo
