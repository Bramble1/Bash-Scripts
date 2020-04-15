#!/bin/bash

check_if_upgrade()
{
	package=$(apt list --upgradeable 2>/dev/null| awk '{ packages+=1 } END{ print packages-1}')
	echo " 📦 "$package
}

check_battery_status()
{
	battery=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '{if($1=="percentage:")print $2}'i)
	echo "⚡ "$battery
}

check_date()
{
	date_status=$(date | awk '{print $1" "$3" "$2" "$6" "$4}')
	echo "⏳ "$date_status
}



#main

#xsetroot -name "$(date)"
while [ 1 ]
do
	packages=$(check_if_upgrade)
	battery=$(check_battery_status)
	date_status=$(check_date)

	xsetroot -name "$(echo $packages" | "$battery" | "$date_status)"
	sleep 5

done 
