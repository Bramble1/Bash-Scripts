#!/bin/bash

function help
{
	printf "1-get binary\n"
	printf "2-validate binary\n"
	printf "3-install kubectl\n"
	printf "4-check\n"
	printf "5-install minikube\n"
}

function get_binary
{
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

}

function validate_binary
{
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

	echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

}

function install_kubectl
{
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

function check
{
	kubectl version --client
}

function install_minikube
{
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
	sudo dpkg -i minikube_latest_amd64.deb
}

#MAIN LOGIC

for arg in "$@"; do

	#help
	[[ "$arg" == "help" ]] && help 

	#get binary
	[[ "$arg" == "1" ]] && get_binary

	#validate binary
	[[ "$arg" == "2" ]] && validate_binary

	#install kubectl
	[[ "$arg" == "3" ]] && install_kubectl

	#check
	[[ "$arg" == "4" ]] && check

	#install minikube
	[[ "$arg" == "5" ]] && install_minikube
done

exit
