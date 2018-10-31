#!/usr/bin/bash

while read i
do
  echo "start""$i"
  perl tools/mergeTfrPathAndPinyin.pl "tfrlist/"$i".tfrlist" "pinyin_id/"$i".pinyin" "pinyin_path/"$i".pinyin"

done<$1
