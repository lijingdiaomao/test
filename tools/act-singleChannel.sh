#!/bin/bash

for list in `cat 1.txt`;do
   #pinyin=$(echo $list| sed 's/\.tfrlist/\.pinyin/g') 
   #echo "$list"
   #echo "$pinyin"
   $(cat tfrlist/"${list}.tfrlist" | grep "\_ch0\_" > 1_tfrlist/"${list}-ch0.tfrlist")
   n=$(wc -l "tfrlist/${list}.tfrlist")
   echo "$n"
   n1=$(cat 1_tfrlist/"${list}-ch0.tfrlist" | wc -l)
   echo "$n1"
   $(head -$n1 pinyin/"${list}.pinyin" > 2_pinyin/"${list}-ch0.pinyin")
   python tools/cmvn_count_tfr.py 1_tfrlist/"${list}-ch0.tfrlist" 3_cmvn/"${list}-ch0.cmvn" 
   
 done
