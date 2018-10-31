#!/bin/bash
act="ni_hao_xiao_wei"
> cal.txt
#去高频
cat 0.txt | while read list; do
 #    echo ${list}
    #perl tools/keep_one.pal pinyin_id/${list}.pinyin 4_idpinyin/${list}_100.pinyin
    echo ${list} >> cal.txt
    str=${act//_/ }
    arr=($str)
    for s in ${arr[@]}; do
        echo $s
        a1=`cat 4_idpinyin/${list}_${act}_balance.pinyin | grep "^$s|" | wc -l`
        a2=`cat 4_idpinyin/${list}_${act}_balance.pinyin | grep "|$s|" | wc -l`
        a3=`cat 4_idpinyin/${list}_${act}_balance.pinyin | grep "|$s$" | wc -l`
        num=$((${a1}+${a2}+${a3}))
        echo ${s}"\t"${num} >> cal.txt
        #cat 5_mHighFrenquency/${list}.pinyin.count | grep "^$s	"
    done
    #cat 5_mHighFrenquency/${list}.pinyin.count | grep "ruo	" >> act_word.txt
    #cat 5_mHighFrenquency/${list}.pinyin.count | grep "qi	" >> act_word.txt
done
