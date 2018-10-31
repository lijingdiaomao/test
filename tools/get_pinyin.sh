#!bin/bash
cat 200000ruoqi.txt | while read line; do
  cat ../pinyin/$line.pinyin
done > 200000ruoqi.pinyin
