#!/usr/bin/bash

while read i
do
  if [[ $i =~ ASR ]];then
     cat "pinyin_id/"$i".pinyin" >> $2
  fi
  
done<$1
