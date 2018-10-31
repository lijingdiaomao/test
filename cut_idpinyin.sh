#!/bin/bash
export export CUDA_VISIBLE_DEVICES=
numerator=4  #分子
denominator=5 #分母
#剪裁
cat 0.txt | while read list; do
 #    echo ${list}
    perl tools/cut_idpinyin.pl pinyin_id/${list}.pinyin 4_idpinyin/${list}_${numerator}_${denominator}_allid.pinyin $numerator $denominator
    #perl tools/idpinyin_filter_idpinyin.pl tools/testid.20180523 5_mHighFrenquency/${list}_${numerator}_${denominator}_allid.pinyin 4_idpinyin/${list}_${numerator}_${denominator}_allid.pinyin
    perl tools/idpinyin_tfrlist.pl 4_idpinyin/${list}_${numerator}_${denominator}_allid.pinyin tfrlist/${list}.tfrlist 1_tfrlist/${list}_${numerator}_${denominator}_allid.tfrlist
    perl tools/filter_pinyin.pl 4_idpinyin/${list}_${numerator}_${denominator}_allid.pinyin 2_pinyin/${list}_${numerator}_${denominator}_allid.pinyin
    python tools/cmvn_count_tfr.py 1_tfrlist/${list}_${numerator}_${denominator}_allid.tfrlist 3_cmvn/${list}_${numerator}_${denominator}_allid.cmvn
done
