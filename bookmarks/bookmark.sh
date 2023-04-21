#!/bin/bash

#$bookmark_path="/home/$(whoami)/.bookmarks"

#read and display links as command line arg, and then open firefox with the supplied link they have chosen, by copying the text to a variable in bash
#and then executing browser to get to it


#hardcoding would make it easier
#websites=("


# ./program -print (prints all the weblinks from the array)
#
# ./program -add (adds a weblink to the array)
#
# ./program -delete (deletes a weblink from array) 
#
# ./program -edit (edits an entry) given the keyname
#
# ./program -open (opens a website link provided the name has been given in the dictionry
#
#
#Maybe it would be best to store and read from a log using awk and sed maybe, just to get the hang off it, and makes it easier to manage
#
#
# Use awk to print and make it look nice, by extracpulating the name form the url
#

#setup function if the option given, then we must init a graph install manager
#and prompt the user for the path to the bookmarks, and bash stores that location
#in an environment variable maybe, or something with persistence
#or hardcode it somehowi
#
#user will need to change the path to the bookmarks.txt within this bash script itself
#run once to create the .bookmarks file in the home directory
setup()
{
	touch /home/$(whoami)/.bookmarks
	echo "bookmarks file created /home/user/.bookmarks"
}


print_help()
{
	printf "bookmarks p\t\t\t(Print bookmarks)\nbookmarks o bookmark_number\t(Open bookmark)\nbookmarks e\t\t\t(edit bookmarks)\n"
}

print_bookmarks()
{
	awk -F '/' '{printf("%d \t%s\n",NR,$3)}' ~/scripts/bash/bookmarks.txt
}


open_bookmark()
{
	google-chrome $(awk -F '/' -v input=$1 'input~NR {print $0}' ~/scripts/bash/bookmarks.txt) & disown	
}

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
		req='^[0-9]+$'
		if [[ $2 =~ $req ]] ; then
			open_bookmark $2
		fi
	fi
	
	
	

}

logic $1 $2

#logic resides here

#Printing bookmarks
#print_bookmarks

#pattern matching
#open_bookmark $1 
