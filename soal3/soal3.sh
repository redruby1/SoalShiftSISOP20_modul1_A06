#!/bin/bash

dir=`pwd`

for n in $(seq 1 28)
do
        wget -O $dir/downloads/pdkt_kusuma_$n -a $dir/wget.log https://loremflickr.com/320/240/cat
done

for file in $(fdupes -r -f $dir/downloads | grep -v '^$')
do
        mv $file $dir/duplicate/duplicate_$((a++))
done

for data in  $(ls $dir/downloads)
do
        mv $dir/downloads/$data $dir/kenangan/kenangan_$((i++))
done

grep "Location" $dir/wget.log >> $dir/location.log
cp wget.log wget.log.bak
