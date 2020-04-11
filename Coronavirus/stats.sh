#!/bin/bash

#http request and get webpage of stats from server
getWebPage()
{
	rm index.html
	wget https://www.worldometers.info/coronavirus/ -o /dev/null
}

#convert the downloaded webpage to text and then obtain the country details we want using the argument
#supplied by the user and awk
print_country_details()
{
	lynx --dump index.html | awk -v country="$1" '$0~country {print $0}' | awk '\
	FNR==1 	{
	print $1

	print "Total Cases:" $2
	print "Total Deaths:" $4
	print "Total Recovered:" $6
	print "Active Cases:" $7
	print "Serious,Critical:" $8
	print "Total Tests:" $10
	}'
}


#Main Program
getWebPage
print_country_details $1



