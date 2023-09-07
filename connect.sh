#!/bin/bash
#
#
verify_pemfile()
{
	#check if contains .pem
	if [[ $1 != *.pem* ]]
	then
		echo -e ".pem extension missing [-]\n"
		exit -1
	fi	

}

set_file_permissions()
{
	if chmod 400 $1
	then
		echo -e "pem file read security increased [+]\n"
	else
		echo -e "pem file read security increased [-]\nExiting."
		exit -1
	fi

}

connect()
{
	verify_pemfile $1
	set_file_permissions $1
	echo -e "connect [+]:\n "
	echo -e "Enter username: "
        read user_name
	echo -e "\nEnter IP address: "
	read ip_address	
	ssh -i $1 $user_name@$ip_address
}

quick_connect()
{
	echo -e "grabbing assumed only pem file from downloads/ [+]\n"
	echo -e "connect [+]:\n"
	pemFile=$(ls ~/Downloads/*.pem | sort)
	verify_pemfile $pemFile
	set_file_permissions $pemFile
      	connect $pemFile	
}

#MAIN CODE
		#bash prog qc  = quick connect option, which grabs only pem file from downloads, in my case.
		#otherwise bash prog pemFile = default connection method where user enters pem as argument
case $1 in
	qc)
	       quick_connect
	       ;;
       *)
	       connect $1
	       ;;
esac
exit
