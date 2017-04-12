#!/bin/bash

timestamp=`date +%F_%H-%M-%S`
oldepoch=`date +%s`
cid=`pidof -s pub.o`
cd /proc/$cid/fd
echo "PID Log - $(date)" >/data/pid_log_$timestamp.txt
while :
do
    datedif=$((`date +%s` - $oldepoch))

    if [ $datedif -gt 43200 ]; then
        oldepoch=`date +%s`
        timestamp=`date +%F_%H-%M-%S`
        echo "PID Log - $(date)" >>/data/pid_log_$timestamp.txt
    fi

    newtime=`date +%F_%H-%M-%S`
    fd=`ls -l | wc -l`
    temp=`/opt/vc/bin/vcgencmd measure_temp`
    temp=${temp:5:16}
    echo $newtime >>/data/pid_log_$timestamp.txt
    echo $temp >>/data/pid_log_$timestamp.txt
    echo "pub.o File Handles - $fd" >>/data/pid_log_$timestamp.txt
    echo `ps -C pub.o -o %cpu,%mem,cmd` >>/data/pid_log_$timestamp.txt
    echo `ps -C pistart.sh -o %cpu,%mem,cmd` >>/data/pid_log_$timestamp.txt
    echo `ps -C pidlogging.sh -o %cpu,%mem,cmd` >>/data/pid_log_$timestamp.txt
    echo `ps -C mosquitto -o %cpu,%mem,cmd` >>/data/pid_log_$timestamp.txt
    echo "Core Voltage:" >>/data/pid_log_$timestamp.txt
#echo `vcgencmd measure_volts core` >>/data/pid_log_$timestamp.txt
    echo >>/data/pid_log_$timestamp.txt
    sleep 5
done
