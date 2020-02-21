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





