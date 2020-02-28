#!/bin/bash

echo "Soal Shift No 1"
echo "  "

echo "Wilayah bagian (region) yang memiliki keuntungan paling sedikit"
awk -F'\t' 'NR>1{a[$13]+=$21} END{for(i in a) print a[i]",",i}' Sample-Superstore.tsv | sort -g | awk -F',' '{print $2}' | head -1
echo "  "

echo "2 negara bagian (state) yang memiliki keuntungan paling sedikit di region$
awk -F'\t' '{if($13=="Central") a[$11]+=$21} END{for(i in a) print a[i]",",i}' Sample-Superstore.tsv | sort -g | awk -F',' '{print $2}' | head -2
echo "  "

echo "10 produk yang memiliki keuntungan paling sedikit di Texas atau Illinois"
awk -F'\t' '{if($13=="Central" && ($11=="Texas" || $11=="Illinois")) a[$17]+=$21} END{for(i in a) print a[i]",",i}' Sample-Superstore.tsv | sort -g | awk -F',' '{print $2}' | head -10
