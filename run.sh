#!/bin/bash
export export CUDA_VISIBLE_DEVICES=

for list in `cat 0.txt`;do
   #pinyin=$(echo $list| sed 's/\.tfrlist/\.pinyin/g') 
   #echo "$list"
   #echo "$pinyin
   ##perl tools/tfrlist_filter_idpinyin.pl tfrlist/${list}.tfrlist tools/ref.pinyin 4_idpinyin/${list}.pinyin
#   perl tools/idpinyin_tfrlist.pl 4_idpinyin/${list}.pinyin tfrlist/${list}.tfrlist 1_tfrlist/${list}.tfrlist
   ##perl tools/tfrlist_filter_idpinyin.pl 1_tfrlist/${list}.tfrlist list.text 4_idpinyin/${list}.pinyin
#   perl tools/filter_pinyin.pl 4_idpinyin/${list}.pinyin 2_pinyin/${list}.pinyin
   python tools/cmvn_count_tfr.py 1_tfrlist/${list}.tfrlist 3_cmvn/${list}.cmvn
   ##cat $list
done
