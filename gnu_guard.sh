#!/bin/bash


display_keys()
{
		clear	
		gpg --list-keys
}

create_keypair()
{
		clear
		gpg --full-gen-key
}

export_public_key()
{
	clear
	echo "Email Associated with key to export: "
	read email

	echo "save exported key as: "
	read name

	clear
	if [[ $1 == "3" ]]; then
		gpg --armor --export $email > $name
	fi
}

import_public_key()
{
	clear
	echo "public key to import: "
	read public_key

	clear
	if [ $1 == "4"] ]]; then
		gpg --import $public_key
	fi
}

validate_sign_key()
{
	clear
	echo "*1.fpr\t 2.sign\t echo 3.check\t at command prompt*"
	echo "___________________________________________________"
	echo "email address associated to verify/validate newly added key: "
	read email

	clear
	gpg --edit-key email
}

encrypt_file()
{
	clear
	awk '/uid/ {print $0}'
	echo " "
	echo "Recipient's email address: "
	read email

	printf "files in current directory:\n\n"
	ls
	echo "File to encrypt: "
	read file

	clear
	gpg -r $email -e $file
}

decrypt_file()
{
	clear
	printf "files in current directory:\n\n"
	ls *.gpg; echo " "
	echo "File to decrypt: "
	read file
	clear
	gpg -d $file
}

delete_keypair()
{
	clear
	display_keys | awk '/uid/ {print $0}'
	echo " "
	echo "Username of key pair to delete: "
	read username

	clear
	gpg --delete-key username
	gpg --delete-secret-key username


}

delete_public_key()
{
	clear
	display_keys | awk '/uid/ {print $0}'
	echo " "
	echo "Username of public key to delete: "
	read username

	clear
	gpg --delete-key username
}

print_help()
{
	echo "1.Create keypair"
	echo "2.Validate & sign key"
	echo "3.Import public key"
	echo "4.Export public key"
	echo "5.Encrypt file"
	echo "6.Decrypt file"
	echo "7.List keys"
	echo "8.Delete my key pair"
	echo "9.Delete public key"
	echo "10.Quit"

	echo " "
}

clear
#Print help menu if no arguments are supplied
if [[ -z "$1" ]]; then
	print_help
fi



echo "<Enter a number>: "
read action
	
if [[ $action == "1" ]]; then
	create_keypair
elif [[ $action == "2" ]]; then
	validate_sign_key
elif [[ $action == "3" ]]; then
	import_puublic_key
elif [[ $action == "4" ]]; then
	export_public_key
elif [[ $action == "5" ]]; then
	encrypt_file
elif [[ $action == "6" ]]; then
	decrypt_file
elif [[ $action == "7" ]]; then
	display_keys
elif [[ $action == "8" ]]; then
	delete_keypair
elif [[ $action == "9" ]]; then
	delete_public_key
elif [[ $action == "10" ]]; then
	exit
fi



