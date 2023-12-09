#!/bin/bash

# check for kustomization.yaml file
if test -f kustomization.yaml >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m kustomization.yaml file was found"
else 
	echo -e "\033[31m[FAIL]\033[0m kustomization.yaml file not found. Please check the example in the course git repository lab8 folder and create it " && exit 3
fi

# check for frontend deployment "frontend"
if kubectl get deploy | grep "frontend" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m Deployment frontend is running"
else 
	echo -e "\033[31m[FAIL]\033[0m Deployment frontend not found. Please check your kustomization.yaml and after verifying run\033[1mkubectl apply -k .\033[0m from the directory that contains the customization.yaml to create it" && exit 4
fi

# check for backend deployment "backend"

if kubectl get deploy | grep "backend" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m Deployment backend is running"
else 
	echo -e "\033[31m[FAIL]\033[0m Deployment backend not found. Please check your kustomization.yaml and after verifying run\033[1mkubectl apply -k .\033[0m from the directory that contains the customization.yaml to create it" && exit 4
fi

# decode the secret to check it has the value "password"

SECRETNAME=$(kubectl get secret | awk '/mysql-pass/ { print $1 }')
PASSWORD=$(kubectl get secret $SECRETNAME -o yaml | awk '/password/ { print $2 }')

if [[ $(echo $PASSWORD | base64 -d) == password ]]
then 
	echo -e "\033[32m[OK]\033[0m I found the password secret with the correct password"
else 
	echo -e "\033[31m[FAIL]\033[0m I didn't find the password "password" in the secret mysql-pass. Please check the kustomization.yaml and verify it contains a section\033[1m secretGenerator \033[0m and next run \033[1mkubectl apply -k .\033[0m to generate the password" && exit 4
fi

# check for existence of configmap "wp-db-host"
if kubectl get cm $(kubectl get cm | awk '/wp-db/ { print $1 }') -o yaml | grep 'hostname: backend' >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m ConfigMap wp-db-host was found and it contains the expected value"
else 
	echo -e "\033[31m[FAIL]\033[0m The ConfigMap wp-db-host which defines the variable hostname with the value wordpress-mysql was not found. Please check your kustomization.yaml and verify it contains a section \033[1m configMapGenerator]033[0m and run\033[1mkubectl apply -k .\033[0m from the directory that contains the customization.yaml to create it" && exit 4
fi

echo
echo -e "\033[32m[CONGRATS]\033[0m you have succesfully completed this lab, congratulations on completing this course"
echo
