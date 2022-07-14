#!/bin/bash
#Variable, which generates name of file
file_name=$(date +"%d-%m-%Y") 
#Variable contains information about number of files in /local/files
numfiles=$(ls -l /local/files | grep "^-" | wc -l) 

#Retrive data from database and write it in a file
echo "use Articles_DB; select * from Articles" | mysql > /local/files/$file_name 

if [ "$numfiles" -gt 3 ]
then
	tar -cvf backup-$file_name /local/files
	mv backup-$file_name /local/backups
	rm /local/files/*
fi
