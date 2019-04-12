#!/bin/bash
#Enable debug bash:
set -x

#User data for ssh connections:
USER="login"
PASSWD="password"

#log file name:
LOG="ssh_conn.log"

#Hosts list:
HOSTS="
10.xxx.xxx.x
10.xxx.xxx.x
"

#Host iterations:
for H in $HOSTS
do

#Display the start date of the script:
echo START SCRIPT: >> $LOG
date +%x-%R >> $LOG

#Expect command:
COMM="
#Setup expect debug:
#log_file debug.log
#exp_internal 1
#Expect timeout
set timeout 4
#SSH connections:
spawn ssh $USER@$H
expect \"*(yes/no)*\" {send \"yes\r\"}
expect \"Password:\"
send \"$PASSWD\r\"
#Execute commands:
expect \"*>\"
send \"copy running-config tftp 10.xxx.xxx.xx $H.conf\r\"
expect \"*>\"
send \"exit\r\"
#End expect commands:
expect eof
"

#Expect start:
expect -c "$COMM" >> $LOG

#Delimiter output:
echo ========================================================================= >> $LOG

done
