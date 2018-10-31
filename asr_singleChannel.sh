#!/bin/bash
export CUDA_VISIBLE_DEVICES=

for list in `cat 1.txt`;do
   #pinyin=$(echo $list| sed 's/\.tfrlist/\.pinyin/g') 
   #echo "$list"
   #echo "$pinyin"
   $(cat tfrlist/"${list}.tfrlist" | grep "\_ch0" > 1_tfrlist/"${list}-ch0.tfrlist")
   perl tools/tfrlist_filter_idpinyin.pl 1_tfrlist/${list}-ch0.tfrlist pinyin_id/${list}.pinyin 4_idpinyin/${list}-ch0.pinyin
   perl tools/filter_pinyin.pl 4_idpinyin/${list}-ch0.pinyin 2_pinyin/${list}-ch0.pinyin
   python tools/cmvn_count_tfr.py 1_tfrlist/"${list}-ch0.tfrlist" 3_cmvn/"${list}-ch0.cmvn" 
   
 done
