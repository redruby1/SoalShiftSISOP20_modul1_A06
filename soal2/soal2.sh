#!/bin/bash

password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)

re=[0-9a-zA-Z]+
while ! [[ "password" =~ ${re} ]]
do
	password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)

done

folder=`pwd`

echo Masukkan Nama File yang Diinginkan
read judul

if [[ $judul =~ ^[+-]?[a-zA-Z]+$ ]]; 
then echo "$password" >> $folder/$judul.txt
else echo Maaf tidak bisa, file hanya dinamai dengan format alfabet
fi
