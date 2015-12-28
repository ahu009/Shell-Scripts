#!/bin/sh

ARRAY=(5 4 7 2 9 1 10)
echo "Before sort: ${ARRAY[@]}"
for((i=0;i<${#ARRAY[@]};i++)); do
	smallest=$i
	for((j=i+1;j<${#ARRAY[@]};j++)); do
		if [ ${ARRAY[j]} -lt ${ARRAY[smallest]} ]; then
			smallest=$j
		fi
	done
	temp=${ARRAY[smallest]}
	ARRAY[smallest]=${ARRAY[i]}
	ARRAY[i]=$temp			
done


echo "After Sort: ${ARRAY[@]}"

