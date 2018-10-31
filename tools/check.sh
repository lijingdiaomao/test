#!/bin/bash
echo "trainlist_number vs pinyin_number"
echo "#####################################"
for list in `ls tfrlist`;do
    name=$(basename $list .tfrlist)
    pinyin_n=`wc -l pinyin/$name.pinyin | awk '{print $1}'`
    list_n=`wc -l tfrlist/$name.tfrlist | awk '{print $1}'`
    echo "$list ====> : $list_n vs. $pinyin_n"
done
