#!/bin/bash

#去高频
cat 0.txt | while read list; do
 #    echo ${list}
    perl tools/keep_one.pl pinyin_id/${list}.pinyin 4_idpinyin/${list}_100.pinyin
    #perl tools/idpinyin_filter_idpinyin.pl tools/testid.20180523 5_mHighFrenquency/${list}_100.pinyin 4_idpinyin/${list}_100.pinyin
    perl tools/idpinyin_tfrlist.pl 4_idpinyin/${list}_100.pinyin tfrlist/${list}.tfrlist 1_tfrlist/${list}_100.tfrlist
    perl tools/filter_pinyin.pl 4_idpinyin/${list}_100.pinyin 2_pinyin/${list}_100.pinyin
    python tools/cmvn_count_tfr.py 1_tfrlist/${list}_100.tfrlist 3_cmvn/${list}_100.cmvn
done
