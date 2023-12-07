#!/bin/bash

# check if a storageclass is running
if kubectl get storageclass >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m A storageclass is running. You're good to continue."
else 
	echo -e "\033[31m[FAIL]\033[0m No storageclass was found. That's weird as it is a default resource in minikube. Are you sure you're using this lab in minikube?" && exit 3
fi

# verify that a PVC is created
if kubectl get pvc | grep "lab6-pvc" >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m PVC lab6-pvc is running"
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot find a PVC with the name lab6-pvc. There is no easy command to create a PVC. Have a look at the example file \033[1mpv-pvc-pod.yaml\033[0m in the course Git repository for an example and create your own lab6-pvc.yaml based on this. Next use  \033[1mkubectl apply -f lab6-pvc.yaml\033[0m to create it it?" && exit 4
fi

# verify that the PVC is bound to a PV
if [[ $(kubectl get pvc | awk '/lab6-pvc/ { print $2 }') == "Bound" ]] >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m PVC lab6-pvc is bound to a Persistent Volume"
else 
	echo -e "\033[31m[FAIL]\033[0m I have found the PVC lab6-pvc but it doesn't show as bound to any storage. Did you include a \033[1mstorageClassName\033[0m property in the lab6-pvc.yaml file? If you did, remove it and run \033[1mkubectl apply lab6-pvc.yaml\033[0m to update the PVC" && exit 4
fi

# verify that a pod with the name lab6 is running
if kubectl get pods | grep lab6 >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m Pod lab6 is running"
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot find a Pod with the name lab6. There is no easy command to create a Pod that connects to specific storage. Have a look at the example file \033[1mpv-pvc-pod.yaml\033[0m in the course Git repository for an example and create your own lab6-pod.yaml based on this. Don't forget to tweak it, and include a default command like sleep 3600. Next use  \033[1mkubectl apply -f lab6-pod.yaml\033[0m to create it it?" && exit 4
fi

# verify that a file with the name lab6file can be written to "storagelab" in the directory /data
if kubectl exec lab6 -- touch /data/lab6file >/dev/null
then 
	echo -e "\033[32m[OK]\033[0m I can write a testfile to the /data directory in the Pod. So all is looking good!"
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot create a testfile in the directory /data in the Pod. Can you please verify that mount path using \033[1mkubectl describe pod lab6\033[0m" && exit 4
fi

# use minikube ssh ls /PATH/labfile to verify the file has been written
if minikube ssh ls /tmp/hostpath-provisioner/default/lab6-pvc/lab6file >/dev/null
then
	echo -e "\033[32m[OK]\033[0m I can find the testfile in the hostPath PV that the StorageClass has created."
else 
	echo -e "\033[31m[FAIL]\033[0m I cannot find the testfile in the hostPath PV that the StorageClass has created. Did you use the name \033[1mlab6-pvc\033[0m for the PVC?" && exit 4
fi

echo
echo -e "\033[32m[CONGRATS]\033[0m you have succesfully completed this lab, please move on to the next lesson"
echo
