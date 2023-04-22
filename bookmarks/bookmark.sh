#!/bin/bash


#Help screen
print_help()
{
	printf "bookmarks p\t\t\t(Print bookmarks)\nbookmarks o bookmark_number\t(Open bookmark)\nbookmarks e\t\t\t(edit bookmarks)\n"
}

#read and write the contents of bookmarks.txt in a certain format to stdout
print_bookmarks()
{
	awk -F '/' '{printf("%d \t%s\n",NR,$3)}' ~/scripts/bash/bookmarks.txt
}


#open chosen bookmarks using chrome browser
open_bookmark()
{
	for byte in $1
	do
		#check byte is a number
		pattern='^[0-9]+$'
		if [[ $byte=~pattern ]];
		then
			google-chrome $(awk -F '/' -v input=$1 'input~NR {print $0}' ~/scripts/bash/bookmarks.txt) & disown
		fi
	done	
}

#Main logic resides here
logic()
{
	#help page if no args supplied,only need to test 1st arg to come to conclusion
	if [[ -z "$1" ]]; then
		print_help		
	fi
	
	#vim into bookmarks.txt and if not the file is created if doesn't exist
	if [[ $1 == 'e' ]]; then
		vim ~/scripts/bash/bookmarks.txt
	fi
	#print bookmarks
	if [[ $1 == 'p' ]]; then
		print_bookmarks
	#open link	
	elif [[ $1 == 'o' ]]; then
	#	req='^[0-9]+$'
	#	if [[ $2 =~ $req ]] ; then
			open_bookmark $2
		#fi
	fi
	
	
	

}

#initial stack frame
logic $1 $2
