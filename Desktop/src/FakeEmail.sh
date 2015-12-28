#!/bin/sh
from=$1
to=$2

if(("$#" != 2)); then
	echo "Illegal number of arguments"
	exit 1
fi

echo "Enter subject: "
read usersubject

echo "Enter contents of email: "
read useremail
touch request.txt

{
echo "helo ucr.edu";
sleep 1;
echo "mail from: $1";
sleep 1;
echo "rcpt to: $2";
sleep 1;
echo "data";
sleep 1; 
echo "Subject: $usersubject";
sleep 1; 
echo "$useremail";
sleep 1; 
echo ".";
sleep 1
} | telnet mail.cs.ucr.edu 25

