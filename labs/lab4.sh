#!/bin/bash

FINDOUT=$(find ~ -name "newdb.yaml" )

if ! [ -z $FINDOUT ]
then 
	echo -e "\033[32m[OK]\033[0m\t\t I have found the YAML file \033[1mnewdb.yaml\033[0m. I'm not smart enough to guarantee that is works though"
else 
	echo -e "\033[31m[FAIL]\033[0m\t\t I cannot find \033[1mnewdb.yaml\033[0m anywhere in your home directory. Did you use \033[1mkubectl create deploy newdb --image=newdb --replicas==2 --dry-run=client -o yaml > newdb.yaml\033[0m to generate it?" && exit 3
fi

## check if deploy newdb exists
if kubectl get deploy | grep "newdb" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m\t\t I have found a deployment with the name \033[1mnewdb\033[0m. Now let's check if it has errors."
else 
	echo -e "\033[31m[FAIL]\033[0m\t\t I cannot find a Deployment with the name \033[1mnewdb\033[0m. Did you use \033[1mkubectl apply -f newdb.yaml\033[0m to create it from the YAML file that you generated in the previous step?" && exit 4
fi

## check if deploy is error-free
if [[ $(kubectl get deploy | awk '/newdb/ { print $4 }') == 0 ]]
then
	if [ ! -f /tmp/lab4check1 ]
	then
		echo -e "\033[31m[FAIL]\033[0m\t\t I have found the deployment \033[1mnewdb\033[0m. Unfortunately, there are no pods running in it. Did you use \033[1mkubectl logs\033[0m on one of the pods to check if there is any error message?" 
		touch /tmp/lab4check1
		exit 4
	fi
else
	if [ -f /tmp/lab4check1 ]
	then
		echo see this if /tmp/lab4check1 does not exist. we get here because the ENTIRE if condition is NOT true
		echo -e "\033[32m[OK]\033[0m\t\t I have found no errors in the deployment \033[1mnewdb\033[0m."
		echo
		echo -e "\033[32m[CONGRATS]\033[0m\t\t you have succesfully completed this lab, please move on to the next lesson"
		exit
	fi
fi

## second hint on erroneous deployment
if [[ $(kubectl get deploy | awk '/newdb/ { print $4 }') == 0 ]]
then
	if [ ! -f /tmp/lab4check2 ]
	then
        	echo -e "\033[31m[FAIL]\033[0m\t\t Unfortunately, your deployment \033[1mnewdb\033[0m is still not running any Pods. Most likely, that is because the MYSQL_ROOT_PASSWORD parameter was not provided. Use \033[1mkubectl set env deploy newdb MYSQL_ROOT_PASSWORD=password\033[0m to set it now and next run this script again to verify that it works." 
        	touch /tmp/lab4check2
        	exit 4
	fi
else
	if [ ! -f /tmp/lab4check2 ]
	then
		echo see this if /tmp/lab4check1 DOES exist
        	echo -e "\033[32m[OK]\033[0m\t\t I have found no errors in the deployment \033[1mnewdb\033[0m."
		echo
		echo -e "\033[32m[CONGRATS]\033\t[0m you have succesfully completed this lab, please move on to the next lesson"
		rm /tmp/lab4check2
		exit
	fi
fi

if [[ $(kubectl get deploy | awk '/newdb/ { print $4 }') == 0 ]]
then
	echo -e "\033[31m[FAIL]\033[0m\t\t Sorry, your deployment is still not working. There must be something wrong that I haven't considered. I'm afraid I can't help you anymore." 
	rm /tmp/lab4check2
	exit 6
fi

## congratulations!
echo -e "\033[32m[CONGRATS]\033[0m\t you have succesfully completed this lab, please move on to the next lesson"
echo
