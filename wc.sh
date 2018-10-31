#!/bin/bash
export export CUDA_VISIBLE_DEVICES=
n=0
for list in `cat 0.txt`;do
   #pinyin=$(echo $list| sed 's/\.tfrlist/\.pinyin/g') 
   #echo "$list"
   #echo "$pinyin
   ##perl tools/tfrlist_filter_idpinyin.pl tfrlist/${list}.tfrlist tools/ref.pinyin 4_idpinyin/${list}.pinyin
   ##perl tools/tfrlist_filter_idpinyin.pl 1_tfrlist/${list}.tfrlist list.text 4_idpinyin/${list}.pinyin
   m=$(cat tfrlist/"${list}.tfrlist" | wc -l)
   n=$(( $n+$m ))
done
echo "$n"
