#!/bin/bash
export export CUDA_VISIBLE_DEVICES=
task="55w"
for list in `cat 0.txt`;do
   #pinyin=$(echo $list| sed 's/\.tfrlist/\.pinyin/g') 
   #echo "$list"
   #echo "$pinyin
   ##perl tools/tfrlist_filter_idpinyin.pl tfrlist/${list}_${task}.tfrlist tools/ref.pinyin 4_idpinyin/${list}_${task}.pinyin
   perl tools/idpinyin_tfrlist.pl 4_idpinyin/${list}_${task}.pinyin tfrlist/${list}.tfrlist 1_tfrlist/${list}_${task}.tfrlist
   ##perl tools/tfrlist_filter_idpinyin.pl 1_tfrlist/${list}_${task}.tfrlist list.text 4_idpinyin/${list}_${task}.pinyin
   perl tools/filter_pinyin.pl 4_idpinyin/${list}_${task}.pinyin 2_pinyin/${list}_${task}.pinyin
   python tools/cmvn_count_tfr.py 1_tfrlist/${list}_${task}.tfrlist 3_cmvn/${list}_${task}.cmvn
   ##cat $list
done
