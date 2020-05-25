#!/bin/bash
rm -f ./result.csv
IFS=$'\n'
echo "Filename; Filepath; Extension; Permission; Size(bytes); Change; Duration (A/V)">> result.csv
function work {
if ! [ -d $1 ]; then
	m=$(ls -lh $1 | awk -F' ' '{print $1";"$5";"$7$6" "$8";"}')
	name=${1##*/}
	g=($1)
	expansion=''
	if [ ${name#*.} != ${name##*.} ] ;then
		expansion=${name##*.}
	elif [[ ${name##*.} != $name ]] && [[ ${name:0:1} != "." ]];then
		expansion=${name##*.}
	fi
	t=''
	if file -ib $1 | grep -q 'video'; then
		t=$(ffmpeg -i $1 2>&1| grep Duration | awk '{print $2}')
	elif file -ib $1 | grep -q 'audio'; then
		t=$(ffmpeg -i $1 2>&1| grep Duration | awk '{print $2}')
	fi
	echo "$name; $1; $expansion; $m $t">> result.csv
fi
}
f=$(ls -1AR $1)
for i in $f
do
	if [[ $i =~ ":" ]]
	then
	p=$(echo ${i/:/''})
	echo $p this is P
	else
	work $p/$i
	fi
done

