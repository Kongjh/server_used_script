#!bin/bash
#
#echo 'hello world'
#echo $?

#read -p "please input (y/n)?" yn
#if [ "$yn" == "y" ] || [ "$yn" == "Y" ]; then
if [ "$1" == "y" ] || [ "$1" == "Y" ]; then
	echo "ok, continue"

#if [ "$yn" == "n" ] || [ "$yn" == "N" ]; then
#	echo 'oh, interupt'
#	exit 0

#elif [ "$yn" == "n" ] || [ "$yn" == "N" ]; then
elif [ "$1" == "n" ] || [ "$1" == "N" ]; then
	echo 'oh, interupt'
else
	echo "try again, not $1"
fi

exit 0

echo "i don't know that what your choice is " 
#&& exit 0

function printit() {
	echo "your choice is $1"
	echo "please input again, not $2"
}
if [ "$1" == "l" ]; then
	printit 1
else
	printit 1 2
fi
