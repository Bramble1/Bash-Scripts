#!/bin/bash

#kill process by process id
kill_process()
{
	kill $(top -b -n 1 | awk -v process="$1" '$0~process {print $1}')
}

#check to see if program was a success or failure
command_check()
{
	if [ $1 -eq 0 ]; then 
		print "$2 terminated succesfully"
	else
		print "$2 failed to terminate"
	fi
}


#main -----------

#kill all processes if 'a' flag specified
if [[ "$1" == "a" ]]; then
	kill_process "" 
fi

#kill only process supplied by the user, supplying the name of the program to kill
if [[ "$1" != "" ]]; then
	kill_process "$1"
	command_check $? $1
fi

