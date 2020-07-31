#!/bin/bash

# dwm status bar
while true; do
	WIFI="$(iw dev wlp2s0 station dump | awk '{ if (NR==13) {print $3}}')dBm"
	CPU="$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print 100 - $1"%"}')"
	CPUTEMP="$(( `cat /sys/class/thermal/thermal_zone0/temp` / 1000 ))°C"
	MEM="$(free -h |  awk '{if (NR==2) {print $3}}')"
	SSD="$( df -h | grep /dev/sda1 | awk '{print $3}')"
	BATT="$( cat /sys/class/power_supply/BAT0/capacity)%"
#	BATTWATT="$((`cat /sys/class/power_supply/BAT0/voltage_now` * `cat /sys/class/power_supply/BAT0/current_now` / (10**12)))W"
	DATETIME="$( date +"%a %b %-d %I:%M%P")"
	
	xsetroot -name "<span fgcolor='#282828'>\
<span bgcolor='#fb4934'> ${WIFI} <span fgcolor='#fe8019'></span></span>\
<span bgcolor='#fe8019'> ${CPU} ${CPUTEMP} <span fgcolor='#fabd2f'></span></span>\
<span bgcolor='#fabd2f'> ${MEM} <span fgcolor='#b8bb26'></span></span>\
<span bgcolor='#b8bb26'> ${SSD} <span fgcolor='#83a598'></span></span>\
<span bgcolor='#83a598'> ⚡${BATT} <span fgcolor='#d3869b'></span></span>\
<span bgcolor='#d3869b'> ${DATETIME} </span>\
</span>"
	sleep 1s
done &
