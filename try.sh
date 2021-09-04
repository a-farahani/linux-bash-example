#!/bin/bash

#define default value
TIME_CHECK=false
COUNTER_CHECK=false

#get inputs
INPUTS=("$@")

#save -i or -n value
while getopts ":i:n:" OPT; do
  case ${OPT} in
    i) if [[ ${OPTARG} =~ ^[\-0-9]+$ ]] && (( ${OPTARG} > 0)); then
			TIME=${OPTARG}
			TIME_CHECK=true
       else
			>&2 echo "This is not integer input"
			exit 1
       fi
      ;;
    n) if [[ ${OPTARG} =~ ^[\-0-9]+$ ]] && (( ${OPTARG} > 0)); then
			COUNTER=${OPTARG}
			COUNTER_CHECK=true
       else
			>&2 echo "This is not integer input"
			exit 1
       fi
      ;;
    \?) echo "Usage: try [-i posetive_number] [-n posetive_number] [COMMAND]"
			>&2 echo "Bad input"
			exit 1
      ;;
  esac
done

#set default value
if [ -z $TIME ] && [ -z $TRY_INTERNAL ]; then
	TIME=5
elif [ -z $TIME ] && [ ! -z $TRY_INTERNAL ]; then
	TIME=$TRY_INTERNAL
fi

if [ -z $COUNTER ] && [ -z $TRY_NUMBER ]; then
	COUNTER=12
elif [ -z $COUNTER ] && [ ! -z $TRY_NUMBER ]; then
	COUNTER=$TRY_NUMBER
fi

#find first COMMAND index
if [ "$TIME_CHECK" = false ] && [ "$COUNTER_CHECK" = false ]; then
	j=0
elif [ "$TIME_CHECK" = true ] && [ "$COUNTER_CHECK" = false ]; then
	j=2
elif [ "$TIME_CHECK" = false ] && [ "$COUNTER_CHECK" = true ]; then
	j=2
elif [ "$TIME_CHECK" = true ] && [ "$COUNTER_CHECK" = true ]; then
	j=4
fi

#create COMMAND
for (( i=$j; i<=(($# - 1)); i++ )); do
	COMMAND=$COMMAND" "${INPUTS[$i]}
done

#check COMMAND
if [[ -z $COMMAND ]]; then
	>&2 echo "No COMMAND" 
	exit 1
fi

#echo all inputs
echo "TIME: " $TIME
echo "COUNTER: " $COUNTER
echo "COMMNAND: " $COMMAND
echo "Current Directory: `pwd`"
#main COUNTER
for (( x=1; x<=$COUNTER; x++ )); do
	echo "##################"
	#execute COMMAND
	bash -c "${COMMAND}"
	if [ $? == 0 ]; then
		exit 0
	else
		sleep $TIME
	fi
done

>&2 echo "error" 
exit 1

