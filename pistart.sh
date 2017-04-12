#!/bin/bash

#enable watchdog
#modprobe bcm2708_wdog
#echo "System is now protected by a watchdog!"

#move cal file
mkdir ./cal; mv localcal.txt ./cal/localcal.txt; chmod 775 ./cal/localcal.txt

#working before 11-17-16
#pm2 start /usr/local/bin/node-red --node-args="--max-old-space-size=128" -- -v
#end working code
#run C program
./pub.o

#run logger
#./pidlogging.sh &

#disable_watchdog () {
    # disable the watchdog hardware
#echo V > /dev/watchdog
    # unload the watchdog kernel module
#modprobe -r bcm2708_wdog
#}

#disable watchdog when container is killed/updated
#trap disable_watchdog SIGTERM

#wait to keep container alive
#while :
#do
#    sleep 1
#done
