#!/bin/bash


backup_bashrc()
{
	cp ~/.bashrc ~/.bashrc.b
}
restore_bashrc()
{
	cp ~/.bashrc.b ~/.bashrc 2>/dev/null
}

add_replace_bookmark()
{
	key=$1
	directory=$2
	


	#check if alias exists and if so replace with new bookmark
	check="alias ${key}" 	

	alias="alias ${key}=\"cd ${directory}\""

	sed "/$check/d" ~/.bashrc > ~/.tmp; mv ~/.tmp ~/.bashrc
	echo $alias >> ~/.bashrc	

}

print_bookmarks()
{	
	
	sed "1,112d" ~/.bashrc  | awk -v key="alias" '$0~key {print $0}'

}

delete_bookmark()
{
	check="alias ${1}"
	sed "/$check/d" ~/.bashrc > ~/.tmp; mv ~/.tmp ~/.bashrc
}


main()
{
#	help page
	if [[ $1 == '-h' ]]; then
		echo "./bookmark -a <key> <directory> (bookmark directory)"
		echo "./bookmark -a <key> (bookmark current working directory)"
		echo "./bookmark -p (print all bookmarks)"
		echo "./bookmark -d <key> (delete bookmark)"
		echo "./bookmark -b (backup bashrc, do this first)"
		echo "./bookmark -r (restore bashrc, in case things break)"

		fi

	#add a bookmark
	if [[ $1 == '-a' ]]; then
		if [[ $2 != "" ]]; then
			if [[ $3 != "" ]]; then
				add_replace_bookmark $2 $3
			else
				add_replace_bookmark $2 $(pwd)
			fi
			fi
			fi

	#print_bookmarks
	if [[ $1 == '-p' ]]; then
		print_bookmarks
	fi

	#delete a bookmark
	if [[ $1 == '-d' ]]; then
		if [[ $2 != "" ]]; then
			delete_bookmark $2
		fi
		fi

	#backup bashrc
	if [[ $1 == '-b' ]]; then
		backup_bashrc
	elif [[ $1 == '-r' ]]; then
		restore_bashrc
	fi

}

#main program
main $1 $2 $3
