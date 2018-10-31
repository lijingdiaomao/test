#!/bin/bash
act="ni_hao_xiao_wei"
> act_word.txt
#去高频
cat 0.txt | while read list; do
 #    echo ${list}
    #perl tools/keep_one.pal pinyin_id/${list}.pinyin 4_idpinyin/${list}_100.pinyin
    tools/srilm/bin/ngram-count -order 1 -text pinyin/${list}.pinyin -write 5_mHighFrenquency/${list}.pinyin.count
    str=${act//_/ }
    arr=($str)
    for s in ${arr[@]}; do
        echo $s
        cat 5_mHighFrenquency/${list}.pinyin.count | grep "^$s	" >> act_word.txt
        #cat 5_mHighFrenquency/${list}.pinyin.count | grep "^$s	"
    done
    #cat 5_mHighFrenquency/${list}.pinyin.count | grep "ruo	" >> act_word.txt
    #cat 5_mHighFrenquency/${list}.pinyin.count | grep "qi	" >> act_word.txt
    perl tools/prep_inputs_mew.pl act_word.txt pinyin_id/${list}.pinyin 4_idpinyin/${list}_${act}_balance.pinyin
    perl tools/idpinyin_tfrlist.pl 4_idpinyin/${list}_${act}_balance.pinyin tfrlist/${list}.tfrlist 1_tfrlist/${list}_${act}_balance.tfrlist
    perl tools/filter_pinyin.pl 4_idpinyin/${list}_${act}_balance.pinyin 2_pinyin/${list}_${act}_balance.pinyin
    python tools/cmvn_count_tfr.py 1_tfrlist/${list}_${act}_balance.tfrlist 3_cmvn/${list}_${act}_balance.cmvn
done
