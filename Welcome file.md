# SoalShiftSISOP20_modul1_A06

## Soal 1
Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.

a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit

b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a

c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b

**Jawab:** 

**a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit**

```
awk -F'\t' 'NR>1{a[$13]+=$21} END{for(i in a) print a[i]"\t",i}' Sample-Superstore.tsv.part | sort -g | awk -F'\t' '{print $2}' | head -1
```
 - ``` awk -F'\t' ``` untuk membaca data dan memisahkan antarkolom menggunakan 'tab'
 - ``` NR>1 ``` agar baris pertama (berisi nama kolom) tidak ikut terbaca
 - ``` 'NR>1{a[$13]+=$21} END{for(i in a) print a[i]"\t",i}' Sample-Superstore.tsv.part ``` memasukkan data nama region ke index *array a* dan data profit menjadi nilainya. Nama region yang sama akan tersimpan di index yang sama kemudian mencetak jumlah profit ``` a[i] ``` dan nama region ``` i ```
 - ``` sort -g ``` untuk mengurutkan profit secara ascending
 - ``` awk -F'\t' '{print $2}' | head -1 ``` mencetak nama region yang memiliki profit terkecil (``` head -1 ``` menunjukkan baris paling atas)
 
 **b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling sedikit berdasarkan hasil poin a**
 ```
 awk -F'\t' '{if($13=="Central") a[$11]+=$21} END{for(i in a) print a[i]"\t",i}' Sample-Superstore.tsv.part | sort -g | awk -F',' '{print $2}' | head -2
 ```
 - Region hasil *a* yaitu *Central* sehingga ``` '{if($13=="Central") a[$11]+=$21} END{for(i in a) print a[i]"\t",i}' Sample-Superstore.tsv.part ``` memilih data state dengan region *Central* dan disimpan di index *array a* dan data profit menjadi nilainya. Nama state yang sama akan tersimpan di index yang sama kemudian mencetak jumlah profit ``` a[i] ``` dan nama state ``` i ```
 - ``` sort -g ``` untuk mengurutkan profit secara ascending
 - ``` awk -F'\t' '{print $2}' | head -2 ``` mencetak 2 nama region yang memiliki profit terkecil (``` head -2 ``` menunjukkan 2 baris paling atas)

**c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling sedikit berdasarkan 2 negara bagian (state) hasil poin b**
```
awk -F'\t' '{if($13=="Central" && ($11=="Texas" || $11=="Illinois")) a[$17]+=$21} END{for(i in a) print a[i]",",i}' Sample-Superstore.tsv.part | sort -g | awk -F',' '{print $2}' | head -10
```
 - State hasil *b* yaitu *Texas* dan *Illinois* sehingga ``` '{if($13=="Central" && ($11=="Texas" || $11=="Illinois")) a[$17]+=$21} END{for(i in a) print a[i]",",i}' Sample-Superstore.tsv.part ``` memilih data produk dengan region *Central* dan statenya *Texas* atau *Illinois* dan kemudian disimpan di index *array a* dan data profit menjadi nilainya. Nama produk yang sama akan tersimpan di index yang sama kemudian mencetak jumlah profit ``` a[i] ``` dan nama produk ``` i ```
 -  ``` sort -g ``` untuk mengurutkan profit secara ascending
 - ``` awk -F'\t' '{print $2}' | head -10 ``` mencetak 10 nama produk yang memiliki profit terkecil (``` head -10 ``` menunjukkan 10 baris paling atas)

> Full code [soal1.sh](https://github.com/redruby1/SoalShiftSISOP20_modul1_A06/blob/master/soal1/soal1.sh)


## Soal 3
**a. Buatlah script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file "wget.log"**
```
dir=`pwd`
for n in $(seq 1 28)
do
        wget -O $dir/downloads/pdkt_kusuma_$n -a $dir/wget.log https://loremflickr.com/320/240/cat
done
```

 - ``` for n in $(seq 1 28) ``` melakukan looping sebanyak 28 kali (downloads sebanyak 28 kali)
 - ``` wget -O $dir/downloads/pdkt_kusuma_$n -a $dir/wget.log https://loremflickr.com/320/240/cat ``` download gambar dari link dan memasukkan *log message* ke *wget.log*

**b. Cronjob setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu**
```
5 6-23/8 * * 0-5 /bin/bash /home/anisa/sisop/modul1/soal3.sh
```
**c. Buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).              
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory​, maka lakukan backup seluruh log menjadi ekstensi ".log.bak"**
```
for file in $(fdupes -r -f $dir/downloads | grep -v '^$')
do
        mv $file $dir/duplicate/duplicate_$((n++))
done

for data in  $(ls $dir/downloads)
do
        mv $data $dir/kenangan/kenangan_$((i++))
done

grep "Location" $dir/wget.log >> $dir/location.log
cp wget.log wget.log.bak
```

 - ``` fdupes -r -f $dir/downloads ``` mencari file yang identik
 - ``` mv $file $dir/duplicate/duplicate_$((n++)) ``` memindahkan file identik ke folder *duplicate*
 - ``` mv $data $dir/kenangan/kenangan_$((i++)) ``` memindahkan sisa file ke folder *kenangan*
 - ``` grep "Location" $dir/wget.log >> $dir/location.log ``` memindahkan log yang berisi *Location*
 - ``` cp wget.log wget.log.bak ```
> Full code [soal3.sh](https://github.com/redruby1/SoalShiftSISOP20_modul1_A06/blob/master/soal3/soal3.sh)





<!--stackedit_data:
eyJoaXN0b3J5IjpbODYyOTIwNzgzXX0=
-->