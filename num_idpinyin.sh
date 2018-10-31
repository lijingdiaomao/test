#!/bin/bash
export export CUDA_VISIBLE_DEVICES=
numerator=1  #分子
denominator=30 #分母
#剪裁
cat 0.txt | while read list; do
 #    echo ${list}
    #perl tools/cut_idpinyin.pl pinyin_id/${list}.pinyin 4_idpinyin/${list}_${numerator}_${denominator}.pinyin $numerator $denominator
    numerator1=`cat pinyin_id/${list}.pinyin | wc -l`  #分子
    num=`expr $numerator1 / $denominator`
    #echo $numerator1
    #echo $num
    perl tools/shuffle_list.pl --srand ${seed:-777} pinyin_id/${list}.pinyin | head -n $num > 4_idpinyin/${list}_${numerator}_${denominator}.pinyin
    #perl tools/idpinyin_filter_idpinyin.pl tools/testid.20180523 5_mHighFrenquency/${list}_${numerator}_${denominator}.pinyin 4_idpinyin/${list}_${numerator}_${denominator}.pinyin
    perl tools/idpinyin_tfrlist.pl 4_idpinyin/${list}_${numerator}_${denominator}.pinyin tfrlist/${list}.tfrlist 1_tfrlist/${list}_${numerator}_${denominator}.tfrlist
    perl tools/filter_pinyin.pl 4_idpinyin/${list}_${numerator}_${denominator}.pinyin 2_pinyin/${list}_${numerator}_${denominator}.pinyin
    python tools/cmvn_count_tfr.py 1_tfrlist/${list}_${numerator}_${denominator}.tfrlist 3_cmvn/${list}_${numerator}_${denominator}.cmvn
done
