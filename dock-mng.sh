#!/bin/bash

#FUNCTIONS
#__________________________
function help
{
	printf "1-list containers\n"
	printf "2-delete containers\n"
	printf "3-list images\n"
	printf "4-delete all unused images\n"
	printf "5-build image\n"
	printf "6-run image\n"
	printf "7-connect\n"
	exit
}

function list_containers
{
	docker ps -a
	printf "\n"
}

function delete_containers
{

	for id in $(docker ps -a | awk 'NR>1{print $1}'); do
		docker rm "$id"
	done

	printf "\n"
}

function list_images
{
	docker images

	printf "\n"
}

function delete_unused_images
{
	docker image prune -a
	
	printf "\n"
}

function build_image
{
	read -p "Container name: " container_name
	docker build -f $(find "$PWD" -name "Dockerfile") -t "$container_name" .
}

function run_image
{
	read -p "Enter image name: " imageid
        read -p "name container: " container	

	port=$(cat $(find "$PWD" -name "Dockerfile") | awk '/EXPOSE/{print $2}')
	workdir=$(cat $(find "$PWD" -name "Dockerfile") | awk '/WORKDIR/{print $2}')

	docker run -v "$PWD":"$workdir" -p "$port":"$port" -d --name "$container" "$imageid"
		
}

function connect
{
	read -p "Container: " container
	docker exec -it "$container" /bin/sh
}

#MAIN LOGIC
#______________________________

for arg in "$@"; do
	
	#print the help menu
	[[ "$arg" == "help" ]] && help

	#list containers
	[[ "$arg" == "1" ]] && list_containers

	#delete containers
	[[ "$arg" == "2" ]] && delete_containers

	#list images
	[[ "$arg" == "3" ]] && list_images

	#delete all unused images
	[[ "$arg" == "4" ]] && delete_unused_images

	#build image
	[[ "$arg" == "5" ]] && build_image

	#run image
	[[ "$arg" == "6" ]] && run_image

	#connect to container
	[[ "$arg" == "7" ]] && connect
done


exit

