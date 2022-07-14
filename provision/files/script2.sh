#!/bin/bash
#Path to the PID file
PIDFILE=/var/run/script2.pid
#Import configuration file
source ./conf_script2.cfg

remove_pidfile()
{
  rm -f "$PIDFILE"
}
another_instance()
{
  echo "There is another instance running, exiting"
  exit 1
}
#True if file exists and is a regular file
if [ -f "$PIDFILE" ]; 
then
  kill -0 "$(cat $PIDFILE)" && another_instance
fi
#use trap to remove the PID file once the script finishes
trap remove_pidfile EXIT
#write PID in /var/run/script2.pid
echo $$ > "$PIDFILE"

if [[ $use_number == "true" ]];
then
		numfiles=$(ls -l /local/backups | grep "^-" | wc -l)
		if [ $numfiles -gt $number_of_files ];
		then
				echo "number of files is more then $number_of_files" | mutt -s "script2" $EMAIL
		fi
else
		size=$(du -B1 /local/backups | head -c 4)
		if [ $size -gt $total_size ];
		then
				echo "total size of files is more then $total_size bytes." | mutt -s "script2" $EMAIL
		fi
fi
