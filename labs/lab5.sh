#!/bin/bash

# check if there is an application with the name salesweb and assume it's running enough replicas
if kubectl get deploy | grep "salesweb" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m The deployment salesweb is running"
else 
	echo -e "\033[31m[FAIL]\033[0m The deployment salesweb is not running. Did you use \033[1mkubectl create deploy salesweb --replicas=3 --image=nginx:1.23\033[0m to start it?" && exit 3
fi

# check if there is a service resource running
if kubectl get services | grep "salesweb" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m The service salesweb is available"
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot find a Service with the name salesweb. Did you use \033[1mkubectl expose deploy salesweb --port=80\033[0m to start it?" && exit 4
fi

# check if the minikube ingress is on
if [[ $(minikube addons list | awk '/ingress / { print $6 }') == 'enabled' ]] >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m The minikube ingress addon is enabled"
else 
	echo -e "\033[31m[FAIL]\033[0m the minikube ingress addon is disabled. Did you use \033[1mminikube addons enable ingress\033[0m to start it?" && exit 4
fi

# check if there is host name resolving to salesweb.example.com
# this fails and I don't know why
echo -e "\033[33m[NOTICE]\[033[0m This test can take up to 30 seconds to complete. Please be patient"
echo
if ping -c 1 salesweb.example.com 2>&1 /dev/null
then
        echo -e "\033[32m[OK]\033[0m I can ping salesweb.example.com."
else
        echo -e "\033[31m[FAIL]\033[0m I cannot ping the hostname salesweb.example.com. It should resolve to the minikube IP address. Did you use \033[1mminikube ip\033[0m to find the minikube IP address and add a line to your local Linux /etc/hosts file that resolves salesweb.example.com to that IP address? It should look like \033[1m192.168.49.2  salesweb.example.com\033[0m" 
fi

# check if curl salesweb.example.com is giving a result
# this fails and I don't know why
if curl -s salesweb.example.com | grep -i 'welcome' 2>&1 /dev/null
then
        echo -e "\033[32m[OK]\033[0m Succesfully contacted the name based virtual host provided by Ingress"
else
	echo -e "\033[31m[FAIL]\033[0m The kubernetes ingress resource isn't doing it's work \(yet\). Give it a few seconds and then try again. If it still doesn't work, check if you used \033[1mkubectl create ingress salesweb --rule=\"salesweb.example.com/=salesweb:80\"\033[0m to create it?" && exit 4
fi


# succesfull completion
echo -e "\033[32m[CONGRATS]\033[0m you have succesfully completed this lab, please move on to the next lesson"
echo