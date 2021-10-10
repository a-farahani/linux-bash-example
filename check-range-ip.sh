#!/bin/bash
IP=()
for i in $(eval echo {$1..$2}); do
	ping -c 2 192.168.20.$i
	if [ $? -eq 0 ]; then
		IP[${#IP[@]}]=192.168.20.$i
	fi
done

echo ${IP[*]}
